From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 3/4] help.c: plug a leak when help.autocorrect is set
Date: Sun,  6 May 2012 14:55:29 +0800
Message-ID: <1336287330-7215-4-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
 <1336287330-7215-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:56:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQvO9-0004bP-Im
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 08:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab2EFG4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 02:56:10 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39937 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab2EFGzt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 02:55:49 -0400
Received: by mail-pz0-f42.google.com with SMTP id f4so2666026dal.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=uC+9ewtOgx3Q91OaCiQt/e5EwWjYG1cTg4d8Ax/SuFk=;
        b=vGKfg7pL321i9bR3XEyyLD7G88+wp7I2WsZAbLmNCHpVwOr4sv+qK2XPJQ7BhmZ/Qb
         fqWF2bmEPDOAnhfW99I36rZI3ZcQNDeOpi+KMyucaM/RpWBmjSNKnVwZt5FoQGXBC0LE
         02KPj3MJ7lok2xIgMFgtkfHqvZKE1qE2oIzh/yBBgeMSGgk0HBXt4omHF6MhUMoeofuw
         33qJhkdtLgTd1l1phgj5y0QtsakaCVFxc4qibdjhpF6Qv0bALYApuxUlOV1zknmJp4w6
         UKwvtWMvRNqr0lSA3TJb5MPWAHf4/meET1L8SBNCRPNMMG6GljDOZ4r/icXkFrtJCxMj
         8m0Q==
Received: by 10.68.244.40 with SMTP id xd8mr17081857pbc.132.1336287349638;
        Sat, 05 May 2012 23:55:49 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm32.beta238.maxonline.com.sg. [116.86.238.32])
        by mx.google.com with ESMTPS id wn3sm14086094pbc.74.2012.05.05.23.55.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 23:55:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.611.g8a79d96
In-Reply-To: <1336287330-7215-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197152>

In an attempt to retain the memory to the string name in main_cmds, we
unfortunately leaked the struct cmdname that held it. Fix this by
creating a copy of the name.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 help.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 705f152..f296d95 100644
--- a/help.c
+++ b/help.c
@@ -360,8 +360,7 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		const char *assumed = main_cmds.names[0]->name;
-		main_cmds.names[0] = NULL;
+		const char *assumed = xstrdup(main_cmds.names[0]->name);
 		clean_cmdnames(&main_cmds);
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
-- 
1.7.10.1.611.g8a79d96
