From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 1/8] t2024: Add tests verifying current DWIM behavior of 'git checkout <branch>'
Date: Sun, 21 Apr 2013 23:51:59 +0200
Message-ID: <1366581126-3880-2-git-send-email-johan@herland.net>
References: <1366581126-3880-1-git-send-email-johan@herland.net>
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Apr 21 23:52:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UU2Bm-0000Mj-Eh
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752521Ab3DUVwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 17:52:46 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:63387 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423Ab3DUVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 17:52:45 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so693350lbf.32
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 14:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=qwpp/zk32QNSOqXMQlnMEM82PylZFtBxzwDkl/WJZaQ=;
        b=AdozR3TNNS/kTwT4UZIqy7RTaO7t/Is2SgPJafER86dUrwTjasRwdoeiIdVNl2vGnq
         I4d95jliKDwUoIPmkAdoUYuH9QQ3oah2xoVGrvcBVT85+w3zEpys1T7AGklp8lQH99f/
         FCoxeptLL4leqaTlpRKsjwuQlY3PMO68g/OcBRNWqEAsZnyHseFrwVkVwOcSwOsKJjpy
         o/3dC5IzWVS/vx640rgogoSycA5ZaUYEJ62M2sB0Lwm4ZOQWb/gib5v9vONKJ/G4BqJf
         FFyL7/+ua2jL7i+MZWZvytRewR3H1od3l65tBHj5/dPP1O8mB9uIq/7jYRbXEhni3xp9
         fZ1A==
X-Received: by 10.152.19.10 with SMTP id a10mr12176824lae.8.1366581164065;
        Sun, 21 Apr 2013 14:52:44 -0700 (PDT)
Received: from gamma.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPS id ak4sm9489460lbc.12.2013.04.21.14.52.42
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 21 Apr 2013 14:52:43 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.3.704.g33f7d4f
In-Reply-To: <1366581126-3880-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221971>

The DWIM mode of checkout allows you to run "git checkout foo" when there is
no existing local ref or path called "foo", and there is exactly one remote
with a remote-tracking branch called "foo". Git will then automatically
create a new local branch called "foo" using the remote-tracking "foo" as
its starting point and configured upstream.

Improved-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t2024-checkout-dwim.sh | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100755 t/t2024-checkout-dwim.sh

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
new file mode 100755
index 0000000..1452bea
--- /dev/null
+++ b/t/t2024-checkout-dwim.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+test_description='checkout <branch>
+
+Ensures that checkout on an unborn branch does what the user expects'
+
+. ./test-lib.sh
+
+# Is the current branch "refs/heads/$1"?
+test_branch () {
+	printf "%s\n" "refs/heads/$1" >expect.HEAD &&
+	git symbolic-ref HEAD >actual.HEAD &&
+	test_cmp expect.HEAD actual.HEAD
+}
+
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
+
+test_expect_success 'setup' '
+	git init repo_a &&
+	(
+		cd repo_a &&
+		test_commit a_master &&
+		git checkout -b foo &&
+		test_commit a_foo &&
+		git checkout -b bar &&
+		test_commit a_bar
+	) &&
+	git init repo_b &&
+	(
+		cd repo_b &&
+		test_commit b_master &&
+		git checkout -b foo &&
+		test_commit b_foo &&
+		git checkout -b baz &&
+		test_commit b_baz
+	) &&
+	git remote add repo_a repo_a &&
+	git remote add repo_b repo_b &&
+	git config remote.repo_b.fetch \
+		"+refs/heads/*:refs/remotes/other_b/*" &&
+	git fetch --all
+'
+
+test_expect_success 'checkout of non-existing branch fails' '
+	git checkout -B master &&
+	test_might_fail git branch -D xyzzy &&
+
+	test_must_fail git checkout xyzzy &&
+	test_must_fail git rev-parse --verify refs/heads/xyzzy &&
+	test_branch master
+'
+
+test_expect_success 'checkout of branch from multiple remotes fails' '
+	git checkout -B master &&
+	test_might_fail git branch -D foo &&
+
+	test_must_fail git checkout foo &&
+	test_must_fail git rev-parse --verify refs/heads/foo &&
+	test_branch master
+'
+
+test_expect_success 'checkout of branch from a single remote succeeds #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D bar &&
+
+	git checkout bar &&
+	test_branch bar &&
+	test_cmp_rev remotes/repo_a/bar HEAD &&
+	test_branch_upstream bar repo_a bar
+'
+
+test_expect_success 'checkout of branch from a single remote succeeds #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	git checkout baz &&
+	test_branch baz &&
+	test_cmp_rev remotes/other_b/baz HEAD &&
+	test_branch_upstream baz repo_b baz
+'
+
+test_expect_success '--no-guess suppresses branch auto-vivification' '
+	git checkout -B master &&
+	test_might_fail git branch -D bar &&
+
+	test_must_fail git checkout --no-guess bar &&
+	test_must_fail git rev-parse --verify refs/heads/bar &&
+	test_branch master
+'
+
+test_done
-- 
1.8.1.3.704.g33f7d4f
