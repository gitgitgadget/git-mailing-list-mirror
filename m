From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 2/4] help.c::exclude_cmds: realloc() before copy, plug a leak
Date: Thu, 26 Jul 2012 00:16:20 +0800
Message-ID: <1343232982-10540-3-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4Gk-0007Bf-8o
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567Ab2GYQQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:16:49 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:54670 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2GYQQs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:16:48 -0400
Received: by yhmm54 with SMTP id m54so885220yhm.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Vxny7sJVUGXKqcsjihLMw9txo4jnWRvLHi0nAacyitg=;
        b=yXnRX643fFNBQiw7sAK4EDCb42cYZ54e7Uq2dVFPiS4uiVGr99rf58CnCgoRUtQEe5
         Ao1TxZ9YETXQvV0H8ICm0XZtI0vU497du4kKsqDtt443fMw2YNMEYKFae2lEKJXqYFC9
         afVA+kgtFddezEDjkspvFCKZw3xYzKP7oJRlt+CF5NsH+0yYf3IFlOneGJ3rMegZ43gA
         6ClmXbOmZ/nZ8PtikT8XcsCzB4Tdqz/BpN6Xrqfuv7+VzakbTrPHXulGASDfWxyWHmGU
         l5vXzYbW4jGvWd++XPzGqMTwZwCdEYHJwuM7sLs5Zwh91TQ00ozH+2C68Zj0oTcsXiH/
         CGZg==
Received: by 10.66.82.97 with SMTP id h1mr13731624pay.45.1343233006894;
        Wed, 25 Jul 2012 09:16:46 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm97.beta238.maxonline.com.sg. [116.86.238.97])
        by mx.google.com with ESMTPS id hw6sm14629418pbc.73.2012.07.25.09.16.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 09:16:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.116.g8228a23
In-Reply-To: <1343232982-10540-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202170>

Copying with structural assignment may not take into account that the
LHS struct has sufficient memory, especially since the cmdname->name
member is nonfixed in size. Be unambiguous about it by realloc()'ing it
to be of sufficient size.

Additionally, free the unused cmdnames, which are no longer accessible
anyway.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 help.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 6991492..dfb2e9d 100644
--- a/help.c
+++ b/help.c
@@ -20,6 +20,17 @@ void add_cmdname(struct cmdnames *cmds, const char *name, int len)
 	cmds->names[cmds->cnt++] = ent;
 }
 
+static void copy_cmdname(struct cmdname **dest, struct cmdname *src)
+{
+	struct cmdname *ent = xrealloc(*dest, sizeof(*ent) + src->len + 1);
+
+	ent->len = src->len;
+	memcpy(ent->name, src->name, src->len);
+	ent->name[src->len] = 0;
+
+	*dest = ent;
+}
+
 static void clean_cmdnames(struct cmdnames *cmds)
 {
 	int i;
@@ -58,20 +69,25 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 {
 	int ci, cj, ei;
 	int cmp;
+	int last_cj;
 
 	ci = cj = ei = 0;
 	while (ci < cmds->cnt && ei < excludes->cnt) {
 		cmp = strcmp(cmds->names[ci]->name, excludes->names[ei]->name);
 		if (cmp < 0)
-			cmds->names[cj++] = cmds->names[ci++];
+			copy_cmdname(&cmds->names[cj++], cmds->names[ci++]);
 		else if (cmp == 0)
 			ci++, ei++;
 		else if (cmp > 0)
 			ei++;
 	}
+	last_cj = cj;
 
 	while (ci < cmds->cnt)
-		cmds->names[cj++] = cmds->names[ci++];
+		copy_cmdname(&cmds->names[cj++], cmds->names[ci++]);
+
+	while (last_cj < cmds->cnt)
+		free(cmds->names[last_cj++]);
 
 	cmds->cnt = cj;
 }
-- 
1.7.11.1.116.g8228a23
