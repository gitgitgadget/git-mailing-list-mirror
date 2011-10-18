From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 4/4] pack-objects: rewrite add_descendants_to_write_order() iteratively
Date: Tue, 18 Oct 2011 00:21:24 -0500
Message-ID: <1318915284-6361-4-git-send-email-dpmcgee@gmail.com>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:21:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG27P-0001Ah-9d
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab1JRFVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:21:35 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:65245 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab1JRFVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:21:33 -0400
Received: by mail-iy0-f174.google.com with SMTP id k3so290439iae.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 22:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=fBJ5ATDKAno0GmaQ690qYaoerCPW//7dEVtZN/GSI4E=;
        b=SXdmZiGDhadg+ZZUeYrte71cfxwp8S7qcIiewgpWk3oM0zHhyTv/7wk7rUT+/TUHkm
         GQ7PLCMFTAFrQBgYUjN0Jkvy4lUSD1KTcAlo2DmAZ1qVmt8al4pURZAJ7nfDId6o0Xfj
         E4K3HuOroomrjWPBJMTAYfM1KG6DfKWNGFe7Q=
Received: by 10.42.154.194 with SMTP id r2mr1482563icw.50.1318915293681;
        Mon, 17 Oct 2011 22:21:33 -0700 (PDT)
Received: from localhost (c-71-194-41-240.hsd1.il.comcast.net. [71.194.41.240])
        by mx.google.com with ESMTPS id p16sm2493593ibk.6.2011.10.17.22.21.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 17 Oct 2011 22:21:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183856>

This removes the need to call this function recursively, shinking the
code size slightly and netting a small performance increase.

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 builtin/pack-objects.c |   44 +++++++++++++++++++++++++++++++++++++-------
 1 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d9fb202..9efd1a7 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -468,12 +468,43 @@ static void add_descendants_to_write_order(struct object_entry **wo,
 					   unsigned int *endp,
 					   struct object_entry *e)
 {
-	struct object_entry *child;
-
-	for (child = e->delta_child; child; child = child->delta_sibling)
-		add_to_write_order(wo, endp, child);
-	for (child = e->delta_child; child; child = child->delta_sibling)
-		add_descendants_to_write_order(wo, endp, child);
+	int add_to_order = 1;
+	while (e) {
+		if (add_to_order) {
+			struct object_entry *s;
+			/* add this node... */
+			add_to_write_order(wo, endp, e);
+			/* all its siblings... */
+			for (s = e->delta_sibling; s; s = s->delta_sibling) {
+				add_to_write_order(wo, endp, s);
+			}
+		}
+		/* drop down a level to add left subtree nodes if possible */
+		if (e->delta_child) {
+			add_to_order = 1;
+			e = e->delta_child;
+		} else {
+			add_to_order = 0;
+			/* our sibling might have some children, it is next */
+			if (e->delta_sibling) {
+				e = e->delta_sibling;
+				continue;
+			}
+			/* go back to our parent node */
+			e = e->delta;
+			while (e && !e->delta_sibling) {
+				/* we're on the right side of a subtree, keep
+				 * going up until we can go right again */
+				e = e->delta;
+			}
+			if (!e) {
+				/* done- we hit our original root node */
+				return;
+			}
+			/* pass it off to sibling at this level */
+			e = e->delta_sibling;
+		}
+	};
 }
 
 static void add_family_to_write_order(struct object_entry **wo,
@@ -484,7 +515,6 @@ static void add_family_to_write_order(struct object_entry **wo,
 
 	for (root = e; root->delta; root = root->delta)
 		; /* nothing */
-	add_to_write_order(wo, endp, root);
 	add_descendants_to_write_order(wo, endp, root);
 }
 
-- 
1.7.7
