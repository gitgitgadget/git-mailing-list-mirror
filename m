X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH] rename_ref: use lstat(2) when testing for symlink
Date: Wed, 29 Nov 2006 21:44:56 +0100
Message-ID: <11648330963464-git-send-email-hjemli@gmail.com>
NNTP-Posting-Date: Wed, 29 Nov 2006 20:54:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.1.gf0df
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32669>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpWS6-0003A8-IA for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967671AbWK2Uym (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:54:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967672AbWK2Uym
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:54:42 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:42654 "EHLO
 mail42.e.nsc.no") by vger.kernel.org with ESMTP id S967671AbWK2Uyl (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:54:41 -0500
Received: from localhost.localdomain (ti231210a080-2784.bb.online.no
 [80.213.122.226]) by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id
 kATKsbFS026844; Wed, 29 Nov 2006 21:54:37 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

The current check for symlinked reflogs was based on stat(2), which is
utterly embarrassing.

Fix it, and add a matching testcase.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---

This is on top of my previous [RFC], which is kind of strange, but I hope 
it wasn't dropped on the floor...

 refs.c            |    2 +-
 t/t3200-branch.sh |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 479f18c..d8c19e6 100644
--- a/refs.c
+++ b/refs.c
@@ -792,7 +792,7 @@ int rename_ref(const char *oldref, const char *newref)
 	struct ref_lock *lock;
 	char msg[PATH_MAX*2 + 100];
 	struct stat loginfo;
-	int log = !stat(git_path("logs/%s", oldref), &loginfo);
+	int log = !lstat(git_path("logs/%s", oldref), &loginfo);
 
 	if (S_ISLNK(loginfo.st_mode))
 		return error("reflog for %s is a symlink", oldref);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index afaa853..5782c30 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -104,4 +104,11 @@ test_expect_success \
         git-branch -m s/s s &&
         test -f .git/logs/refs/heads/s'
 
+test_expect_failure \
+    'git-branch -m u v should fail when the reflog for u is a symlink' \
+    'git-branch -l u &&
+     mv .git/logs/refs/heads/u real-u &&
+     ln -s real-u .git/logs/refs/heads/u &&
+     git-branch -m u v'
+
 test_done
-- 
1.4.4.1.gf0df
