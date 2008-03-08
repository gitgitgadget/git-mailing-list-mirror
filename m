From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add test for filter-branch on a subdirectory that's been
 added and deleted and re-added
Date: Sat, 08 Mar 2008 12:25:58 -0800
Message-ID: <7vejalt12h.fsf@gitster.siamese.dyndns.org>
References: <1204977007-7267-3-git-send-email-kevin@sb.org>
 <7vzlt9t5wr.fsf@gitster.siamese.dyndns.org>
 <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 21:26:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JY5d4-0000lj-Lx
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 21:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbYCHU0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 15:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbYCHU0N
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 15:26:13 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42668 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755308AbYCHU0M (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 15:26:12 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C11803B9B;
	Sat,  8 Mar 2008 15:26:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B986A3B9A; Sat,  8 Mar 2008 15:26:07 -0500 (EST)
In-Reply-To: <91DF7A2E-540B-4AD6-91B2-BDB0B04EFC71@sb.org> (Kevin Ballard's
 message of "Sat, 8 Mar 2008 13:45:17 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76579>

This will hopefully be the final version.

-- >8 --
filter-branch: handle "disappearing tree" case correctly in subdir filter

The subdirectory filter had a bug to notice that the commit in question
did not have anything in the path-limited part of the tree.  $commit:$path
does not name an empty tree when $path does not appear in $commit.

This should fix it.  The additional test in t7003 is originally from Kevin
Ballard but with fixups.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * -f is needed because the previous one is about aborting the filter and
    leaving the "original" namespace.

 git-filter-branch.sh     |   11 ++++++++++-
 t/t7003-filter-branch.sh |   24 ++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 49e13f0..010353a 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -252,7 +252,16 @@ while read commit parents; do
 		git read-tree -i -m $commit
 		;;
 	*)
-		git read-tree -i -m $commit:"$filter_subdir"
+		# The commit may not have the subdirectory at all
+		err=$(git read-tree -i -m $commit:"$filter_subdir" 2>&1) || {
+			if ! git rev-parse --verify $commit:"$filter_subdir" 2>/dev/null
+			then
+				rm -f "$GIT_INDEX_FILE"
+			else
+				echo >&2 "$err"
+				false
+			fi
+		}
 	esac || die "Could not initialize the index"
 
 	GIT_COMMIT=$commit
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 868babc..6e14bf1 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -179,4 +179,28 @@ test_expect_success 'Name needing quotes' '
 
 '
 
+test_expect_success 'Subdirectory filter with disappearing trees' '
+	git reset --hard &&
+	git checkout master &&
+
+	mkdir foo &&
+	touch foo/bar &&
+	git add foo &&
+	test_tick &&
+	git commit -m "Adding foo" &&
+
+	git rm -r foo &&
+	test_tick &&
+	git commit -m "Removing foo" &&
+
+	mkdir foo &&
+	touch foo/bar &&
+	git add foo &&
+	test_tick &&
+	git commit -m "Re-adding foo" &&
+
+	git filter-branch -f --subdirectory-filter foo &&
+	test $(git rev-list master | wc -l) = 3
+'
+
 test_done
