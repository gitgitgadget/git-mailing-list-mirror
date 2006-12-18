X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Adjust t5510 to put remotes in config
Date: Mon, 18 Dec 2006 15:27:43 -0800
Message-ID: <7virg8vl74.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612171545390.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v7iwox59i.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182325550.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vvek8vnb8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612182346500.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612182349070.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vr6uwvmk8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 18 Dec 2006 23:28:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vr6uwvmk8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 18 Dec 2006 14:58:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34761>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwRtd-0005GQ-KP for gcvg-git@gmane.org; Tue, 19 Dec
 2006 00:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754759AbWLRX1q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754764AbWLRX1q
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 18:27:46 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39139 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1754763AbWLRX1p (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 18:27:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061218232744.SJJV20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 18:27:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0PT31W00H1kojtg0000000; Mon, 18 Dec 2006
 18:27:03 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 18 Dec 2006, Johannes Schindelin wrote:
>>
>>> I don't install templates. Ever. I want to be sure that nothing slips in 
>>> by mistake, and so I install hooks manually.
>>
>> Side note: prior to installing the tests would fail anyway, no?
>
> They shouldn't.  At least the intent was to make the tests read
> from $SRCDIR/templates/blt/ as the source of templates.
>
> But maybe you spotted a bug in t/test-lib.sh; I don't know
> without digging.

Indeed it appears to be the case.  I am thinking about applying
this patch to fix it.

-- >8 --
fix testsuite: make sure they use templates freshly built from the source

The initial t/trash repository for testing was created properly
but over time we gained many tests that create secondary test
repositories with init-db or clone and they were not careful
enough.

This fixes it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac7be76..7e91497 100755
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -182,6 +182,16 @@ test_create_repo () {
 	cd "$owd"
 }
 	
+# Many tests do init-db and clone but they must be told about the freshly
+# built templates.
+git_init_db () {
+	git init-db --template="$GIT_EXEC_PATH/templates/blt/" "$@"
+}
+
+git_clone () {
+	git clone --template="$GIT_EXEC_PATH/templates/blt/" "$@"
+}
+
 test_done () {
 	trap - exit
 	case "$test_failure" in
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 74f5c2a..a79c77a 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -50,12 +50,12 @@ test_expect_success 'setup separate repository lacking postimage' '
 
 	git tar-tree initial initial | tar xf - &&
 	(
-		cd initial && git init-db && git add .
+		cd initial && git_init_db && git add .
 	) &&
 
 	git tar-tree second second | tar xf - &&
 	(
-		cd second && git init-db && git add .
+		cd second && git_init_db && git add .
 	)
 
 '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index de45ac4..8a8152b 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -44,7 +44,7 @@ test_expect_success \
     'unpack without delta' \
     "GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git_init_db &&
      git-unpack-objects -n <test-1-${packname_1}.pack &&
      git-unpack-objects <test-1-${packname_1}.pack"
 
@@ -75,7 +75,7 @@ test_expect_success \
     'unpack with delta' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git_init_db &&
      git-unpack-objects -n <test-2-${packname_2}.pack &&
      git-unpack-objects <test-2-${packname_2}.pack'
 
@@ -100,7 +100,7 @@ test_expect_success \
     'use packed objects' \
     'GIT_OBJECT_DIRECTORY=.git2/objects &&
      export GIT_OBJECT_DIRECTORY &&
-     git-init-db &&
+     git_init_db &&
      cp test-1-${packname_1}.pack test-1-${packname_1}.idx .git2/objects/pack && {
 	 git-diff-tree --root -p $commit &&
 	 while read object
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 28744b3..901da8c 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -24,7 +24,7 @@ test_expect_success setup '
 	    parent=$commit || return 1
 	done &&
 	git-update-ref HEAD "$commit" &&
-	git-clone -l ./. victim &&
+	git_clone -l ./. victim &&
 	cd victim &&
 	git-log &&
 	cd .. &&
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index f7625a6..61e2a55 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -97,7 +97,7 @@ pull_to_client () {
 (
 	mkdir client &&
 	cd client &&
-	git-init-db 2>> log2.txt
+	git_init_db 2>> log2.txt
 )
 
 add A1
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a11ab0a..e2e8c89 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -15,12 +15,12 @@ test_expect_success setup '
 	git commit -a -m original'
 
 test_expect_success "clone and setup child repos" '
-	git clone . one &&
+	git_clone . one &&
 	cd one &&
 	echo >file updated by one &&
 	git commit -a -m "updated by one" &&
 	cd .. &&
-	git clone . two &&
+	git_clone . two &&
 	cd two &&
 	git repo-config branch.master.remote one &&
 	{
@@ -28,7 +28,7 @@ test_expect_success "clone and setup child repos" '
 		echo "Pull: refs/heads/master:refs/heads/one"
 	} >.git/remotes/one
 	cd .. &&
-	git clone . three &&
+	git_clone . three &&
 	cd three &&
 	git repo-config branch.master.remote two &&
 	git repo-config branch.master.merge refs/heads/one &&
@@ -74,7 +74,7 @@ test_expect_success 'fetch following tags' '
 
 	mkdir four &&
 	cd four &&
-	git init-db &&
+	git_init_db &&
 
 	git fetch .. :track &&
 	git show-ref --verify refs/tags/anno &&
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index f841574..66ef92f 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -17,7 +17,7 @@ test_expect_success setup '
 test_expect_success 'pulling into void' '
 	mkdir cloned &&
 	cd cloned &&
-	git init-db &&
+	git_init_db &&
 	git pull ..
 '
 
diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
index 041be04..1913a12 100755
--- a/t/t5600-clone-fail-cleanup.sh
+++ b/t/t5600-clone-fail-cleanup.sh
@@ -13,7 +13,7 @@ remove the directory before attempting a clone again.'
 
 test_expect_failure \
     'clone of non-existent source should fail' \
-    'git-clone foo bar'
+    'git_clone foo bar'
 
 test_expect_failure \
     'failed clone should not leave a directory' \
@@ -29,11 +29,11 @@ test_create_repo foo
 # current path not to the target dir
 test_expect_failure \
     'clone of non-existent (relative to $PWD) source should fail' \
-    'git-clone ../foo baz'
+    'git_clone ../foo baz'
 
 test_expect_success \
     'clone should work now that source exists' \
-    'git-clone foo bar'
+    'git_clone foo bar'
 
 test_expect_success \
     'successfull clone must leave the directory' \
diff --git a/t/t5700-clone-reference.sh b/t/t5700-clone-reference.sh
index dd9caad..52dab2d 100755
--- a/t/t5700-clone-reference.sh
+++ b/t/t5700-clone-reference.sh
@@ -17,7 +17,7 @@ git commit -m initial'
 cd "$base_dir"
 
 test_expect_success 'preparing second repository' \
-'git clone A B && cd B &&
+'git_clone A B && cd B &&
 echo second > file2 &&
 git add file2 &&
 git commit -m addition &&
@@ -27,7 +27,7 @@ git prune'
 cd "$base_dir"
 
 test_expect_success 'cloning with reference' \
-'git clone -l -s --reference B A C'
+'git_clone -l -s --reference B A C'
 
 cd "$base_dir"
 
diff --git a/t/t5710-info-alternate.sh b/t/t5710-info-alternate.sh
index b9f6d96..3c43554 100755
--- a/t/t5710-info-alternate.sh
+++ b/t/t5710-info-alternate.sh
@@ -34,7 +34,7 @@ git prune'
 cd "$base_dir"
 
 test_expect_success 'preparing second repository' \
-'git clone -l -s A B && cd B &&
+'git_clone -l -s A B && cd B &&
 echo "foo bar" > file2 &&
 git add file2 &&
 git commit -m "next commit" file2 &&
@@ -44,7 +44,7 @@ git prune'
 cd "$base_dir"
 
 test_expect_success 'preparing third repository' \
-'git clone -l -s B C && cd C &&
+'git_clone -l -s B C && cd C &&
 echo "Goodbye, cruel world" > file3 &&
 git add file3 &&
 git commit -m "one more" file3 &&
@@ -54,11 +54,11 @@ git prune'
 cd "$base_dir"
 
 test_expect_failure 'creating too deep nesting' \
-'git clone -l -s C D &&
-git clone -l -s D E &&
-git clone -l -s E F &&
-git clone -l -s F G &&
-git clone -l -s G H &&
+'git_clone -l -s C D &&
+git_clone -l -s D E &&
+git_clone -l -s E F &&
+git_clone -l -s F G &&
+git_clone -l -s G H &&
 cd H &&
 test_valid_repo'
 
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 2f4ff82..ae597e8 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -88,7 +88,7 @@ test_expect_success \
 
 test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
-	git init-db &&
+	git_init_db &&
 	mkdir -p papers/unsorted papers/all-papers partA &&
 	echo a > papers/unsorted/Thesis.pdf &&
 	echo b > partA/outline.txt &&
@@ -109,7 +109,7 @@ rm -fr papers partA path?
 
 test_expect_success "Sergey Vlasov's test case" '
 	rm -fr .git &&
-	git init-db &&
+	git_init_db &&
 	mkdir ab &&
 	date >ab.c &&
 	date >ab/d &&
