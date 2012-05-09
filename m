From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] xdiff: add hunk_func()
Date: Wed, 09 May 2012 22:20:55 +0200
Message-ID: <4FAAD1A7.50206@lsrfire.ath.cx>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDNr-00043Z-9I
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760151Ab2EIUVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:21:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:59435 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758318Ab2EIUVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:21:09 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 8A2CA2F803C;
	Wed,  9 May 2012 22:21:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAAD13E.8030806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197503>

Add a way to register a callback function that is gets passed the
start line and line count of each hunk of a diff.  Only standard
types are used.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 xdiff/xdiff.h  |    5 +++++
 xdiff/xdiffi.c |   17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index 09215af..33c010b 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -86,6 +86,10 @@ typedef struct s_xdemitcb {
 
 typedef long (*find_func_t)(const char *line, long line_len, char *buffer, long buffer_size, void *priv);
 
+typedef int (*xdl_emit_hunk_consume_func_t)(long start_a, long count_a,
+					    long start_b, long count_b,
+					    void *cb_data);
+
 typedef struct s_xdemitconf {
 	long ctxlen;
 	long interhunkctxlen;
@@ -93,6 +97,7 @@ typedef struct s_xdemitconf {
 	find_func_t find_func;
 	void *find_func_priv;
 	void (*emit_func)();
+	xdl_emit_hunk_consume_func_t hunk_func;
 } xdemitconf_t;
 
 typedef struct s_bdiffparam {
diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index bc889e8..4d671f4 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -538,6 +538,20 @@ void xdl_free_script(xdchange_t *xscr) {
 	}
 }
 
+static int xdl_call_hunk_func(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
+			      xdemitconf_t const *xecfg)
+{
+	xdchange_t *xch, *xche;
+
+	for (xch = xscr; xch; xch = xche->next) {
+		xche = xdl_get_hunk(xch, xecfg);
+		if (xecfg->hunk_func(xch->i1, xche->i1 + xche->chg1 - xch->i1,
+				     xch->i2, xche->i2 + xche->chg2 - xch->i2,
+				     ecb->priv) < 0)
+			return -1;
+	}
+	return 0;
+}
 
 int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
@@ -546,6 +560,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
 	emit_func_t ef = xecfg->emit_func ?
 		(emit_func_t)xecfg->emit_func : xdl_emit_diff;
 
+	if (xecfg->hunk_func)
+		ef = xdl_call_hunk_func;
+
 	if (xdl_do_diff(mf1, mf2, xpp, &xe) < 0) {
 
 		return -1;
-- 
1.7.10.1
