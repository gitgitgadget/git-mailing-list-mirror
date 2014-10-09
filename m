From: Fabian Ruch <bafain@gmail.com>
Subject: [PATCH v1] rebase -m: Use empty tree base for parentless commits
Date: Thu,  9 Oct 2014 20:50:02 +0200
Message-ID: <bf0e177fbaac91f8c55526729e580fade9f0f395.1412879523.git.bafain@gmail.com>
References: <5434312E.6040407@redhat.com>
Cc: Eric Wong <normalperson@yhbt.net>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 20:50:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcIna-0002gE-6s
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 20:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbaJISuq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 14:50:46 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:47644 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaJISup (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 14:50:45 -0400
Received: by mail-la0-f54.google.com with SMTP id gm9so1783381lab.41
        for <git@vger.kernel.org>; Thu, 09 Oct 2014 11:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9EE0qXB4BN7sl3rcKLGI6xCnEDaZr+cx1yo/N7+6Q4=;
        b=RzZ78KkoVXmIBd45noAD0qvf1jK8iwzrqqjXlRiLs/xkaboAT26qodShWTv5X/dRcm
         De+HkQPViFnO2RlG3aqGuagK6zgd/m+9n6Kw/M2NlKbY9BoANR9wX0RgIdOtxSqZwOTL
         EVLKmXEmn8vab/+FNv01nUQxymfiQHoajSiVfOnYz5t69QESeKMJ0eeEdemrrr0uHibI
         tgHRKEGB45Efx0gXuWATOtnlMG627NRWxtfNEvut00BksVFLmDvOTFeDvpadinwGfVlf
         2NprKspySj89U/9DOI1WN/+5wV/Fq/bIOmz+FQcc6pazOgcOkh+1NE05Krn4jegdWGvT
         1z5Q==
X-Received: by 10.152.9.37 with SMTP id w5mr20485425laa.28.1412880643023;
        Thu, 09 Oct 2014 11:50:43 -0700 (PDT)
Received: from puffy.se (putty.olf.sgsnet.se. [46.239.119.252])
        by mx.google.com with ESMTPSA id pm3sm1180127lbb.15.2014.10.09.11.50.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 09 Oct 2014 11:50:42 -0700 (PDT)
X-Mailer: git-send-email 2.1.1
In-Reply-To: <5434312E.6040407@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user specifies a merge strategy, `git-merge-$strategy` is
used in non-interactive mode to replay the changes introduced by the
current branch relative to some upstream. Specifically, for each
commit `c` that is not in upstream the changes that led from `c^` to
`c` are reapplied.

If the current has a different root than the upstream, either because
the history is disconnected or merged in a disconnected history, then
there will be a parentless commit `c` and `c^` will not refer to a
commit.

In order to cope with such a situation, check for every `c` whether
its list of parents is empty. If it is empty, determine the
introduced changes by comparing the committed tree to the empty tree
instead. Otherwise, take the differences between `c^` and `c` as
before.

The other git-rebase modes do not have similar problems because they
use git-cherry-pick to replay changes, even with strategy options. It
seems that the non-interactive rebase with merge strategies was not
implemented using git-cherry-pick because it did not support them at
the time (`git rebase --merge` added in 58634dbf and `git cherry-pick
--strategy` added in 91e52598). The idea of using the empty tree as
reference tree for orphan commits is taken from the git-cherry-pick
implementation.

Regarding the patch, we do not have to commit the empty tree before
we can pass it as a base argument to `git-merge-$strategy` because
tree objects are recognized as such and implicitly committed by
`git-merge-$strategy`.

Add a test. The test case rebases a single disconnected commit which
creates an isolated file on master and, therefore, does not require a
specific merge strategy. It is a mere sanity check.

Reported-by: David M. Lloyd <david.lloyd@redhat.com>
Signed-off-by: Fabian Ruch <bafain@gmail.com>
---
Hi David,

I don't think you made a mistake at all. If I understand the --merge
mode of git-rebase correctly there is no need to require a parent.
The error occurs when the script tries to determine the changes your
merge commit introduces, which includes the whole "importing/master"
branch. The strategy is not yet part of the picture then and will not
be until the changes are being replayed.

The test case tries to simplify your scenario because the relevant
characteristic seems to be that a parentless commit gets rebased, the
root commit of "importing/master".

Regards,
   Fabian

 git-rebase--merge.sh          |  8 +++++++-
 t/t3400-rebase.sh             | 12 ++++++++++++
 t/t3402-rebase-merge.sh       | 12 ++++++++++++
 t/t3404-rebase-interactive.sh | 10 ++++++++++
 4 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index d3fb67d..3f754ae 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -67,7 +67,13 @@ call_merge () {
 		GIT_MERGE_VERBOSITY=1 && export GIT_MERGE_VERBOSITY
 	fi
 	test -z "$strategy" && strategy=recursive
-	eval 'git-merge-$strategy' $strategy_opts '"$cmt^" -- "$hd" "$cmt"'
+	base=$(git rev-list --parents -1 $cmt | cut -d ' ' -s -f 2 -)
+	if test -z "$base"
+	then
+		# the empty tree sha1
+		base=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	fi
+	eval 'git-merge-$strategy' $strategy_opts '"$base" -- "$hd" "$cmt"'
 	rv=$?
 	case "$rv" in
 	0)
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 47b5682..9b0b57f 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -10,6 +10,8 @@ among other things.
 '
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 GIT_AUTHOR_NAME=author@name
 GIT_AUTHOR_EMAIL=bogus@email@address
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
@@ -255,4 +257,14 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 	grep "author .* 34567 +0600$" actual
 '
 
+test_expect_success 'rebase disconnected' '
+	test_when_finished reset_rebase &&
+	git checkout --orphan test-rebase-disconnected &&
+	git rm -rf . &&
+	test_commit disconnected &&
+	git rebase master &&
+	test_path_is_file disconnected.t &&
+	test_cmp_rev master HEAD^
+'
+
 test_done
diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 5a27ec9..1653540 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -7,6 +7,8 @@ test_description='git rebase --merge test'
 
 . ./test-lib.sh
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
 T="A quick brown fox
 jumps over the lazy dog."
 for i in 1 2 3 4 5 6 7 8 9 10
@@ -153,4 +155,14 @@ test_expect_success 'rebase --skip works with two conflicts in a row' '
 	git rebase --skip
 '
 
+test_expect_success 'rebase --merge disconnected' '
+	test_when_finished reset_rebase &&
+	git checkout --orphan test-rebase-disconnected &&
+	git rm -rf . &&
+	test_commit disconnected &&
+	git rebase --merge master &&
+	test_path_is_file disconnected.t &&
+	test_cmp_rev master HEAD^
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 8197ed2..858c036 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1039,4 +1039,14 @@ test_expect_success 'short SHA-1 collide' '
 	)
 '
 
+test_expect_success 'rebase --interactive disconnected' '
+	test_when_finished reset_rebase &&
+	git checkout --orphan test-rebase-disconnected &&
+	git rm -rf . &&
+	test_commit disconnected &&
+	EDITOR=true git rebase --interactive master &&
+	test_path_is_file disconnected.t &&
+	test_cmp_rev master HEAD^
+'
+
 test_done
-- 
2.1.1
