From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Remove branch by putting a null sha1 into the ref file.
Date: Mon, 18 Sep 2006 06:54:29 +0200
Message-ID: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 06:48:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPB3U-000529-JG
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 06:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965382AbWIREsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 00:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbWIREsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 00:48:25 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:8938 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S965382AbWIREsZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Sep 2006 00:48:25 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g19.free.fr (Postfix) with SMTP id 565982CA94;
	Mon, 18 Sep 2006 06:48:23 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27222>

With the new packed ref file format from Linus, this should be
the new way to remove a branch.

"refs.c" is fixed so that a null sha1 for a deleted branch does
not result in "refs/head/deleted does not point to a valid
commit object!" messages.

"t/t3200-branch.sh" is fixed so that it uses git-show-ref
instead of checking that the ref does not exist when a branch
is deleted.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 git-branch.sh     |    6 +++++-
 refs.c            |    2 ++
 t/t3200-branch.sh |    2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index 2600e9c..cb55880 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -10,6 +10,9 @@ SUBDIRECTORY_OK='Yes'
 
 headref=$(git-symbolic-ref HEAD | sed -e 's|^refs/heads/||')
 
+# Fourty 0s.
+NULL_SHA1="0000000000000000000000000000000000000000" 
+
 delete_branch () {
     option="$1"
     shift
@@ -43,7 +46,8 @@ If you are sure you want to delete it, r
 	    ;;
 	esac
 	rm -f "$GIT_DIR/logs/refs/heads/$branch_name"
-	rm -f "$GIT_DIR/refs/heads/$branch_name"
+	echo $NULL_SHA1 > "$GIT_DIR/refs/heads/$branch_name" || \
+	    die "Failed to delete branch '$branch_name' !"
 	echo "Deleted branch $branch_name."
     done
     exit 0
diff --git a/refs.c b/refs.c
index 5e65314..76d8d0e 100644
--- a/refs.c
+++ b/refs.c
@@ -162,6 +162,8 @@ static int do_for_each_ref(const char *b
 				error("%s points nowhere!", path);
 				continue;
 			}
+			if (is_null_sha1(sha1))
+				continue; /* Ignore deleted refs. */
 			if (!has_sha1_file(sha1)) {
 				error("%s does not point to a valid "
 				      "commit object!", path);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5b04efc..150dfdc 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -47,7 +47,7 @@ test_expect_success \
 test_expect_success \
     'git branch -d d/e/f should delete a branch and a log' \
 	'git-branch -d d/e/f &&
-	 test ! -f .git/refs/heads/d/e/f &&
+	 ! git-show-ref --verify --quiet -- "refs/heads/d/e/f" &&
 	 test ! -f .git/logs/refs/heads/d/e/f'
 
 cat >expect <<EOF
-- 
1.4.2.1.g4251-dirty
