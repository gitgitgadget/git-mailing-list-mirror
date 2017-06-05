Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D3F11F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 20:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdFEUk3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 16:40:29 -0400
Received: from a7-18.smtp-out.eu-west-1.amazonses.com ([54.240.7.18]:39986
        "EHLO a7-18.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751274AbdFEUk2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 5 Jun 2017 16:40:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1496695225;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=ivVRtogBCpoAyVTarM8jtGCPKGU/gq8ceq/lwvu0Z98=;
        b=jAtpX0y49JqnxIsce7e7cq1t+GHoJI17eywUetg+wgRwDN/UrqrOI//cC2+e6bPE
        hjot/EH0UPOD1CgOX1khB2yEn8jM+hPKhFEnU1VEgsZ/jd6uHgyM7oiY7hVUTZWX0wY
        oNdlWZAuFmKlFWL8xAqU6OVHEuz1eghxOIaBzQoI=
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015c64f0dceb-02338e52-74d5-4d6c-9a9d-f41e98ff88bc-000000@eu-west-1.amazonses.com>
References: <0102015c64f0dceb-02338e52-74d5-4d6c-9a9d-f41e98ff88bc-000000@eu-west-1.amazonses.com>
Subject: [PATCH/RFC v4 1/3] branch: add tests for new copy branch feature
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Mon, 5 Jun 2017 20:40:25 +0000
X-SES-Outgoing: 2017.06.05-54.240.7.18
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adds a few basic tests for the new copy branch option. Aim is to
have an option -c for copying a branch just like -m option for
renaming a branch.

My definition of "copy" for this feature is "copying from A to create
B, keeping A intact". That means "copy branch A to B" should do
whatever "move branch A to B" does except it shouldn't delete A and
should keep A unchanged.

1. When a branch topic-2 is created by copying from branch topic-1,
topic-2 branch reflog should now contain the all the entries of
topic-1 branch (before copying) followed by "Copied from topic-1".
[This is debatable though, I want inputs/suggestions about this.]

2. Copying a branch should also copy the git config section for that
branch. This means if topic-2 branch is created from topic-1,
"branch.topic-2.remote" should now be same as "branch.topic-1.remote",
if set.

3. "git push" to copied branch for example - topic-2 should push a new
branch with the same name in the remote repo. That means if topic-1
was previously pushed and a new branch topic-2 is copied from topic-1,
"git push" on topic-2 branch won't push to the same branch as "git
push on topic-1 branch would.

4. "git branch -c new-branch" should copy the currently checked out
branch and create a new branch with name "new-branch".

Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---
 t/t3200-branch.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index fe62e7c775da6..91b9d07539bec 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -341,6 +341,106 @@ test_expect_success 'config information was renamed, too' '
 	test_must_fail git config branch.s/s/dummy
 '
 
+test_expect_success 'git branch -c dumps usage' '
+	test_expect_code 128 git branch -c 2>err &&
+	test_i18ngrep "branch name required" err
+'
+
+test_expect_success 'git branch -c d e should work' '
+	git branch -l d &&
+	git reflog exists refs/heads/d &&
+	git config branch.d.dummy Hello &&
+	git branch -c d e &&
+	git reflog exists refs/heads/d &&
+	git reflog exists refs/heads/e &&
+	test $(git config branch.e.dummy) = Hello &&
+	test $(git config branch.d.dummy) = Hello
+'
+
+test_expect_success 'git branch -c f/f g/g should work' '
+	git branch -l f/f &&
+	git reflog exists refs/heads/f/f &&
+	git config branch.f/f.dummy Hello &&
+	git branch -c f/f g/g &&
+	git reflog exists refs/heads/f/f &&
+	git reflog exists refs/heads/g/g &&
+	test $(git config branch.f/f.dummy) = Hello &&
+	test $(git config branch.g/g.dummy) = Hello
+'
+
+test_expect_success 'git branch -c m2 m2 should work' '
+	git branch -l m2 &&
+	git reflog exists refs/heads/m2 &&
+	git config branch.m2.dummy Hello &&
+	git branch -c m2 m2 &&
+	git reflog exists refs/heads/m2 &&
+	test $(git config branch.m2.dummy) = Hello
+'
+
+test_expect_success 'git branch -c zz zz/zz should fail' '
+	git branch -l zz &&
+	git reflog exists refs/heads/zz &&
+	test_must_fail git branch -c zz zz/zz
+'
+
+test_expect_success 'git branch -c b/b b should fail' '
+	git branch -l b/b &&
+	test_must_fail git branch -c b/b b
+'
+
+test_expect_success 'git branch -C o/q o/p should work when o/p exists' '
+	git branch -l o/q &&
+	git reflog exists refs/heads/o/q &&
+	git reflog exists refs/heads/o/p &&
+	git branch -C o/q o/p
+'
+
+test_expect_success 'git branch -c -f o/q o/p should work when o/p exists' '
+	git reflog exists refs/heads/o/q &&
+	git reflog exists refs/heads/o/p &&
+	git branch -m -f o/q o/p
+'
+
+test_expect_success 'git branch -c qq rr/qq should fail when r exists' '
+	git branch qq &&
+	git branch rr &&
+	test_must_fail git branch -c qq rr/qq
+'
+
+test_expect_success 'git branch -C b1 b2 should fail when b2 is checked out' '
+	git branch b1 &&
+	git checkout -b b2 &&
+	test_must_fail git branch -C b1 b2
+'
+
+test_expect_success 'git branch -C c1 c2 should succeed when c1 is checked out' '
+	git checkout -b c1 &&
+	git branch c2 &&
+	git branch -C c1 c2 &&
+	test $(git rev-parse --abbrev-ref HEAD) = c2
+'
+
+test_expect_success 'git branch -C c1 c2 should add entries to .git/logs/HEAD' '
+	msg="Branch: copied refs/heads/c1 to refs/heads/c2" &&
+	grep "$msg$" .git/logs/HEAD
+'
+
+test_expect_success 'git branch -C master should work when master is checked out' '
+	git checkout master &&
+	git branch -C master
+'
+
+test_expect_success 'git branch -C master master should work when master is checked out' '
+	git checkout master &&
+	git branch -C master master
+'
+
+test_expect_success 'git branch -C master5 master5 should work when master is checked out' '
+	git checkout master &&
+	git branch master5 &&
+	git branch -C master5 master5
+'
+
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&

--
https://github.com/git/git/pull/363
