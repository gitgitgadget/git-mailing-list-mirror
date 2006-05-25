From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH 2/2] Improve the tutorial script
Date: Wed, 24 May 2006 21:40:03 -0400
Message-ID: <20060525014003.27814.66211.stgit@dv.roinet.com>
References: <20060525014001.27814.23082.stgit@dv.roinet.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 03:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj4qD-0003rz-Bp
	for gcvg-git@gmane.org; Thu, 25 May 2006 03:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWEYBkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 May 2006 21:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964844AbWEYBkk
	(ORCPT <rfc822;git-outgoing>); Wed, 24 May 2006 21:40:40 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:5311 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S964842AbWEYBkj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 May 2006 21:40:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fj4pv-0002MZ-OW
	for git@vger.kernel.org; Wed, 24 May 2006 21:40:29 -0400
Received: from [127.0.0.1] (helo=dv.roinet.com)
	by dv.roinet.com with esmtp (Exim 4.62)
	(envelope-from <proski@gnu.org>)
	id 1Fj4pX-0007Es-QN; Wed, 24 May 2006 21:40:03 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060525014001.27814.23082.stgit@dv.roinet.com>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20718>

From: Pavel Roskin <proski@gnu.org>

Use a function to imitate differern users.  Set environment variables so
the the names of the users are actually used in the commits.

Further limit direct use of git.  Stop using git for patch transmission. 
Use cg-mkpatch and cg-patch instead.  Don't even attempt octopus merge
to avoid confusing users.

Don't use obsolete "-d" flag for cg-tag.

Rewrite many comments to make the tutorial more coherent.  Group
commands in a more logical way.

Suppress "ed" output.  Strip trailing spaces.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 Documentation/tutorial-script/0000-playground.sh |    6 -
 Documentation/tutorial-script/script.sh          |  237 ++++++++++++----------
 2 files changed, 129 insertions(+), 114 deletions(-)

diff --git a/Documentation/tutorial-script/0000-playground.sh b/Documentation/tutorial-script/0000-playground.sh
deleted file mode 100755
index cdfb442..0000000
--- a/Documentation/tutorial-script/0000-playground.sh
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/sh
-
-rm -rf Playground
-mkdir Playground
-cd Playground
-mkdir Alice Bob Charlie
diff --git a/Documentation/tutorial-script/script.sh b/Documentation/tutorial-script/script.sh
index 5b7fc6d..b99e3c9 100755
--- a/Documentation/tutorial-script/script.sh
+++ b/Documentation/tutorial-script/script.sh
@@ -1,15 +1,14 @@
 #!/bin/bash
 #
-# FIXME: This script has some GITisms. They stem from missing Cogito
-# features, such as exporting patches to mbox format, applying patches
-# from e-mail, merging multiple tags at once, verifying signed tags and
-# repacking the repository.
+# This script serves both as a tutorial explaining how to use Cogito and
+# as a test for Cogito.  It's uses as part of the testsuite.
 #
-# Not that there would be anything wrong per se with this; GIT and Cogito
-# can interoperate fine (except few quite special situations; see the README
-# for details) and you can mix the commands; Cogito might never provide
-# wrappers for some of the GIT features which are nevertheless awesomely
-# useful, like `git bisect`.
+# This script has a few direct calls to git.  They are used when Cogito
+# doesn't provide needed functionality, such as verifying signed tags
+# and repacking the repository.
+#
+# There is anything wrong with this; git and Cogito can interoperate
+# just fine, especially if you don't use git for things Cogito can do.
 
 
 # This function is appended as "&& should_fail" to commands which should
@@ -28,100 +27,132 @@ set -e
 trap 'echo >&2 "Unexpected error $? on line $LINENO"; exit 1' exit
 
 
-### Set up playground
-sh 0000-playground.sh
-export PATH=$(pwd)/../..:$PATH # Use the local Cogito version
+# Since this script doubles as a test, prefer the local Cogito version
+# so it can be tested before installation
 TOP=$(pwd)
+export PATH=$TOP/../..:$PATH
+
+### Set up the playground
+rm -rf Playground
+mkdir Playground
+cd Playground
+
+# Suppose we have three users: Alice, Bob and Charlie
+mkdir Alice Bob Charlie
 ALICE=$TOP/Playground/Alice
 BOB=$TOP/Playground/Bob
 CHARLIE=$TOP/Playground/Charlie
-cd Playground
 
