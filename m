From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/4] help.c::uniq: plug a leak
Date: Sun,  6 May 2012 14:55:27 +0800
Message-ID: <1336287330-7215-2-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 06 08:56:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQvO9-0004bP-1q
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 08:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532Ab2EFGzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 02:55:49 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39937 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab2EFGzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 02:55:44 -0400
Received: by mail-pz0-f42.google.com with SMTP id f4so2666026dal.1
        for <git@vger.kernel.org>; Sat, 05 May 2012 23:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=/WSO77HsszDbx/udPImYufQJMQ00yjqauyTcaP0wjNg=;
        b=vBNAz+U6uS9eWJ49jsc2fBWjbbaln3R+lX2LDdMb5EzGEGE87Ioawsnk2+P3Dd87PJ
         gwuq1UVmtzDQkNFM0vhnGqvXpQB7lZo5aYxXWAcCF7fwUSB5RxZMnQDaI6dlC3vHLSWk
         oBQQ0+sn8mRsPSsfR57HImbwGByXuKWeLe7FQpTvahrHCZ5taPumOjouD7ywFDe9FNkg
         gnvbfATGkJnryZwfoIvDrkFMkby1tZKx5o7FgTZJYXWaB0QMx8xLTJpOcwl/qdJ8Ag/5
         B0xS6N0xJxoiuz8mn4gmj3Hwl3nFa3tJTs/Ql66Dfhkv7Yf0+fPJlTM+enRvRqhL97Gc
         S6+w==
Received: by 10.68.224.167 with SMTP id rd7mr34039131pbc.129.1336287344120;
        Sat, 05 May 2012 23:55:44 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm32.beta238.maxonline.com.sg. [116.86.238.32])
        by mx.google.com with ESMTPS id wn3sm14086094pbc.74.2012.05.05.23.55.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 May 2012 23:55:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.1.611.g8a79d96
In-Reply-To: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197150>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 help.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 69d483d..b64056d 100644
--- a/help.c
+++ b/help.c
@@ -38,14 +38,24 @@ static int cmdname_compare(const void *a_, const void *b_)
 
 static void uniq(struct cmdnames *cmds)
 {
-	int i, j;
+	int i, j, c = 0;
 
 	if (!cmds->cnt)
 		return;
 
 	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name)) {
+
+			/* The i-1 entry was the cth duplicate
+			 * Guarantees c=0
+			 */
+			for (; c >= 1; c--)
+				free(cmds->names[i - c]);
+
 			cmds->names[j++] = cmds->names[i];
+		} else {
+			c++;
+		}
 
 	cmds->cnt = j;
 }
-- 
1.7.10.1.611.g8a79d96
