From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] Add another option for receive.denyCurrentBranch
Date: Sun, 30 Nov 2014 19:18:50 -0800
Message-ID: <xmqq1tokrrad.fsf@gitster.dls.corp.google.com>
References: <cover.1417033080.git.johannes.schindelin@gmx.de>
	<cover.1417041787.git.johannes.schindelin@gmx.de>
	<ff9c17b14b4418ae9743a094989d5478dab19701.1417041788.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 01 04:18:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvHVp-0005WY-52
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 04:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbaLADSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 22:18:53 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752326AbaLADSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 22:18:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E367623EDE;
	Sun, 30 Nov 2014 22:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=rsgGQ6i7TDtRPSnr727oef0VLCQ=; b=dINBQeaKmTAVDaEibv2r
	83Oqc2joHYEQIje+lj2ZsHSxwpGlx61U3gKZWK/2LJr8SafJooKRDEngmLJILUNz
	A2iY1ipm+d0cRG4AJpKKiuT2dkVVqWuV7LSggTfXEFPyJxzmT1tsxTg+KvuF9Mlf
	zx4na3EvJ+mPexCkmlrjbno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=M+8yDFlFHy2aC7zLDS52dtQgPts4R+IbcT1zVMjlFlcn+J
	tEuYvZzOgrEQ8LU5woZD1rY900/Krj3rdcvMkEaMHWsqYOhMfNAOfAa4SZTGuPLf
	omQlZJhiq2IIzyq4S8AdaqzcGPL4Ms0qB5jYY2fAQ/YchBJ6l6zM/TWy0GKok=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DB7A823EDD;
	Sun, 30 Nov 2014 22:18:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4DEFF23EDC;
	Sun, 30 Nov 2014 22:18:51 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C5CE9CE4-7908-11E4-A43C-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260466>

Thanks, will queue.

I think we would need a bit more tests to protect the feature from
future changes, if you care about the cleanliness requirement of
this feature which is a lot stricter than that of "git checkout".

Perhaps like this one on top.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sun, 30 Nov 2014 17:54:30 -0800
Subject: [PATCH] t5516: more tests for receive.denyCurrentBranch=updateInstead

The previous one tests only the case where a path to be updated by
the push-to-deploy has an incompatible change in the target's
working tree that has already been added to the index, but the
feature itself wants to require the working tree to be a lot cleaner
than what is tested.  Add a handful more tests to protect the
feature from future changes that mistakenly (from the viewpoint of
the inventor of the feature) loosens the cleanliness requirement,
namely:

 - A change only to the working tree but not to the index is still a
   change to be protected;

 - An untracked file in the working tree that would be overwritten
   by a push-to-deploy needs to be protected;

 - A change that happens to make a file identical to what is being
   pushed is still a change to be protected (i.e. the feature's
   cleanliness requirement is more strict than that of checkout).

Also, test that a stat-only change to the working tree is not a
reason to reject a push-to-deploy.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5516-fetch-push.sh | 96 ++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 87 insertions(+), 9 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 7b353d0..85c7fec 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1332,28 +1332,106 @@ test_expect_success 'fetch into bare respects core.logallrefupdates' '
 
 test_expect_success 'receive.denyCurrentBranch = updateInstead' '
 	git push testrepo master &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
 		git reset --hard &&
 		git config receive.denyCurrentBranch updateInstead
 	) &&
 	test_commit third path2 &&
+
+	# Try pushing into a repository with pristine working tree
 	git push testrepo master &&
-	test $(git rev-parse HEAD) = $(cd testrepo && git rev-parse HEAD) &&
-	test third = "$(cat testrepo/path2)" &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
+		git update-index -q --refresh &&
+		git diff-files --quiet -- &&
+		git diff-index --quiet --cached HEAD -- &&
+		test third = "$(cat path2)" &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
+	) &&
+
+	# Try pushing into a repository with working tree needing a refresh
+	(
+		cd testrepo &&
+		git reset --hard HEAD^ &&
+		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
+		test-chmtime +100 path1
+	) &&
+	git push testrepo master &&
+	(
+		cd testrepo &&
 		git update-index -q --refresh &&
 		git diff-files --quiet -- &&
 		git diff-index --quiet --cached HEAD -- &&
-		echo changed >path2 &&
-		git add path2
+		test_cmp ../path1 path1 &&
+		test third = "$(cat path2)" &&
+		test $(git -C .. rev-parse HEAD) = $(git rev-parse HEAD)
 	) &&
+
+	# Update what is to be pushed
 	test_commit fourth path2 &&
+
+	# Try pushing into a repository with a dirty working tree
+	# (1) the working tree updated
+	(
+		cd testrepo &&
+		echo changed >path1
+	) &&
 	test_must_fail git push testrepo master &&
-	test $(git rev-parse HEAD^) = $(git -C testrepo rev-parse HEAD) &&
-	(cd testrepo &&
+	(
+		cd testrepo &&
+		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
+		git diff --quiet --cached &&
+		test changed = "$(cat path1)"
+	) &&
+
+	# (2) the index updated
+	(
+		cd testrepo &&
+		echo changed >path1 &&
+		git add path1
+	) &&
+	test_must_fail git push testrepo master &&
+	(
+		cd testrepo &&
+		test $(git -C .. rev-parse HEAD^) = $(git rev-parse HEAD) &&
+		git diff --quiet &&
+		test changed = "$(cat path1)"
+	) &&
+
+	# Introduce a new file in the update
+	test_commit fifth path3 &&
+
+	# (3) the working tree has an untracked file that would interfere
+	(
+		cd testrepo &&
+		git reset --hard &&
+		echo changed >path3
+	) &&
+	test_must_fail git push testrepo master &&
+	(
+		cd testrepo &&
+		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
+		git diff --quiet &&
+		git diff --quiet --cached &&
+		test changed = "$(cat path3)"
+	) &&
+
+	# (4) the target changes to what gets pushed but it still is a change
+	(
+		cd testrepo &&
+		git reset --hard &&
+		echo fifth >path3 &&
+		git add path3
+	) &&
+	test_must_fail git push testrepo master &&
+	(
+		cd testrepo &&
+		test $(git -C .. rev-parse HEAD^^) = $(git rev-parse HEAD) &&
 		git diff --quiet &&
-		test changed = "$(cat path2)"
+		test fifth = "$(cat path3)"
 	)
+
 '
 
 test_done
-- 
2.2.0-117-g2c5ea17
