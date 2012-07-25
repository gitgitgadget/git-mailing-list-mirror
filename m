From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/4] help.c: plug leaks with(out) help.autocorrect
Date: Thu, 26 Jul 2012 00:16:21 +0800
Message-ID: <1343232982-10540-4-git-send-email-rctay89@gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-1-git-send-email-rctay89@gmail.com>
 <1343232982-10540-2-git-send-email-rctay89@gmail.com>
 <1343232982-10540-3-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	Thomas Rast <trast@student.ethz.ch>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 25 18:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su4Gk-0007Bf-Ph
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 18:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573Ab2GYQQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 12:16:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55919 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756426Ab2GYQQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 12:16:49 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so1628912pbb.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 09:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ve+juH0mxkeg0y6S3zOdTC7GXJpfyLLKzNN1LVG3dXE=;
        b=kdpES3KNBe+47p4th39MhPIAuB7jQvV7ephuQ3FEjk3LcPXuNWm5Asl0OH0s+NtwmH
         SckYW2ddPi8SY1dT8q+eeZNdLMNNHyZWoe9faqXBixZv+bD+k1L1NLReKqGj46g2MbmM
         L9FlQjWhV5kulWZv+sX/15+4UOMREWcNkef0gQnvtzwbpHg2RO7LCvuxXBsSH0LkT0xt
         2i7EM6gtKWGOLTvLYt+LWHWYQvDcPOG7PTMsZwOCk7j8xzA8O5ZZskSFDZQuvoszBLqE
         vG1eH+4CRexFHjjPsFQfPNOmgG17zFoJPXuRM41bfv/PyCf/KaSzUlRo1vb7KyPM+m9I
         2w7w==
Received: by 10.68.130.67 with SMTP id oc3mr54643868pbb.18.1343233009134;
        Wed, 25 Jul 2012 09:16:49 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (cm97.beta238.maxonline.com.sg. [116.86.238.97])
        by mx.google.com with ESMTPS id hw6sm14629418pbc.73.2012.07.25.09.16.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 09:16:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.1.116.g8228a23
In-Reply-To: <1343232982-10540-3-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202171>

When help.autocorrect is set, in an attempt to retain the memory to the
string name in main_cmds, we unfortunately leaked the struct cmdname
that held it. Fix this by creating a copy of the string name.

When help.autocorrect is not set, we exit()'d without free'ing it like
we do when the config is set; fix this.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

Changed in v2: plug leak when help.autocorrect is not set.

---
 help.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index dfb2e9d..ee261f4 100644
--- a/help.c
+++ b/help.c
@@ -362,8 +362,7 @@ const char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 	if (autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
-		const char *assumed = main_cmds.names[0]->name;
-		main_cmds.names[0] = NULL;
+		const char *assumed = xstrdup(main_cmds.names[0]->name);
 		clean_cmdnames(&main_cmds);
 		fprintf_ln(stderr,
 			   _("WARNING: You called a Git command named '%s', "
@@ -390,6 +389,7 @@ const char *help_unknown_cmd(const char *cmd)
 			fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);
 	}
 
+	clean_cmdnames(&main_cmds);
 	exit(1);
 }
 
-- 
1.7.11.1.116.g8228a23
