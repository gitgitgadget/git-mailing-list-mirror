From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] tests: avoid pushing to current branch of non-bare repo
Date: Fri, 7 Nov 2008 17:22:41 -0500
Message-ID: <20081107222241.GC16058@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Sam Vilain <sam@vilain.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 23:24:04 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyZkF-0004Ge-4X
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 23:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbYKGWWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 17:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYKGWWo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 17:22:44 -0500
Received: from peff.net ([208.65.91.99]:4435 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751930AbYKGWWn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 17:22:43 -0500
Received: (qmail 2927 invoked by uid 111); 7 Nov 2008 22:22:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 07 Nov 2008 17:22:42 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2008 17:22:41 -0500
Content-Disposition: inline
In-Reply-To: <20081107220730.GA15942@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100351>

Many tests create a new repo, and then push into the master
branch (sometimes after making some commits on that branch).
After such a push the index and working tree of the
receiving repo are out of sync with the HEAD. This isn't a
problem for most tests, since they don't bother looking at
the working tree after such a push.  But this is generally a
dangerous behavior, and the tests would break if we later
decided to put in a safety valve.

Depending on the situation, this patch takes one of two
approaches:

  - creates the pushed-to repo as a bare repository. This
    works if we don't actually want to create our own
    commits in the repo.

  - switches the pushed-to repo to another branch before
    pushing. Since we never look at the working tree after
    the push anyway, this doesn't impact the test results.

Signed-off-by: Jeff King <peff@peff.net>
---
This is not the _most_ minimal patch, since when changing a non-bare
repo to a bare one, the name of the git dir changed (e.g.,
s{victim/.git}{victim}), causing a lot of textual changes. We could
technically call the bare clone "victim/.git", but I think this is less
confusing (if a bit harder to read the diff).

 t/t5400-send-pack.sh        |   30 ++++++++++++----------
 t/t5401-update-hooks.sh     |   58 +++++++++++++++++++++---------------------
 t/t5405-send-pack-rewind.sh |    3 +-
 t/t5516-fetch-push.sh       |    3 +-
 t/t5517-push-mirror.sh      |    2 +-
 5 files changed, 50 insertions(+), 46 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index da69f08..6bcb4df 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -31,7 +31,7 @@ test_expect_success setup '
 	    parent=$commit || return 1
 	done &&
 	git update-ref HEAD "$commit" &&
-	git clone ./. victim &&
+	git clone --bare ./. victim &&
 	cd victim &&
 	git log &&
 	cd .. &&
@@ -68,7 +68,7 @@ test_expect_success 'pack the destination repository' '
 test_expect_success \
         'pushing rewound head should not barf but require --force' '
 	# should not fail but refuse to update.
-	if git send-pack ./victim/.git/ master
+	if git send-pack ./victim/ master
 	then
 		# now it should fail with Pasky patch
 		echo >&2 Gaah, it should have failed.
@@ -77,7 +77,7 @@ test_expect_success \
 		echo >&2 Thanks, it correctly failed.
 		true
 	fi &&
-	if cmp victim/.git/refs/heads/master .git/refs/heads/master
+	if cmp victim/refs/heads/master .git/refs/heads/master
 	then
 		# should have been left as it was!
 		false
@@ -85,8 +85,8 @@ test_expect_success \
 		true
 	fi &&
 	# this should update
-	git send-pack --force ./victim/.git/ master &&
-	cmp victim/.git/refs/heads/master .git/refs/heads/master
+	git send-pack --force ./victim/ master &&
+	cmp victim/refs/heads/master .git/refs/heads/master
 '
 
 test_expect_success \
@@ -94,14 +94,14 @@ test_expect_success \
 	cd victim &&
 	git branch extra master &&
 	cd .. &&
-	test -f victim/.git/refs/heads/extra &&
-	git send-pack ./victim/.git/ :extra master &&
-	! test -f victim/.git/refs/heads/extra
+	test -f victim/refs/heads/extra &&
+	git send-pack ./victim/ :extra master &&
+	! test -f victim/refs/heads/extra
 '
 
 unset GIT_CONFIG GIT_CONFIG_LOCAL
 HOME=`pwd`/no-such-directory
-export HOME ;# this way we force the victim/.git/config to be used.
+export HOME ;# this way we force the victim/config to be used.
 
 test_expect_success \
 	'pushing a delete should be denied with denyDeletes' '
@@ -109,10 +109,10 @@ test_expect_success \
 	git config receive.denyDeletes true &&
 	git branch extra master &&
 	cd .. &&
-	test -f victim/.git/refs/heads/extra &&
-	test_must_fail git send-pack ./victim/.git/ :extra master
+	test -f victim/refs/heads/extra &&
+	test_must_fail git send-pack ./victim/ :extra master
 '
-rm -f victim/.git/refs/heads/extra
+rm -f victim/refs/heads/extra
 
 test_expect_success \
         'pushing with --force should be denied with denyNonFastforwards' '
@@ -120,14 +120,15 @@ test_expect_success \
 	git config receive.denyNonFastforwards true &&
 	cd .. &&
 	git update-ref refs/heads/master master^ || return 1
-	git send-pack --force ./victim/.git/ master && return 1
-	! test_cmp .git/refs/heads/master victim/.git/refs/heads/master
+	git send-pack --force ./victim/ master && return 1
+	! test_cmp .git/refs/heads/master victim/refs/heads/master
 '
 
 test_expect_success \
 	'pushing does not include non-head refs' '
 	mkdir parent && cd parent &&
 	git init && touch file && git add file && git commit -m add &&
+	git checkout -b otherbranch &&
 	cd .. &&
 	git clone parent child && cd child && git push --all &&
 	cd ../parent &&
@@ -139,6 +140,7 @@ rewound_push_setup() {
 	mkdir parent && cd parent &&
 	git init && echo one >file && git add file && git commit -m one &&
 	echo two >file && git commit -a -m two &&
+	git checkout -b otherbranch
 	cd .. &&
 	git clone parent child && cd child && git reset --hard HEAD^
 }
diff --git a/t/t5401-update-hooks.sh b/t/t5401-update-hooks.sh
index 64f66c9..ae1aa77 100755
--- a/t/t5401-update-hooks.sh
+++ b/t/t5401-update-hooks.sh
@@ -17,22 +17,22 @@ test_expect_success setup '
 	commit1=$(echo modify | git commit-tree $tree1 -p $commit0) &&
 	git update-ref refs/heads/master $commit0 &&
 	git update-ref refs/heads/tofail $commit1 &&
-	git clone ./. victim &&
-	GIT_DIR=victim/.git git update-ref refs/heads/tofail $commit1 &&
+	git clone --bare ./. victim &&
+	GIT_DIR=victim git update-ref refs/heads/tofail $commit1 &&
 	git update-ref refs/heads/master $commit1 &&
 	git update-ref refs/heads/tofail $commit0
 '
 
-cat >victim/.git/hooks/pre-receive <<'EOF'
+cat >victim/hooks/pre-receive <<'EOF'
 #!/bin/sh
 printf %s "$@" >>$GIT_DIR/pre-receive.args
 cat - >$GIT_DIR/pre-receive.stdin
 echo STDOUT pre-receive
 echo STDERR pre-receive >&2
 EOF
-chmod u+x victim/.git/hooks/pre-receive
+chmod u+x victim/hooks/pre-receive
 
-cat >victim/.git/hooks/update <<'EOF'
+cat >victim/hooks/update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/update.args
 read x; printf %s "$x" >$GIT_DIR/update.stdin
@@ -40,77 +40,77 @@ echo STDOUT update $1
 echo STDERR update $1 >&2
 test "$1" = refs/heads/master || exit
 EOF
-chmod u+x victim/.git/hooks/update
+chmod u+x victim/hooks/update
 
-cat >victim/.git/hooks/post-receive <<'EOF'
+cat >victim/hooks/post-receive <<'EOF'
 #!/bin/sh
 printf %s "$@" >>$GIT_DIR/post-receive.args
 cat - >$GIT_DIR/post-receive.stdin
 echo STDOUT post-receive
 echo STDERR post-receive >&2
 EOF
-chmod u+x victim/.git/hooks/post-receive
+chmod u+x victim/hooks/post-receive
 
-cat >victim/.git/hooks/post-update <<'EOF'
+cat >victim/hooks/post-update <<'EOF'
 #!/bin/sh
 echo "$@" >>$GIT_DIR/post-update.args
 read x; printf %s "$x" >$GIT_DIR/post-update.stdin
 echo STDOUT post-update
 echo STDERR post-update >&2
 EOF
-chmod u+x victim/.git/hooks/post-update
+chmod u+x victim/hooks/post-update
 
 test_expect_success push '
-	test_must_fail git send-pack --force ./victim/.git \
+	test_must_fail git send-pack --force ./victim \
 		master tofail >send.out 2>send.err
 '
 
 test_expect_success 'updated as expected' '
-	test $(GIT_DIR=victim/.git git rev-parse master) = $commit1 &&
-	test $(GIT_DIR=victim/.git git rev-parse tofail) = $commit1
+	test $(GIT_DIR=victim git rev-parse master) = $commit1 &&
+	test $(GIT_DIR=victim git rev-parse tofail) = $commit1
 '
 
 test_expect_success 'hooks ran' '
-	test -f victim/.git/pre-receive.args &&
-	test -f victim/.git/pre-receive.stdin &&
-	test -f victim/.git/update.args &&
-	test -f victim/.git/update.stdin &&
-	test -f victim/.git/post-receive.args &&
-	test -f victim/.git/post-receive.stdin &&
-	test -f victim/.git/post-update.args &&
-	test -f victim/.git/post-update.stdin
+	test -f victim/pre-receive.args &&
+	test -f victim/pre-receive.stdin &&
+	test -f victim/update.args &&
+	test -f victim/update.stdin &&
+	test -f victim/post-receive.args &&
+	test -f victim/post-receive.stdin &&
+	test -f victim/post-update.args &&
+	test -f victim/post-update.stdin
 '
 
 test_expect_success 'pre-receive hook input' '
 	(echo $commit0 $commit1 refs/heads/master;
 	 echo $commit1 $commit0 refs/heads/tofail
-	) | test_cmp - victim/.git/pre-receive.stdin
+	) | test_cmp - victim/pre-receive.stdin
 '
 
 test_expect_success 'update hook arguments' '
 	(echo refs/heads/master $commit0 $commit1;
 	 echo refs/heads/tofail $commit1 $commit0
-	) | test_cmp - victim/.git/update.args
+	) | test_cmp - victim/update.args
 '
 
 test_expect_success 'post-receive hook input' '
 	echo $commit0 $commit1 refs/heads/master |
