From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/5] blame: use hunk_func(), part 1
Date: Wed, 09 May 2012 22:21:56 +0200
Message-ID: <4FAAD1E4.30906@lsrfire.ath.cx>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:22:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDOo-0004WD-Kp
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760165Ab2EIUWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:22:10 -0400
Received: from india601.server4you.de ([85.25.151.105]:59437 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758318Ab2EIUWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:22:09 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id AD2DE2F803C;
	Wed,  9 May 2012 22:22:07 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAAD13E.8030806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197504>

Use blame_chunk_cb() directly as hunk_func() callback, without detour
through xdi_diff_hunks().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/blame.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 324d476..9ae5cf3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -759,12 +759,14 @@ struct blame_chunk_cb_data {
 	long tlno;
 };
 
-static void blame_chunk_cb(void *data, long same, long p_next, long t_next)
+static int blame_chunk_cb(long start_a, long count_a,
+			  long start_b, long count_b, void *data)
 {
 	struct blame_chunk_cb_data *d = data;
-	blame_chunk(d->sb, d->tlno, d->plno, same, d->target, d->parent);
-	d->plno = p_next;
-	d->tlno = t_next;
+	blame_chunk(d->sb, d->tlno, d->plno, start_b, d->target, d->parent);
+	d->plno = start_a + count_a;
+	d->tlno = start_b + count_b;
+	return 0;
 }
 
 /*
@@ -781,6 +783,8 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	struct blame_chunk_cb_data d;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
 	memset(&d, 0, sizeof(d));
 	d.sb = sb; d.target = target; d.parent = parent;
 	last_in_target = find_last_in_target(sb, target);
@@ -795,7 +799,10 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 0;
-	xdi_diff_hunks(&file_p, &file_o, blame_chunk_cb, &d, &xpp, &xecfg);
+	xecfg.hunk_func = blame_chunk_cb;
+	memset(&ecb, 0, sizeof(ecb));
+	ecb.priv = &d;
+	xdi_diff(&file_p, &file_o, &xpp, &xecfg, &ecb);
 	/* The rest (i.e. anything after tlno) are the same as the parent */
 	blame_chunk(sb, d.tlno, d.plno, last_in_target, target, parent);
 
-- 
1.7.10.1
