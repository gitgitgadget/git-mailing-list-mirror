From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] add xdi_diff_hunks() for callers that only need hunk
 lengths
Date: Sat, 25 Oct 2008 15:31:15 +0200
Message-ID: <49031FA3.3050803@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 15:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtjFr-0000Pp-R5
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 15:32:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbYJYNbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 09:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYJYNbT
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 09:31:19 -0400
Received: from india601.server4you.de ([85.25.151.105]:56970 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbYJYNbS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 09:31:18 -0400
Received: from [10.0.1.100] (p57B7B97B.dip.t-dialin.net [87.183.185.123])
	by india601.server4you.de (Postfix) with ESMTPSA id ABF4B2F8045;
	Sat, 25 Oct 2008 15:31:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48BF0FBF.3010104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99111>

Based on a patch by Brian Downing, this uses the xdiff emit_func feature
to implement xdi_diff_hunks().  It's a function that calls a callback for
each hunk of a diff, passing its lengths.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff-interface.c |   49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 xdiff-interface.h |    4 ++++
 2 files changed, 52 insertions(+), 1 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 49e06af..e8ef46d 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,6 +1,9 @@
 #include "cache.h"
 #include "xdiff-interface.h"
-#include "strbuf.h"
+#include "xdiff/xtypes.h"
+#include "xdiff/xdiffi.h"
+#include "xdiff/xemit.h"
+#include "xdiff/xmacros.h"
 
 struct xdiff_emit_state {
 	xdiff_emit_consume_fn consume;
@@ -153,6 +156,50 @@ int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 	return ret;
 }
 
+struct xdiff_emit_hunk_state {
+	xdiff_emit_hunk_consume_fn consume;
+	void *consume_callback_data;
+};
+
+static int process_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+			xdemitconf_t const *xecfg)
+{
+	long s1, s2, same, p_next, t_next;
+	xdchange_t *xch, *xche;
+	struct xdiff_emit_hunk_state *state = ecb->priv;
+	xdiff_emit_hunk_consume_fn fn = state->consume;
+	void *consume_callback_data = state->consume_callback_data;
+
+	for (xch = xscr; xch; xch = xche->next) {
+		xche = xdl_get_hunk(xch, xecfg);
+
+		s1 = XDL_MAX(xch->i1 - xecfg->ctxlen, 0);
+		s2 = XDL_MAX(xch->i2 - xecfg->ctxlen, 0);
+		same = s2 + XDL_MAX(xch->i1 - s1, 0);
+		p_next = xche->i1 + xche->chg1;
+		t_next = xche->i2 + xche->chg2;
+
+		fn(consume_callback_data, same, p_next, t_next);
+	}
+	return 0;
+}
+
+int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
+		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
+		   xpparam_t const *xpp, xdemitconf_t *xecfg)
+{
+	struct xdiff_emit_hunk_state state;
+	xdemitcb_t ecb;
+
+	memset(&state, 0, sizeof(state));
+	memset(&ecb, 0, sizeof(ecb));
+	state.consume = fn;
+	state.consume_callback_data = consume_callback_data;
+	xecfg->emit_func = (void (*)())process_diff;
+	ecb.priv = &state;
+	return xdi_diff(mf1, mf2, xpp, xecfg, &ecb);
+}
+
 int read_mmfile(mmfile_t *ptr, const char *filename)
 {
 	struct stat st;
diff --git a/xdiff-interface.h b/xdiff-interface.h
index eaf9cd3..7352b9a 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -4,12 +4,16 @@
 #include "xdiff/xdiff.h"
 
 typedef void (*xdiff_emit_consume_fn)(void *, char *, unsigned long);
+typedef void (*xdiff_emit_hunk_consume_fn)(void *, long, long, long);
 
 int xdi_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp, xdemitconf_t const *xecfg, xdemitcb_t *ecb);
 int xdi_diff_outf(mmfile_t *mf1, mmfile_t *mf2,
 		  xdiff_emit_consume_fn fn, void *consume_callback_data,
 		  xpparam_t const *xpp,
 		  xdemitconf_t const *xecfg, xdemitcb_t *xecb);
+int xdi_diff_hunks(mmfile_t *mf1, mmfile_t *mf2,
+		   xdiff_emit_hunk_consume_fn fn, void *consume_callback_data,
+		   xpparam_t const *xpp, xdemitconf_t *xecfg);
 int parse_hunk_header(char *line, int len,
 		      int *ob, int *on,
 		      int *nb, int *nn);
-- 
1.6.0.3.514.g2f91b
