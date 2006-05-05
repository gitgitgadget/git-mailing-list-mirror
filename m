From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach fmt-patch about --numbered
Date: Fri, 5 May 2006 04:30:52 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605050430070.26082@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Fri May 05 04:31:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbq5s-0001Hl-94
	for gcvg-git@gmane.org; Fri, 05 May 2006 04:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWEECay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 22:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWEECay
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 22:30:54 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:9437 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932440AbWEECax (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 22:30:53 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B39E22007;
	Fri,  5 May 2006 04:30:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id A86421FFC;
	Fri,  5 May 2006 04:30:52 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 86A851F7C;
	Fri,  5 May 2006 04:30:52 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19594>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 builtin-log.c |    9 ++++++++-
 commit.c      |    5 +----
 commit.h      |    2 +-
 log-tree.c    |   15 ++++++++++++---
 rev-list.c    |    2 +-
 revision.h    |    1 +
 show-branch.c |    2 +-
 7 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 53a47c9..43c7ecd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -137,6 +137,7 @@ int cmd_format_patch(int argc, const cha
 	struct rev_info rev;
 	int nr = 0, total, i, j;
 	int use_stdout = 0;
+	int numbered = 0;
 
 	init_revisions(&rev);
 	rev.commit_format = CMIT_FMT_EMAIL;
@@ -156,6 +157,9 @@ int cmd_format_patch(int argc, const cha
 	for (i = 1, j = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--stdout"))
 			use_stdout = 1;
+		else if (!strcmp(argv[i], "-n") ||
+				!strcmp(argv[i], "--numbered"))
+			numbered = 1;
 		else if (!strcmp(argv[i], "-o")) {
 			if (argc < 3)
 				die ("Which directory?");
@@ -186,11 +190,14 @@ int cmd_format_patch(int argc, const cha
 		list[nr - 1] = commit;
 	}
 	total = nr;
+	if (numbered)
+		rev.total = total;
 	while (0 <= --nr) {
 		int shown;
 		commit = list[nr];
+		rev.nr = total - nr;
 		if (!use_stdout)
-			reopen_stdout(commit, total - nr);
+			reopen_stdout(commit, rev.nr);
 		shown = log_tree_commit(&rev, commit);
 		free(commit->buffer);
 		commit->buffer = NULL;
diff --git a/commit.c b/commit.c
index 42b44bb..93b3903 100644
--- a/commit.c
+++ b/commit.c
@@ -489,17 +489,14 @@ static int add_merge_info(enum cmit_fmt 
 	return offset;
 }
 
-unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit, unsigned long len, char *buf, unsigned long space, int abbrev)
+unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject)
 {
 	int hdr = 1, body = 0;
 	unsigned long offset = 0;
 	int indent = 4;
 	int parents_shown = 0;
 	const char *msg = commit->buffer;
-	const char *subject = NULL;
 
-	if (fmt == CMIT_FMT_EMAIL)
-		subject = "Subject: [PATCH] ";
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		indent = 0;
 
diff --git a/commit.h b/commit.h
index 01eec60..8d7514c 100644
--- a/commit.h
+++ b/commit.h
@@ -51,7 +51,7 @@ enum cmit_fmt {
 };
 
 extern enum cmit_fmt get_commit_format(const char *arg);
-extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev);
+extern unsigned long pretty_print_commit(enum cmit_fmt fmt, const struct commit *, unsigned long len, char *buf, unsigned long space, int abbrev, const char *subject);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/log-tree.c b/log-tree.c
index d92abaf..cec7068 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -20,6 +20,7 @@ void show_log(struct rev_info *opt, stru
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
 	const char *extra;
 	int len;
+	char* subject = NULL;
 
 	opt->loginfo = NULL;
 	if (!opt->verbose_header) {
@@ -50,10 +51,18 @@ void show_log(struct rev_info *opt, stru
 	 * Print header line of header..
 	 */
 
-	if (opt->commit_format == CMIT_FMT_EMAIL)
+	if (opt->commit_format == CMIT_FMT_EMAIL) {
+		if (opt->total > 0) {
+			static char buffer[64];
+			snprintf(buffer, sizeof(buffer),
+					"Subject: [PATCH %d/%d] ",
+					opt->nr, opt->total);
+			subject = buffer;
+		} else
+			subject = "Subject: [PATCH] ";
 		printf("From %s  Thu Apr 7 15:13:13 2005\n",
 		       sha1_to_hex(commit->object.sha1));
-	else {
+	} else {
 		printf("%s%s",
 		       opt->commit_format == CMIT_FMT_ONELINE ? "" : "commit ",
 		       diff_unique_abbrev(commit->object.sha1, abbrev_commit));
@@ -69,7 +78,7 @@ void show_log(struct rev_info *opt, stru
 	/*
 	 * And then the pretty-printed message itself
 	 */
-	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev);
+	len = pretty_print_commit(opt->commit_format, commit, ~0u, this_header, sizeof(this_header), abbrev, subject);
 	printf("%s%s%s", this_header, extra, sep);
 }
 
diff --git a/rev-list.c b/rev-list.c
index 89b3343..347f627 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -83,7 +83,7 @@ static void show_commit(struct commit *c
 		static char pretty_header[16384];
 		pretty_print_commit(revs.commit_format, commit, ~0,
 				    pretty_header, sizeof(pretty_header),
-				    revs.abbrev);
+				    revs.abbrev, NULL);
 		printf("%s%c", pretty_header, hdr_termination);
 	}
 	fflush(stdout);
diff --git a/revision.h b/revision.h
index 48d7b4c..62759f7 100644
--- a/revision.h
+++ b/revision.h
@@ -58,6 +58,7 @@ struct rev_info {
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
+	int		nr, total;
 
 	/* special limits */
 	int max_count;
diff --git a/show-branch.c b/show-branch.c
index 268c57b..bbe26c2 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -259,7 +259,7 @@ static void show_one_commit(struct commi
 	struct commit_name *name = commit->object.util;
 	if (commit->object.parsed)
 		pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-				    pretty, sizeof(pretty), 0);
+				    pretty, sizeof(pretty), 0, NULL);
 	else
 		strcpy(pretty, "(unavailable)");
 	if (!strncmp(pretty, "[PATCH] ", 8))
-- 
1.3.1.g5f039
