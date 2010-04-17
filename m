From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff too slow for a file
Date: Sat, 17 Apr 2010 17:52:08 +0200
Message-ID: <4BC9D928.50909@lsrfire.ath.cx>
References: <4BB00573.6040005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 17:52:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3AJy-0004uu-2y
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 17:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752691Ab0DQPw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 11:52:27 -0400
Received: from india601.server4you.de ([85.25.151.105]:55318 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab0DQPw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 11:52:26 -0400
Received: from [10.0.1.100] (p57B7EB9F.dip.t-dialin.net [87.183.235.159])
	by india601.server4you.de (Postfix) with ESMTPSA id 196362F80B3;
	Sat, 17 Apr 2010 17:52:24 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <4BB00573.6040005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145152>

Am 29.03.2010 03:42, schrieb SungHyun Nam:
> Hello,
> 
> If I run a attached script for bunzipped attached files, I get:
> (To reduce size, I removed many lines and bzipped.)
> 
>     $ ./mk.sh
>     time diff -u x3 x4 >/dev/null 2>&1
> 
>     real    0m0.011s
>     user    0m0.000s
>     sys    0m0.010s
> 
>     time git diff >/dev/null 2>&1
> 
>     real    0m0.193s
>     user    0m0.190s
>     sys    0m0.000s
> 
>     $ git version
>     git version 1.7.0.2.273.gc2413
> 
>     $ diff --version
>     diff (GNU diffutils) 2.8.1
>     ...
> 
> Well, though the files are ascii file, they includes a random
> hexa-decimal datas, so that I don't interest the diff result at
> all.  But the real problem is 'rebasing took so long if the file
> was changed'.  Because the git tree includes several such a file,
> if they changed, rebase took some miniutes for every branch.
> Such a branch includes a few lines of changes for a C source file,
> though.  Now I'm waiting an hour to finish rebasing all the
> branches and yet a rebasing script is running... :-(

I can reproduce it; I concatenated your example files five times to get
meaningful timings (x1 = five times x3, x2 = five times x4).

The difference between GNU diff and git diff is that the latter is trying
hard to minimize the size of the diff.  Each user of the xdiff library in
git turns on the XDF_NEED_MINIMAL flag, which makes it very expensive
(specifically the function xdl_split()).

The following patch is not meant for inclusion, but rather to start a
dicussion.  Is XDF_NEED_MINIMAL a good default to have?

The patch removes XDF_NEED_MINIMAL and replaces it with XDF_QUICK, with
reversed meaning.  XDF_QUICK is only set if the new option --quick is
given, so without it the old behaviour is retained.  Some numbers:

$ time diff ../x1 ../x2 | diffstat
 unknown |34208 ++++++++++++++++++++++++++++++++--------------------------------
 1 file changed, 17104 insertions(+), 17104 deletions(-)

real	0m0.043s
user	0m0.030s
sys	0m0.010s

$ time git diff --stat
 x |32082 ++++++++++++++++++++++++++++++++++----------------------------------
 1 files changed, 16041 insertions(+), 16041 deletions(-)

real	0m2.176s
user	0m2.170s
sys	0m0.010s

$ time git diff --quick --stat
 x |34208 ++++++++++++++++++++++++++++++++++----------------------------------
 1 files changed, 17104 insertions(+), 17104 deletions(-)

real	0m0.064s
user	0m0.060s
sys	0m0.010s

---
 builtin/blame.c      |    2 +-
 builtin/merge-file.c |    2 +-
 builtin/merge-tree.c |    2 +-
 builtin/rerere.c     |    2 +-
 combine-diff.c       |    2 +-
 diff.c               |   12 +++++++-----
 merge-file.c         |    2 +-
 xdiff/xdiff.h        |    2 +-
 xdiff/xdiffi.c       |    2 +-
 9 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..8deeee1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -39,7 +39,7 @@ static int show_root;
 static int reverse;
 static int blank_boundary;
 static int incremental;
-static int xdl_opts = XDF_NEED_MINIMAL;
+static int xdl_opts;
 
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 610849a..b8e9e5b 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -25,7 +25,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	const char *names[3] = { NULL, NULL, NULL };
 	mmfile_t mmfs[3];
 	mmbuffer_t result = {NULL, 0};
-	xmparam_t xmp = {{XDF_NEED_MINIMAL}};
+	xmparam_t xmp = {{0}};
 	int ret = 0, i = 0, to_stdout = 0;
 	int quiet = 0;
 	int nongit;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index a4a4f2c..fc00d79 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -106,7 +106,7 @@ static void show_diff(struct merge_list *entry)
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
 
-	xpp.flags = XDF_NEED_MINIMAL;
+	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	ecb.outf = show_outf;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 34f9ace..0048f9e 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -89,7 +89,7 @@ static int diff_two(const char *file1, const char *label1,
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = XDF_NEED_MINIMAL;
+	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	ecb.outf = outf;
diff --git a/combine-diff.c b/combine-diff.c
index 6162691..29779be 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -221,7 +221,7 @@ static void combine_diff(const unsigned char *parent, unsigned int mode,
 	parent_file.ptr = grab_blob(parent, mode, &sz);
 	parent_file.size = sz;
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = XDF_NEED_MINIMAL;
+	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	memset(&state, 0, sizeof(state));
 	state.nmask = nmask;
diff --git a/diff.c b/diff.c
index a1bf1e9..e32b47b 100644
--- a/diff.c
+++ b/diff.c
@@ -718,7 +718,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	memset(&xecfg, 0, sizeof(xecfg));
 	diff_words_fill(&diff_words->minus, &minus, diff_words->word_regex);
 	diff_words_fill(&diff_words->plus, &plus, diff_words->word_regex);
-	xpp.flags = XDF_NEED_MINIMAL;
+	xpp.flags = 0;
 	/* as only the hunk header will be parsed, we need a 0-context */
 	xecfg.ctxlen = 0;
 	xdi_diff_outf(&minus, &plus, fn_out_diff_words_aux, diff_words,
@@ -1744,7 +1744,7 @@ static void builtin_diff(const char *name_a,
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.file = o->file;
 		ecbdata.header = header.len ? &header : NULL;
-		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
+		xpp.flags = o->xdl_opts;
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
@@ -1834,7 +1834,7 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
-		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
+		xpp.flags = o->xdl_opts;
 		xdi_diff_outf(&mf1, &mf2, diffstat_consume, diffstat,
 			      &xpp, &xecfg, &ecb);
 	}
@@ -1883,7 +1883,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		memset(&xpp, 0, sizeof(xpp));
 		memset(&xecfg, 0, sizeof(xecfg));
 		xecfg.ctxlen = 1; /* at least one context line */
-		xpp.flags = XDF_NEED_MINIMAL;
+		xpp.flags = 0;
 		xdi_diff_outf(&mf1, &mf2, checkdiff_consume, &data,
 			      &xpp, &xecfg, &ecb);
 
@@ -2816,6 +2816,8 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
 	else if (!strcmp(arg, "--patience"))
 		DIFF_XDL_SET(options, PATIENCE_DIFF);
+	else if (!strcmp(arg, "--quick"))
+		DIFF_XDL_SET(options, QUICK);
 
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
@@ -3438,7 +3440,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 					len2, p->two->path);
 		git_SHA1_Update(&ctx, buffer, len1);
 
-		xpp.flags = XDF_NEED_MINIMAL;
+		xpp.flags = 0;
 		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
diff --git a/merge-file.c b/merge-file.c
index c336c93..db4d0d5 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -66,7 +66,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	xdemitcb_t ecb;
 
 	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = XDF_NEED_MINIMAL;
+	xpp.flags = 0;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	xecfg.flags = XDL_EMIT_COMMON;
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 711048e..3b8a962 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -28,7 +28,7 @@ extern "C" {
 #endif /* #ifdef __cplusplus */
 
 
-#define XDF_NEED_MINIMAL (1 << 1)
+#define XDF_QUICK (1 << 1)
 #define XDF_IGNORE_WHITESPACE (1 << 2)
 #define XDF_IGNORE_WHITESPACE_CHANGE (1 << 3)
 #define XDF_IGNORE_WHITESPACE_AT_EOL (1 << 4)
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index da67c04..1f688cf 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -367,7 +367,7 @@ int xdl_do_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	dd2.rindex = xe->xdf2.rindex;
 
 	if (xdl_recs_cmp(&dd1, 0, dd1.nrec, &dd2, 0, dd2.nrec,
-			 kvdf, kvdb, (xpp->flags & XDF_NEED_MINIMAL) != 0, &xenv) < 0) {
+			 kvdf, kvdb, (xpp->flags & XDF_QUICK) == 0, &xenv) < 0) {
 
 		xdl_free(kvd);
 		xdl_free_env(xe);
