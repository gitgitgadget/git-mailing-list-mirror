From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH/RFC 6/7] contrib/subtree: Use %B for the split commit message
Date: Sun, 13 Jan 2013 09:52:37 +0800
Message-ID: <1358041958-1998-7-git-send-email-techlivezheng@gmail.com>
References: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jan 13 02:59:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuCrV-0001Bu-Mg
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 02:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507Ab3AMB7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 20:59:24 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:44396 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753667Ab3AMB7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 20:59:21 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so1633323pad.2
        for <git@vger.kernel.org>; Sat, 12 Jan 2013 17:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=W0RW2+KFkPbIHPb9cBIqcVRa95yZs3/1tcRe6xeWIz0=;
        b=AJYRuc/DoOWipH1TeGpO5NSmMfnWS8U5A2PW1Kc3sjJvZq1ezhosZXYGhCnQo5zb+D
         qjMoY2KSWprZKd66Yiphmi/3dQadOoVZy6PjwXFdi0Qm3iZKjTdkog7wrE8lCdomLm2d
         dVudNlMDUf46t77VG1rUU98MCIItn66FgedKys5Jxq+wlPI4SYuKZfkW7OXRuUuBSL0a
         PjinVJNKCdaEs5I1C186BsCQqC87LYTk6XOUU7yGWY8iHcKHnLcDF9aUoTeLmljfkH+2
         jQ68LYnzYR0dyY6HUZBmwBJzO98w83wjzK1OPysI3P0y7yJUM9LJ63uR9RwXEmbwFKnU
         fRxQ==
X-Received: by 10.68.83.68 with SMTP id o4mr245067666pby.25.1358042360918;
        Sat, 12 Jan 2013 17:59:20 -0800 (PST)
Received: from home.techlive.me ([122.244.155.16])
        by mx.google.com with ESMTPS id d8sm5908882pax.23.2013.01.12.17.59.17
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Jan 2013 17:59:20 -0800 (PST)
X-Mailer: git-send-email 1.8.1
In-Reply-To: <1358041958-1998-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213326>

Use %B rather than %s%n%n%b to handle the special case of a commit that
only has a subject line.  We don't want to introduce a newline after the
subject, causing generation of a new hash.

After this commit, the newly split branch might differ from the previous
one. If this is the case, --fallback option could help.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh     | 13 ++++++++++-
 contrib/subtree/git-subtree.txt    | 13 +++++++++++
 contrib/subtree/t/t7900-subtree.sh | 47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 91e6e87..018ee32 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -25,6 +25,7 @@ b,branch=     create a new branch from the split subtree
 ignore-joins  ignore prior --rejoin commits
 onto=         try connecting new tree to an existing one
 rejoin        merge the new branch back into HEAD
+fallback      fallback to the obsolete commit generating mechanism
  options for 'add', 'merge', 'pull' and 'push'
 squash        merge subtree changes as a single commit
 "
@@ -45,6 +46,7 @@ ignore_joins=
 annotate=
 squash=
 message=
+fallback=
 
 debug()
 {
@@ -92,6 +94,8 @@ while [ $# -gt 0 ]; do
 		--no-ignore-joins) ignore_joins= ;;
 		--squash) squash=1 ;;
 		--no-squash) squash= ;;
+		--fallback) fallback=1 ;;
+		--no-fallback) fallback= ;;
 		--) break ;;
 		*) die "Unexpected option: $opt" ;;
 	esac
@@ -296,7 +300,14 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+
+	if [ -z "$fallback" ]; then
+		log_format='%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B'
+	else
+		log_format='%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b'
+	fi
+
+	git log -1 --pretty=format:"$log_format" "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index c5bce41..ca9f199 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -254,6 +254,19 @@ OPTIONS FOR split
 	'--rejoin' when you split, because you don't want the
 	subproject's history to be part of your project anyway.
 
+--fallback::
+	Previously, git subtree would introduce an extra new line for
+	the commits whose commit message contains only one line.
+	This behavior has been correct. Unfortunately, for those whose
+	current split branch contains these kind of commits, git subtree
+	will generate a new split branch which differs from the existing
+	split branch in these commits. It is better to use this new
+	split branch, because its commits stay intact within the mainline.
+	
+	Otherwise, the previous fault behavior could still be used with
+	this option. This option is only for a compatible purpose, newly
+	split branch should never use this option.
+
 
 EXAMPLE 1. Add command
 ----------------------
diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ece2064..1492303 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -399,6 +399,53 @@ test_expect_success 'split subdir/ with --branch for an incompatible branch' '
     )
 '
 
+test_expect_success 'make sure commits with one line message stay intact after split' '
+    test_create_repo $test_count &&
+    test_create_repo $test_count/subproj &&
+    test_create_commit $test_count main1 &&
+    test_create_commit $test_count/subproj sub1 &&
+    (
+        cd $test_count &&
+        git fetch ./subproj master &&
+        ori_hash=$(git rev-parse FETCH_HEAD) &&
+        git branch subori FETCH_HEAD &&
+        git filter-branch --index-filter '\''git ls-files -s | sed "s-\t-&subdir/-" | GIT_INDEX_FILE=$GIT_INDEX_FILE.new git update-index --index-info && mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"'\'' subori
+        git merge -m "Merge B project as our subdirectory" subori &&
+        git subtree split --prefix subdir --branch splitbr1 &&
+        new_hash_1=$(git rev-parse splitbr1) &&
+        test_equal "$ori_hash" "$new_hash_1" &&
+        git subtree split --prefix subdir --branch splitbr2 --fallback &&
+        new_hash_2=$(git rev-parse splitbr2) &&
+        test_must_fail test_equal "$ori_hash" "$new_hash_2"
+    )
+'
+
+test_expect_success 'make sure --fallback option works correctly for the existing split branch' '
+    test_create_repo "$test_count" &&
+    test_create_repo "$test_count"/subproj &&
+    test_create_commit "$test_count" main1 &&
+    test_create_commit "$test_count"/subproj sub1 &&
+    (
+        cd $test_count &&
+        git fetch ./subproj master &&
+        ori_hash=$(git rev-parse FETCH_HEAD) &&
+        git subtree add --prefix=subdir FETCH_HEAD
+    ) &&
+    test_create_commit "$test_count" subdir/main-sub1 &&
+    (
+        cd $test_count &&
+        git subtree split --prefix subdir --branch splitbr1 &&
+        git subtree split --prefix subdir --branch splitbr2 --fallback &&
+        test_must_fail test_equal "$(git rev-parse splitbr1)" "$(git rev-parse splitbr2)"
+    ) &&
+    test_create_commit "$test_count" subdir/main-sub2 &&
+    (
+        cd $test_count &&
+        test_must_fail git subtree split --prefix subdir --branch splitbr2 &&
+        git subtree split --prefix subdir --branch splitbr2 --fallback
+    )
+'
+
 #
 # Validity checking
 #
-- 
1.8.1
