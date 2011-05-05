From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: t5541: Bad file descriptor
Date: Thu, 5 May 2011 00:49:19 -0400
Message-ID: <3340686A-18D8-4279-87F0-580262DD4DFA@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 06:49:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHqVF-0003cq-1n
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 06:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159Ab1EEEtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 00:49:23 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:33605 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025Ab1EEEtW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 00:49:22 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 May 2011 00:49:22 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C82B71FFC135; Thu,  5 May 2011 04:49:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 59C641FFC0F6
	for <git@vger.kernel.org>; Thu,  5 May 2011 04:49:09 +0000 (UTC)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172794>

I haven't had a lot of time to track down it down until today, but I've been getting failures in t5541-http-push-.sh.  Several tests fail with the error "fatal: write error: Bad file descriptor".

I have bisected this to "73776dc: 
Merge branch 'js/maint-1.6.6-send-pack-stateless-rpc-deadlock-fix' into js/maint-send-pack-stateless-rpc-deadlock-fix"

Full test output follows:

$ ./t5541-http-push.sh -v
Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/.git/
expecting success: 
	cd "$ROOT_PATH" &&
	mkdir test_repo &&
	cd test_repo &&
	git init &&
	: >path1 &&
	git add path1 &&
	test_tick &&
	git commit -m initial &&
	cd - &&
	git clone --bare test_repo test_repo.git &&
	cd test_repo.git &&
	git config http.receivepack true &&
	ORIG_HEAD=$(git rev-parse --verify HEAD) &&
	cd - &&
	mv test_repo.git "$HTTPD_DOCUMENT_ROOT_PATH"

Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/test_repo/.git/
[master (root-commit) 0c973ae] initial
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 path1
/Users/brian/dev/git/t/trash directory.t5541-http-push
Cloning into bare repository test_repo.git...
done.
/Users/brian/dev/git/t/trash directory.t5541-http-push
ok 1 - setup remote repository

expecting success: 
	# In the URL, add a trailing slash, and see if git appends yet another
	# slash.
	cd "$ROOT_PATH" &&
	git clone $HTTPD_URL/smart/test_repo.git/ test_repo_clone &&

	sed -e "
		s/^.* \"//
		s/\"//
		s/ [1-9][0-9]*\$//
		s/^GET /GET  /
	" >act <"$HTTPD_ROOT_PATH"/access.log &&

	# Clear the log, so that it does not affect the "used receive-pack
	# service" test which reads the log too.
	#
	# We do this before the actual comparison to ensure the log is cleared.
	echo > "$HTTPD_ROOT_PATH"/access.log &&

	test_cmp exp act

Cloning into test_repo_clone...
remote: Counting objects: 3, done.        
remote: Total 3 (delta 0), reused 0 (delta 0)        
Unpacking objects: 100% (3/3), done.
ok 2 - no empty path components

expecting success: 
	rm -rf test_repo_clone &&
	git clone $HTTPD_URL/smart/test_repo.git test_repo_clone

Cloning into test_repo_clone...
remote: Counting objects: 3, done.        
remote: Total 3 (delta 0), reused 0 (delta 0)        
Unpacking objects: 100% (3/3), done.
ok 3 - clone remote repository

expecting success: 
	cd "$ROOT_PATH"/test_repo_clone &&
	: >path2 &&
	git add path2 &&
	test_tick &&
	git commit -m path2 &&
	HEAD=$(git rev-parse --verify HEAD) &&
	git push &&
	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
	 test $HEAD = $(git rev-parse --verify HEAD))

[master 9d498b0] path2
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 path2
Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 240 bytes, done.
Total 2 (delta 0), reused 0 (delta 0)
fatal: write error: Bad file descriptor
fatal: The remote end hung up unexpectedly
not ok - 4 push to remote repository
#	
#		cd "$ROOT_PATH"/test_repo_clone &&
#		: >path2 &&
#		git add path2 &&
#		test_tick &&
#		git commit -m path2 &&
#		HEAD=$(git rev-parse --verify HEAD) &&
#		git push &&
#		(cd "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git &&
#		 test $HEAD = $(git rev-parse --verify HEAD))
#	

expecting success: 
	git push

Counting objects: 3, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 240 bytes, done.
Total 2 (delta 0), reused 0 (delta 0)
fatal: write error: Bad file descriptor
fatal: The remote end hung up unexpectedly
not ok - 5 push already up-to-date
#	
#		git push
#	

