From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/6] t6014: test prune with detached HEADs in separate worktrees
Date: Fri, 26 Feb 2016 17:39:42 +0100
Message-ID: <47fd12af598614ca10fa28cb36fb98ca9ab6d7bb.1456504190.git.git@drmicha.warpmail.net>
References: <cover.1456504190.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 17:40:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZLR0-00014b-9t
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 17:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbcBZQjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 11:39:53 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35035 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754483AbcBZQjv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 11:39:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 94E52208E3
	for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:39:50 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 26 Feb 2016 11:39:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	date:from:in-reply-to:message-id:references:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=r4dVJkvAZVLsIvTyLvQxo5TMD24
	=; b=CWUbSH7m/UOzFgg0qWjBMuLM8QqwfuB3UWtOabM6ocgYgSqKTXbmIaWJYQ2
	sT9V9fSqsCu4jIHW24x4n/0JiCrNmuhSDgFVtAApxVMZq4x7u/r0DXOBQ2X5UcgD
	ntt909NytDwvquMku6GlKI4PggIbRqR4nmM0v0DvdZ8Arwwg=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=r4dV
	JkvAZVLsIvTyLvQxo5TMD24=; b=a/994qnfjv93XKkl7/e+Nef1F671F5RoJvO5
	Z3ex92tKVbB2yxH1qtm8HNTOyTsmC9BfLxUfg/B7giRTGwKDJlMCi/LbOptJiis0
	n/zPF2CJMW4tUXOPzGN9MQ+SG5iuu3yc+xkC7/EI10y1rO9FAnaOJLh0hl0ha6Uq
	d1gpFrc=
X-Sasl-enc: pO1kJB9sXLZvZOtoHi6r0u/B6Dh8au/NzLQflyLufYer 1456504790
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 2C105C00014;
	Fri, 26 Feb 2016 11:39:50 -0500 (EST)
X-Mailer: git-send-email 2.7.2.618.g7a61b68
In-Reply-To: <cover.1456504190.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287585>

"git prune" relies on "git rev-list --all" to list all reachable,
non-prunable commits. In the presence of per-worktree refs such as HEAD
this becomes more complicated.

Add a test that makes sure that per-worktree refs from other worktrees
are not omitted.

This is currently broken, possibly resulting in data loss.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t6014-rev-list-all.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/t/t6014-rev-list-all.sh b/t/t6014-rev-list-all.sh
index c9bedd2..99bf8ae 100755
--- a/t/t6014-rev-list-all.sh
+++ b/t/t6014-rev-list-all.sh
@@ -39,4 +39,29 @@ test_expect_success 'rev-list --graph --no-walk is forbidden' '
 	test_must_fail git rev-list --graph --no-walk HEAD
 '
 
+test_expect_success 'setup worktree tests' '
+	mkdir newtree &&
+	git worktree add --detach newtree master^ &&
+	(
+		cd newtree &&
+		commit detached2
+	)
+'
+
+test_expect_failure 'prune in main worktree does not lose detached HEAD in new worktree' '
+	git prune --expire=now &&
+	(
+		cd newtree &&
+		git show HEAD
+	)
+'
+
+test_expect_failure 'prune in new worktree does not lose detached HEAD in main worktree' '
+	(
+		cd newtree &&
+		git prune --expire=now
+	) &&
+	git show HEAD
+'
+
 test_done
-- 
2.7.2.618.g7a61b68
