From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] rebase: test broken behavior with --keep-empty
Date: Fri, 20 Nov 2015 13:04:39 +0100
Message-ID: <1448021080-4994-2-git-send-email-ps@pks.im>
References: <1448021080-4994-1-git-send-email-ps@pks.im>
Cc: ps@pks.im
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 13:05:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZzkR4-0006vj-4v
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 13:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759973AbbKTME5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 07:04:57 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34685 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751329AbbKTME4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2015 07:04:56 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id E913420744
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 07:04:55 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 20 Nov 2015 07:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=wNtt
	WXHTkeMbQceEZYNhailWf0I=; b=P95rMbvdNTyzdRHOJ/dC85kt82Gm2Uv6fs5s
	xgfzTibodECK43qb4S5x7tV3JQR9UeIy/SvkKpH6KtAwIOoFN7XHDBZIGeP9tc6e
	+8dIvXT6dik0xrMzyALRAQNZQ/0qn3bEpS/DEbfFAZqHrSvHR2FLRMdMmu0h6qtK
	XUeE8ZU=
X-Sasl-enc: xZcwkfQGm+/sQij0bNubozqTbkHia9t63y4eT2rHp5rY 1448021095
Received: from localhost (i59f7870a.versanet.de [89.247.135.10])
	by mail.messagingengine.com (Postfix) with ESMTPA id 501EFC016DA;
	Fri, 20 Nov 2015 07:04:55 -0500 (EST)
X-Mailer: git-send-email 2.6.3
In-Reply-To: <1448021080-4994-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281514>

When a commit is already present in the branch that is being
rebased upon we get an empty commit. Usually we just drop this
commit, but with `--keep-empty` we want to preserve the commit's
message.

Instead of simply applying the empty commit, though, we
erroneously end up in cherry-picking mode without any ability to
get back to the previous rebase.

The same error happens when we try to rebase a commit with
`--keep-empty` that causes a conflict.

Add tests that document this breakage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t3400-rebase.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 47b5682..6cca319 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -255,4 +255,30 @@ test_expect_success 'rebase commit with an ancient timestamp' '
 	grep "author .* 34567 +0600$" actual
 '
 
+test_expect_failure 'rebase duplicated commit with --keep-empty' '
+	git reset --hard &&
+	git checkout master &&
+
+	>x && git add x && git commit x -mx &&
+	echo x > x && git commit x -mx1 &&
+
+	git checkout -b duplicated HEAD~ &&
+	echo x > x && git commit x -mx2 &&
+	git rebase --keep-empty master
+'
+
+test_expect_failure 'rebase conflicting commit with --keep-empty' '
+	git reset --hard &&
+	git checkout master &&
+
+	echo y > x && git commit x -my &&
+
+	git checkout -b conflict HEAD~ &&
+	echo z > x && git commit x -mz &&
+	test_must_fail git rebase --keep-empty master &&
+
+	git add x &&
+	git rebase --continue
+'
+
 test_done
-- 
2.6.3
