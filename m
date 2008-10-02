From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] git-stash.sh: fix flawed fix of invalid ref handling (commit
 da65e7c1)
Date: Thu, 02 Oct 2008 18:52:11 -0500
Message-ID: <PE1YPoO2gOexZnninF0-ua_lZKCzmivC8TnRlA2S101NX3E7meiItQ@cipher.nrlssc.navy.mil>
References: <DDpCKmlWUqX7hHbNNF45UGo81L7NuUHMbU3vXSfhHU60An5PUqIvRA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 01:53:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlXz7-0003My-T1
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 01:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517AbYJBXwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 19:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbYJBXwQ
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 19:52:16 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57761 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbYJBXwP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 19:52:15 -0400
Received: by mail.nrlssc.navy.mil id m92NqCM7007961; Thu, 2 Oct 2008 18:52:12 -0500
In-Reply-To: <DDpCKmlWUqX7hHbNNF45UGo81L7NuUHMbU3vXSfhHU60An5PUqIvRA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 02 Oct 2008 23:52:12.0329 (UTC) FILETIME=[E3B8D190:01C924E9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97381>

The referenced commit tried to fix a flaw in stash's handling of a user
supplied invalid ref. i.e. 'git stash apply fake_ref@{0}' should fail
instead of applying stash@{0}. But, it did so in a naive way by avoiding the
use of the --default option of rev-parse, and instead manually supplied the
default revision if the user supplied an empty command line. This prevented
a common usage scenario of supplying flags on the stash command line (i.e.
non-empty command line) which would be parsed by lower level git commands,
without supplying a specific revision. This should fall back to the default
revision, but now it causes an error. e.g. 'git stash show -p'

The correct fix is to use the --verify option of rev-parse, which fails
properly if an invalid ref is supplied, and still allows falling back to a
default ref when one is not supplied.

Convert stash-drop to use --verify while we're at it, since specifying
multiple revisions for any of these commands is also an error and --verify
makes it so.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---


The patch is simpler than it looks, since it includes a revert of my
original patch.

Here is 'git diff da65e7c1^:git-stash.sh git-stash.sh':

 @@ -144,17 +144,16 @@ show_stash () {
        then
                flags=--stat
        fi
-       s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@")
 
-       w_commit=$(git rev-parse --verify "$s") &&
-       b_commit=$(git rev-parse --verify "$s^") &&
+       w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
+       b_commit=$(git rev-parse --verify "$w_commit^") &&
        git diff $flags $b_commit $w_commit
 }
 
 @@ -169,7 +168,7 @@ apply_stash () {
 
        # stash records the work tree, and is a merge between the
        # base commit (first parent) and the index tree (second parent).
-       s=$(git rev-parse --revs-only --no-flags --default $ref_stash "$@") &&
+       s=$(git rev-parse --verify --default $ref_stash "$@") &&
        w_tree=$(git rev-parse --verify "$s:") &&
        b_tree=$(git rev-parse --verify "$s^1:") &&
        i_tree=$(git rev-parse --verify "$s^2:") ||
 @@ -229,7 +228,7 @@ drop_stash () {
                shift
        fi
        # Verify supplied argument looks like a stash entry
-       s=$(git rev-parse --revs-only --no-flags "$@") &&
+       s=$(git rev-parse --verify "$@") &&
        git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
        git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
        git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||

I already messed this up once, so a review is appreciated. Any reason
--verify wasn't used in the first place?

I know why it wasn't used in drop_stash(), it's because I just copied it
from apply_stash().

-brandon


 git-stash.sh |   22 ++++------------------
 1 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 42f626f..b9ace99 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -145,16 +145,8 @@ show_stash () {
 		flags=--stat
 	fi
 
-	if test $# = 0
-	then
-		set x "$ref_stash@{0}"
-		shift
-	fi
-
-	s=$(git rev-parse --revs-only --no-flags "$@")
-
-	w_commit=$(git rev-parse --verify "$s") &&
-	b_commit=$(git rev-parse --verify "$s^") &&
+	w_commit=$(git rev-parse --verify --default $ref_stash "$@") &&
+	b_commit=$(git rev-parse --verify "$w_commit^") &&
 	git diff $flags $b_commit $w_commit
 }
 
@@ -170,19 +162,13 @@ apply_stash () {
 		shift
 	esac
 
-	if test $# = 0
-	then
-		set x "$ref_stash@{0}"
-		shift
-	fi
-
 	# current index state
 	c_tree=$(git write-tree) ||
 		die 'Cannot apply a stash in the middle of a merge'
 
 	# stash records the work tree, and is a merge between the
 	# base commit (first parent) and the index tree (second parent).
-	s=$(git rev-parse --revs-only --no-flags "$@") &&
+	s=$(git rev-parse --verify --default $ref_stash "$@") &&
 	w_tree=$(git rev-parse --verify "$s:") &&
 	b_tree=$(git rev-parse --verify "$s^1:") &&
 	i_tree=$(git rev-parse --verify "$s^2:") ||
@@ -242,7 +228,7 @@ drop_stash () {
 		shift
 	fi
 	# Verify supplied argument looks like a stash entry
-	s=$(git rev-parse --revs-only --no-flags "$@") &&
+	s=$(git rev-parse --verify "$@") &&
 	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
 	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
 	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
-- 
1.6.0.2.323.g7c850
