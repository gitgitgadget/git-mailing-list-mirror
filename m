From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] shortlog: match both "Author:" and "author" on stdin
Date: Fri, 15 Jan 2016 12:08:23 -0500
Message-ID: <20160115170823.GA21102@sigill.intra.peff.net>
References: <20160115170627.GA20983@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 18:08:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK7rR-00075F-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbcAORI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:08:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:54464 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751396AbcAORIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:08:25 -0500
Received: (qmail 2105 invoked by uid 102); 15 Jan 2016 17:08:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:08:25 -0500
Received: (qmail 21343 invoked by uid 107); 15 Jan 2016 17:08:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 12:08:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 12:08:23 -0500
Content-Disposition: inline
In-Reply-To: <20160115170627.GA20983@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284181>

The original git-shortlog could read both the normal "git
log" output as well as "git log --format=raw". However, when it was
converted to C by b8ec592 (Build in shortlog, 2006-10-22),
the trailing colon became mandatory, and we no longer
matched the raw output.

Given the amount of intervening time without any bug
reports, it's probable that nobody cares. But given that
it's easy to fix, and that the end result is hopefully more
obvious and flexible (it could now easily accomodate matching
"Committer"), let's just make it work.

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would be to assume that nobody cares about
"--format=raw" and just do:

  if (!skip_prefix(author, "Author: ", &v))
	continue;

That technically breaks somebody who was feeding shortlog output that
contains "author: ", but since Git itself doesn't generate that, it
seems rather unlikely.

 builtin/shortlog.c  | 27 ++++++++++++++++++++++++---
 t/t4201-shortlog.sh |  6 ++++++
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 35ebd17..fe9fa2f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -89,13 +89,34 @@ static void insert_one_record(struct shortlog *log,
 	string_list_append(item->util, buffer);
 }
 
+/*
+ * If header is "author", match candidate against the regex /[Aa]uthor:? /,
+ * and return a pointer to the remainder of the string in out_value.
+ */
+static int match_ident_header(const char *candidate, const char *header,
+			      const char **out_value)
+{
+	const char *v;
+
+	if (tolower(*candidate++) != tolower(*header++))
+		return 0;
+	if (!skip_prefix(candidate, header, &v))
+		return 0;
+	if (*v == ':')
+		v++;
+	if (*v++ != ' ')
+		return 0;
+	*out_value = v;
+	return 1;
+}
+
 static void read_from_stdin(struct shortlog *log)
 {
 	char author[1024], oneline[1024];
 
 	while (fgets(author, sizeof(author), stdin) != NULL) {
-		if (!(author[0] == 'A' || author[0] == 'a') ||
-		    !starts_with(author + 1, "uthor: "))
+		const char *v;
+		if (!match_ident_header(author, "author", &v))
 			continue;
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] != '\n')
@@ -103,7 +124,7 @@ static void read_from_stdin(struct shortlog *log)
 		while (fgets(oneline, sizeof(oneline), stdin) &&
 		       oneline[0] == '\n')
 			; /* discard blanks */
-		insert_one_record(log, author + 8, oneline);
+		insert_one_record(log, v, oneline);
 	}
 }
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 7600a3e..82b2314 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -120,6 +120,12 @@ test_expect_success !MINGW 'shortlog from non-git directory' '
 	test_cmp expect out
 '
 
+test_expect_success !MINGW 'shortlog can read --format=raw output' '
+	git log --format=raw HEAD >log &&
+	GIT_DIR=non-existing git shortlog -w <log >out &&
+	test_cmp expect out
+'
+
 test_expect_success 'shortlog should add newline when input line matches wraplen' '
 	cat >expect <<\EOF &&
 A U Thor (2):
-- 
2.7.0.244.g0701a9d
