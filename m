Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73BC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC23720829
	for <git@archiver.kernel.org>; Wed, 20 May 2020 01:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="IjgukdgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgETBmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 21:42:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:38526 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbgETBmM (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 19 May 2020 21:42:12 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DFF0E60482;
        Wed, 20 May 2020 01:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1589938931;
        bh=Q/hLJZpkU/AbsSAm2uB44YQ+HBLHT72nMF3dsfb8ZO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=IjgukdgAHmiMK3YGkvrI7YGtpK2uC8sqQn31KTMyzQbiKu7KbSOIu6RPsE9Ub2SeV
         FKsElPZVfJh31nNZf3EYSQyUSrsEuH7RnKrqpmZMIigFvmiUdH2NgzVTBxVofaKTp1
         z3Gte1q3/41UpYimho6ccL2ezkrubIJChlU2DsDSwttl06XAwrwnYXMFH15l4TsAIa
         Xl/QnlQBw4+S5wavBozmk5RFMZUwGB0C6VriX/bjZ9sLrPlrQ/NU5nWmFIrW7Ak0rf
         5rNylvvfFrsmq3pRrPtSeEMXCEFAoZWmqnh4R3jD+JBBlrl3XGa2R2t97XgrNwp4lp
         ZmkukCTAeiC8TFAsJEfchc/7ngKq/xEZ7uDxRdqcn/3AiwvIAsIrLvPMiZq3BxlOeI
         UBY975Qlwvq/itWPw1OEqlLyDmhOiEVo44jff0GOogSL+LQwCB+qc2AgMv6Ju2Dfu3
         A436XZFTJ/7JpaUNsEznlFBDhWRbDJsHinBbYfOiylvSwQ7J8UY
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/1] builtin/checkout: simplify metadata initialization
Date:   Wed, 20 May 2020 01:41:56 +0000
Message-Id: <20200520014156.1570124-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652
In-Reply-To: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
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
here, since reset_tree is called only (indirectly) via switch_branches,
which requires that we have a valid commit.  switch_branches dies if we
lack a name and cannot produce a commit from HEAD, and its caller dies
if we do have a branch name but still lack a commit pointer.

Since we know we must always have a valid commit structure in this case,
let's remove the dead code paths and just refer to the commit structure.
This simplifies the code and makes it easier for the reader.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/checkout.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index e9d111bb83..e53bdab5b8 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -620,11 +620,7 @@ static int reset_tree(struct tree *tree, const struct checkout_opts *o,
 	opts.verbose_update = o->show_progress;
 	opts.src_index = &the_index;
 	opts.dst_index = &the_index;
-	init_checkout_metadata(&opts.meta, info->refname,
-			       info->commit ? &info->commit->object.oid :
-			       is_null_oid(&info->oid) ? &tree->object.oid :
-			       &info->oid,
-			       NULL);
+	init_checkout_metadata(&opts.meta, info->refname, &info->commit->object.oid, NULL);
 	parse_tree(tree);
 	init_tree_desc(&tree_desc, tree->buffer, tree->size);
 	switch (unpack_trees(1, &tree_desc, &opts)) {
