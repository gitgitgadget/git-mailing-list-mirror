From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 2/2] rebase: fix preserving commits with --keep-empty
Date: Fri, 20 Nov 2015 13:04:40 +0100
Message-ID: <1448021080-4994-3-git-send-email-ps@pks.im>
References: <1448021080-4994-1-git-send-email-ps@pks.im>
Cc: ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 13:05:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzkRC-0007Fl-4q
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 13:05:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162462AbbKTMFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 07:05:00 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53197 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbbKTME6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 07:04:58 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 387502057D
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 07:04:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 20 Nov 2015 07:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=IbAb
	PD9HIU4qRDG4EIR3vzyWrA8=; b=BHX/8sYmBt1Y2K96wLc3YcUgL6lotf9YasRe
	Tq25jcxhhC4pzbjnRdhFSNC+nzWc8SLAOmoCQtkcWWesyoC1p629G0a1DFOIMzau
	yd5IxoLVf8bAx+aaXlNXWJ3tPbhxM7Tq2wk4+xfHF9F3dtBVJ/HPxKLFQqrYDIgx
	n4bPeTc=
X-Sasl-enc: L5mfdt3XwYVfje55lbYt6BUmhTaXpKHLAVpO+6iPYf0P 1448021097
Received: from localhost (i59f7870a.versanet.de [89.247.135.10])
	by mail.messagingengine.com (Postfix) with ESMTPA id 8D721C016EE;
	Fri, 20 Nov 2015 07:04:57 -0500 (EST)
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1448021080-4994-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281516>

When rebasing commits where one or several commits are redundant
to commits on the branch that is being rebased upon we error out.
This is due to the usage of `--allow-empty` for the invoked
cherry-pick command, which will only cause _empty_ commits to be
picked instead of also allowing redundant commits. As
git-rebase(1) mentions, though, we also want to keep commits that
do not change anything from its parents, that is also redundant
commits.

Fix this by invoking `git cherry-pick --keep-redundant-commits`
instead, which will cause redundant commits to be rebased
correctly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 git-rebase--am.sh | 2 +-
 t/t3400-rebase.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 9ae898b..ea7b897 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -44,7 +44,7 @@ then
 	# empty commits and even if it didn't the format doesn't really lend
 	# itself well to recording empty patches.  fortunately, cherry-pick
 	# makes this easy
-	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
+	git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --keep-redundant-commits \
 		--right-only "$revisions" \
 		${restrict_revision+^$restrict_revision}
 	ret=$?
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 6cca319..f43b202 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -255,7 +255,7 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 	grep "author .* 34567 +0600$" actual
 '
 
-test_expect_failure 'rebase duplicated commit with --keep-empty' '
+test_expect_success 'rebase duplicated commit with --keep-empty' '
 	git reset --hard &&
 	git checkout master &&
 
-- 
2.6.3
