From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/5] blame: inline get_patch()
Date: Sat, 25 Oct 2008 15:30:22 +0200
Message-ID: <49031F6E.7040402@lsrfire.ath.cx>
References: <1219360921-28529-1-git-send-email-bdowning@lavos.net> <1219360921-28529-2-git-send-email-bdowning@lavos.net> <48AFC73F.2010100@lsrfire.ath.cx> <20080824081254.GI31114@lavos.net> <48BF0FBF.3010104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Oct 25 15:32:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtjFc-0000Mb-Fw
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 15:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYJYNa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 09:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbYJYNa0
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 09:30:26 -0400
Received: from india601.server4you.de ([85.25.151.105]:56959 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782AbYJYNa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 09:30:26 -0400
Received: from [10.0.1.100] (p57B7B97B.dip.t-dialin.net [87.183.185.123])
	by india601.server4you.de (Postfix) with ESMTPSA id 3DEAA2F8045;
	Sat, 25 Oct 2008 15:30:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <48BF0FBF.3010104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99110>

Inline get_patch() to its only call site as a preparation for getting rid
of struct patch.  Also we don't need to check the ptr members because
fill_origin_blob() already did, and the caller didn't check for NULL
anyway, so drop the test.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-blame.c |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 48cc0c1..593b539 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -542,25 +542,6 @@ static struct patch *compare_buffer(mmfile_t *file_p, mmfile_t *file_o,
 	return state.ret;
 }
 
-/*
- * Run diff between two origins and grab the patch output, so that
- * we can pass blame for lines origin is currently suspected for
- * to its parent.
- */
-static struct patch *get_patch(struct origin *parent, struct origin *origin)
-{
-	mmfile_t file_p, file_o;
-	struct patch *patch;
-
-	fill_origin_blob(parent, &file_p);
-	fill_origin_blob(origin, &file_o);
-	if (!file_p.ptr || !file_o.ptr)
-		return NULL;
-	patch = compare_buffer(&file_p, &file_o, 0);
-	num_get_patch++;
-	return patch;
-}
-
 static void free_patch(struct patch *p)
 {
 	free(p->chunks);
@@ -824,12 +805,22 @@ static int pass_blame_to_parent(struct scoreboard *sb,
 {
 	int i, last_in_target, plno, tlno;
 	struct patch *patch;
+	mmfile_t file_p, file_o;
 
 	last_in_target = find_last_in_target(sb, target);
 	if (last_in_target < 0)
 		return 1; /* nothing remains for this target */
 
-	patch = get_patch(parent, target);
+	/*
+	 * Run diff between two origins and grab the patch output, so that
+	 * we can pass blame for lines origin is currently suspected for
+	 * to its parent.
+	 */
+	fill_origin_blob(parent, &file_p);
+	fill_origin_blob(target, &file_o);
+	patch = compare_buffer(&file_p, &file_o, 0);
+	num_get_patch++;
+
 	plno = tlno = 0;
 	for (i = 0; i < patch->num; i++) {
 		struct chunk *chunk = &patch->chunks[i];
-- 
1.6.0.3.514.g2f91b
