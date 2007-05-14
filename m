From: Junio C Hamano <junkio@cox.net>
Subject: Re: committing selected 'changed' or 'added' files works, but not 'removed'
Date: Mon, 14 May 2007 00:44:36 -0700
Message-ID: <7viravonmj.fsf@assigned-by-dhcp.cox.net>
References: <87y7jsgcag.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon May 14 09:44:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnVEZ-0004Wz-Q5
	for gcvg-git@gmane.org; Mon, 14 May 2007 09:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753729AbXENHoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 03:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754498AbXENHoi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 03:44:38 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:60115 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbXENHoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 03:44:38 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514074436.CLGA13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Mon, 14 May 2007 03:44:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id yvkd1W0011kojtg0000000; Mon, 14 May 2007 03:44:37 -0400
In-Reply-To: <87y7jsgcag.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 14 May 2007 08:16:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47226>

Jim Meyering <jim@meyering.net> writes:

> Why should "removed" files be handled so differently?  If I cannot commit
> a selected "file removal" (regardless of the state of the index), then
> isn't that an opportunity to add a feature?

The answer is because it is a bit cumbersome to arrange, and
people who felt the need were too lazy to add that.  And
everybody knows that I am not from the "partial commit" camp.

You could do something like this...

NOTE NOTE NOTE.

I am not quite happy with this one, as it exposes one of my
favorite pet peeves -- wildcard pathspecs behave differently
between diff-tree family and ls-files family.  After modifying a
random C source file, you can say:

	git commit -m 'C files changed' -- '*.c'

but you cannot say:

	git commit -m 'C files modified and/or removed' -- '*.c'

after removing a C source file, because diff-tree's pathspec
only works as top-down, subdirectory limiter.

-- >8 --
git-commit: Allow removal to be partially committed as well

We allow partial commit of modified and added files but never
handled removed files.  This hacks it around.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-commit.sh     |   36 ++++++++++++++++++++++++++++++-
 t/t7400-commit.sh |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 1 deletions(-)

diff --git a/git-commit.sh b/git-commit.sh
index f28fc24..f4ba0ef 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -59,6 +59,40 @@ run_status () {
 		${untracked_files:+--untracked}
 }
 
+compute_commit_only () {
+
+	# The first one cannot commit removal
+	if test -n "$initial_commit"
+	then
+		exec git-ls-files --error-unmatch -- "$@"
+	fi
+
+	# Usual case -- no unmatch
+	if files=$(git-ls-files --error-unmatch -- "$@" 2>/dev/null)
+	then
+		echo "$files"
+		exit 0
+	fi
+
+	has_unmatch_errs=
+	# Otherwise we need to do it the hard way
+	for p in "$@"
+	do
+		removed=$(git-diff-index --cached --name-only \
+			--diff-filter=D HEAD -- "$p")
+		if test -n "$removed"
+		then
+			echo "$removed"
+		elif git-ls-files --error-unmatch -- "$p"
+		then
+			: ok so far
+		else
+			has_unmatch_errs=t
+		fi
+	done
+	test -z "$has_unmatch_errs"
+}
+
 trap '
 	test -z "$TMP_INDEX" || {
 		test -f "$TMP_INDEX" && rm -f "$TMP_INDEX"
@@ -364,7 +398,7 @@ t,)
 			refuse_partial "Cannot do a partial commit during a merge."
 		fi
 		TMP_INDEX="$GIT_DIR/tmp-index$$"
-		commit_only=`git-ls-files --error-unmatch -- "$@"` || exit
+		commit_only=$( (compute_commit_only "$@") ) || exit
 
 		# Build a temporary index and update the real index
 		# the same way.
diff --git a/t/t7400-commit.sh b/t/t7400-commit.sh
new file mode 100755
index 0000000..81196b0
--- /dev/null
+++ b/t/t7400-commit.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git commit porcelain-ish'
+
+. ./test-lib.sh
+
+test_expect_success 'the basics' '
+
+	echo doing partial >"commit is" &&
+	mkdir not &&
+	echo very much encouraged but we should >not/forbid &&
+	git add "commit is" not &&
+	echo update added "commit is" file >"commit is" &&
+	echo also update another >not/forbid &&
+	test_tick &&
+	git commit -a -m "initial with -a" &&
+
+	git cat-file blob HEAD:"commit is" >current.1 &&
+	git cat-file blob HEAD:not/forbid >current.2 &&
+
+	cmp current.1 "commit is" &&
+	cmp current.2 not/forbid
+
+'
+
+test_expect_success 'partial' '
+
+	echo another >"commit is" &&
+	echo another >not/forbid &&
+	test_tick &&
+	git commit -m "partial commit to handle a file" "commit is" &&
+
+	changed=$(git diff-tree --name-only HEAD^ HEAD) &&
+	test "$changed" = "commit is"
+
+'
+
+test_expect_success 'partial modification into subdirecotry' '
+
+	test_tick &&
+	git commit -m "partial commit to subdirectory" not &&
+
+	changed=$(git diff-tree -r --name-only HEAD^ HEAD) &&
+	test "$changed" = "not/forbid"
+
+'
+
+test_expect_success 'partial removal' '
+
+	git rm not/forbid &&
+	git commit -m "partial commit to remove not/forbid" not &&
+
+	changed=$(git diff-tree -r --name-only HEAD^ HEAD) &&
+	test "$changed" = "not/forbid" &&
+	remain=$(git ls-tree -r --name-only HEAD) &&
+	test "$remain" = "commit is"
+
+'
+
+test_done
