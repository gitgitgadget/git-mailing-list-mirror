From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 2/5] Bypass textual patch generation and parsing in git blame
Date: Thu, 21 Aug 2008 18:21:58 -0500
Message-ID: <1219360921-28529-3-git-send-email-bdowning@lavos.net>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net>
 <1219360921-28529-2-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 01:34:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWJfE-0003Ti-8r
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 01:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbYHUXcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 19:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbYHUXcp
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 19:32:45 -0400
Received: from mail.somat.com ([63.252.84.66]:50096 "EHLO somat1.somat.local"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754376AbYHUXcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 19:32:43 -0400
X-Greylist: delayed 634 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Aug 2008 19:32:39 EDT
Received: from silvara.lavos.net ([192.168.0.108]) by somat1.somat.local with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 21 Aug 2008 18:22:01 -0500
Received: (nullmailer pid 28567 invoked by uid 1000);
	Thu, 21 Aug 2008 23:22:01 -0000
X-Mailer: git-send-email 1.5.6.1
In-Reply-To: <1219360921-28529-2-git-send-email-bdowning@lavos.net>
X-OriginalArrivalTime: 21 Aug 2008 23:22:01.0445 (UTC) FILETIME=[B7005950:01C903E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93228>

This uses the new xdiff emit_func feature to directly generate the
patch/chunk information from the low-level diff output, rather than
generating and parsing a patch.  This improves performance considerably
for certain test cases:

:; time git-blame -M -C -C -p --incremental server.c >/dev/null
Before:
79.62user 0.10system 1:19.81elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+41189minor)pagefaults 0swaps
After:
48.66user 0.08system 0:48.75elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+36961minor)pagefaults 0swaps

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 builtin-blame.c |   90 +++++++++++++++++++------------------------------------
 1 files changed, 31 insertions(+), 59 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index e4d12de..60f70bf 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -19,6 +19,10 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "parse-options.h"
+#include "xdiff/xtypes.h"
+#include "xdiff/xdiffi.h"
+#include "xdiff/xemit.h"
+#include "xdiff/xmacros.h"
 
 static char blame_usage[] = "git blame [options] [rev-opts] [rev] [--] file";
 
@@ -464,62 +468,36 @@ struct patch {
 	int num;
 };
 
-struct blame_diff_state {
-	struct patch *ret;
-	unsigned hunk_post_context;
-	unsigned hunk_in_pre_context : 1;
-};
-
-static void process_u_diff(void *state_, char *line, unsigned long len)
+static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+			xdemitconf_t const *xecfg)
 {
-	struct blame_diff_state *state = state_;
+	struct patch *patch = ecb->priv;
+	long s1, s2;
+	xdchange_t *xch, *xche;
 	struct chunk *chunk;
-	int off1, off2, len1, len2, num;
 
-	num = state->ret->num;
-	if (len < 4 || line[0] != '@' || line[1] != '@') {
-		if (state->hunk_in_pre_context && line[0] == ' ')
-			state->ret->chunks[num - 1].same++;
-		else {
-			state->hunk_in_pre_context = 0;
-			if (line[0] == ' ')
-				state->hunk_post_context++;
-			else
-				state->hunk_post_context = 0;
-		}
-		return;
-	}
+	for (xch = xche = xscr; xch; xch = xche->next) {
+		xche = xdl_get_hunk(xch, xecfg);
 
-	if (num && state->hunk_post_context) {
-		chunk = &state->ret->chunks[num - 1];
-		chunk->p_next -= state->hunk_post_context;
-		chunk->t_next -= state->hunk_post_context;
-	}
-	state->ret->num = ++num;
-	state->ret->chunks = xrealloc(state->ret->chunks,
-				      sizeof(struct chunk) * num);
-	chunk = &state->ret->chunks[num - 1];
-	if (parse_hunk_header(line, len, &off1, &len1, &off2, &len2)) {
-		state->ret->num--;
-		return;
-	}
-
-	/* Line numbers in patch output are one based. */
-	off1--;
-	off2--;
+		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
+		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
 
-	chunk->same = len2 ? off2 : (off2 + 1);
+		++patch->num;
+		patch->chunks = xrealloc(patch->chunks,
+					 sizeof(struct chunk) * patch->num);
+		chunk = &patch->chunks[patch->num - 1];
+		chunk->same = s2 + XDL_MAX(xch->i1 - s1, 0);
+		chunk->p_next = xche->i1 + xche->chg1;
+		chunk->t_next = xche->i2 + xche->chg2;
+	}
 
-	chunk->p_next = off1 + (len1 ? len1 : 1);
-	chunk->t_next = chunk->same + len2;
-	state->hunk_in_pre_context = 1;
-	state->hunk_post_context = 0;
+	return 0;
 }
 
 static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 				    int context)
 {
-	struct blame_diff_state state;
+	struct patch *patch;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
 	xdemitcb_t ecb;
@@ -527,20 +505,14 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = context;
-	memset(&state, 0, sizeof(state));
-	state.ret = xmalloc(sizeof(struct patch));
-	state.ret->chunks = NULL;
-	state.ret->num = 0;
-
-	xdi_diff_outf(file_p, file_o, process_u_diff, &state, &xpp, &xecfg, &ecb);
+	patch = xmalloc(sizeof(struct patch));
+	patch->chunks = NULL;
+	patch->num = 0;
+	xecfg.emit_func = (void (*)())process_diff;
+	ecb.priv = patch;
+	xdi_diff(file_p, file_o, &xpp, &xecfg, &ecb);
 
-	if (state.ret->num) {
-		struct chunk *chunk;
-		chunk = &state.ret->chunks[state.ret->num - 1];
-		chunk->p_next -= state.hunk_post_context;
-		chunk->t_next -= state.hunk_post_context;
-	}
-	return state.ret;
+	return patch;
 }
 
 /*
-- 
1.5.6.1
