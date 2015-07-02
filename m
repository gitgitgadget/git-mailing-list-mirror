From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH 1/4] list-object: add get_commit_count function
Date: Wed,  1 Jul 2015 22:38:53 -0700
Message-ID: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Cc: gitster@pobox.com, Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 07:39:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAXDf-0001Y2-Ed
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 07:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbbGBFjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 01:39:25 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:35551 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798AbbGBFjX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 01:39:23 -0400
Received: by ykdy1 with SMTP id y1so59351473ykd.2
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 22:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=bbUqfUE/5/a/e25A+TgqfvfZ//vsAydIyq4h6Hwcx6A=;
        b=gB/b2z4f2ExE3wnrESBSkldQXuRIvlPqDUm+W5gctDt29Awd2vzuXXryO7T1848sRc
         frhEZv6FApLu22rP0REvFn542PXNZ4z0CHglf4qM547fc+ag1ShTRG/u4Sevg5ukW00a
         d5ao/Qh5awK/wSoz4GgSPjb9X0nWW5je4eCQG+6GojmBizm/kQd7R4ZNs0iKFApRCFpS
         oEotLgfEkKhKS181GKTM7xej4iIOXRjaLABgxdrxQl1ki28JXPI+NOphE317bK88syHm
         21JCv77ymodMsF6unl5DqNHXecXzRYM0WDnXxGN6oy4nSJKE5ijVCY2Yz3NAn/9r9xOX
         8E9A==
X-Received: by 10.170.151.85 with SMTP id s82mr36786996ykc.31.1435815562809;
        Wed, 01 Jul 2015 22:39:22 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id m12sm4563641ywd.22.2015.07.01.22.39.21
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 22:39:22 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273212>

Moving commit counting from rev-list into list-object which is a step
toward letting git log do counting as well.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 builtin/rev-list.c | 12 ++----------
 list-objects.c     | 14 ++++++++++++++
 list-objects.h     |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..7b091db 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -388,16 +388,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 
 	traverse_commit_list(&revs, show_commit, show_object, &info);
 
-	if (revs.count) {
-		if (revs.left_right && revs.cherry_mark)
-			printf("%d\t%d\t%d\n", revs.count_left, revs.count_right, revs.count_same);
-		else if (revs.left_right)
-			printf("%d\t%d\n", revs.count_left, revs.count_right);
-		else if (revs.cherry_mark)
-			printf("%d\t%d\n", revs.count_left + revs.count_right, revs.count_same);
-		else
-			printf("%d\n", revs.count_left + revs.count_right);
-	}
+	if (revs.count) 
+		get_commit_count(&revs);  
 
 	return 0;
 }
diff --git a/list-objects.c b/list-objects.c
index 41736d2..6f76301 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -234,3 +234,17 @@ void traverse_commit_list(struct rev_info *revs,
 	object_array_clear(&revs->pending);
 	strbuf_release(&base);
 }
+
+void get_commit_count(struct rev_info * revs) {
+	if (revs->count) {
+		if (revs->left_right && revs->cherry_mark)
+			printf("%d\t%d\t%d\n", revs->count_left, revs->count_right, revs->count_same);
+		else if (revs->left_right)
+			printf("%d\t%d\n", revs->count_left, revs->count_right);
+		else if (revs->cherry_mark)
+			printf("%d\t%d\n", revs->count_left + revs->count_right, revs->count_same);
+		else
+			printf("%d\n", revs->count_left + revs->count_right);
+	}
+	return;
+}
diff --git a/list-objects.h b/list-objects.h
index 136a1da..d28c1f3 100644
--- a/list-objects.h
+++ b/list-objects.h
@@ -7,5 +7,6 @@ void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, voi
 
 typedef void (*show_edge_fn)(struct commit *);
 void mark_edges_uninteresting(struct rev_info *, show_edge_fn);
+void get_commit_count(struct rev_info * revs);
 
 #endif
-- 
1.9.1