-### Alice's first version
-cd $ALICE
+# This function imitates becoming one of the users
+switch_user () {
+	case $1 in
+		Alice) cd "$ALICE";;
+		Bob) cd "$BOB";;
+		Charlie) cd "$CHARLIE";;
+		*) echo "I don't know you, $1"; exit 1;;
+	esac
+	HOME=$(pwd)
+	GIT_AUTHOR_NAME="$1"
+	GIT_AUTHOR_EMAIL="$1@example.com"
+	GIT_COMMITTER_NAME="$1"
+	GIT_COMMITTER_EMAIL="$1@example.com"
+}
+
+
+### Let's start.  Pretend you are Alice
+switch_user Alice
+
+# Alice has written an RPN calculator program
 tar xf $TOP/0001-alice.tar
 cd rpn
 
 # Being a tidy girl, she places it under Cogito
 echo "Alice's first version" | cg-init
-cg-tag -d "First ever version of RPN" rpn-0.1
- 
 
-# Alice decides on OSL-2.1
-cd $ALICE/rpn
+# Let it be known as version 0.1
+cg-tag -m "First ever version of RPN" rpn-0.1
+
+# Alice decides to add the license file to the code
 cp $TOP/0002-alice-license.txt osl-2.1.txt
 
-# The new file has to be added
+# Cogito should know that it's a new file to be added
 cg-add osl-2.1.txt
 
-# Fix up the files
+# Notices should be added to the existing files
 patch -p1 -i $TOP/0003-alice-osl.patch
 
-# Now save all, and tag it for later reference
+# Alice commits the changes and tags the result as version 0.2
 cg-commit -m "Place under OSL-2.1"
-cg-tag -d "Place under OSL-2.1" rpn-0.2
+cg-tag -m "Place under OSL-2.1" rpn-0.2
 
-# Alice creates a public repository for the new toy
+# Now Alice creates a public repository for the new toy
 cg-admin-setuprepo $ALICE/rpn.git
-cg-branch-add public "$ALICE/rpn.git" # Shortcut for the public repository
-# Alice pushes her master _and_ the two tags to the public repository
+
+# Alice will refer to it as the "public" branch
+cg-branch-add public "$ALICE/rpn.git"
+
+# Alice pushes her master branch and both tags to the public repository
 cg-push public -t rpn-0.1 -t rpn-0.2
 
-### Bob hears about this exciting new program, gets a copy from Alice
-cd $BOB
 
+### Bob hears about this exciting new program and gets a copy from Alice
+switch_user Bob
 cg-clone $ALICE/rpn.git
-
 cd rpn
 
-# Bob thinks the declarations for the stack should go in a header file
+# Bob thinks the declarations for the stack belong to a header file
 cp $TOP/0004-bob-stack_h stack.h
 patch -p1 -i $TOP/0005-bob-stack_h.patch
-
 cg-add stack.h
 cg-commit -m "Place stack declarations in header file" \
           -m "Create stack.h, move declarations of stack manipulation into it" \
-          -m "Include stack.h in rpn.c and stack.h" 
+          -m "Include stack.h in rpn.c and stack.h"
 
-# Later, he remembers he didn't fix the Makefile
+# Just after commit, Bob realizes he didn't fix the Makefile
 patch -p1 -i $TOP/0006-bob-Makefile.patch
-
 cg-commit -m "Update dependencies for stack.h in Makefile"
 
 
 ### Alice has been busy too...
-cd $ALICE/rpn
+switch_user Alice
+cd rpn
 
 # She adds the 'd'rop operation
 patch -p1 -i $TOP/0007-alice-drop.patch
-
 cg-commit -m "Add drop command" \
           -m "Change rpn.c to add handling for 'd'rop"
 
 # Then she adds 'C'lear, and a first stab at documentation
 patch -p1 -i $TOP/0008-alice-clear.patch
 cp $TOP/0009-alice-README.txt README
-
 cg-add README
 cg-commit -m "Add clear stack command" \
           -m "Change rpn.c to add handling for 'C'lear" \
           -m "Add README file with fist stab at documentation"
 
 # The result works fine, so she prepares to release it
-cg-tag -d "First public release" rpn-0.3
+cg-tag -m "First public release" rpn-0.3
 cg-push public -t rpn-0.3
 cg-export ../rpn-0.3.tar.bz2
 
 
 ### Bob tells Alice of his changes, Alice prepares to get them.
