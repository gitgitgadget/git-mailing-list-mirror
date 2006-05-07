From: Martin Waitz <tali@admingilde.org>
Subject: [PATCH] clone: keep --reference even with -l -s
Date: Sun, 7 May 2006 20:19:09 +0200
Message-ID: <20060507181909.GB23738@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun May 07 20:19:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fcnqr-00043u-7M
	for gcvg-git@gmane.org; Sun, 07 May 2006 20:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEGSTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 14:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWEGSTL
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 14:19:11 -0400
Received: from admingilde.org ([213.95.32.146]:33999 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S1750718AbWEGSTK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 May 2006 14:19:10 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FcnqX-0000pV-Ad
	for git@vger.kernel.org; Sun, 07 May 2006 20:19:09 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19710>

Both -l -s and --reference update objects/info/alternates and used
to write over each other.

Signed-off-by: Martin Waitz <tali@admingilde.org>

---

 git-clone.sh               |    2 +
 t/t5700-clone-reference.sh |   78 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 1 deletions(-)
 create mode 100755 t/t5700-clone-reference.sh

3410837e34357d43a38a170691ca45f8f3a82221
diff --git a/git-clone.sh b/git-clone.sh
index 0805168..b785247 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -265,7 +265,7 @@ yes,yes)
 		test -f "$repo/objects/info/alternates" &&
 		cat "$repo/objects/info/alternates";
 		echo "$repo/objects"
-	    } >"$GIT_DIR/objects/info/alternates"
+	    } >>"$GIT_DIR/objects/info/alternates"
 	    ;;
 	esac
 	git-ls-remote "$repo" >"$GIT_DIR/CLONE_HEAD"
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
new file mode 100755
index 0000000..916ee15
--- /dev/null
+++ b/t/t5700-clone-reference.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+#
+# Copyright (C) 2006 Martin Waitz <tali@admingilde.org>
+#
+
+test_description='test clone --reference'
+. ./test-lib.sh
+
+base_dir=`pwd`
+
+test_expect_success 'preparing first repository' \
+'test_create_repo A && cd A &&
+echo first > file1 &&
+git add file1 &&
+git commit -m initial'
+
+cd "$base_dir"
+
+test_expect_success 'preparing second repository' \
+'git clone A B && cd B &&
+echo second > file2 &&
+git add file2 &&
+git commit -m addition &&
+git repack -a -d &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_success 'cloning with reference' \
+'git clone -l -s --reference B A C'
+
+cd "$base_dir"
+
+test_expect_success 'existance of info/alternates' \
+'test `wc -l <C/.git/objects/info/alternates` = 2'
+
+cd "$base_dir"
+
+test_expect_success 'pulling from reference' \
+'cd C &&
+git pull ../B'
+
+cd "$base_dir"
+
+test_expect_success 'that reference gets used' \
+'cd C &&
+echo "0 objects, 0 kilobytes" > expected &&
+git count-objects > current &&
+diff expected current'
+
+cd "$base_dir"
+
+test_expect_success 'updating origin' \
+'cd A &&
+echo third > file3 &&
+git add file3 &&
+git commit -m update &&
+git repack -a -d &&
+git prune'
+
+cd "$base_dir"
+
+test_expect_success 'pulling changes from origin' \
+'cd C &&
+git pull origin'
+
+cd "$base_dir"
+
+# the 2 local objects are commit and tree from the merge
+test_expect_success 'that alternate to origin gets used' \
+'cd C &&
+echo "2 objects" > expected &&
+git count-objects | cut -d, -f1 > current &&
+diff expected current'
+
+cd "$base_dir"
+
+test_done
-- 
1.3.1.g6ef7
