From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Use git-{update,symbolic}-ref for updating HEAD
Date: Sat, 8 Oct 2005 18:57:23 +0200
Message-ID: <20051008165723.GA28414@diku.dk>
References: <20051002101224.GA9219@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 08 18:57:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOI0u-0005SP-Kb
	for gcvg-git@gmane.org; Sat, 08 Oct 2005 18:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbVJHQ50 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Oct 2005 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVJHQ50
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Oct 2005 12:57:26 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:40145 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932161AbVJHQ5Z (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2005 12:57:25 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 303AE6E1E4C; Sat,  8 Oct 2005 18:57:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 689036E17A4; Sat,  8 Oct 2005 18:57:12 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E051260F94; Sat,  8 Oct 2005 18:57:23 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20051002101224.GA9219@diku.dk>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9840>

Conditionally make git-update-ref check the old head. For this to succeed
for the initial commit, cg-init should not touch .git/refs/heads/master,
and the touching seems to be redundant anyway, so remove it.

This should make Cogito mostly work on cygwin.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

This is an incremental update to make Cogito handle symbolic refs.

 I am not sure whether the change from using '[ -L .git/HEAD ]' to using
'[ -e .git/HEAD ]' is the thing to do. And I haven't used it so much
yet; did a few commit and so on. And the tests fails do to local cloning
not working yet (git-local-fetch needs to be fixed).

 Makefile                        |    2 +-
 cg-Xlib                         |    4 ++--
 cg-commit                       |    4 ++--
 cg-init                         |    1 -
 cg-object-id                    |    2 +-

---

diff --git a/Makefile b/Makefile
index f0a0590..9eacade 100644
--- a/Makefile
+++ b/Makefile
@@ -35,7 +35,7 @@ all: cogito
 cogito: $(GEN_SCRIPT)
 
 ifneq (,$(wildcard .git))
-GIT_HEAD=.git/HEAD
+GIT_HEAD=.git/$(shell git-symbolic-ref HEAD)
 GIT_HEAD_ID=" \($(shell cat $(GIT_HEAD))\)"
 endif
 cg-version: $(VERSION) $(GIT_HEAD) Makefile
diff --git a/cg-Xlib b/cg-Xlib
index b27e8b9..dcf9aa3 100755
--- a/cg-Xlib
+++ b/cg-Xlib
@@ -246,7 +246,7 @@ tree_timewarp()
 	fi
 
 	git-read-tree -m "$branch" || die "$branch: bad commit"
-	[ "$no_head_update" ] || echo "$branch" > $_git/HEAD
+	[ "$no_head_update" ] || git-update-ref HEAD "$branch"
 
 	# Kill gone files
 	git-diff-tree -z -r $base $branch | xargs -0 bash -c '
@@ -471,7 +471,7 @@ if [ ! "$_git_repo_unneeded" ]; then
 	       exit 1
 	fi
 	_git_head=master
-	[ -L "$_git/HEAD" ] && _git_head="$(basename "$(readlink "$_git/HEAD")")"
+	[ -e "$_git/HEAD" ] && _git_head="$(basename "$(git-symbolic-ref HEAD)")"
 	[ -s "$_git/head-name" ] && _git_head="$(cat "$_git/head-name")"
 fi
 
diff --git a/cg-commit b/cg-commit
index 4345bd5..6024f17 100755
--- a/cg-commit
+++ b/cg-commit
@@ -396,7 +396,7 @@ fi
 
 oldhead=
 if [ -s "$_git/HEAD" ]; then
-	oldhead=$(cat $_git/HEAD)
+	oldhead=$(git-symbolic-ref HEAD)
 	oldheadstr="-p $oldhead"
 fi
 
@@ -420,7 +420,7 @@ fi
 
 if [ "$newhead" ]; then
 	echo "Committed as $newhead."
-	echo $newhead >$_git/HEAD
+	git-update-ref HEAD $newhead $oldhead 
 	[ "$merging" ] && rm $_git/merging $_git/merging-sym $_git/merge-base
 	rm -f "$_git/commit-ignore"
 
diff --git a/cg-init b/cg-init
index 570c83e..65faf84 100755
--- a/cg-init
+++ b/cg-init
@@ -48,7 +48,6 @@ done
 cleanup_trap "rm -rf $_git"
 
 git-init-db
-touch $_git/refs/heads/master
 
 git-read-tree # Seed the dircache
 if ! [ "$no_initial_commit" ]; then
diff --git a/cg-object-id b/cg-object-id
index 2ae9420..5c03626 100755
--- a/cg-object-id
+++ b/cg-object-id
@@ -53,7 +53,7 @@ normalize_id()
 	fi
 
 	if [ ! "$id" ] || [ "$id" = "this" ] || [ "$id" = "HEAD" ]; then
-		read id < "$_git/HEAD"
+		read id < "$_git/$(git-symbolic-ref HEAD)"
 
 	elif [ -r "$_git/refs/tags/$id" ]; then
 		read id < "$_git/refs/tags/$id"
-- 
Jonas Fonseca