-cd $ALICE/rpn
+switch_user Alice
+cd rpn
 
+# Alice creates local branch "bob" to integrate Bob's changes.
 cg-switch -r master bob
+
+# Now Alice has branches "master", "public" and "bob" ("bob" is active).
 cg-status -g
 
-# Alice needs to register his remote branch
+# Remote branch "bobswork" is a shortcut to the Bob's master branch
 cg-branch-add bobswork $BOB/rpn
-# Now try to merge Bob's work to the bob branch
+
+# Remote branches are "public" and "bobswork".
+cg-branch-ls
+
+# Alice tries to merge Bob's work to the "bob" branch
 cg-update bobswork && should_fail
 
 # There are conflicts in rpn.c. Looking at the file, Alice sees the
@@ -132,98 +163,82 @@ #: <<<<<<< bob
 #: extern double pop(void);
 #: extern void push(double);
 #: extern void clear(void);
-#: 
+#:
 #: =======
 #: >>>>>>> bobswork
 #: extern int getsym(void);
 #: ...
- 
-# Alice keeps Bob's version
-ed rpn.c < $TOP/0010-alice-bob-fixup.ed
+
+# Alice keeps Bob's version, i.e. the one from the "bobswork" branch
+ed -s rpn.c < $TOP/0010-alice-bob-fixup.ed
 
 # cg-commit after resolving conflicts from failed merge will autogenerate
 # the commit message.
 cg-commit </dev/null
 
-# She fixes up Makefile and stack.h a bit
+# While still on the "bob" branch, Alice fixes up Makefile and stack.h
 patch -p1 -i $TOP/0011-alice-cleanup.patch
 cg-commit -m "Fix Makefile and stack.h"
 
 
-## Charlie heard of RPN, and wants to hack too.
-cd $CHARLIE
-
+### Charlie heard of RPN, and wants to hack too
+switch_user Charlie
 cg-clone $ALICE/rpn.git rpn
 cd rpn
 
-# He hacks around, and messes up rpn.c. To restore the saved version:
-rm rpn.c
-cg-restore rpn.c
+# He hacks around, and messes up rpn.c
+echo "Oops!" > rpn.c
 
-# Finally, he has the changes he wants
+# Fortunately, cg-restore can take care of it
+cg-restore -f rpn.c
+
+# Finally, Charlie has the changes he wants
 cp $TOP/0012-charlie-lexer_h lexer.h
 patch -p1 -i $TOP/0013-charlie-lexer.patch
-
 cg-add lexer.h
 cg-commit -m "Add proper header file for lexer" \
           -m "Create lexer.h, move lexer declarations into it." \
           -m "Include lexer.h in rpn.c and lexer.c" \
           -m "Update dependencies in Makefile"
 
-# Charlie emails the patch to Alice:
-# cg-mkpatch -d .. -r rpn-0.3..master
-git format-patch -o .. --mbox --signoff -r rpn-0.3
-# Only git can create mbox formatted output
-# Compare the result to 0014-charlie-email
+# Charlie prepares the patch and sends it to Alice
+cg-mkpatch -d ../patches -r rpn-0.3..master
+
+# Well, in real life Charlie is more likely to use e-mail than "cp"
+cp -r $CHARLIE/patches $ALICE/patches
 
 
 ### Alice is busy meanwhile...
-cd $ALICE/rpn
+switch_user Alice
+cd rpn
 
+# She returns to master branch, leaving "bob" for later merging
 cg-switch master
 
+# The calculator gets a new operator
 patch -p1 -i $TOP/0015-alice-mod.patch
-
 cg-commit -m "Add mod operator" \
           -m "Add handling for '%' (fmod(3)) in rpn.c"
 
+# And then another one
 patch -p1 -i $TOP/0016-alice-dup.patch
-
 cg-commit -m "Add duplication operator" \
           -m "Add handling for 'D'up in rpn.c"
-          
+
 # Alice publishes her work-in-progress
 cg-push public
 
-
-### Alice gets Charlie's fix, creates a new branch for his changes
-cd $ALICE/rpn
-
+# Alice gets Charlie's fix and creates a new branch for his changes.
+# This time, she starts the branch off the rpn-0.3 tag, which was
+# the base version for Charlie's changes.
 cg-switch -r rpn-0.3 charlie
