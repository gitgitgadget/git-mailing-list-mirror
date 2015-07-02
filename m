From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH v2 1/4] list-object: add get_commit_count function
Date: Thu,  2 Jul 2015 16:50:08 -0700
Message-ID: <1435881011-13879-2-git-send-email-lawrencesiebert@gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoFn-0005Eb-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:50:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbbGBXuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 19:50:46 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36268 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbbGBXum (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 19:50:42 -0400
Received: by ykdr198 with SMTP id r198so82511180ykd.3
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ddsjWwqNsejaG/nQRe2E8cT44HiP2tzxJQyHvnynegM=;
        b=FutqsfMz4oGwoUBLUZCPvDgmZiXrX1dfBQKzCFThlp56HcLXuNSQOc510kfi3lL4zI
         dvXykf9eD4yUYg9bYdNd0KkHcbGxjFethSxDFU+bljxsH+IXZLHYOIF54bqs036rDQGF
         Ot2tjKWZ8+2LQLWbv/CPLfz93seiNidvCMwbY6HI1d/kjjf+ygkQMyBx9l6qUb9rRPMD
         x5PHSjGq+/8Ta4eiwAS7YGIvFXt8cEq9g7mN8YAywMhdUfHbCSLrc7mHgWo0fH/BxY+H
         kUeierugSugCS1TerHPtctgauP75szhRxlKME6nY0tvT9Y0M9X/phpPddujdJGgOEElw
         KH4Q==
X-Received: by 10.170.154.212 with SMTP id v203mr41747879ykc.0.1435881041498;
        Thu, 02 Jul 2015 16:50:41 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b131sm7190938ywc.18.2015.07.02.16.50.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 16:50:41 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273275>

Moving commit counting from rev-list into list-object which is a step
toward letting git log do counting as well.

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 builtin/rev-list.c | 12 ++----------
 list-objects.c     | 14 ++++++++++++++
 list-objects.h     |  1 +
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index ff84a82..07f522b 100644
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
