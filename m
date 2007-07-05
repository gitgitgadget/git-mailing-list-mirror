From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] Future-proof source for changes in xdemitconf_t
Date: Wed, 04 Jul 2007 22:02:14 -0700
Message-ID: <7vr6nne949.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707041905570.4071@racer.site>
	<alpine.LFD.0.98.0707041140230.9434@woody.linux-foundation.org>
	<7vejjnhpap.fsf@assigned-by-dhcp.cox.net>
	<7vwsxfe96i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 07:02:20 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6JTv-0004Ig-0U
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 07:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbXGEFCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 01:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXGEFCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 01:02:16 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38437 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbXGEFCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 01:02:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070705050216.MUID11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 5 Jul 2007 01:02:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Kh2E1X0091kojtg0000000; Thu, 05 Jul 2007 01:02:15 -0400
In-Reply-To: <7vwsxfe96i.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 04 Jul 2007 22:00:53 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51655>

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date: Wed, 4 Jul 2007 19:05:46 +0100

The instances of xdemitconf_t were initialized member by member.
Instead, initialize them to all zero, so we do not have
to update those places each time we introduce a new member.

[jc: minimally fixed by getting rid of a new global]

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c  |    2 +-
 builtin-rerere.c |    2 +-
 combine-diff.c   |    3 +--
 diff.c           |   10 +++++-----
 merge-file.c     |    1 +
 merge-tree.c     |    2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index da23a6f..0519339 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -518,8 +518,8 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xdemitcb_t ecb;
 
 	xpp.flags = xdl_opts;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	xecfg.flags = 0;
 	ecb.outf = xdiff_outf;
 	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29fb075..01f3848 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -282,8 +282,8 @@ static int diff_two(const char *file1, const char *label1,
 	printf("--- a/%s\n+++ b/%s\n", label1, label2);
 	fflush(stdout);
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	xecfg.flags = 0;
 	ecb.outf = outf;
 	xdl_diff(&minus, &plus, &xpp, &xecfg, &ecb);
 
diff --git a/combine-diff.c b/combine-diff.c
index ea3ca5f..ef62234 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -215,8 +215,7 @@ static void combine_diff(const unsigned char *parent, mmfile_t *result_file,
 	parent_file.ptr = grab_blob(parent, &sz);
 	parent_file.size = sz;
 	xpp.flags = XDF_NEED_MINIMAL;
-	xecfg.ctxlen = 0;
-	xecfg.flags = 0;
+	memset(&xecfg, 0, sizeof(xecfg));
 	ecb.outf = xdiff_outf;
 	ecb.priv = &state;
 	memset(&state, 0, sizeof(state));
diff --git a/diff.c b/diff.c
index 1958970..552f7c0 100644
--- a/diff.c
+++ b/diff.c
@@ -390,6 +390,7 @@ static void diff_words_show(struct diff_words_data *diff_words)
 	mmfile_t minus, plus;
 	int i;
 
+	memset(&xecfg, 0, sizeof(xecfg));
 	minus.size = diff_words->minus.text.size;
 	minus.ptr = xmalloc(minus.size);
 	memcpy(minus.ptr, diff_words->minus.text.ptr, minus.size);
@@ -408,7 +409,6 @@ static void diff_words_show(struct diff_words_data *diff_words)
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = diff_words->minus.alloc + diff_words->plus.alloc;
-	xecfg.flags = 0;
 	ecb.outf = xdiff_outf;
 	ecb.priv = diff_words;
 	diff_words->xm.consume = fn_out_diff_words_aux;
@@ -1202,6 +1202,7 @@ static void builtin_diff(const char *name_a,
 		xdemitcb_t ecb;
 		struct emit_callback ecbdata;
 
+		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->color_diff;
@@ -1270,9 +1271,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 
+		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
-		xecfg.ctxlen = 0;
-		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
 		ecb.priv = diffstat;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
@@ -1310,9 +1310,8 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 		xdemitconf_t xecfg;
 		xdemitcb_t ecb;
 
+		memset(&xecfg, 0, sizeof(xecfg));
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 0;
-		xecfg.flags = 0;
 		ecb.outf = xdiff_outf;
 		ecb.priv = &data;
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
@@ -2764,6 +2763,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 		struct diff_filepair *p = q->queue[i];
 		int len1, len2;
 
+		memset(&xecfg, 0, sizeof(xecfg));
 		if (p->status == 0)
 			return error("internal diff status error");
 		if (p->status == DIFF_STATUS_UNKNOWN)
diff --git a/merge-file.c b/merge-file.c
index 748d15c..1e031ea 100644
--- a/merge-file.c
+++ b/merge-file.c
@@ -62,6 +62,7 @@ static int generate_common_file(mmfile_t *res, mmfile_t *f1, mmfile_t *f2)
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
 	xecfg.flags = XDL_EMIT_COMMON;
 	ecb.outf = common_outf;
diff --git a/merge-tree.c b/merge-tree.c
index 3b8d9e6..7d4f628 100644
--- a/merge-tree.c
+++ b/merge-tree.c
@@ -106,8 +106,8 @@ static void show_diff(struct merge_list *entry)
 	xdemitcb_t ecb;
 
 	xpp.flags = XDF_NEED_MINIMAL;
+	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 3;
-	xecfg.flags = 0;
 	ecb.outf = show_outf;
 	ecb.priv = NULL;
 
-- 
1.5.3.rc0.818.ga2b52
