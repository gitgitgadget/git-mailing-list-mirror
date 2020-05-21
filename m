Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC07CC433DF
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86840206D4
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Blc92jBw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgEUCHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:07:22 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38556 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726833AbgEUCHW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 20 May 2020 22:07:22 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C40246081B;
        Thu, 21 May 2020 02:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1590026841;
        bh=nSDUaYwrMMHEbBF0915b/1t08h+0F3t/x6pYDp6uphQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=Blc92jBwsoYGMU4KfVnKVWdpRoYvylbt4MuM2RDA2sy7SSj1LnYI/01bVhX4iECUq
         lDASBiERuK+v+EUFnKXijp3Pwp/0nRzTFdANrHnKntRyVpqu/enoWrnvjj1OG6XFQa
         eH9sXsiSIVoroyHLID1ZtsuwpA9TuH+cmqn815P0LZmO5x20SuFpwhM3EzX3fJMFGW
         8XLovFj2i14/Y/JarSEm9wcriRwl8qkDF6FsiqU5Vk+JgVd2xpZBA7srLmYklIijei
         Oh0SvrhFwmQFp4jViglAP1luzS8UnWJIKl6lLPIj/7v+Zr8LPCCrx4ugIVmWxH0sNw
         B9c/F2Lq6u/3V5IG9FYJzaYSeoexXn4ywQpkHtXnNehE5WqeIqXKMb4fFXiF/qNYHA
         BhA7NGrlnkNRy8K5LgkzM4Cga1JRDtJrbE7NkgB2RsPs7cfPimZWshhoo3+ye90BIN
         tbPtzXH2VQkLij3DDACme4wFiRWu9AwML8vKPCdg/AwXgWLW9nB
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/2] builtin/checkout: simplify metadata initialization
Date:   Thu, 21 May 2020 02:07:11 +0000
Message-Id: <20200521020712.1620993-2-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <20200521020712.1620993-1-sandals@crustytoothpaste.net>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200521020712.1620993-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we call init_checkout_metadata in reset_tree, we want to pass the
object ID of the commit in question so that it can be passed to filters,
or if there is no commit, the tree.  We anticipated this latter case,
which can occur elsewhere in the checkout code, but it cannot occur
here.  The only case in which we do not have a commit object is when
invoking git switch with --orphan.  Moreover, we can only hit this code
path without a commit object additionally with either --force or
--discard-changes.

In such a case, there is no point initializing the checkout metadata
with a commit or tree because (a) there is no commit, only the empty
tree, and (b) we will never use the data, since no files will be smudged
when checking out a branch with no files.  Pass the all-zeros object ID
in this case, since we just need some value which is a valid pointer.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e9d111bb83..62b5e371bc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -621,9 +621,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
 	init_checkout_metadata(&opts.meta, info->refname,
-			       info->commit ? &info->commit->object.oid :
-			       is_null_oid(&info->oid) ? &tree->object.oid :
-			       &info->oid,
+			       info->commit ? &info->commit->object.oid : &null_oid,
 			       NULL);
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
