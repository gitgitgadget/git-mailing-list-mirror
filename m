From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v4 2/9] stash: extract stash-like check into its own function
Date: Tue, 10 Aug 2010 10:04:41 +1000
Message-ID: <1281398688-21008-3-git-send-email-jon.seymour@gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 02:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OicML-0001TU-N0
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 02:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757345Ab0HJAGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 20:06:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38370 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757316Ab0HJAGO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 20:06:14 -0400
Received: by mail-pz0-f46.google.com with SMTP id 26so3864421pzk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 17:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DbccNlToQgQvzRyubX+gLMAIGMU0ohaLCaAxaQlVojo=;
        b=rKWiSasWk+rowf6/AOpg9zrCmgXNjFlJ35m+aq9EgVBweRQhjQOdX6+rPQW4zSytth
         1y/vZU/6gEP5IVYFbEvrbXtBbZz3Jc01o2lJt8QA4pjsem54B3bGX6eUX3N4VwkjOaIc
         u8FY8l+uQXWhzOtX6SUsK+vzO+jUAusF6H7rg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PCN0N/E4le9hGY4lOPiPBVJQHuxwzzCVdgTCR30FvqiZZmnHMbJmLHhUZxVT6jn1/l
         pOJNwwYKQ9mZT/hvxaYYZaW65RHF0/bBgxFz1N5MtuTGaI1YGolEsDtnKKJShqEfxOhV
         wXVGEhl7srApe0TEnt8qUTnNZoO9zrDhtHOF8=
Received: by 10.142.204.2 with SMTP id b2mr14222638wfg.282.1281398771239;
        Mon, 09 Aug 2010 17:06:11 -0700 (PDT)
Received: from localhost.localdomain ([120.16.203.103])
        by mx.google.com with ESMTPS id x18sm7096974wfd.8.2010.08.09.17.06.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 17:06:10 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.53.gddb82
In-Reply-To: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153060>

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
1.6.5.rc3.8.g8ba5e
