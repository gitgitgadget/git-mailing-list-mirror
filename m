From: Mark Wooding <mdw@distorted.org.uk>
Subject: [PATCH] git-merge: New options `--no-fast-forward' and `--direct'.
Date: Sat, 18 Mar 2006 10:19:42 +0000
Message-ID: <20060318101941.8941.52615.stgit@metalzone.distorted.org.uk>
References: <slrne1nnhm.fr9.mdw@metalzone.distorted.org.uk>
X-From: git-owner@vger.kernel.org Sat Mar 18 11:19:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKYXC-0003WS-I2
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 11:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWCRKTo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 05:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWCRKTo
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 05:19:44 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:37101 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S932379AbWCRKTn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 05:19:43 -0500
Received: (qmail 8968 invoked from network); 18 Mar 2006 10:19:42 -0000
Received: from localhost (HELO metalzone.distorted.org.uk) (127.0.0.1)
  by localhost with SMTP; 18 Mar 2006 10:19:42 -0000
To: git@vger.kernel.org
In-Reply-To: <slrne1nnhm.fr9.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17694>

From: Mark Wooding <mdw@distorted.org.uk>

These options disable some of git-merge's optimizations.  

--no-fast-forward
	Does what it says on the tin: git-merge will always make a
	commit as a result of this merge (or leave one in the pipeline,
	if --no-commit was given).

--direct
	Don't do anything clever: go directly to the merge strategy
	programs.  In particular, this forbids an attempt at in-index
	merging.

We also force direct merging with the `ours' strategy, since this is
obviously what was wanted.

Signed-off-by: Mark Wooding <mdw@distorted.org.uk>
---

 Documentation/merge-options.txt |    9 ++++++++-
 git-merge.sh                    |   28 ++++++++++++++++++++++------
 git-pull.sh                     |   13 +++++++++++--
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 53cc355..5b145a1 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -6,7 +6,6 @@
 	not autocommit, to give the user a chance to inspect and
 	further tweak the merge result before committing.
 
-
 -s <strategy>, \--strategy=<strategy>::
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
@@ -14,3 +13,11 @@
 	is used instead (`git-merge-recursive` when merging a single
 	head, `git-merge-octopus` otherwise).
 
+--no-ff, \--no-fast-forward::
+	Don't fast-forward, even when it looks possible.  There will
+	always be a commit to do at the end of the merge.
+
+--direct::
+	Don't do anything clever: go directly to the merge strategy
+	programs.  In particular, this forbids an attempt at in-index
+	merging.
diff --git a/git-merge.sh b/git-merge.sh
index cc0952a..d6a579f 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -13,6 +13,8 @@ LF='
 all_strategies='recursive octopus resolve stupid ours'
 default_strategies='recursive'
 use_strategies=
+ff=t
+index_merge=t
 if test "@@NO_PYTHON@@"; then
 	all_strategies='resolve octopus stupid ours'
 	default_strategies='resolve'
@@ -65,6 +67,12 @@ do
 		no_summary=t ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=t ;;
+	--no-f|--no-ff|--no-fa|--no-fas|--no-fast|--no-fast-|--no-fast-f|\
+		--no-fast-fo|--no-fast-for|--no-fast-forw|--no-fast-forwa|\
+		--no-fast-forwar|--no-fast-forward)
+		ff=f ;;
+	--d|--di|--dir|--dire|--direc|--direct)
+		ff=f index_merge=f ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -90,6 +98,10 @@ do
 	shift
 done
 
+# `ours' is a funny strategy and clever merging optimizations here make
+# it not work.
+case " $use_strategies " in *" ours "*) ff=f index_merge=f ;; esac
+
 test "$#" -le 2 && usage ;# we need at least two heads.
 
 merge_msg="$1"
@@ -118,18 +130,18 @@ case "$#" in
 esac
 echo "$head" >"$GIT_DIR/ORIG_HEAD"
 
-case "$#,$common,$no_commit" in
-*,'',*)
+case "$#,$ff,$index_merge,$common,$no_commit" in
+*,*,*,'',*)
 	# No common ancestors found. We need a real merge.
 	;;
-1,"$1",*)
+1,*,*,"$1",*)
 	# If head can reach all the merge then we are up to date.
 	# but first the most common case of merging one remote
 	echo "Already up-to-date."
 	dropsave
 	exit 0
 	;;
-1,"$head",*)
+1,t,*,"$head",*)
 	# Again the most common case of merging one remote.
 	echo "Updating from $head to $1"
 	git-update-index --refresh 2>/dev/null
@@ -139,11 +151,11 @@ case "$#,$common,$no_commit" in
 	dropsave
 	exit 0
 	;;
-1,?*"$LF"?*,*)
+1,*,*,?*"$LF"?*,*)
 	# We are not doing octopus and not fast forward.  Need a
 	# real merge.
 	;;
-1,*,)
+1,*,t,*,)
 	# We are not doing octopus, not fast forward, and have only
 	# one common.  See if it is really trivial.
 	git var GIT_COMMITTER_IDENT >/dev/null || exit
@@ -164,6 +176,10 @@ case "$#,$common,$no_commit" in
 	fi
 	echo "Nope."
 	;;
+1,*,*,*,)
+	# Only a single remote, but we've been told not to try anything
+	# clever.  Skip to real merge.
+	;;
 *)
 	# An octopus.  If we can reach all the remote we are up to date.
 	up_to_date=t
diff --git a/git-pull.sh b/git-pull.sh
index 17fda26..229cec7 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -8,7 +8,7 @@ USAGE='[-n | --no-summary] [--no-commit]
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 
-strategy_args= no_summary= no_commit=
+strategy_args= no_summary= no_commit= noff= direct=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -17,6 +17,12 @@ do
 		no_summary=-n ;;
 	--no-c|--no-co|--no-com|--no-comm|--no-commi|--no-commit)
 		no_commit=--no-commit ;;
+	--no-f|--no-ff|--no-fa|--no-fas|--no-fast|--no-fast-|--no-fast-f|\
+		--no-fast-fo|--no-fast-for|--no-fast-forw|--no-fast-forwa|\
+		--no-fast-forwar|--no-fast-forward)
+		noff=--no-fast-forward ;;
+	--d|--di|--dir|--dire|--direc|--direct)
+		direct=--direct ;;
 	-s=*|--s=*|--st=*|--str=*|--stra=*|--strat=*|--strate=*|\
 		--strateg=*|--strategy=*|\
 	-s|--s|--st|--str|--stra|--strat|--strate|--strateg|--strategy)
@@ -92,4 +98,7 @@ case "$strategy_args" in
 esac
 
 merge_name=$(git-fmt-merge-msg <"$GIT_DIR/FETCH_HEAD")
-git-merge $no_summary $no_commit $strategy_args "$merge_name" HEAD $merge_head
+git-merge \
+	$no_summary $no_commit $noff $direct \
+	$strategy_args \
+	"$merge_name" HEAD $merge_head
