From: Jeff King <peff@peff.net>
Subject: [PATCH 4/4] commit: accept more date formats for "--date"
Date: Thu, 1 May 2014 21:12:42 -0400
Message-ID: <20140502011242.GD25413@sigill.intra.peff.net>
References: <20140502010328.GA30556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:12:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg21w-00052L-3c
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbaEBBMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:12:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:43276 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751317AbaEBBMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 21:12:44 -0400
Received: (qmail 28254 invoked by uid 102); 2 May 2014 01:12:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 20:12:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 21:12:42 -0400
Content-Disposition: inline
In-Reply-To: <20140502010328.GA30556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247918>

Right now we pass off the string found by "--date" straight
to the fmt_ident function, which will use our strict
parse_date to normalize it. However, this means obvious
things like "--date=now" or "--date=2.days.ago" will not
work.

Instead, let's fallback to the approxidate function to
handle this for us. Note that we must try parse_date
ourselves first, even though approxidate will try strict
parsing itself. The reason is that approxidate throws away
any timezone information it sees from the strict parsing,
and we want to preserve it. So asking for:

  git commit --date="@1234567890 -0700"

continues to set the date in -0700, regardless of what the
local timezone is.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c  | 27 +++++++++++++++++++++++++--
 t/t7501-commit.sh | 12 ++++++++++--
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index a25661f..d1c90db 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -526,10 +526,29 @@ static int sane_ident_split(struct ident_split *person)
 	return 1;
 }
 
+static int parse_force_date(const char *in, char *out, int len)
+{
+	if (len < 1)
+		return -1;
+	*out++ = '@';
+	len--;
+
+	if (parse_date(in, out, len) < 0) {
+		int errors = 0;
+		unsigned long t = approxidate_careful(in, &errors);
+		if (errors)
+			return -1;
+		snprintf(out, len, "%lu", t);
+	}
+
+	return 0;
+}
+
 static void determine_author_info(struct strbuf *author_ident)
 {
 	char *name, *email, *date;
 	struct ident_split author;
+	char date_buf[64];
 
 	name = getenv("GIT_AUTHOR_NAME");
 	email = getenv("GIT_AUTHOR_EMAIL");
@@ -574,8 +593,12 @@ static void determine_author_info(struct strbuf *author_ident)
 		email = xstrndup(lb + 2, rb - (lb + 2));
 	}
 
-	if (force_date)
-		date = force_date;
+	if (force_date) {
+		if (parse_force_date(force_date, date_buf, sizeof(date_buf)))
+			die(_("invalid date format: %s"), force_date);
+		date = date_buf;
+	}
+
 	strbuf_addstr(author_ident, fmt_ident(name, email, date, IDENT_STRICT));
 	if (!split_ident_line(&author, author_ident->buf, author_ident->len) &&
 	    sane_ident_split(&author)) {
diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 5a76823..63e0427 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -351,8 +351,16 @@ test_expect_success 'commit mentions forced date in output' '
 	grep "Date: *Sat Jan 2 03:04:05 2010" output
 '
 
-test_expect_success 'commit complains about bogus date' '
-	test_must_fail git commit --amend --date=10.11.2010
+test_expect_success 'commit complains about completely bogus dates' '
+	test_must_fail git commit --amend --date=seventeen
+'
+
+test_expect_success 'commit --date allows approxidate' '
+	git commit --amend \
+		--date="midnight the 12th of october, anno domini 1979" &&
+	echo "Fri Oct 12 00:00:00 1979 +0000" >expect &&
+	git log -1 --format=%ad >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'sign off (1)' '
-- 
1.9.1.656.ge8a0637
