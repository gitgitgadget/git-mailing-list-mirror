From: Manzur Mukhitdinov <manzurmm@gmail.com>
Subject: [PATCH] replace: fix replacing object with itself
Date: Thu, 13 Nov 2014 15:05:59 +0100
Message-ID: <1415887559-16585-1-git-send-email-manzurmm@gmail.com>
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 13 15:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xov3A-00013P-4l
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 15:07:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933122AbaKMOHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 09:07:00 -0500
Received: from mail-la0-f51.google.com ([209.85.215.51]:47389 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbaKMOG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 09:06:59 -0500
Received: by mail-la0-f51.google.com with SMTP id q1so13195879lam.24
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 06:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qeula4bUpWHoglU5RnZQt/R/9thWqofLS4993xxNX8o=;
        b=ka271usN2M89TVSNKk3qa6EiEqOEjcOgalRGy1IlzEcHH3uvK2NICf0sDsNrwI0Frg
         0AAM8LnqtHoYIvu0fLQsCFll03zIqfsSakqxlq8cf1W1QhqlfT/0A+NHYqlUz323zj4w
         vFRwiFilAzBeuyMP/n95SlaZJRQf7BDUvrgs+/QNOahTPTtUYeg8GvDZ7cljVv6CljAR
         Le5ABcv8Lv+nIMW4BopxnwTSQYIyW/EZ2fJIHbiV3xO36CWoRogUe2IaLjtyHEMtguYm
         jgbCCUuSOdAjXBQcDy7CWmoYO6R6IpL6FSk4WrYJLFn8kxpf+5tawZLIaIjI+nKzA60x
         7t+g==
X-Received: by 10.152.21.135 with SMTP id v7mr2664706lae.65.1415887617477;
        Thu, 13 Nov 2014 06:06:57 -0800 (PST)
Received: from localhost.localdomain ([37.110.214.49])
        by mx.google.com with ESMTPSA id qg4sm7507178lbb.36.2014.11.13.06.06.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 13 Nov 2014 06:06:56 -0800 (PST)
X-Mailer: git-send-email 2.1.3.2.ge64e4eb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When object is replaced with itself git shows unhelpful messages like(git log):
    "fatal: replace depth too high for object <SHA1>"

Prevents user from replacing object with itself(with test for checking
this case).

Signed-off-by: Manzur Mukhitdinov <manzurmm@gmail.com>
---
 builtin/replace.c  |  8 +++-----
 t/t6050-replace.sh | 11 +++++++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/replace.c b/builtin/replace.c
index 294b61b..628377a 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -157,6 +157,9 @@ static int replace_object_sha1(const char *object_ref,
 	char ref[PATH_MAX];
 	struct ref_lock *lock;
 
+	if (!hashcmp(object, repl))
+		return error("new object is the same as the old one: '%s'", sha1_to_hex(object));
+
 	obj_type = sha1_object_info(object, NULL);
 	repl_type = sha1_object_info(repl, NULL);
 	if (!force && obj_type != repl_type)
@@ -295,9 +298,6 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 
 	free(tmpfile);
 
-	if (!hashcmp(old, new))
-		return error("new object is the same as the old one: '%s'", sha1_to_hex(old));
-
 	return replace_object_sha1(object_ref, old, "replacement", new, force);
 }
 
@@ -406,8 +406,6 @@ static int create_graft(int argc, const char **argv, int force)
 
 	strbuf_release(&buf);
 
-	if (!hashcmp(old, new))
-		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
 
 	return replace_object_sha1(old_ref, old, "replacement", new, force);
 }
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 4d5a25e..5f96374 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -369,9 +369,8 @@ test_expect_success '--edit with and without already replaced object' '
 	git cat-file commit "$PARA3" | grep "A fake Thor"
 '
 
-test_expect_success '--edit and change nothing or command failed' '
+test_expect_success '--edit with failed editor' '
 	git replace -d "$PARA3" &&
-	test_must_fail env GIT_EDITOR=true git replace --edit "$PARA3" &&
 	test_must_fail env GIT_EDITOR="./fakeeditor;false" git replace --edit "$PARA3" &&
 	GIT_EDITOR=./fakeeditor git replace --edit "$PARA3" &&
 	git replace -l | grep "$PARA3" &&
@@ -440,4 +439,12 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
 	git replace -d $HASH10
 '
 
+test_expect_success 'replacing object with itself must fail' '
+    test_must_fail git replace $HASH1 $HASH1 &&
+    HASH8=$(git rev-parse --verify HEAD) &&
+    test_must_fail git replace HEAD $HASH8 &&
+    test_must_fail git replace --graft HEAD HEAD^ &&
+    test_must_fail env GIT_EDITOR=true git replace --edit HEAD
+'
+
 test_done
-- 
1.9.1
