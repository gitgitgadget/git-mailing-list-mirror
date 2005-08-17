From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] When copying or renaming, keep the mode, please
Date: Wed, 17 Aug 2005 09:01:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508170900420.3236@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Aug 17 09:02:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5HvE-0006mm-34
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 09:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVHQHBJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 03:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbVHQHBJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 03:01:09 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:26249 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750939AbVHQHBI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2005 03:01:08 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6DFF3E2574; Wed, 17 Aug 2005 09:01:07 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4CD41AD79D; Wed, 17 Aug 2005 09:01:07 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E420AD5B5; Wed, 17 Aug 2005 09:01:07 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 179D8E2574; Wed, 17 Aug 2005 09:01:07 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Without this patch, git-apply does not retain the mode when renaming or
copying files.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

 apply.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

8dca30668d7077fa9b9157c3685b3ace8598a514
diff --git a/apply.c b/apply.c
--- a/apply.c
+++ b/apply.c
@@ -1043,8 +1043,12 @@ static int check_patch(struct patch *pat
 			return error("%s: already exists in working directory", new_name);
 		if (errno != ENOENT)
 			return error("%s: %s", new_name, strerror(errno));
-		if (!patch->new_mode)
-			patch->new_mode = S_IFREG | 0644;
+		if (!patch->new_mode) {
+			if (patch->is_new)
+				patch->new_mode = S_IFREG | 0644;
+			else
+				patch->new_mode = patch->old_mode;
+		}
 	}
 
 	if (new_name && old_name) {
