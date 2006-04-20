From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] colored diff.
Date: Thu, 20 Apr 2006 03:18:31 -0700
Message-ID: <7vpsjczh1k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 20 12:18:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWWFA-0006Tf-Uf
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 12:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWDTKSe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 06:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWDTKSe
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 06:18:34 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:56744 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750839AbWDTKSd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 06:18:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420101832.LJPF18566.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 06:18:32 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18964>

With configuration option diff.usecolor, this colorizes the diff
output.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 * I am not happy with the initialization, especially the part
   that calls git_config(git_diff_config) from git.c, and I am
   not that interested in this myself, but some people seem to
   like colors, so this will be in "pu" for now.

 cache.h    |    3 +-
 diff-lib.c |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 diff.h     |    2 +
 git.c      |    3 +-
 pager.c    |   17 ++++++----
 5 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/cache.h b/cache.h
index 69801b0..e6aa297 100644
--- a/cache.h
+++ b/cache.h
@@ -169,7 +169,6 @@ extern int trust_executable_bit;
 extern int assume_unchanged;
 extern int only_use_symrefs;
 extern int warn_ambiguous_refs;
-extern int diff_rename_limit_default;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 
@@ -359,6 +358,6 @@ extern int receive_unpack_pack(int fd[2]
 extern int receive_keep_pack(int fd[2], const char *me, int quiet);
 
 /* pager.c */
-extern void setup_pager(void);
+extern int setup_pager(void);
 
 #endif /* CACHE_H */
diff --git a/diff-lib.c b/diff-lib.c
index 0a832c3..86a2561 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -12,7 +12,8 @@ #include "xdiff-interface.h"
 
 static int use_size_cache;
 
-int diff_rename_limit_default = -1;
+static int diff_rename_limit_default = -1;
+static int diff_use_color = 0;
 
 int git_diff_config(const char *var, const char *value)
 {
@@ -20,10 +21,31 @@ int git_diff_config(const char *var, con
 		diff_rename_limit_default = git_config_int(var, value);
 		return 0;
 	}
-
+	if (!strcmp(var, "diff.usecolor")) {
+		diff_use_color = git_config_bool(var, value);
+		return 0;
+	}
 	return git_default_config(var, value);
 }
 
+static const char *diff_colors[] = {
+	"\033[0;0m",
+	"\033[1;35m",
+	"\033[1;31m",
+	"\033[1;34m",
+};
+
+void diff_setup_colors(void)
+{
+	static int inited;
+	if (!inited) {
+		if (diff_use_color && !isatty(1))
+			diff_use_color = 0;
+		inited++;
+		git_config(git_diff_config);
+	}
+}
+
 static char *quote_one(const char *str)
 {
 	int needlen;
@@ -176,23 +198,61 @@ static int fill_mmfile(mmfile_t *mf, str
 }
 
 struct emit_callback {
+	struct xdiff_emit_state xm;
+	int nparents;
 	const char **label_path;
 };
 
-static int fn_out(void *priv, mmbuffer_t *mb, int nbuf)
+enum color_diff {
+	DIFF_PLAIN = 0,
+	DIFF_METAINFO = 1,
+	DIFF_FILE_OLD = 2,
+	DIFF_FILE_NEW = 3,
+};
+
+static void color_diff(enum color_diff ix)
+{
+	diff_setup_colors();
+	if (diff_use_color)
+		fputs(diff_colors[ix], stdout);
+}
+
+static void fn_out_consume(void *priv, char *line, unsigned long len)
 {
 	int i;
 	struct emit_callback *ecbdata = priv;
-
 	if (ecbdata->label_path[0]) {
+		color_diff(DIFF_METAINFO);
 		printf("--- %s\n", ecbdata->label_path[0]);
+		color_diff(DIFF_METAINFO);
 		printf("+++ %s\n", ecbdata->label_path[1]);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
-	for (i = 0; i < nbuf; i++)
-		if (!fwrite(mb[i].ptr, mb[i].size, 1, stdout))
-			return -1;
-	return 0;
+
+	/* This is not really necessary for now because
+	 * this codepath only deals with two-way diffs.
+	 */
+	for (i = 0; i < len && line[i] == '@'; i++)
+		;
+	if (2 <= i && i < len && line[i] == ' ') {
+		ecbdata->nparents = i - 1;
+		color_diff(DIFF_METAINFO);
+	}
+	else if (len < ecbdata->nparents)
+		color_diff(DIFF_PLAIN);
+	else {
+		int nparents = ecbdata->nparents;
+		int color = DIFF_PLAIN;
+		for (i = 0; i < nparents && len; i++) {
+			if (line[i] == '-')
+				color = DIFF_FILE_OLD;
+			else if (line[i] == '+')
+				color = DIFF_FILE_NEW;
+		}
+		color_diff(color);
+	}
+	fwrite(line, len, 1, stdout);
+	color_diff(DIFF_PLAIN);
 }
 
 struct diffstat_t {
@@ -359,25 +419,37 @@ static void builtin_diff(const char *nam
 	b_two = quote_two("b/", name_b);
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
+
+	color_diff(DIFF_METAINFO);
 	printf("diff --git %s %s\n", a_one, b_two);
 	if (lbl[0][0] == '/') {
 		/* /dev/null */
+		color_diff(DIFF_METAINFO);
 		printf("new file mode %06o\n", two->mode);
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 	}
 	else if (lbl[1][0] == '/') {
+		color_diff(DIFF_METAINFO);
 		printf("deleted file mode %06o\n", one->mode);
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 	}
 	else {
 		if (one->mode != two->mode) {
+			color_diff(DIFF_METAINFO);
 			printf("old mode %06o\n", one->mode);
+			color_diff(DIFF_METAINFO);
 			printf("new mode %06o\n", two->mode);
 		}
-		if (xfrm_msg && xfrm_msg[0])
+		if (xfrm_msg && xfrm_msg[0]) {
+			color_diff(DIFF_METAINFO);
 			puts(xfrm_msg);
+		}
 		/*
 		 * we do not run diff between different kind
 		 * of objects.
@@ -385,6 +457,7 @@ static void builtin_diff(const char *nam
 		if ((one->mode ^ two->mode) & S_IFMT)
 			goto free_ab_and_return;
 		if (complete_rewrite) {
+			color_diff(DIFF_PLAIN);
 			emit_rewrite_diff(name_a, name_b, one, two);
 			goto free_ab_and_return;
 		}
@@ -403,7 +476,9 @@ static void builtin_diff(const char *nam
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 
+		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
+		ecbdata.nparents = 0;
 		xpp.flags = XDF_NEED_MINIMAL;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -413,12 +488,14 @@ static void builtin_diff(const char *nam
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!strncmp(diffopts, "-u", 2))
 			xecfg.ctxlen = strtoul(diffopts + 2, NULL, 10);
-		ecb.outf = fn_out;
+		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
+		ecbdata.xm.consume = fn_out_consume;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
 	}
 
  free_ab_and_return:
+	color_diff(DIFF_PLAIN);
 	free(a_one);
 	free(b_two);
 	return;
diff --git a/diff.h b/diff.h
index 52fff66..7cb5708 100644
--- a/diff.h
+++ b/diff.h
@@ -168,4 +168,6 @@ #define DIFF_STATUS_FILTER_BROKEN	'B'
 
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
+extern void diff_setup_colors(void);
+
 #endif /* DIFF_H */
diff --git a/git.c b/git.c
index 40b7e42..6742de7 100644
--- a/git.c
+++ b/git.c
@@ -290,7 +290,8 @@ static int cmd_log_wc(int argc, const ch
 		die("unrecognized argument: %s", argv[1]);
 
 	prepare_revision_walk(rev);
-	setup_pager();
+	if (!setup_pager())
+		diff_setup_colors();
 	while ((commit = get_revision(rev)) != NULL) {
 		log_tree_commit(rev, commit);
 		free(commit->buffer);
diff --git a/pager.c b/pager.c
index b063353..1fb7103 100644
--- a/pager.c
+++ b/pager.c
@@ -10,26 +10,29 @@ static void run_pager(const char *pager)
 	execlp(pager, pager, NULL);
 }
 
-void setup_pager(void)
+/* Returns 0 if the caller can assume the output stream
+ * is like a terminal (either bare terminal or a pager.
+ */
+int setup_pager(void)
 {
 	pid_t pid;
 	int fd[2];
 	const char *pager = getenv("PAGER");
 
 	if (!isatty(1))
-		return;
+		return 1;
 	if (!pager)
 		pager = "less";
 	else if (!*pager || !strcmp(pager, "cat"))
-		return;
+		return 0;
 
 	if (pipe(fd) < 0)
-		return;
+		return -1;
 	pid = fork();
 	if (pid < 0) {
 		close(fd[0]);
 		close(fd[1]);
-		return;
+		return -1;
 	}
 
 	/* return in the child */
@@ -37,7 +40,7 @@ void setup_pager(void)
 		dup2(fd[1], 1);
 		close(fd[0]);
 		close(fd[1]);
-		return;
+		return 0;
 	}
 
 	/* The original process turns into the PAGER */
@@ -45,7 +48,7 @@ void setup_pager(void)
 	close(fd[0]);
 	close(fd[1]);
 
-	setenv("LESS", "-S", 0);
+	setenv("LESS", "-RS", 0);
 	run_pager(pager);
 	exit(255);
 }
