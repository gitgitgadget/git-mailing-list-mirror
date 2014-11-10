From: Manzur Mukhitdinov <manzurmm@gmail.com>
Subject: [PATCH] replace: fix replacing object with itself
Date: Tue, 11 Nov 2014 00:20:56 +0100
Message-ID: <1415661656-3657-1-git-send-email-manzurmm@gmail.com>
Cc: Manzur Mukhitdinov <manzurmm@gmail.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 11 00:21:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnyGu-0006rc-2w
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 00:21:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbaKJXVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 18:21:10 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33860 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaKJXVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 18:21:09 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so10262719wgg.31
        for <git@vger.kernel.org>; Mon, 10 Nov 2014 15:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=nAiaPFJ30KWP7uxqVwZQT//S49JmIZvkS7mk+2+e/K4=;
        b=aF2E5tPohHsiJYg3EOlhmgrmA28bKjziIAJzRqBKz1QDbMnEy2FeKtuQALrvHs5Fbd
         AYN+ZFS74V81Af+Uql1yQAuRywD37YE6HzTh9yhbTFn7vhj+zd9FV9Wkw4omte7GOW7p
         baySsf90GBHs1QgD1dWM86+CfC2wjtY/6qZZEe+HIvZEtWkdMoNd0yyl+8xcMwzezf5f
         Sl7sBIieRTkqcW888v2CCENFOuIblhHyRSmyrjXk+2IXzRKKwoDjAFervWQm//7rwLFi
         g0Rr4aFi5ZomlEPQ+egLEh3fTX3QLoU4Fa+eu/AKUqtHJsCyyMaF6v8HdxbPXOXqJdBJ
         0aqg==
X-Received: by 10.180.109.17 with SMTP id ho17mr28298759wib.4.1415661668178;
        Mon, 10 Nov 2014 15:21:08 -0800 (PST)
Received: from localhost.localdomain (a86147.upc-a.chello.nl. [62.163.86.147])
        by mx.google.com with ESMTPSA id wl1sm24992282wjb.4.2014.11.10.15.21.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Nov 2014 15:21:07 -0800 (PST)
X-Mailer: git-send-email 2.1.3.2.gb1b4c12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When object is replaced with itself git shows unhelpful messages like(git log):
    "fatal: replace depth too high for object <SHA1>"

Prevents user from replacing object with itself(with test for checking
this case).
---
 builtin/replace.c  | 8 +++-----
 t/t6050-replace.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

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
index 4d5a25e..98ac9dd 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -440,4 +440,12 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
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
