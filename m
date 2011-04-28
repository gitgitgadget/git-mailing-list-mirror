From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH v2] git-rebase--interactive.sh: preserve-merges fails on merges created with no-ff
Date: Thu, 28 Apr 2011 00:35:55 -0400
Message-ID: <1303965355-3393-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vfwp38uwf.fsf@alter.siamese.dyndns.org>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 06:37:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFIym-00020m-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 06:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752824Ab1D1EhX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 00:37:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46444 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab1D1EhW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 00:37:22 -0400
Received: by ywj3 with SMTP id 3so856913ywj.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 21:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=2Q9Gi+beQW714yrstQ7uyPtt0hxLdoPKoXdNTrusRQo=;
        b=sPVaDKqfvY5rcW4sQzBWqPeo2tB32QqGrhjtSzfCTAg+ffKith5ePeW+80/VUp9uQf
         f6pQA+zJ/jOqroj7gb1nMU3a9YbfrEygY2wKtjT11BJnnl+bzzDcQVN1sv5AOHaC1wXi
         jX+qz7/3Y/SuxJcDDMI8XM9f1E/3J81TgGT80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=CJsrxnX9/Ode0Qe78hnLFBZVkSOEf3yIRMpUBY4GbJy4nKpoTdbizBgQHj2lgSfv4H
         ugHpdgFhrMvT3NY5rg5C0QsdoUyj9CIwa7tswLKmyo3y0jyrydc/FoG5+iY9CAVUmRgj
         GC901JvUBlHut5MaVKza2OxgQwYJgXRqe4zvE=
Received: by 10.101.175.1 with SMTP id c1mr1906383anp.169.1303965441653;
        Wed, 27 Apr 2011 21:37:21 -0700 (PDT)
Received: from localhost.localdomain (CPE687f74883d54-CM001692fb632e.cpe.net.cable.rogers.com [99.231.190.188])
        by mx.google.com with ESMTPS id j15sm1430970ank.5.2011.04.27.21.37.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 21:37:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2
In-Reply-To: <7vfwp38uwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172315>

'git rebase' uses 'git merge' to preserve merges (-p).  This preserves
the original merge commit correctly, except when the original merge
commit was created by 'git merge --no-ff'.  In this case, 'git rebase'
will fail to preserve the merge, because during 'git rebase', 'git
merge' will simply fast-forward and skip the commit.  For example:

               B
              / \
             A---M
            /
    ---o---O---P---Q

If we try to rebase M onto P, we lose the merge commit and this happens:

                 A---B
                /
    ---o---O---P---Q

To correct this, we simply do a "no fast-forward" on all merge commits
when rebasing.  Since by the time we decided to do a 'git merge' inside
'git rebase', it means there was a merge originally, so 'git merge'
should always create a merge commit regardless of what the merge
branches look like. This way, when rebase M onto P from the above
example, we get:

                   B
                  / \
                 A---M
                /
    ---o---O---P---Q

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 git-rebase--interactive.sh        |    2 +-
 t/t3409-rebase-preserve-merges.sh |   32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 5873ba4..c308529 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -339,7 +339,7 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge --no-ff $STRATEGY -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 19341e5..08201e2 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -27,7 +27,17 @@ export GIT_AUTHOR_EMAIL
 #    \
 #     B2       <-- origin/topic
 #
-# In both cases, 'topic' is rebased onto 'origin/topic'.
+# Clone 3 (no-ff merge):
+#
+# A1--A2--B3   <-- origin/master
+#  \
+#   B1------M  <-- topic
+#    \     /
+#     \--A3    <-- topic2
+#      \
+#       B2     <-- origin/topic
+#
+# In all cases, 'topic' is rebased onto 'origin/topic'.
 
 test_expect_success 'setup for merge-preserving rebase' \
 	'echo First > A &&
@@ -61,6 +71,16 @@ test_expect_success 'setup for merge-preserving rebase' \
 		git commit -m "Merge origin/master into topic"
 	) &&
 
+	git clone ./. clone3 &&
+	(
+		cd clone3 &&
+		git checkout -b topic2 origin/topic &&
+		echo Sixth > A &&
+		git commit -a -m "Modify A3" &&
+		git checkout -b topic origin/topic &&
+		git merge --no-ff topic2
+	) &&
+
 	git checkout topic &&
 	echo Fourth >> B &&
 	git commit -a -m "Modify B2"
@@ -93,4 +113,14 @@ test_expect_success '--continue works after a conflict' '
 	)
 '
 
+test_expect_success 'rebase -p preserves no-ff merges' '
+	(
+	cd clone3 &&
+	git fetch &&
+	git rebase -p origin/topic &&
+	test 3 = $(git rev-list --all --pretty=oneline | grep "Modify A" | wc -l) &&
+	test 1 = $(git rev-list --all --pretty=oneline | grep "Merge branch" | wc -l)
+	)
+'
+
 test_done
-- 
1.7.2.2
