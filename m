From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: git diff too slow for a file
Date: Sun, 02 May 2010 15:04:41 +0200
Message-ID: <4BDD7869.10701@lsrfire.ath.cx>
References: <4BB00573.6040005@gmail.com> <4BC9D928.50909@lsrfire.ath.cx> <7vpr1y2eev.fsf@alter.siamese.dyndns.org> <4BCB48E5.9090303@lsrfire.ath.cx> <7vd3xuinbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: SungHyun Nam <goweol@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 02 15:05:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8YrH-0003kM-Je
	for gcvg-git-2@lo.gmane.org; Sun, 02 May 2010 15:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755387Ab0EBNFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 May 2010 09:05:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:49247 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab0EBNFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 May 2010 09:05:10 -0400
Received: from [10.0.1.100] (p57B7DA34.dip.t-dialin.net [87.183.218.52])
	by india601.server4you.de (Postfix) with ESMTPSA id 7ABE32F8003;
	Sun,  2 May 2010 15:05:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vd3xuinbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146171>

Am 20.04.2010 09:40, schrieb Junio C Hamano:
> Probably we should at least try to get rid of the use of MINIMAL
> immediately after 1.7.1 and if nobody finds large discrepancies, aim to
> ship 1.7.2 (and possibly 1.7.1.1) without even --quick/--slow options.

-- >8 --
Ever since the xdiff library had been introduced to git, all its callers
have used the flag XDF_NEED_MINIMAL.  It makes sure that the smallest
possible diff is produced, but that takes quite some time if there are
lots of differences that can be expressed in multiple ways.

This flag makes a difference for only 0.1% of the non-merge commits in
the git repo of Linux, both in terms of diff size and execution time.
The patches there are mostly nice and small.

SungHyun Nam however reported a case in a different repo where a diff
took more than 20 times longer to generate with XDF_NEED_MINIMAL than
without.  Rebasing became really slow.

This patch removes this flag from all callers.  The default of xdiff is
saner because it has minimal to no impact in the normal case of small
diffs and doesn't incur that much of a speed penalty for large ones.

A follow-up patch may introduce a command line option to set the flag if
the user needs it, similar to GNU diff's -d/--minimal.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/blame.c      |    2 +-
 builtin/merge-file.c |    2 +-
 builtin/merge-tree.c |    2 +-
 builtin/rerere.c     |    2 +-
 combine-diff.c       |    2 +-
 diff.c               |   10 +++++-----
 merge-file.c         |    2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

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
index a1bf1e9..29e608b 100644
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
 
@@ -3438,7 +3438,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
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
-- 
1.7.1