expecting success: 
	cd "$ROOT_PATH"/test_repo_clone &&
	git checkout -b dev &&
	: >path3 &&
	git add path3 &&
	test_tick &&
	git commit -m dev &&
	git push origin dev &&
	git push origin :dev &&
	test_must_fail git show-ref --verify refs/remotes/origin/dev

Switched to a new branch 'dev'
[dev 3ea4fbb] dev
 Author: A U Thor <author@example.com>
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 path3
Counting objects: 5, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 414 bytes, done.
Total 4 (delta 1), reused 0 (delta 0)
fatal: The remote end hung up unexpectedly
fatal: write error: Bad file descriptor
not ok - 6 create and delete remote branch
#	
#		cd "$ROOT_PATH"/test_repo_clone &&
#		git checkout -b dev &&
#		: >path3 &&
#		git add path3 &&
#		test_tick &&
#		git commit -m dev &&
#		git push origin dev &&
#		git push origin :dev &&
#		test_must_fail git show-ref --verify refs/remotes/origin/dev
#	

expecting success: 
	sed -e "
		s/^.* \"//
		s/\"//
		s/ [1-9][0-9]*\$//
		s/^GET /GET  /
	" >act <"$HTTPD_ROOT_PATH"/access.log &&
	test_cmp exp act

--- exp	2011-05-05 04:48:00.000000000 +0000
+++ act	2011-05-05 04:48:00.000000000 +0000
@@ -2,9 +2,5 @@
 GET  /smart/test_repo.git/info/refs?service=git-upload-pack HTTP/1.1 200
 POST /smart/test_repo.git/git-upload-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
 GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
-GET  /smart/test_repo.git/info/refs?service=git-receive-pack HTTP/1.1 200
-POST /smart/test_repo.git/git-receive-pack HTTP/1.1 200
not ok - 7 used receive-pack service
#	
#		sed -e "
#			s/^.* \"//
#			s/\"//
#			s/ [1-9][0-9]*\$//
#			s/^GET /GET  /
#		" >act <"$HTTPD_ROOT_PATH"/access.log &&
#		test_cmp exp act
#	

expecting success: 
		cd "$REMOTE_REPO" &&
		HEAD=$(git rev-parse --verify HEAD) &&

		cd "$LOCAL_REPO" &&
		git checkout $BRANCH &&
		echo "changed" > path2 &&
		git commit -a -m path2 --amend &&

		test_must_fail git push -v origin >output 2>&1 &&
		(cd "$REMOTE_REPO" &&
		 test $HEAD = $(git rev-parse --verify HEAD))
	
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 1 commit.
[master 910616f] path2
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 path2
ok 8 - non-fast-forward push fails

expecting success: 
		grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" output
	
not ok - 9 non-fast-forward push show ref status
#	
#			grep "^ ! \[rejected\][ ]*$BRANCH -> $BRANCH (non-fast-forward)$" output
#		

expecting success: 
		test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" output
	
not ok - 10 non-fast-forward push shows help message
#	
#			test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" output
#		

expecting success: 
	# create a dissimilarly-named remote ref so that git is unable to match the
	# two refs (viz. local, remote) unless an explicit refspec is provided.
	git push origin master:retsam

	echo "change changed" > path2 &&
	git commit -a -m path2 --amend &&

	# push master too; this ensures there is at least one 'push' command to
	# the remote helper and triggers interaction with the helper.
	test_must_fail git push -v origin +master master:retsam >output 2>&1
Counting objects: 4, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 279 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
fatal: write error: Bad file descriptor
fatal: The remote end hung up unexpectedly
[master 6773b42] path2
 Author: A U Thor <author@example.com>
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 path2
ok 11 - push fails for non-fast-forward refs unmatched by remote helper

expecting success: 
	grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
	grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output

not ok - 12 push fails for non-fast-forward refs unmatched by remote helper: remote output
#	
#		grep "^ + [a-f0-9]*\.\.\.[a-f0-9]* *master -> master (forced update)$" output &&
#		grep "^ ! \[rejected\] *master -> retsam (non-fast-forward)$" output
#	

expecting success: 
	test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" \
		output

not ok - 13 push fails for non-fast-forward refs unmatched by remote helper: our output
#	
#		test_i18ngrep "To prevent you from losing history, non-fast-forward updates were rejected" \
#			output
#	

# failed 8 among 13 test(s)
1..13
