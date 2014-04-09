From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/5] remote-bzr: include authors field in pushed commits
Date: Wed,  9 Apr 2014 13:50:03 -0500
Message-ID: <1397069404-7451-5-git-send-email-felipe.contreras@gmail.com>
References: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Cc: dequis <dx@dxzone.com.ar>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 09 21:00:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXxjp-0006Zq-0c
	for gcvg-git-2@plane.gmane.org; Wed, 09 Apr 2014 21:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934177AbaDITAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2014 15:00:33 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:46704 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933354AbaDITA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2014 15:00:28 -0400
Received: by mail-ob0-f173.google.com with SMTP id gq1so3223483obb.32
        for <git@vger.kernel.org>; Wed, 09 Apr 2014 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=issndbHh3dNzGRClKMZqWk39Ld/H2mDjfGdHFKfQOL4=;
        b=JdJxrBbaL09RYJkJ55yaOrNsbF4w6vlEE+YCjw/aH+eknW6tYx+6ZLcTLMK8vkhdGA
         c/AxMqFseKvQ/eLKTnpdyMsfOIafreV87cb0roIN8YimsMM/04e/Etvb59mKMY6qh2Rl
         s6fEIhZqtfAXAZNXBcd5AlPHqwOzMElIv3LSczf3vb3aXa+n6ud2GeAmA90QqgxZyhGT
         8kkrz7eT1dOJ2cy5RWQDlo2BUe6gLF3oKji4VqgPWuP1e7L6wfGFiSPbdv5TSt6A6GVY
         DpS+A5Fyo/X8zfg5/Adw/xQgAD68skJfSO9oXvbxxTKN3/O+oBfmmMkGVXKfN4fissnW
         pQ5w==
X-Received: by 10.182.241.9 with SMTP id we9mr1696320obc.81.1397070028320;
        Wed, 09 Apr 2014 12:00:28 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qh7sm2865591obc.13.2014.04.09.12.00.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Apr 2014 12:00:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.1+fc1
In-Reply-To: <1397069404-7451-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245992>

From: dequis <dx@dxzone.com.ar>

Tests-by: Felipe Contreras <felipe.contreras@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-bzr |  2 ++
 contrib/remote-helpers/test-bzr.sh    | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/contrib/remote-helpers/git-remote-bzr b/contrib/remote-helpers/git-remote-bzr
index 7f354c8..6ca1e97 100755
--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -618,10 +618,12 @@ def parse_commit(parser):
         files[path] = f
 
     committer, date, tz = committer
+    author, _, _ = author
     parents = [mark_to_rev(p) for p in parents]
     revid = bzrlib.generate_ids.gen_revision_id(committer, date)
     props = {}
     props['branch-nick'] = branch.nick
+    props['authors'] = author
 
     mtree = CustomTree(branch, revid, parents, files)
     changes = mtree.iter_changes()
diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 1e53ff9..431de3b 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -391,4 +391,28 @@ test_expect_success 'export utf-8 authors' '
 	test_cmp expected actual
 '
 
+test_expect_success 'push different author' '
+	test_when_finished "rm -rf bzrrepo gitrepo" &&
+
+	bzr init bzrrepo &&
+
+	(
+	git init gitrepo &&
+	cd gitrepo &&
+	echo john >> content &&
+	git add content &&
+	git commit -m john --author "John Doe <jdoe@example.com>" &&
+	git remote add bzr "bzr::../bzrrepo" &&
+	git push bzr master
+	) &&
+
+	(
+	cd bzrrepo &&
+	bzr log | grep "^author: " > ../actual
+	) &&
+
+	echo "author: John Doe <jdoe@example.com>" > expected &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.9.1+fc1
