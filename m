From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/5] blame: use hunk_func(), part 2
Date: Wed, 09 May 2012 22:22:47 +0200
Message-ID: <4FAAD217.6040702@lsrfire.ath.cx>
References: <4FAAD13E.8030806@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 09 22:23:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSDPf-0004s3-8x
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 22:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761003Ab2EIUXC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 May 2012 16:23:02 -0400
Received: from india601.server4you.de ([85.25.151.105]:59439 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758540Ab2EIUXB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2012 16:23:01 -0400
Received: from [192.168.2.105] (p4FFD8B75.dip.t-dialin.net [79.253.139.117])
	by india601.server4you.de (Postfix) with ESMTPSA id 6D7052F803C;
	Wed,  9 May 2012 22:22:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <4FAAD13E.8030806@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197506>

Use handle_split_cb() directly as hunk_func() callback, without going
through xdi_diff_hunks().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/blame.c |   18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9ae5cf3..c83fc7c 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -906,12 +906,15 @@ struct handle_split_cb_data {
 	long tlno;
 };
 
-static void handle_split_cb(void *data, long same, long p_next, long t_next)
+static int handle_split_cb(long start_a, long count_a,
+			   long start_b, long count_b, void *data)
 {
 	struct handle_split_cb_data *d = data;
-	handle_split(d->sb, d->ent, d->tlno, d->plno, same, d->parent, d->split);
-	d->plno = p_next;
-	d->tlno = t_next;
+	handle_split(d->sb, d->ent, d->tlno, d->plno, start_b, d->parent,
+		     d->split);
+	d->plno = start_a + count_a;
+	d->tlno = start_b + count_b;
+	return 0;
 }
 
 /*
@@ -931,6 +934,8 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	struct handle_split_cb_data d;
 	xpparam_t xpp;
 	xdemitconf_t xecfg;
+	xdemitcb_t ecb;
+
 	memset(&d, 0, sizeof(d));
 	d.sb = sb; d.ent = ent; d.parent = parent; d.split = split;
 	/*
@@ -954,8 +959,11 @@ static void find_copy_in_blob(struct scoreboard *sb,
 	xpp.flags = xdl_opts;
 	memset(&xecfg, 0, sizeof(xecfg));
 	xecfg.ctxlen = 1;
+	xecfg.hunk_func = handle_split_cb;
+	memset(&ecb, 0, sizeof(ecb));
+	ecb.priv = &d;
 	memset(split, 0, sizeof(struct blame_entry [3]));
-	xdi_diff_hunks(file_p, &file_o, handle_split_cb, &d, &xpp, &xecfg);
+	xdi_diff(file_p, &file_o, &xpp, &xecfg, &ecb);
 	/* remainder, if any, all match the preimage */
 	handle_split(sb, ent, d.tlno, d.plno, ent->num_lines, parent, split);
 }
-- 
1.7.10.1
