From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 35/37] handle_delete_modify(): Check whether D/F conflicts are still present
Date: Mon, 20 Sep 2010 02:29:08 -0600
Message-ID: <1284971350-30590-36-git-send-email-newren@gmail.com>
References: <1284971350-30590-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 20 10:30:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxblO-0006R4-EJ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Sep 2010 10:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967Ab0ITI2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 04:28:45 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:39104 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755919Ab0ITI2n (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 04:28:43 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1070490pzk.19
        for <git@vger.kernel.org>; Mon, 20 Sep 2010 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=wj7f1Esdn3y5WrBV2LunWrxTwpaY2vZ9VAEekBZPVKg=;
        b=aYqPVxZ4pARcRyOV3rmopZYjv8exAcpooUzclkUmyouvUzkio4zZqqx1equThmA6T6
         QylyEwSXeJBEwzkRpqHG0GdbasRqairGCu5QmdLvCxj3V/1vTAaHlIsirJCqlB97tQ7Y
         GDam9uW4jodQu54JaCkc4vqYCmxw5kABFU4bM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FytHgDmj+wCxasdjEqhBDKWmKjZlNhV+GoP5bf0ELrRdGf3Q5l581RHnWae+zg2/x2
         Ffandi8l+FnqVf9tRDIt2Ril1UTTrxDDBRup2Fc1jYhGn72jb89Dr8WIOW0ndwWykL7g
         +TQ/HJXbM4/kWqAP6fFDTLoAXk2Fry0wjIIOY=
Received: by 10.142.57.10 with SMTP id f10mr5889753wfa.330.1284971323041;
        Mon, 20 Sep 2010 01:28:43 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id 9sm9288954wfd.0.2010.09.20.01.28.40
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 20 Sep 2010 01:28:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.271.g16009
In-Reply-To: <1284971350-30590-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156585>

If all the paths below some directory involved in a D/F conflict were not
removed during the rest of the merge, then the contents of the file whose
path conflicted needs to be recorded in file with an alternative filename.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c   |   25 ++++++++++++++++---------
 t/t6020-merge-df.sh |    2 +-
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index a971d59..05da47c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1164,25 +1164,29 @@ error_return:
 
 static void handle_delete_modify(struct merge_options *o,
 				 const char *path,
+				 const char *new_path,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
 	if (!a_sha) {
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree.",
+		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch1,
-		       o->branch2, o->branch2, path);
-		update_file(o, 0, b_sha, b_mode, path);
+		       o->branch2, o->branch2, path,
+		       path == new_path ? "" : " at ",
+		       path == new_path ? "" : new_path);
+		update_file(o, 0, b_sha, b_mode, new_path);
 	} else {
 		output(o, 1, "CONFLICT (delete/modify): %s deleted in %s "
-		       "and modified in %s. Version %s of %s left in tree.",
+		       "and modified in %s. Version %s of %s left in tree%s%s.",
 		       path, o->branch2,
-		       o->branch1, o->branch1, path);
-		update_file(o, 0, a_sha, a_mode, path);
+		       o->branch1, o->branch1, path,
+		       path == new_path ? "" : " at ",
+		       path == new_path ? "" : new_path);
+		update_file(o, 0, a_sha, a_mode, new_path);
 	}
 }
 
-
 static int merge_content(struct merge_options *o,
 			 const char *path,
 			 unsigned char *o_sha, int o_mode,
@@ -1281,7 +1285,7 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Deleted in one and changed in the other */
 			clean_merge = 0;
-			handle_delete_modify(o, path,
+			handle_delete_modify(o, path, path,
 					     a_sha, a_mode, b_sha, b_mode);
 		}
 
@@ -1398,8 +1402,11 @@ static int process_df_entry(struct merge_options *o,
 		}
 	} else if (o_sha && (!a_sha || !b_sha)) {
 		/* Modify/delete; deleted side may have put a directory in the way */
+		const char *new_path = path;
+		if (lstat(path, &st) == 0 && S_ISDIR(st.st_mode))
+			new_path = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 		clean_merge = 0;
-		handle_delete_modify(o, path,
+		handle_delete_modify(o, path, new_path,
 				     a_sha, a_mode, b_sha, b_mode);
 	} else if (!o_sha && !!a_sha != !!b_sha) {
 		/* directory -> (directory, file) */
diff --git a/t/t6020-merge-df.sh b/t/t6020-merge-df.sh
index bc9db1a..7b1ce82 100755
--- a/t/t6020-merge-df.sh
+++ b/t/t6020-merge-df.sh
@@ -71,7 +71,7 @@ test_expect_success 'setup modify/delete + directory/file conflict' '
 	git commit -m deleted
 '
 
-test_expect_failure 'modify/delete + directory/file conflict' '
+test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-- 
1.7.3.271.g16009
