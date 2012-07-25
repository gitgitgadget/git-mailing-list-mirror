From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 1/4] help.c::uniq: plug a leak
Date: Thu, 26 Jul 2012 00:16:19 +0800
Message-ID: <1343232982-10540-2-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:17:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4Gj-0007Bf-Ny
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:17:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756565Ab2GYQQq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:16:46 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:52343 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2GYQQp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:16:45 -0400
Received: by yenl2 with SMTP id l2so883455yen.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Ba1IWnJtpJ9qYEQnnlCxb4Iy8VV4rr1RT0Wjc7BAaTk=;
        b=pmuMo7796AiTinSerLlK1dyKF7z0q+ZwFMQ5B5BUVD4EozWx+hQaSjZYP9bmun1D57
         cZx/PY1CemG1BL544EtQKNSJQgMgxprGNJGTVgarcDfOtGyKQQcW+60fOOKdYz/3rMbh
         J1EPVQ8y2pIoqa8eC86SCdu6N9jwsOCtijLUWATJBSSa8ko6tfkFVl9SK1Xd9r2EBCiC
         Q2RiWfYR50nAjkCKCPUteQRfFUYvkr6oewYO36Lf56qH7yXDMeDFmZkPkRmLTT5TH/sB
         iDEzTfenbXiK3mRwVDG5RErOcWPVEvfx5zdJhY4BeBjVYVb88rBywKCEkmVJZodNLxrF
         NqZQ==
Received: by 10.66.75.168 with SMTP id d8mr13770223paw.63.1343233004696;
        Wed, 25 Jul 2012 09:16:44 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm97.beta238.maxonline.com.sg. [116.86.238.97])
        by mx.google.com with ESMTPS id hw6sm14629418pbc.73.2012.07.25.09.16.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 09:16:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.116.g8228a23
In-Reply-To: <1343232982-10540-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202169>

From: Jeff King <peff@peff.net>

We observe that the j-1 element can serve the same purpose as the i-1
element that we use in the strcmp(); it is either:

  1. Exactly i-1, when the loop begins (and until we see a duplicate).

  2. The same pointer that was stored at i-1 (if it was not a duplicate,
     and we just copied it into place).

  3. A pointer to an equivalent string (i.e., we rejected i-1 _because_
     it was identical to j-1).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

---

Changed in v2: used Jeff's code from [1]. Patch text was also based on
it.

[1] <20120506081213.GA27878@sigill.intra.peff.net>
---
 help.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 662349d..6991492 100644
--- a/help.c
+++ b/help.c
@@ -44,9 +44,12 @@ static void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+	for (i = j = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[j-1]->name))
+			free(cmds->names[i]);
+		else
 			cmds->names[j++] = cmds->names[i];
+	}
 
 	cmds->cnt = j;
 }
-- 
1.7.11.1.116.g8228a23
