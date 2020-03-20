Return-Path: <SRS0=v+yc=5F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0147BC4332B
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58AC20714
	for <git@archiver.kernel.org>; Fri, 20 Mar 2020 21:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="km1i/spY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCTVjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:39:25 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58270 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgCTVjZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 20 Mar 2020 17:39:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id AD0B960478;
        Fri, 20 Mar 2020 21:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1584740365;
        bh=iJVQosoz0Pk/Cd/NkSf4zpyDgkMM70G+7JVR1T3XdT4=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=km1i/spYE6/c/oyIyzWWW5EGW4uFMC9JUJO90GkQBo14akAyGjSrcvtHbn4Gtpuz1
         JwSKfK0/ee4FLCfAvH0JNj9urSKFitC7+xRltY9Ht4OzJOvdWn0MM2dDWdB6D+hTpl
         4llk5/qtGJHsAOMb0R9r9kUECp1cc2UYuoivAa4aoniF/ockgpXaebk6tARdgAR2iG
         hH0I+WkNpc34oBmipS3P4MJO7oGcEmNdxxeyoTgacDqqh02UJ4cPs+dc9ogksav9mP
         54wntGL98OFlU5M2sN1XsQQP2gGv3D5+A0XBl8obpTHBxqatWDOv4GUjoKvSwpyiAn
         1rcplICYGwbrxAOkuMh4z9JCKc3kfidxOOAzoIF3bUPu6R+5XrdEU8pLpj25RydSSB
         sxuAjNsUn3gyAAD8WjMXD7qYWM7/UZIPAthTFgDQQUpXr09DU9VOTl9c5+USrVeOiS
         nSZQuF5hIrsBHu+2hicXEqvdcX+t4UM+HFIh4bgIN2uTaiBYwpf
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] t3419: prevent failure when run with EXPENSIVE
Date:   Fri, 20 Mar 2020 21:39:16 +0000
Message-Id: <20200320213916.604658-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.26.0.rc2.221.ge327a58236c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test runs a function which itself runs several assertions.  The
last of these assertions cleans up the .git/rebase-apply directory,
since when run with EXPENSIVE set, the function is invoked a second time
to run the same tests with a larger data set.

However, as of 2ac0d6273f ("rebase: change the default backend from "am"
to "merge"", 2020-02-15), the default backend of rebase has changed, and
cleaning up the rebase-apply directory has no effect: it no longer
exists, since we're using rebase-merge instead.

Since we don't really care which rebase backend is in use, let's just
clean up both, which means we'll do the right thing in every case.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
I noticed this when I was working on another series and running the
testsuite with GIT_TEST_LONG=1.  We'll probably want to add this before
the release if possible.

It may also be desirable to have at least once CI run that runs this
way.  In my experience, it does not take substantially longer to run the
testsuite on a modern Linux system with this option enabled.

 t/t3419-rebase-patch-id.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index 94552669ae..824d84f9ce 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -91,7 +91,7 @@ do_tests () {
 		git commit -q -m squashed &&
 		git checkout -q other^{} &&
 		test_must_fail git rebase squashed &&
-		rm -rf .git/rebase-apply
+		rm -rf .git/rebase-merge .git/rebase-apply
 	'
 }
 
