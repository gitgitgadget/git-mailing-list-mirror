From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] add tests for checkout -b
Date: Mon, 21 Jun 2010 00:33:10 +0800
Message-ID: <1277051592-4552-2-git-send-email-rctay89@gmail.com>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 20 18:33:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQNSi-0006rx-Ot
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 18:33:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab0FTQdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 12:33:33 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:61053 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab0FTQd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 12:33:29 -0400
Received: by pxi12 with SMTP id 12so1072162pxi.19
        for <git@vger.kernel.org>; Sun, 20 Jun 2010 09:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=pzdRqu/5OM/Btfn2VTdZ3qtsftP9Aj07nMWkNaUd1qg=;
        b=IPwTT+RKLdqAXnzi0lT96H0u1aAWPki+h2e4+PC205YLNnME5pESbYTudH+u7gSl6R
         XbdWjqlVBZYz+iMsWhoWrvV6dyqIIoOs1KG4sfv8UG0mymVfstY/8Qj7gXutKL7tKOS8
         dxuoC2pDicCnIsuOquZe1MCB7eeg4/gZt6hWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aFVOotUAf51II3kr4kvwVU3RgG/cuc6/XXrfL/b5v6J+lbSZC2CCIGxbxpTYJ06Eu7
         I7xYuI/rIS+grAvDJOMi84OZZn5Ky4vzeFZfBjStN/df0Tx0PXWVV3OUbgFcG6a/jULY
         xRDKZujknCC/fo4ut4cLo14XwNmze1TK0NQ4w=
Received: by 10.114.253.34 with SMTP id a34mr2969521wai.43.1277051609238;
        Sun, 20 Jun 2010 09:33:29 -0700 (PDT)
Received: from localhost.localdomain (cm123.zeta152.maxonline.com.sg [116.87.152.123])
        by mx.google.com with ESMTPS id n29sm9634993wae.16.2010.06.20.09.33.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 20 Jun 2010 09:33:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.513.g06a69
In-Reply-To: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149396>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t2018-checkout-branch.sh |   66 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100755 t/t2018-checkout-branch.sh

diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
new file mode 100755
index 0000000..678a34f
--- /dev/null
+++ b/t/t2018-checkout-branch.sh
@@ -0,0 +1,66 @@
+#!/bin/sh
+
+test_description='checkout '
+
+. ./test-lib.sh
+
+# Arguments: <branch> <sha> [<checkout options>]
+do_checkout() {
+	exp_branch=$1 &&
+	exp_ref="refs/heads/$exp_branch" &&
+
+	# if <sha> is not specified, use HEAD.
+	exp_sha=${2:-$(git rev-parse --verify HEAD)} &&
+
+	git checkout ${3+"$3"} -b $exp_branch $exp_sha &&
+
+	test $exp_ref = $(git rev-parse --symbolic-full-name HEAD) &&
+	test $exp_sha = $(git rev-parse --verify HEAD)
+}
+
+test_dirty() {
+	! git diff --exit-code >/dev/null
+}
+
+setup_dirty() {
+	echo >>file1 change2
+}
+
+test_expect_success 'setup' '
+	test_commit initial file1 &&
+	HEAD1=$(git rev-parse --verify HEAD) &&
+
+	test_commit change1 file1 &&
+	HEAD2=$(git rev-parse --verify HEAD) &&
+
+	git branch -m branch1
+'
+
+test_expect_success 'checkout -b to a new branch' '
+	do_checkout branch2
+'
+
+test_expect_success 'checkout -b to a new branch (explicit ref)' '
+	git checkout branch1 &&
+	git branch -D branch2 &&
+
+	do_checkout branch2 $HEAD1
+'
+
+test_expect_success 'checkout -b to a new branch (dirty)' '
+	git checkout branch1 &&
+	git branch -D branch2 &&
+
+	setup_dirty &&
+	test_must_fail do_checkout branch2 $HEAD1 &&
+	test_dirty
+'
+
+test_expect_success 'checkout -b to an existing branch fails' '
+	git reset --hard HEAD &&
+	git branch branch2 &&
+
+	test_must_fail do_checkout branch2 $HEAD2
+'
+
+test_done
-- 
1.7.1.513.g4f18
