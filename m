From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] blame: add --line-porcelain output format
Date: Mon, 9 May 2011 09:34:42 -0400
Message-ID: <20110509133442.GC11022@sigill.intra.peff.net>
References: <20110509133153.GA10998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 15:34:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJQbp-00023j-SS
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 15:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297Ab1EINep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 09:34:45 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39685
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab1EINeo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 09:34:44 -0400
Received: (qmail 9125 invoked by uid 107); 9 May 2011 13:36:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 09:36:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 09:34:42 -0400
Content-Disposition: inline
In-Reply-To: <20110509133153.GA10998@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173232>

This is just like --porcelain, except that we always output
the commit information for each line, not just the first
time it is referenced. This can make quick and dirty scripts
much easier to write; see the example added to the blame
documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm not 100% happy with the name, but I couldn't think of anything
better. Something like --verbose-porcelain works, but is a little too
vague. Suggestions welcome.

 Documentation/blame-options.txt |    5 +++++
 Documentation/git-blame.txt     |   13 +++++++++++++
 builtin/blame.c                 |   10 ++++++++--
 t/t8008-blame-formats.sh        |   19 +++++++++++++++++++
 4 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 16e3c68..e76195a 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -52,6 +52,11 @@ of lines before or after the line given by <start>.
 --porcelain::
 	Show in a format designed for machine consumption.
 
+--line-porcelain::
+	Show the porcelain format, but output commit information for
+	each line, not just the first time a commit is referenced.
+	Implies --porcelain.
+
 --incremental::
 	Show the result incrementally in a format designed for
 	machine consumption.
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index bb8edb4..9516914 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -105,6 +105,19 @@ The contents of the actual line is output after the above
 header, prefixed by a TAB. This is to allow adding more
 header elements later.
 
+The porcelain format generally suppresses commit information that has
+already been seen. For example, two lines that are blamed to the same
+commit will both be shown, but the details for that commit will be shown
+only once. This is more efficient, but may require more state be kept by
+the reader. The `--line-porcelain` option can be used to output full
+commit information for each line, allowing simpler (but less efficient)
+usage like:
+
+	# count the number of lines attributed to each author
+	git blame --line-porcelain file |
+	sed -n 's/^author //p' |
+	sort | uniq -c | sort -rn
+
 
 SPECIFYING RANGES
 -----------------
diff --git a/builtin/blame.c b/builtin/blame.c
index d74e18f..6c26672 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1619,6 +1619,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_SHOW_SCORE      0100
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
+#define OUTPUT_LINE_PORCELAIN 01000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -1630,6 +1631,7 @@ static void emit_porcelain_details(struct origin *suspect, int repeat)
 static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 			   int opt)
 {
+	int repeat = opt & OUTPUT_LINE_PORCELAIN;
 	int cnt;
 	const char *cp;
 	struct origin *suspect = ent->suspect;
@@ -1642,15 +1644,18 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	emit_porcelain_details(suspect, 0);
+	emit_porcelain_details(suspect, repeat);
 
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
-		if (cnt)
+		if (cnt) {
 			printf("%s %d %d\n", hex,
 			       ent->s_lno + 1 + cnt,
 			       ent->lno + 1 + cnt);
+			if (repeat)
+				emit_porcelain_details(suspect, 1);
+		}
 		putchar('\t');
 		do {
 			ch = *cp++;
@@ -2307,6 +2312,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT('f', "show-name", &output_option, "Show original filename (Default: auto)", OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, "Show original linenumber (Default: off)", OUTPUT_SHOW_NUMBER),
 		OPT_BIT('p', "porcelain", &output_option, "Show in a format designed for machine consumption", OUTPUT_PORCELAIN),
+		OPT_BIT(0, "line-porcelain", &output_option, "Show porcelain format with per-line commit information", OUTPUT_PORCELAIN|OUTPUT_LINE_PORCELAIN),
 		OPT_BIT('c', NULL, &output_option, "Use the same output mode as git-annotate (Default: off)", OUTPUT_ANNOTATE_COMPAT),
 		OPT_BIT('t', NULL, &output_option, "Show raw timestamp (Default: off)", OUTPUT_RAW_TIMESTAMP),
 		OPT_BIT('l', NULL, &output_option, "Show long commit SHA1 (Default: off)", OUTPUT_LONG_OBJECT_NAME),
diff --git a/t/t8008-blame-formats.sh b/t/t8008-blame-formats.sh
index 387d1a6..d15f8b3 100755
--- a/t/t8008-blame-formats.sh
+++ b/t/t8008-blame-formats.sh
@@ -68,4 +68,23 @@ test_expect_success 'blame --porcelain output' '
 	test_cmp expect actual
 '
 
+cat >expect <<EOF
+$ID1 1 1 1
+$COMMIT1
+	a
+$ID2 2 2 3
+$COMMIT2
+	b
+$ID2 3 3
+$COMMIT2
+	c
+$ID2 4 4
+$COMMIT2
+	d
+EOF
+test_expect_success 'blame --line-porcelain output' '
+	git blame --line-porcelain file >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.7.5.rc2.8.gc085
