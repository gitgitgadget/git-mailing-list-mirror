From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Making it easier to find which change introduced a bug
Date: Sat, 30 Jul 2005 10:08:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507300919320.29650@g5.osdl.org>
References: <200507300442_MC3-1-A5F6-A039@compuserve.com>
 <20050730122007.GA8364@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 30 19:09:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dyuq3-0002Kk-14
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 19:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbVG3RIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 13:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVG3RIs
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 13:08:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20658 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263074AbVG3RI1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 13:08:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6UH8LjA025498
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Jul 2005 10:08:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6UH8K2Q002738;
	Sat, 30 Jul 2005 10:08:20 -0700
To: Alexander Nyberg <alexn@telia.com>
In-Reply-To: <20050730122007.GA8364@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Jul 2005, Alexander Nyberg wrote:
> 
> Linus, do you think we could have something like
> patch-2.6.13-rc4-incremental-broken-out.tar.bz2 that could like Andrew's
> be placed into patches/ in a tree?

Not really. The thing is, since the git patches really _aren't_ serial, 
and merging isn't based on patch-merging at all (unlike quilt, that 
literally merges patches as patches), you can't really linearize a git 
tree without getting some really strange behaviour.

> As it stands today it's easier for us who don't know git to just find
> out in which mainline kernel it works and which -mm it doesn't work in,
> get the broken-out and start push/pop. And I know I'm not the only one
> who has noticed this.

What we can do is try to script the git bisection thing so that it's
really trivial. It's actually very simple to use, and I think somebody had
some example scripts around.

Here's a simple starting point for somebody who wants to try.. It's not 
very well tested, but I've done _some_ testing on it to try to make sure 
it's at least reasonable. It adds four new git commands:

 - "git bisect-start"
	reset bisect state

 - "git bisect-bad"
	mark some version known-bad (if no arguments, then current HEAD)

 - "git bisect-good"
	mark some version known-good (if no arguments, then current HEAD)

 - "git bisect"
	do a bisection between the known bad and the known good heads, and 
	check that version out.

Then, the way you use it is:

	git bisect-start
	git bisect-bad			# Current version is bad
	git bisect-good v2.6.13-rc2	# v2.6.13-rc2 was the last version tested that was good
	git bisect

which will say something like

	Bisecting: 675 revisions left to test after this

and check out the state in the middle. Now, compile that kernel, and boot 
it. Now, let's say that this booted kernel works fine, then just do

	git bisect-good			# this one is good
	git bisect

which will now say

	Bisecting: 337 revisions left to test after this

and you continue along, compiling that one, testing it, and depending on 
whether it is good or bad, you say "git-bisect-good" or "git-bisect-bad", 
and ask for the next bisection.

Until you have no more left, and you'll have been left with the first bad
kernel rev in "refs/bisect/bad".

Oh, and then after you want to reset to the original head, do a

	git checkout master

to get back to the master branch, instead of being in one of the bisection 
branches ("git bisect-start" will do that for you too, actually: it will 
reset the bisection state, and before it does that it checks that you're 
not using some old bisection branch).

Not really any harder than doing series of "quilt push" and "quilt pop", 
now is it?

		Linus

---
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -62,7 +62,9 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script
+	git-request-pull-script git-bisect-bad-script git-bisect-good-script \
+	git-bisect-script git-bisect-start-script
+
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-bisect-bad-script b/git-bisect-bad-script
new file mode 100755
--- /dev/null
+++ b/git-bisect-bad-script
@@ -0,0 +1,4 @@
+#!/bin/sh
+. git-sh-setup-script || dir "Not a git archive"
+rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
+echo "$rev" > "$GIT_DIR/refs/bisect/bad"
diff --git a/git-bisect-good-script b/git-bisect-good-script
new file mode 100755
--- /dev/null
+++ b/git-bisect-good-script
@@ -0,0 +1,4 @@
+#!/bin/sh
+. git-sh-setup-script || dir "Not a git archive"
+rev=$(git-rev-parse --revs-only --verify --default HEAD "$@") || exit
+echo "$rev" > "$GIT_DIR/refs/bisect/good-$rev"
diff --git a/git-bisect-script b/git-bisect-script
new file mode 100755
--- /dev/null
+++ b/git-bisect-script
@@ -0,0 +1,15 @@
+#!/bin/sh
+. git-sh-setup-script || dir "Not a git archive"
+bad=$(git-rev-parse --revs-only --verify refs/bisect/bad) || exit
+good=($(git-rev-parse --revs-only --not $(cd "$GIT_DIR" ; ls refs/bisect/good-*))) || exit
+rev=$(git-rev-list --bisect $bad ${good[@]}) || exit
+nr=$(git-rev-list $rev ${good[@]} | wc -l) || exit
+if [ "$nr" = "0" ]; then
+	echo "$bad is first bad commit"
+	git-diff-tree --pretty $bad
+	exit 0
+fi
+echo "Bisecting: $nr revisions left to test after this"
+echo "$rev" > "$GIT_DIR/refs/heads/new-bisect"
+git checkout new-bisect || exit
+cd "$GIT_DIR" && mv refs/heads/new-bisect refs/heads/bisect && ln -sf refs/heads/bisect HEAD
diff --git a/git-bisect-start-script b/git-bisect-start-script
new file mode 100755
--- /dev/null
+++ b/git-bisect-start-script
@@ -0,0 +1,26 @@
+#!/bin/sh
+. git-sh-setup-script || die "Not a git archive"
+
+#
+# Verify HEAD. If we were bisecting before this, reset to the
+# top-of-line master first!
+#
+head=$(readlink $GIT_DIR/HEAD) || die "Bad HEAD - I need a symlink"
+case "$head" in
+refs/heads/bisect*)
+	git checkout master || exit
+	;;
+refs/heads/*)
+	;;
+*)
+	die "Bad HEAD - strange symlink"
+	;;
+esac
+
+#
+# Get rid of any old bisect state
+#
+cd "$GIT_DIR"
+rm -f "refs/heads/bisect"
+rm -rf "refs/bisect/"
+mkdir "refs/bisect"
