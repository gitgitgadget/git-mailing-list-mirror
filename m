From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 6/6] builtin-gc.c: use new pack_keep bitfield to detect .keep file existence
Date: Wed, 12 Nov 2008 11:59:07 -0600
Message-ID: <WFmMnhNsYRw3IUD8hZk59C3ZoEDrEYCSt5_rIQMMTYQv4ZvQe32lQz-HznOAfvnsLxMiqGz6XW4@cipher.nrlssc.navy.mil>
References: <NRnq_JA3Ngz2v6EUhSwtVu5zewgvJgLsW85zZZqzrYE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59MeWg__Hu_J0586FDlwkv7_Bb80SFy_3xVB_YmBMzdF0byAGksl5Rnk@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59JmvLQlpuqo-hsW2L51xXUJ0ETOpVPtrZvZzBrrquDq1PlXDGK5BhsQ@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Bod6u3kdkWtabbRw1_B1XS8U8eP3drqEMEsFa_-Q_Qu-xrbOsLcdzo@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59Ll3-y-Spr-gg7enTTiJoZ2xRB8K4w13wAlZBhI9MXJqCLarfq3OODE@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59PVSBNnWW0Ot3Am0gtsYesn_-APZGMYcRjOXaJqcBZo4pwvAKF-s_s0@cipher.nrlssc.navy.mil> <WFmMnhNsYRw3IUD8hZk59At-5jc1rZU5GaB35sb1epRZ6zwd7IMw9V94SQyEliIEyriM4J5j3AM@cipher.nrlssc.navy.mil>
Cc: peff@peff.net, git@vger.kernel.org, spearce@spearce.org,
	nico@cam.org, Brandon Casey <casey@nrlssc.navy.mil>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 12 19:01:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0K1H-0002R5-V9
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 19:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752293AbYKLR7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 12:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbYKLR7e
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 12:59:34 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50122 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYKLR7d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 12:59:33 -0500
Received: by mail.nrlssc.navy.mil id mACHxIYY019956; Wed, 12 Nov 2008 11:59:18 -0600
In-Reply-To: <WFmMnhNsYRw3IUD8hZk59At-5jc1rZU5GaB35sb1epRZ6zwd7IMw9V94SQyEliIEyriM4J5j3AM@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 12 Nov 2008 17:59:17.0763 (UTC) FILETIME=[61A23530:01C944F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100790>

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 builtin-gc.c |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 7af65bb..781df60 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -131,19 +131,9 @@ static int too_many_packs(void)
 
 	prepare_packed_git();
 	for (cnt = 0, p = packed_git; p; p = p->next) {
-		char path[PATH_MAX];
-		size_t len;
-		int keep;
-
 		if (!p->pack_local)
 			continue;
-		len = strlen(p->pack_name);
-		if (PATH_MAX <= len + 1)
-			continue; /* oops, give up */
-		memcpy(path, p->pack_name, len-5);
-		memcpy(path + len - 5, ".keep", 6);
-		keep = access(p->pack_name, F_OK) && (errno == ENOENT);
-		if (keep)
+		if (p->pack_keep)
 			continue;
 		/*
 		 * Perhaps check the size of the pack and count only
-- 
1.6.0.3.552.g12334
