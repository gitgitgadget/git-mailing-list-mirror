From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Making it easier to find which change introduced a bug
Date: Sat, 30 Jul 2005 18:04:50 -0700
Message-ID: <7vy87nyedp.fsf@assigned-by-dhcp.cox.net>
References: <200507300442_MC3-1-A5F6-A039@compuserve.com>
	<20050730122007.GA8364@localhost.localdomain>
	<Pine.LNX.4.58.0507300919320.29650@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jul 31 03:05:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dz2GF-0004As-T9
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 03:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVGaBEy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 21:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVGaBEx
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 21:04:53 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:5776 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S261194AbVGaBEw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2005 21:04:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731010450.KMZO550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 30 Jul 2005 21:04:50 -0400
To: Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have placed this, after slight reworking, in the master
branch.

[jc: This patch is a rework based on what Linus posted to the
     list.  The changes are:

  - The original introduced four separate commands, which was
    three too many, so I merged them into one with subcommands.

  - Since the next thing you would want to do after telling it
    "bad" and "good" is always to bisect, this version does it
    automatically for you.

  - I think the termination condition was wrong.  The original
    version checked if the set of revisions reachable from next
    bisection but not rechable from any of the known good ones
    is empty, but if the current bisection was a bad one, this
    would not terminate, so I changed it to terminate it when
    the set becomes a singleton or empty.

  - Removed the use of shell array variable.
]

Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile          |    2 -
 git-bisect-script |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+), 1 deletions(-)
 create mode 100755 git-bisect-script

8cc6a083198877fc32224b73c61ec6e6cf8a96f5
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script
+	git-request-pull-script git-bisect-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-bisect-script b/git-bisect-script
new file mode 100755
--- /dev/null
+++ b/git-bisect-script
@@ -0,0 +1,158 @@
+#!/bin/sh
+. git-sh-setup-script || dir "Not a git archive"
+
+usage() {
+    echo >&2 'usage: git bisect [start | bad | good | next | reset]
+git bisect start		reset bisect state and start bisection.
+git bisect bad [<rev>]		mark <rev> a known-bad revision.
+git bisect good [<rev>...]	mark <rev>... known-good revisions.
+git bisect next			find next bisection to test and check it out.
+git bisect reset [<branch>]	finish bisection search and go back to branch.'
+    exit 1
+}
+
+bisect_autostart() {
+	test -d "$GIT_DIR/refs/bisect" || {
+		echo >&2 'You need to start by "git bisect start"'
+		if test -t 0
+		then
+			echo >&2 -n 'Do you want me to do it for you [Y/n]? '
+			read yesno
+			case "$yesno" in
+			[Nn]*)
+				exit ;;
+			esac
+			bisect_start
+		else
+			exit 1
+		fi
+	}
+}
+
+bisect_start() {
+        case "$#" in 0) ;; *) usage ;; esac
+	#
+	# Verify HEAD. If we were bisecting before this, reset to the
+	# top-of-line master first!
+	#
+	head=$(readlink $GIT_DIR/HEAD) || die "Bad HEAD - I need a symlink"
+	case "$head" in
+	refs/heads/bisect*)
+		git checkout master || exit
+		;;
+	refs/heads/*)
+		;;
+	*)
+		die "Bad HEAD - strange symlink"
+		;;
+	esac
+
+	#
+	# Get rid of any old bisect state
+	#
+	rm -f "$GIT_DIR/refs/heads/bisect"
+	rm -rf "$GIT_DIR/refs/bisect/"
+	mkdir "$GIT_DIR/refs/bisect"
+}
+
+bisect_bad() {
+	bisect_autostart
+        case "$#" in 0 | 1) ;; *) usage ;; esac
+	rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
+	echo "$rev" > "$GIT_DIR/refs/bisect/bad"
+	bisect_auto_next
+}
+
+bisect_good() {
+	bisect_autostart
+        case "$#" in
+	0)    revs=$(git-rev-parse --verify HEAD) || exit ;;
+	*)    revs=$(git-rev-parse --revs-only "$@") || exit ;;
+	esac
+	for rev in $revs
+	do
+	    echo "$rev" >"$GIT_DIR/refs/bisect/good-$rev"
+	done
+	bisect_auto_next
+}
+
+bisect_next_check() {
+	next_ok=no
+        test -f "$GIT_DIR/refs/bisect/bad" &&
+	case "$(cd "$GIT_DIR" && echo refs/bisect/good-*)" in
+	refs/bisect/good-\*) ;;
+	*) next_ok=yes ;;
+	esac
+	case "$next_ok,$1" in
+	no,) false ;;
+	no,fail)
+	    echo >&2 'You need to give me at least one good and one bad revisions.'
+	    exit 1 ;;
+	*)
+	    true ;;
+	esac
+}
+
+bisect_auto_next() {
+	bisect_next_check && bisect_next
+}
+
+bisect_next() {
+        case "$#" in 0) ;; *) usage ;; esac
+	bisect_autostart
+	bisect_next_check fail
+	bad=$(git-rev-parse --verify refs/bisect/bad) &&
+	good=$(git-rev-parse --sq --revs-only --not \
+		$(cd "$GIT_DIR" && ls refs/bisect/good-*)) &&
+	rev=$(eval "git-rev-list --bisect $good $bad") || exit
+	nr=$(eval "git-rev-list $rev $good" | wc -l) || exit
+	if [ "$nr" -le "1" ]; then
+	    echo "$bad is first bad commit"
+	    git-diff-tree --pretty $bad
+	    exit 0
+	fi
+	echo "Bisecting: $nr revisions left to test after this"
+	echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
+	git checkout new-bisect || exit
+	mv "$GIT_DIR/refs/heads/new-bisect" "$GIT_DIR/refs/heads/bisect" &&
+	ln -sf refs/heads/bisect "$GIT_DIR/HEAD"
+}
+
+bisect_reset() {
+	case "$#" in
+	0) branch=master ;;
+	1) test -f "$GIT_DIR/refs/heads/$1" || {
+	       echo >&2 "$1 does not seem to be a valid branch"
+	       exit 1
+	   }
+	   branch="$1" ;;
+        *)
+	    usage ;;
+	esac
+	git checkout "$branch" &&
+	rm -fr "$GIT_DIR/refs/bisect"
+	rm -f "$GIT_DIR/refs/reads/bisect"
+}
+
+case "$#" in
+0)
+    usage ;;
+*)
+    cmd="$1"
+    shift
+    case "$cmd" in
+    start)
+        bisect_start "$@" ;;
+    bad)
+        bisect_bad "$@" ;;
+    good)
+        bisect_good "$@" ;;
+    next)
+        # Not sure we want "next" at the UI level anymore.
+        bisect_next "$@" ;;
+    reset)
+        bisect_reset "$@" ;;
+    *)
+        usage ;;
+    esac
+esac