-cg-status -g
-
-# Check what's inside the patch.  There is no Cogito equivalent yet.
-git apply --stat $TOP/0014-charlie-email
-git apply --summary $TOP/0014-charlie-email
-git apply --check $TOP/0014-charlie-email
-
-# Everything looks OK
-git applymbox $TOP/0014-charlie-email
-# This doesn't work well yet
-# cg-patch < $TOP/0014-charlie-email
-
-### Alice integrates the changes in the branches for the next release
-cd $ALICE/rpn
+cg-patch -d $ALICE/patches
 
+# Alice is going to integrate the changes in the "bob" and "charlie"
+# branches into "master" for the next release
 cg-switch master
-# Alice tries "git merge" instead of "cg-merge" since she wanted to
-# merge both branches at once, which "cg-merge" cannot do.
-git merge "Integrate changes from Bob and Charlie" master bob charlie \
-	&& should_fail
 
-# Automatic 3-way merge fails! Have to do it step by step
-
-cg-reset
+# First, Alice tries to integrate Bob's changes
 cg-merge bob && should_fail
 
 # Merge fails:
@@ -239,34 +254,38 @@ #: stack.o: stack.h
 #: lexer.o:	
 #: >>>>>>> bob
 
-ed Makefile < $TOP/0017-alice-bob-fixup.ed
-
+# Alice fixes Makefile and commits the changes
+ed -s Makefile < $TOP/0017-alice-bob-fixup.ed
 cg-commit -m "Integrate Bob's changes"
 
+# Now it's time to integrate Charlie's changes
 cg-merge charlie && should_fail
 
-# Merge conflicts!
+# Merge fails again!  Makefile needs tweaking
 
 #: ...
 #: <<<<<<< master
 #:         $(CC) $(CFLAGS) $^ -lm -o $@
-#:        
+#:
 #: rpn.o: stack.h
 #: stack.o: stack.h
 #: lexer.o:
 #: =======
 #:         $(CC) $(CFLAGS) $^ -o $@
-#:                
+#:
 #: rpn.o lexer.o: lexer.h
-#: 
+#:
 #: >>>>>>> charlie
 
-ed Makefile < $TOP/0018-alice-charlie-fixup1.ed
+# Alice fixes Makefile
+ed -s Makefile < $TOP/0018-alice-charlie-fixup1.ed
+
+# rpn.c needs fixing too
 
 #: ...
 #: <<<<<<< master
 #: extern int getsym(void);
-#: 
+#:
 #: =======
 #: extern double pop(void);
 #: extern void push(double);
@@ -275,36 +294,37 @@ #:
 #: >>>>>> charlie
 #: ...
 
-ed rpn.c    < $TOP/0019-alice-charlie-fixup2.ed
+ed -s rpn.c < $TOP/0019-alice-charlie-fixup2.ed
 
+# Finally, Charlie's changes can be committed
 cg-commit -m "Integrate Charlie's changes"
 
-# Give proper credits
+# Alice gives proper credits to the contributors
 cp $TOP/0020-alice-CONTRIBUTORS.txt CONTRIBUTORS
-
 cg-add CONTRIBUTORS
 cg-commit -m "Add CONTRIBUTORS"
 
-# Wrong file name...
+# But maybe it's better to call that file CREDITS?
 cg-mv CONTRIBUTORS CREDITS
 cg-commit -m "Rename CONTRIBUTORS to CREDITS"
 
-
-# Pack it so it uses less space
+# Alice packs the repository so it uses less space
 git repack
 git prune-packed
 
-# Second public release
-cg-tag -d "New public release" rpn-0.4
+# Now it's time for another public release
+cg-tag -m "Public release of version 0.4" rpn-0.4
 cg-push public -t rpn-0.4
 cg-export ../rpn-0.4.tar.bz2
 
-# Also pack public repository
+# The public repository needs packing too
 GIT_DIR=$ALICE/rpn.git git repack
 GIT_DIR=$ALICE/rpn.git git prune-packed
 
+
 ### Bob updates his version to Alice's
-cd $BOB/rpn
+switch_user Bob
+cd rpn
 
 cg-fetch
 
@@ -314,9 +334,10 @@ # to set up a GPG key before running the
 # scripts does not make much sense.)
 git verify-tag rpn-0.4 && should_fail
 
-# Everything's OK, integrate the changes
+# Everything's OK, Bob integrate the changes
 cg-merge
 
-# Great, we are done.
+
+### Great, we are done.
 trap - exit
 echo "Script completed successfully!"
