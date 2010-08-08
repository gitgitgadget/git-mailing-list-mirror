From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v3 2/9] stash: extract stash-like check into its own function
Date: Sun,  8 Aug 2010 14:46:04 +1000
Message-ID: <1281242771-24764-3-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, ams@toroid.org, nanako3@bluebottle.com,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 08 06:47:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhxnY-0007q2-6q
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874Ab0HHErh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:47:37 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:63422 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0HHErg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:47:36 -0400
Received: by mail-pw0-f46.google.com with SMTP id 7so971854pwj.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=7wnVMtXqSI/gkJUjDpUMwgNy/2LMMJrsItDGxRmNJj0=;
        b=f2hnv7VniQ0SFTu+CtnndbBmi/a35KHYBQSZiZ90oAQ7Rd4CzcjzkSc/7dOEMZZlL2
         kI0wjCjmkWQ3Hhl/CR0U/Nnk6rtwxzkfnmrpzPquYO61Pz/UgXzi+F+ad1s0yV+1lXLX
         OyHVGarNeI/UR+54DSrGZg8JgDZe0kSj/WJZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=B5UwuWG6LyHKW1J6/HauURazNnRkTr6p9LPz5SDLeXe/hd3RzmxcI/Fvz7eVv+WQFw
         4RvgYpn+u48HdLQh6QrIEtYLIKvIzJ4AlR7Pio1DymbWnHE9ZfBamo8/cH1O6SrWv1L7
         T6c3eLIud+jQ5ZZpzW4hqyNgx0Gz2Nxcyw0TY=
Received: by 10.142.156.14 with SMTP id d14mr12108744wfe.86.1281242855828;
        Sat, 07 Aug 2010 21:47:35 -0700 (PDT)
Received: from localhost.localdomain ([120.16.216.92])
        by mx.google.com with ESMTPS id n2sm4295884wfl.13.2010.08.07.21.47.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:47:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.47.gc532
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152886>

A similar code block is used in three places; this change
factors the stash-like check into a separate function so that
it can be used in these and other places.

Note to reviewers: The existing code in apply_stash appears
to assume w_tree, b_tree and i_tree are all trees as opposed
to tree-ish (which is what they actually are).

This refactoring does not change the existing derivation,
but one wonders whether this difference might be subverting
the intent of the test which compares c_tree with i_tree.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 git-stash.sh |   46 ++++++++++++++++++++++++++++++----------------
 1 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 31ea333..dbb7944 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -218,13 +218,30 @@ show_stash () {
 		flags=--stat
 	fi
 
-	w_commit=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
-	b_commit=$(git rev-parse --quiet --verify "$w_commit^") ||
-		die "'$*' is not a stash"
+	assert_stash_like "$@"
 
 	git diff $flags $b_commit $w_commit
 }
 
+#
+# if this function returns, then:
+#   s is set to the stash commit
+#   w_commit is set to the commit containing the working tree
+#   b_commit is set to the base commit
+#   i_commit is set to the commit containing the index tree
+# otherwise:
+#   the function exits via die
+#
+assert_stash_like() {
+	# stash records the work tree, and is a merge between the
+	# base commit (first parent) and the index tree (second parent).
+	s=$(git rev-parse --revs-only --quiet --verify --default $ref_stash "$@") &&
+	w_commit=$(git rev-parse --quiet --verify "$s:") &&
+	b_commit=$(git rev-parse --quiet --verify "$s^1:") &&
+	i_commit=$(git rev-parse --quiet --verify "$s^2:") ||
+		die "$*: no valid stashed state found"
+}
+
 apply_stash () {
 	applied_stash=
 	unstash_index=
@@ -253,13 +270,11 @@ apply_stash () {
 		applied_stash="$*"
 	fi
 
-	# stash records the work tree, and is a merge between the
-	# base commit (first parent) and the index tree (second parent).
-	s=$(git rev-parse --quiet --verify --default $ref_stash "$@") &&
-	w_tree=$(git rev-parse --quiet --verify "$s:") &&
-	b_tree=$(git rev-parse --quiet --verify "$s^1:") &&
-	i_tree=$(git rev-parse --quiet --verify "$s^2:") ||
-		die "$*: no valid stashed state found"
+	assert_stash_like "$@"
+
+	b_tree=$b_commit
+	w_tree=$w_commit
+	i_tree=$i_commit
 
 	git update-index -q --refresh &&
 	git diff-files --quiet --ignore-submodules ||
@@ -270,6 +285,9 @@ apply_stash () {
 		die 'Cannot apply a stash in the middle of a merge'
 
 	unstashed_index_tree=
+	#
+	# note to reviewers: comparing $c_tree to $i_tree seems unsound, since i_tree is only tree-ish
+	#
 	if test -n "$unstash_index" && test "$b_tree" != "$i_tree" &&
 			test "$c_tree" != "$i_tree"
 	then
@@ -351,12 +369,8 @@ drop_stash () {
 		set x "$ref_stash@{0}"
 		shift
 	fi
-	# Verify supplied argument looks like a stash entry
-	s=$(git rev-parse --verify "$@") &&
-	git rev-parse --verify "$s:"   > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^1:" > /dev/null 2>&1 &&
-	git rev-parse --verify "$s^2:" > /dev/null 2>&1 ||
-		die "$*: not a valid stashed state"
+
+	assert_stash_like "$@"
 
 	git reflog delete --updateref --rewrite "$@" &&
 		say "Dropped $* ($s)" || die "$*: Could not drop stash entry"
-- 
1.7.2.1.51.g82c0c0
