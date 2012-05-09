From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/5] xdiff: remove emit_func() and xdi_diff_hunks()
Date: Wed, 09 May 2012 22:24:34 +0200
Message-ID: <4FAAD282.1060105@lsrfire.ath.cx>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:24:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDRM-0005cS-Si
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761056Ab2EIUYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:24:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:59443 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761030Ab2EIUYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:24:47 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 4072D2F803C;
	Wed,  9 May 2012 22:24:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAAD13E.8030806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197508>

The functions are unused now, remove them.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff-interface.c |   44 --------------------------------------------
 xdiff-interface.h |    4 ----
 xdiff/xdiff.h     |    1 -
 xdiff/xdiffi.c    |    6 +-----
 4 files changed, 1 insertion(+), 54 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0e2c169..ecfa05f 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -156,50 +156,6 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	return ret;
 }
 
-struct xdiff_emit_hunk_state {
-	xdiff_emit_hunk_consume_fn consume;
-	void *consume_callback_data;
-};
-
-static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
-			xdemitconf_t const *xecfg)
-{
-	long s1, s2, same, p_next, t_next;
-	xdchange_t *xch, *xche;
-	struct xdiff_emit_hunk_state *state = ecb->priv;
-	xdiff_emit_hunk_consume_fn fn = state->consume;
-	void *consume_callback_data = state->consume_callback_data;
-
-	for (xch = xscr; xch; xch = xche->next) {
-		xche = xdl_get_hunk(xch, xecfg);
-
-		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
-		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
-		same = s2 + XDL_MAX(xch->i1 - s1, 0);
-		p_next = xche->i1 + xche->chg1;
-		t_next = xche->i2 + xche->chg2;
-
-		fn(consume_callback_data, same, p_next, t_next);
-	}
-	return 0;
-}
-
-int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
-		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
-		   xpparam_t const *xpp, xdemitconf_t *xecfg)
-{
-	struct xdiff_emit_hunk_state state;
-	xdemitcb_t ecb;
-
-	memset(&state, 0, sizeof(state));
-	memset(&ecb, 0, sizeof(ecb));
-	state.consume = fn;
-	state.consume_callback_data = consume_callback_data;
-	xecfg->emit_func = (void (*)())process_diff;
-	ecb.priv = &state;
-	return xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
-}
-
 int read_mmfile(mmfile_t *ptr, const char *filename)
 {
 	struct stat st;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 49d1116..eff7762 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -4,15 +4,11 @@
 #include "xdiff/xdiff.h"
 
 typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
-typedef void (*xdiff_emit_hunk_consume_fn)(void *, long, long, long);
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp, xdemitconf_t const *xecfg);
-int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
-		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
-		   xpparam_t const *xpp, xdemitconf_t *xecfg);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 33c010b..219a3bb 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -96,7 +96,6 @@ typedef struct s_xdemitconf {
 	unsigned long flags;
 	find_func_t find_func;
 	void *find_func_priv;
-	void (*emit_func)();
 	xdl_emit_hunk_consume_func_t hunk_func;
 } xdemitconf_t;
 
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 4d671f4..1b7012a 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -557,11 +557,7 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
 	xdchange_t *xscr;
 	xdfenv_t xe;
-	emit_func_t ef = xecfg->emit_func ?
-		(emit_func_t)xecfg->emit_func : xdl_emit_diff;
-
-	if (xecfg->hunk_func)
-		ef = xdl_call_hunk_func;
+	emit_func_t ef = xecfg->hunk_func ? xdl_call_hunk_func : xdl_emit_diff;
 
 	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
 
-- 
1.7.10.1
