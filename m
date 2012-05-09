From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/5] blame: factor out helper for calling xdi_diff()
Date: Wed, 09 May 2012 22:23:39 +0200
Message-ID: <4FAAD24B.3010901@lsrfire.ath.cx>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDQT-0005Eg-Cz
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761001Ab2EIUXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:23:53 -0400
Received: from india601.server4you.de ([85.25.151.105]:59442 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758540Ab2EIUXx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:23:53 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 79AE32F803C;
	Wed,  9 May 2012 22:23:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAAD13E.8030806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197507>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/blame.c |   38 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 22 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index c83fc7c..778d661 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -88,6 +88,20 @@ struct origin {
 	char path[FLEX_ARRAY];
 };
 
+static int diff_hunks(mmfile_t *file_a, mmfile_t *file_b, long ctxlen,
+		      xdl_emit_hunk_consume_func_t hunk_func, void *cb_data)
+{
+	xpparam_t xpp = {0};
+	xdemitconf_t xecfg = {0};
+	xdemitcb_t ecb = {0};
+
+	xpp.flags = xdl_opts;
+	xecfg.ctxlen = ctxlen;
+	xecfg.hunk_func = hunk_func;
+	ecb.priv = cb_data;
+	return xdi_diff(file_a, file_b, &xpp, &xecfg, &ecb);
+}
+
 /*
  * Prepare diff_filespec and convert it using diff textconv API
  * if the textconv driver exists.
@@ -781,9 +795,6 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	int last_in_target;
 	mmfile_t file_p, file_o;
 	struct blame_chunk_cb_data d;
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
 
 	memset(&d, 0, sizeof(d));
 	d.sb = sb; d.target = target; d.parent = parent;
@@ -795,14 +806,7 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	fill_origin_blob(&sb->revs->diffopt, target, &file_o);
 	num_get_patch++;
 
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 0;
-	xecfg.hunk_func = blame_chunk_cb;
-	memset(&ecb, 0, sizeof(ecb));
-	ecb.priv = &d;
-	xdi_diff(&file_p, &file_o, &xpp, &xecfg, &ecb);
+	diff_hunks(&file_p, &file_o, 0, blame_chunk_cb, &d);
 	/* The rest (i.e. anything after tlno) are the same as the parent */
 	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
 
@@ -932,9 +936,6 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	int cnt;
 	mmfile_t file_o;
 	struct handle_split_cb_data d;
-	xpparam_t xpp;
-	xdemitconf_t xecfg;
-	xdemitcb_t ecb;
 
 	memset(&d, 0, sizeof(d));
 	d.sb = sb; d.ent = ent; d.parent = parent; d.split = split;
@@ -955,15 +956,8 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	 * file_o is a part of final image we are annotating.
 	 * file_p partially may match that image.
 	 */
-	memset(&xpp, 0, sizeof(xpp));
-	xpp.flags = xdl_opts;
-	memset(&xecfg, 0, sizeof(xecfg));
-	xecfg.ctxlen = 1;
-	xecfg.hunk_func = handle_split_cb;
-	memset(&ecb, 0, sizeof(ecb));
-	ecb.priv = &d;
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	xdi_diff(file_p, &file_o, &xpp, &xecfg, &ecb);
+	diff_hunks(file_p, &file_o, 1, handle_split_cb, &d);
 	/* remainder, if any, all match the preimage */
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
-- 
1.7.10.1