-	test_cmp - victim/.git/post-receive.stdin
+	test_cmp - victim/post-receive.stdin
 '
 
 test_expect_success 'post-update hook arguments' '
 	echo refs/heads/master |
-	test_cmp - victim/.git/post-update.args
+	test_cmp - victim/post-update.args
 '
 
 test_expect_success 'all hook stdin is /dev/null' '
-	! test -s victim/.git/update.stdin &&
-	! test -s victim/.git/post-update.stdin
+	! test -s victim/update.stdin &&
+	! test -s victim/post-update.stdin
 '
 
 test_expect_success 'all *-receive hook args are empty' '
-	! test -s victim/.git/pre-receive.args &&
-	! test -s victim/.git/post-receive.args
+	! test -s victim/pre-receive.args &&
+	! test -s victim/post-receive.args
 '
 
 test_expect_success 'send-pack produced no output' '
diff --git a/t/t5405-send-pack-rewind.sh b/t/t5405-send-pack-rewind.sh
index cb9aacc..2ad080f 100755
--- a/t/t5405-send-pack-rewind.sh
+++ b/t/t5405-send-pack-rewind.sh
@@ -16,7 +16,8 @@ test_expect_success setup '
 	) &&
 
 	>file2 && git add file2 && test_tick &&
-	git commit -m Second
+	git commit -m Second &&
+	git checkout -b otherbranch
 
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 3411107..7070171 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -12,7 +12,8 @@ mk_empty () {
 	(
 		cd testrepo &&
 		git init &&
-		mv .git/hooks .git/hooks-disabled
+		mv .git/hooks .git/hooks-disabled &&
+		git symbolic-ref HEAD refs/heads/nonexistent
 	)
 }
 
diff --git a/t/t5517-push-mirror.sh b/t/t5517-push-mirror.sh
index ea49ded..5536077 100755
--- a/t/t5517-push-mirror.sh
+++ b/t/t5517-push-mirror.sh
@@ -19,7 +19,7 @@ mk_repo_pair () {
 	mkdir mirror &&
 	(
 		cd mirror &&
-		git init
+		git --bare init
 	) &&
 	mkdir master &&
 	(
-- 
1.6.0.3.866.gc189b
