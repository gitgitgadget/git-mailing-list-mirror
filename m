From: Stefan Naewe <stefan.naewe@gmail.com>
Subject: [PATCH] revision.c: fix possible null pointer access
Date: Thu,  3 Dec 2015 20:32:16 +0100
Message-ID: <1449171136-31566-1-git-send-email-stefan.naewe@gmail.com>
Cc: Stefan Naewe <stefan.naewe@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 03 20:32:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4ZcG-0008Pt-SD
	for gcvg-git-2@plane.gmane.org; Thu, 03 Dec 2015 20:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbbLCTc2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2015 14:32:28 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:34443 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbLCTc1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2015 14:32:27 -0500
Received: by wmvv187 with SMTP id v187so43281100wmv.1
        for <git@vger.kernel.org>; Thu, 03 Dec 2015 11:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BQeHPPU+QgH+ZWGsAAEWBlj95ux4n991m41nEzCFslY=;
        b=04WX06o+VUIHQPhr3e+FbZbkFOdpI7OPevs1yijVZ2mVOJyxrJX4GuOPsixTt1eEjy
         JFrhkSfOZVtpw/xEXkn3N0LPrlv9fily38JMqGwdrsNRJv0ojULDnSssPaVKpDAk5MPs
         z6ZbaYTcB2B6FEqyKIjSG96Op7JDcQ6NRSjK1ehbMdd5hBwSQ5i3AGhlF07KaqF3eg1p
         glsTIdIsYocnBORxnSd4y8VBaJqOTNvyS/alrfR2qX3swifgide+gM/v22gf46VyYN1z
         wffF0iz8IOMr0k4PkBTPIdj/tedNYlWytkTBMmR+OxGrgcI3T7YWY80x7tneELVg7XrZ
         JEWg==
X-Received: by 10.28.15.194 with SMTP id 185mr418246wmp.9.1449171146017;
        Thu, 03 Dec 2015 11:32:26 -0800 (PST)
Received: from localhost.localdomain (dslb-092-077-029-007.092.077.pools.vodafone-ip.de. [92.77.29.7])
        by smtp.gmail.com with ESMTPSA id he3sm8925184wjc.25.2015.12.03.11.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Dec 2015 11:32:25 -0800 (PST)
X-Mailer: git-send-email 2.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281962>

Two functions dereference a tree pointer before checking
if the pointer is valid. Fix that by doing the check first.

Signed-off-by: Stefan Naewe <stefan.naewe@gmail.com>
---
This has been reported through the CppHints newsletter (http://cpphints.com/hints/40)
but doesn't seem to have made its way to the ones who care (the git list
that is...)

 revision.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 0fbb684..bb40179 100644
--- a/revision.c
+++ b/revision.c
@@ -104,7 +104,12 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
-	struct object *obj = &tree->object;
+	struct object *obj;
+
+	if (!tree)
+		return;
+
+	obj = &tree->object;
 
 	if (!has_sha1_file(obj->sha1))
 		return;
@@ -135,10 +140,13 @@ static void mark_tree_contents_uninteresting(struct tree *tree)
 
 void mark_tree_uninteresting(struct tree *tree)
 {
-	struct object *obj = &tree->object;
+	struct object *obj;
 
 	if (!tree)
 		return;
+
+	obj = &tree->object;
+
 	if (obj->flags & UNINTERESTING)
 		return;
 	obj->flags |= UNINTERESTING;
-- 
2.6.3
