Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7402DC433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238750AbiCBAhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiCBAhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:37:08 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E50613F9B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:36:27 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id n12-20020a170902e54c00b0015011534fa3so110551plf.9
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xaw7KJcH0cTwWL1nQaT6K3mY6NobthsgtfljbPDtlEk=;
        b=I0ODrpSYE1JNhTqQBzzB59umYOhY/jJ8itmUXYSZTjGntVDkkHWhcSi+DAE+gdUjjj
         RaYwBeX6AP51SdsRjDzr2rH4EUIIL24JQmopn2eWkDA5h2+J1OEyFnDuavS5WTh19fUY
         PfweDSmzqbQ1LkvADhh7mkHB5quNtIEy5MNM42Bwo7GDiGZsC1ZqFwmxa3LwME8Bewmj
         b1S12X1ku+iFPTnazqiqpcM8TPCXKAXX8TaIZRqKzA127/qewWiLnRN10saidTP9+nuy
         Q8RHy0VIZWmAvcYUX+wMTYMY7c7YoGeXJN+1b6xmUmRQ57E77TMD4CfSW1IRcJR9sYUZ
         qbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xaw7KJcH0cTwWL1nQaT6K3mY6NobthsgtfljbPDtlEk=;
        b=WcaFSxWHNgX675J9cw5DMUnUx4x5gyMpLxCxLmar5+G1zYYR9HJgsFPEmftGLMJVqT
         K/OZTP6+pHO0FpS5bl2+8qu6S6e9Fsi6dHpFv9wgdDKr8c51KhPSRXNbWO+XTq+pb8YW
         O9ukmmh8v0JCQf7gQzEVi0rZ3W222/cUapwLsdNdvNsiLlyATpTq66IHzIs1+QJ3XGgf
         DQckz519p3lEPTnFWC/OSnq2S8RwT2dWoxruPYRpx+4BjAgkTBC6wM413f+W2lPAa9aX
         aTt1aDnprfsPdUWH2lgbqVHMqx5Dl7V+NJLkFTRR61nH5RiTJqLtn40ehzkdazAczbcG
         y2Jg==
X-Gm-Message-State: AOAM5329JTzWp6DlyHhDlVJeaTt1VoRXuvtb2iK+mIzQrwFlJflA3h9P
        eVoBPtJykMPJawDm52kW9l5szYcs8LmxLqbvdLPMX5jz2jDV9/JUwLq7qRqNEHb9j6k3upwhel2
        bVrBg029lOu6b3/n5W/nSlrk4SHbOAxE7BN+D33DvkOhOi6cIvCD3O/7RHXf88lU=
X-Google-Smtp-Source: ABdhPJw+kcMZ3EeWui0tke596GJVILXAgdr12oTz6mSrCe3oMy/zpf6SxdpI0+nvIlesGkgPVFtQmcaJ0YSs2w==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4385:b0:1bc:d480:91c5 with SMTP
 id r5-20020a17090a438500b001bcd48091c5mr24316111pjg.212.1646181386446; Tue,
 01 Mar 2022 16:36:26 -0800 (PST)
Date:   Tue,  1 Mar 2022 16:36:13 -0800
Message-Id: <20220302003613.15567-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] checkout, clone: die if tree cannot be parsed
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a tree oid is invalid, parse_tree_indirect() can return NULL. Check
for NULL instead of proceeding as though it were a valid pointer and
segfaulting.

Signed-off-by: Glen Choo <chooglen@google.com>
---
At $DAYJOB, this bug was discovered due to some interactions between
"git clone --filter=tree:0" and a buggy server that failed to transfer
certain commits.

In the 'checkout' step of "git clone --filter=tree:0", the repo tries to
get the HEAD commit from the server (since it's not present locally),
but this fails due to an unrelated bug in the server. Since the commit
tree is invalid, parse_tree_indirect() returns NULL, causing
parse_tree(NULL) to segfault.

I tried to write a test for this segfault, but I couldn't quite figure
out how:

- Invalid trees are typically caught pretty early, so I suspect that any
  reproduction scenario would need to replicate the partial clone +
  buggy server setup.
- I couldn't figure out how to replicate the aforementioned buggy setup

I'd appreciate any suggestions on how to test this though :)

Note that there are many other callsites that don't check for NULLs from
parse_tree_indirect(), and some of which are fairly subtle. I wasn't
confident in changing those, so I stayed on the conservative side and
only changed the ones that I could get to segfault.

 builtin/checkout.c | 13 ++++++++++---
 builtin/clone.c    |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index d9b31bbb6d..c1035304a5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -738,6 +738,7 @@
 		struct tree_desc trees[2];
 		struct tree *tree;
 		struct unpack_trees_options topts;
+		const struct object_id *old_commit_oid;
 
 		memset(&topts, 0, sizeof(topts));
 		topts.head_idx = -1;
@@ -765,9 +766,15 @@
 				       &new_branch_info->commit->object.oid :
 				       &new_branch_info->oid, NULL);
 		topts.preserve_ignored = !opts->overwrite_ignore;
-		tree = parse_tree_indirect(old_branch_info->commit ?
-					   &old_branch_info->commit->object.oid :
-					   the_hash_algo->empty_tree);
+
+		old_commit_oid = old_branch_info->commit ?
+			&old_branch_info->commit->object.oid :
+			the_hash_algo->empty_tree;
+		tree = parse_tree_indirect(old_commit_oid);
+		if (!tree)
+			die(_("unable to parse commit %s"),
+				oid_to_hex(old_commit_oid));
+
 		init_tree_desc(&trees[0], tree->buffer, tree->size);
 		parse_tree(new_tree);
 		tree = new_tree;
diff --git a/builtin/clone.c b/builtin/clone.c
index a572cda503..0aea177660 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -700,6 +700,8 @@
 	init_checkout_metadata(&opts.meta, head, &oid, NULL);
 
 	tree = parse_tree_indirect(&oid);
+	if (!tree)
+		die(_("unable to parse commit %s"), oid_to_hex(&oid));
 	parse_tree(tree);
 	init_tree_desc(&t, tree->buffer, tree->size);
 	if (unpack_trees(1, &t, &opts) < 0)

base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
-- 
2.33.GIT

