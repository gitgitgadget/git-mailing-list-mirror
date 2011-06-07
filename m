From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Tue, 7 Jun 2011 16:06:59 -0400
Message-ID: <20110607200659.GA6177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, Michael Nahas <mike@nahas.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 22:07:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU2YS-0001Bk-6f
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 22:07:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753821Ab1FGUHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 16:07:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58667
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab1FGUHE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 16:07:04 -0400
Received: (qmail 20861 invoked by uid 107); 7 Jun 2011 20:07:10 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 16:07:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 16:06:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175262>

This is an idea I've had for a while, but I was inspired to push it
forward a bit by Mike's command-line thread.

One problem I have seen people complain about is how "reset" and
"checkout" are somewhat overloaded to pull content into and out of the
index (since they also do things like moving HEAD or switching
branches). Those commands took the approach of saying "reset is about
changing the HEAD and possibly the index; therefore "reset -- file"
should be about pulling things from a commit into the index". And that
is certainly one way to think about it.

But another way to think about it is that commits, the index, and the
working tree are all "locations" with content. And one common operation
you may want to do is to move content from one spot to another, either
whole, by file, or by diff hunks. To a new user, knowing that "add" is
the command for moving content from thet working tree to the index does
not help them know which command to use to do the opposite content
movement.

So the "reset -- <file>" command is easily discoverable if you come at
it one way (I already know what reset does, but I want to reset just
some specific file), but not another way (I know how to move content one
way, but not the other way).

My idea is therefore to have a single command for moving content from
one location to another. You specify a source and a destination and get
a uniform interface for moving content.

A proof-of-concept patch is below. Be aware that is meant to be
illustrative and is not well tested. Also, it is a minimal presentation
of the concept. Other "locations" may also be meaningful. I'll include
some ideas below the patch.

---
 Makefile   |    1 +
 git-put.sh |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+), 0 deletions(-)
 create mode 100644 git-put.sh

diff --git a/Makefile b/Makefile
index e40ac0c..4564506 100644
--- a/Makefile
+++ b/Makefile
@@ -368,6 +368,7 @@ SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-pull.sh
+SCRIPT_SH += git-put.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase.sh
 SCRIPT_SH += git-repack.sh
diff --git a/git-put.sh b/git-put.sh
new file mode 100644
index 0000000..f673e14
--- /dev/null
+++ b/git-put.sh
@@ -0,0 +1,70 @@
+#!/bin/sh
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHASH=Yes
+OPTIONS_SPEC="\
+git put [options] <from> <to> [--] <file...>
+
+Move contents from one place to another, where <from> and <to> are one of:
+  1. A commit (e.g., master, HEAD~10, v1.7.5)
+  2. The special token INDEX to indicate git's index.
+  3. The special token WORKTREE to indicate the working directory.
+
+Options:
+--
+p            don't move whole files; use the patch interface
+"
+. git-sh-setup
+
+patch=
+while test $# != 0; do
+	case "$1" in
+	-p) patch=--patch ;;
+	--) shift; break ;;
+	*) usage ;;
+	esac
+	shift
+done
+test $# -lt 2 && usage
+
+from=$1; shift
+to=$1; shift
+test "$1" = "--" && shift
+
+type_of() {
+	case "$1" in
+	INDEX) echo index ;;
+	WORKTREE) echo worktree ;;
+	*) echo commit ;;
+	esac
+}
+
+# Checkout contents to worktree without munging the index in
+# between.
+worktree_checkout() {
+	old=$GIT_INDEX_FILE
+	test -z "$old" && old=$(git rev-parse --git-dir)/index
+	new=$(git rev-parse --git-dir)/put-index.tmp
+	cp "$old" "$new" &&
+	GIT_INDEX_FILE=$new git checkout "$@"
+	status=$?
+	rm -f "$new"
+	exit $status
+}
+
+case "$(type_of "$from"),$(type_of "$to")" in
+*,commit)
+	die "You can't modify an existing commit." ;;
+index,index)
+	die "You can't move content from the index on top of itself." ;;
+worktree,index)
+	exec git add $patch -- "$@" ;;
+commit,index)
+	exec git reset $patch "$from" -- "$@" ;;
+index,worktree)
+	exec git checkout $patch -- "$@" ;;
+worktree,worktree)
+	die "You can't move content in the worktree on top of itself." ;;
+commit,worktree)
+	worktree_checkout $patch "$from" -- "$@" ;;
+esac


As you can see, this handles only three typoes of locations: the
worktree, the index, and an arbitrary commit (really a tree-ish). Some
other types I've thought of are:

  - stashes; you can already use stashes a source with "stash@{0}". They
    could also be a destination, chaining to "git stash".

  - branches as destinations; obviously we can't change an existing
    commit, but what about something like:

      git put WORKTREE BRANCH:foo

    to optionally create a new branch "refs/heads/foo" based on the
    current HEAD, push changes into a temporary index that matches its
    tip, and then making a new commit based on top.

    This would serve a similar purpose to stashes, except that they
    would be named and could operate as full branches. I would find it
    useful for picking apart a mass of worktree changes into discrete
    commits.

  - allow multiple destinations, like

     # equivalent to "git checkout --"
     git put HEAD INDEX,WORKTREE

  - blobs as locations. We could allow something like:

      git put v1.7.5:Makefile WORKTREE:Makefile

    which would be equivalent to

      git put v1.7.5 WORKTREE -- Makefile

    but sometimes matches the user's mental model better. It also allows
    pulling blobs from index stages, like:

      # Resolve in favor of "ours"
      git put :2:Makefile INDEX,WORKTREE

  - subtrees as locations. This allows a form of renaming between old
    versions.

      git put gitgui-0.10.0: WORKTREE:git-gui


I hope it's obvious from what I wrote above and from the implementation,
but this would not be _replacing_ other commands, but would just be
another way of looking at them. By having more than one way to do the
same thing, it helps people discover the way that fits their mental
model most appropriately.  Of course, it may also just introduce insane
confusion.

Let the flaming begin.

-Peff
