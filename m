From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] diff-options: add --patch-with-stat
Date: Sat, 15 Apr 2006 13:41:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151340210.24303@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sat Apr 15 13:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUj9W-0003qF-Pc
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 13:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbWDOLlU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 07:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWDOLlU
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 07:41:20 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19400 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932490AbWDOLlT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 07:41:19 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1568A1CF5;
	Sat, 15 Apr 2006 13:41:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 079381CEA;
	Sat, 15 Apr 2006 13:41:18 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E1A4B1CE8;
	Sat, 15 Apr 2006 13:41:17 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18737>


With this option, git prepends a diffstat in front of the patch.

Since I really, really do not know what a diffstat of a combined diff
("merge diff") should look like, the diffstat is not generated for these.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	Buggeth, and you shall be given.

	BTW I really would like to have a diffstat for combined diffs.
	Any ideas?

 Documentation/diff-options.txt |    3 +++
 diff.c                         |   17 ++++++++++++++++-
 diff.h                         |    3 +++
 3 files changed, 22 insertions(+), 1 deletions(-)

c06cf94fe5a2f0b004e7b46c0322554e7ec4ff99
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 447e522..c183dc9 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -10,6 +10,9 @@
 --stat::
 	Generate a diffstat instead of a patch.
 
+--patch-with-stat::
+	Generate patch and prepend its diffstat.
+
 -z::
 	\0 line termination on output
 
diff --git a/diff.c b/diff.c
index f1b672d..1b33465 100644
--- a/diff.c
+++ b/diff.c
@@ -1049,6 +1049,10 @@ int diff_opt_parse(struct diff_options *
 	}
 	else if (!strcmp(arg, "--stat"))
 		options->output_format = DIFF_FORMAT_DIFFSTAT;
+	else if (!strcmp(arg, "--patch-with-stat")) {
+		options->output_format = DIFF_FORMAT_PATCH;
+		options->with_stat = 1;
+	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
@@ -1518,7 +1522,7 @@ void diff_flush(struct diff_options *opt
 	int diff_output_format = options->output_format;
 	struct diffstat_t *diffstat = NULL;
 
-	if (diff_output_format == DIFF_FORMAT_DIFFSTAT) {
+	if (diff_output_format == DIFF_FORMAT_DIFFSTAT || options->with_stat) {
 		diffstat = xcalloc(sizeof (struct diffstat_t), 1);
 		diffstat->xm.consume = diffstat_consume;
 	}
@@ -1530,6 +1534,17 @@ void diff_flush(struct diff_options *opt
 		}
 		putchar(options->line_termination);
 	}
+	if (options->with_stat) {
+		for (i = 0; i < q->nr; i++) {
+			struct diff_filepair *p = q->queue[i];
+			flush_one_pair(p, DIFF_FORMAT_DIFFSTAT, options,
+					diffstat);
+		}
+		show_stats(diffstat);
+		free(diffstat);
+		diffstat = NULL;
+		putchar(options->line_termination);
+	}
 	for (i = 0; i < q->nr; i++) {
 		struct diff_filepair *p = q->queue[i];
 		flush_one_pair(p, diff_output_format, options, diffstat);
diff --git a/diff.h b/diff.h
index 2f8aff2..f783bae 100644
--- a/diff.h
+++ b/diff.h
@@ -25,6 +25,7 @@ struct diff_options {
 	const char *pickaxe;
 	unsigned recursive:1,
 		 with_raw:1,
+		 with_stat:1,
 		 tree_in_recursive:1,
 		 full_index:1;
 	int break_opt;
@@ -120,6 +121,8 @@ #define COMMON_DIFF_OPTIONS_HELP \
 "  --patch-with-raw\n" \
 "                output both a patch and the diff-raw format.\n" \
 "  --stat        show diffstat instead of patch.\n" \
+"  --patch-with-stat\n" \
+"                output a patch and prepend its diffstat.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
 "  --full-index  show full object name on index lines.\n" \
-- 
1.3.0.rc4.ga1167e-dirty
