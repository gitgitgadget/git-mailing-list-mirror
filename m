From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 3/8] diff: make more cases implicit --no-index
Date: Sun, 25 Feb 2007 23:35:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702252335010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Feb 25 23:35:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLRxr-0003Ac-Sz
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 23:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbXBYWf3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 17:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXBYWf3
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 17:35:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:45617 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751284AbXBYWf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 17:35:29 -0500
Received: (qmail invoked by alias); 25 Feb 2007 22:35:27 -0000
X-Provags-ID: V01U2FsdGVkX1/y0KFzGmjy/P2FAzx45G6Xf6vZpm4ozQls6FF9lV
	Gi+g==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40585>


When specifying an absolute path, or a relative path pointing outside
the working tree, do not fail, but roll your own diffopt parsing,
and execute a --no-index diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-diff-files.c |    5 +++-
 builtin-diff.c       |    5 +++-
 diff-lib.c           |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 diff.h               |    2 +
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index e1199f8..aec8338 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -23,7 +23,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
+		argc = 0;
+	else
+		argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	return run_diff_files_cmd(&rev, argc, argv);
diff --git a/builtin-diff.c b/builtin-diff.c
index 814d1fc..e7ece0a 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -215,7 +215,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	if (!setup_diff_no_index(&rev, argc, argv, nongit, prefix))
+		argc = 0;
+	else
+		argc = setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/diff-lib.c b/diff-lib.c
index b164222..6678e22 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -200,6 +200,60 @@ static int handle_diff_files_args(struct rev_info *revs,
 	return 0;
 }
 
+static int is_outside_repo(const char *path, int nongit, const char *prefix)
+{
+	int i;
+	if (nongit || !strcmp(path, "-") || path[0] == '/')
+		return 1;
+	if (prefixcmp(path, "../"))
+		return 0;
+	if (!prefix)
+		return 1;
+	for (i = strlen(prefix); !prefixcmp(path, "../"); ) {
+		while (i > 0 && prefix[i - 1] != '/')
+			i--;
+		if (--i < 0)
+			return 1;
+		path += 3;
+	}
+	return 0;
+}
+
+int setup_diff_no_index(struct rev_info *revs,
+		int argc, const char ** argv, int nongit, const char *prefix)
+{
+	int i;
+	for (i = 1; i < argc; i++)
+		if (argv[i][0] != '-')
+			break;
+		else if (!strcmp(argv[i], "--")) {
+			i++;
+			break;
+		} else if (i < argc - 3 && !strcmp(argv[i], "--no-index")) {
+			i = argc - 3;
+			break;
+		}
+	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
+				!is_outside_repo(argv[i], nongit, prefix)))
+		return -1;
+
+	diff_setup(&revs->diffopt);
+	for (i = 1; i < argc - 2; )
+		if (!strcmp(argv[i], "--no-index"))
+			i++;
+		else {
+			int j = diff_opt_parse(&revs->diffopt,
+					argv + i, argc - i);
+			if (!j)
+				die("invalid diff option/value: %s", argv[i]);
+			i += j;
+		}
+	revs->diffopt.paths = argv + argc - 2;
+	revs->diffopt.nr_paths = 2;
+	revs->max_count = -2;
+	return 0;
+}
+
 int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 {
 	int silent_on_removed;
diff --git a/diff.h b/diff.h
index 4043cec..4b435e8 100644
--- a/diff.h
+++ b/diff.h
@@ -222,6 +222,8 @@ extern void diff_flush(struct diff_options*);
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
 extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
+extern int setup_diff_no_index(struct rev_info *revs,
+		int argc, const char ** argv, int nongit, const char *prefix);
 extern int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv);
 
 extern int run_diff_index(struct rev_info *revs, int cached);
-- 
1.5.0.1.788.g8ca52
