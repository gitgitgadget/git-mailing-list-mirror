From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pretty.c: allow date formats in user format strings
Date: Sat, 5 Mar 2011 15:00:10 -0500
Message-ID: <20110305200010.GB32095@sigill.intra.peff.net>
References: <20110305195020.GA3089@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dietmar Winkler <dietmarw@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 21:00:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvxeG-0008WN-RG
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 21:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753289Ab1CEUAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 15:00:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752616Ab1CEUAM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 15:00:12 -0500
Received: (qmail 14314 invoked by uid 111); 5 Mar 2011 20:00:12 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 05 Mar 2011 20:00:12 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2011 15:00:10 -0500
Content-Disposition: inline
In-Reply-To: <20110305195020.GA3089@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168512>

You can now do "%ad(short)" or similar (using any format
that works for --date). This makes some formats like %aD
redundant (since you can do "%ad(rfc)"), but of course we
keep them for compatibility.

While we're updating the docs, let's explain in more detail
how the placeholder mode, the --date= option, and the
log.date config all interact.

Signed-off-by: Jeff King <peff@peff.net>
---
My only reservation here is the strdup() we need to call
parse_date_format(). We usually try to keep the formatting parsing
lightweight since it gets re-parsed for each commit.

My timings for logging all of git.git showed that the slowdown is lost
in the noise, so it's probably not worth caring about.

 Documentation/pretty-formats.txt |   21 +++++++++++++++++++--
 pretty.c                         |   33 +++++++++++++++++++++++++++++----
 t/t6006-rev-list-format.sh       |   12 ++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 561cc9f..a73a9ac 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -109,7 +109,7 @@ The placeholders are:
 - '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ae': author email
 - '%aE': author email (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%ad': author date (format respects --date= option)
+- '%ad': author date (see below for format information)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
@@ -118,7 +118,7 @@ The placeholders are:
 - '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
 - '%cE': committer email (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
-- '%cd': committer date
+- '%cd': committer date (see below for format information)
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
 - '%ct': committer date, UNIX timestamp
@@ -151,6 +151,23 @@ insert an empty string unless we are traversing reflog entries (e.g., by
 `git log -g`). The `%d` placeholder will use the "short" decoration
 format if `--decorate` was not already provided on the command line.
 
+Dates given by `%ad` and `%cd` are formatted according to the following
+rules:
+
+  1. A date mode in parentheses may follow the placeholder. For example,
+     `%ad(iso8601)` will format the author date in the ISO8601 format.
+     You may specify any mode valid for the `--date=` option of
+     linkgit:git-log[1].
+
+  2. If no date mode is specified, and the command respects the
+     `--date=` option, the mode specified by that option is used.
+
+  3. Otherwise, if the format is used by the log family of commands and
+     the `log.date` config option is set, the mode specified by that
+     option is used.
+
+  4. Otherwise, the format is equivalent to that of --date=default.
+
 If you add a `{plus}` (plus sign) after '%' of a placeholder, a line-feed
 is inserted immediately before the expansion if and only if the
 placeholder expands to a non-empty string.
diff --git a/pretty.c b/pretty.c
index 00bcf83..d0bf2a0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -440,6 +440,27 @@ static int mailmap_name(char *email, int email_len, char *name, int name_len)
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
 
+static size_t format_date(struct strbuf *sb, const char *part,
+			  unsigned long date, int tz, enum date_mode dmode)
+{
+	int consumed = 0;
+	if (*part == '(') {
+		char *v;
+		consumed++;
+		while (part[consumed] && part[consumed] != ')')
+			consumed++;
+		/* yuck, we do this malloc for every commit */
+		v = xstrndup(part + 1, consumed - 1);
+		dmode = parse_date_format(v);
+		free(v);
+		if (part[consumed] == ')')
+			consumed++;
+	}
+	if (sb)
+		strbuf_addstr(sb, show_date(date, tz, dmode));
+	return consumed;
+}
+
 static size_t format_person_part(struct strbuf *sb, const char *part,
 				 const char *msg, int len, enum date_mode dmode)
 {
@@ -519,9 +540,9 @@ static size_t format_person_part(struct strbuf *sb, const char *part,
 	}
 
 	switch (*part) {
-	case 'd':	/* date */
-		strbuf_addstr(sb, show_date(date, tz, dmode));
-		return placeholder_len;
+	case 'd':	/* date, possibly with format */
+		return placeholder_len +
+			format_date(sb, part + 1, date, tz, dmode);
 	case 'D':	/* date, RFC2822 style */
 		strbuf_addstr(sb, show_date(date, tz, DATE_RFC2822));
 		return placeholder_len;
@@ -538,9 +559,13 @@ skip:
 	 * bogus commit, 'sb' cannot be updated, but we still need to
 	 * compute a valid return value.
 	 */
-	if (*part == 'n' || *part == 'e' || *part == 't' || *part == 'd'
+	if (*part == 'n' || *part == 'e' || *part == 't'
 	    || *part == 'D' || *part == 'r' || *part == 'i')
 		return placeholder_len;
+	/* handle 'd' separately, as it is variable length */
+	if (*part == 'd')
+		return placeholder_len +
+			format_date(NULL, part + 1, 0, 0, 0);
 
 	return 0; /* unknown placeholder */
 }
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index d918cc0..b9cef1f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -176,6 +176,18 @@ test_expect_success '%ad respects --date=' '
 	test_cmp expect.ad-short output.ad-short
 '
 
+test_format 'date-with-mode' '%ad(short)%n%ad(iso)' <<'EOF'
+commit f58db70b055c5718631e5c61528b28b12090cdea
+2005-04-07
+2005-04-07 15:13:13 -0700
+commit 131a310eb913d107dd3c09a65d1651175898735d
+2005-04-07
+2005-04-07 15:13:13 -0700
+commit 86c75cfd708a0e5868dc876ed5b8bb66c80b4873
+2005-04-07
+2005-04-07 15:13:13 -0700
+EOF
+
 test_expect_success 'empty email' '
 	test_tick &&
 	C=$(GIT_AUTHOR_EMAIL= git commit-tree HEAD^{tree} </dev/null) &&
-- 
1.7.4.rc1.24.g38985d
