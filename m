From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] blame: refactor porcelain output
Date: Mon, 9 May 2011 09:34:02 -0400
Message-ID: <20110509133402.GB11022@sigill.intra.peff.net>
References: <20110509133153.GA10998@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 09 15:34:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJQbG-0001j9-4d
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 15:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126Ab1EINeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 09:34:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39682
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab1EINeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 09:34:05 -0400
Received: (qmail 9095 invoked by uid 107); 9 May 2011 13:36:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 May 2011 09:36:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2011 09:34:02 -0400
Content-Disposition: inline
In-Reply-To: <20110509133153.GA10998@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173231>

This is in preparation for adding more porcelain output
options. The three changes are:

  1. emit_porcelain now receives the format option flags

  2. emit_one_suspect_detail takes an optional "repeat"
     parameter to suppress the "show only once" behavior

  3. The code for emitting porcelain suspect is factored
     into its own function for repeatability.

There should be no functional changes.

Signed-off-by: Jeff King <peff@peff.net>
---
I broke this out for readability. I can break each of the 3 out into a
separate patch if that helps, but it seemed excessive.

 builtin/blame.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4242e4b..d74e18f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1484,13 +1484,14 @@ static void write_filename_info(const char *path)
 /*
  * Porcelain/Incremental format wants to show a lot of details per
  * commit.  Instead of repeating this every line, emit it only once,
- * the first time each commit appears in the output.
+ * the first time each commit appears in the output (unless the
+ * user has specifically asked for us to repeat).
  */
-static int emit_one_suspect_detail(struct origin *suspect)
+static int emit_one_suspect_detail(struct origin *suspect, int repeat)
 {
 	struct commit_info ci;
 
-	if (suspect->commit->object.flags & METAINFO_SHOWN)
+	if (!repeat && suspect->commit->object.flags & METAINFO_SHOWN)
 		return 0;
 
 	suspect->commit->object.flags |= METAINFO_SHOWN;
@@ -1529,7 +1530,7 @@ static void found_guilty_entry(struct blame_entry *ent)
 		printf("%s %d %d %d\n",
 		       sha1_to_hex(suspect->commit->object.sha1),
 		       ent->s_lno + 1, ent->lno + 1, ent->num_lines);
-		emit_one_suspect_detail(suspect);
+		emit_one_suspect_detail(suspect, 0);
 		write_filename_info(suspect->path);
 		maybe_flush_or_die(stdout, "stdout");
 	}
@@ -1619,7 +1620,15 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
 
-static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
+static void emit_porcelain_details(struct origin *suspect, int repeat)
+{
+	if (emit_one_suspect_detail(suspect, repeat) ||
+	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
+		write_filename_info(suspect->path);
+}
+
+static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
+			   int opt)
 {
 	int cnt;
 	const char *cp;
@@ -1633,9 +1642,7 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent)
 	       ent->s_lno + 1,
 	       ent->lno + 1,
 	       ent->num_lines);
-	if (emit_one_suspect_detail(suspect) ||
-	    (suspect->commit->object.flags & MORE_THAN_ONE_PATH))
-		write_filename_info(suspect->path);
+	emit_porcelain_details(suspect, 0);
 
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
@@ -1756,7 +1763,7 @@ static void output(struct scoreboard *sb, int option)
 
 	for (ent = sb->ent; ent; ent = ent->next) {
 		if (option & OUTPUT_PORCELAIN)
-			emit_porcelain(sb, ent);
+			emit_porcelain(sb, ent, option);
 		else {
 			emit_other(sb, ent, option);
 		}
-- 
1.7.5.rc2.8.gc085
