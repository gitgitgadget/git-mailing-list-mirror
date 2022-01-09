Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289B0C433EF
	for <git@archiver.kernel.org>; Sun,  9 Jan 2022 04:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbiAIE5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 23:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbiAIE5q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 23:57:46 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A678C061401
        for <git@vger.kernel.org>; Sat,  8 Jan 2022 20:57:46 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id c10so8998878qte.2
        for <git@vger.kernel.org>; Sat, 08 Jan 2022 20:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zh8OKF3j1q5SUGO2iJV4T9e0WGhpsyWIeWP6j2YVq+c=;
        b=SNMnM+XQfyi/7yzE4TAl+VuISUqNeKTnFQY3cnRnnulFW3FeZoONuRNnd8BaDfE/eY
         RmbnzTw9cR76W9N68CLr2CTAPdTSDXAawblTwu8AfATvDFpS1uotTnkZS9D4flT6MLyr
         zQTrnW3y01y9E68L/ObmzFmN0JzT2+A5BAOHU0Flda8TveBzRuAKKTloBsLda1sgcYvE
         yNjbcquJm1og7wyeQfe8bCb8veETgV/vlJECdIkE2jNiFS8zVohPjuTg0pHhoCpcJAsy
         0SKxhCcPSIFHE1UtKFgMZtMSSw2loGtOVb0v9Zho3NUIAM7xebseOdL5PtZc/V6aAWWO
         SyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zh8OKF3j1q5SUGO2iJV4T9e0WGhpsyWIeWP6j2YVq+c=;
        b=6vsoqIZ3MVF2OnpYGkTOJAnFXbb6LaUv+CHWR3VXF5Iy596GNMVjDChChv1uxRZKrD
         QRI84plCEByK9hQTuKiruqwz9ODG95XUt+HC8YKlCfajuLW6kusqubuWOHjMi3te2Pc0
         ogddhP2irqSTiIL+AFDNePdhOuzFh7e+ONDYXsn35kqa3rHL4FKpiQ9j+yeOeOvoAqXC
         kpHnRxdnxKr2L8Mh3bCviE1Ad2SJBuna2Tux3JxFdbWhQWyVuJN57IlVYzAxzAvJhs4f
         mh7NRpY0nf5TaOi6fx8Ynmdz6QDyCiQVTAwDVPoRfRwJoCUGEjWOi6jYrC5o97Gfieyu
         EJXw==
X-Gm-Message-State: AOAM533E0+xAZHevJSMK8176J4JO0v4czol2G52RpSGnslzIXP33Z5LZ
        fIq555N4WB95cgTOQxSN4ISLNcNqWZVAng==
X-Google-Smtp-Source: ABdhPJw2ss8wXNSPCBOlu2WQ0tajrWhFB/PFrooPXFjAUvLD1ieX5dTnefc6l9+PZ6yfNTZcaFcQqg==
X-Received: by 2002:a05:622a:1818:: with SMTP id t24mr60527582qtc.169.1641704265281;
        Sat, 08 Jan 2022 20:57:45 -0800 (PST)
Received: from iron-rod.attlocal.net ([2600:1700:bae0:2de0::1b])
        by smtp.gmail.com with ESMTPSA id t5sm2118915qtp.60.2022.01.08.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 20:57:44 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/5] unpack-trees: fix accidental loss of user changes
Date:   Sat,  8 Jan 2022 20:57:29 -0800
Message-Id: <20220109045732.2497526-3-newren@gmail.com>
X-Mailer: git-send-email 2.34.1.442.ge63c19bdd2.dirty
In-Reply-To: <20220109045732.2497526-1-newren@gmail.com>
References: <20220109045732.2497526-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For sparse-checkouts, we don't want unpack-trees to error out on files
that are missing from the worktree, so there has traditionally been
logic to make it skip the verify_uptodate() check for these.
Unfortunately, it was skipping the verify_uptodate() check for files
that were expected to *become* SKIP_WORKTREE.  For files that were not
already SKIP_WORKTREE, that can cause us to later delete the file in
apply_sparse_checkout().  Only skip the check for files that were
already SKIP_WORKTREE as well to avoid lightly discarding important
changes users may have made to files.

Note 1: unpack-trees.c is already a bit complex, and the logic around
CE_SKIP_WORKTREE and CE_NEW_SKIP_WORKTREE in that file are no exception.
I also tried just replacing CE_NEW_SKIP_WORKTREE with CE_SKIP_WORKTREE
in the verify_uptodate() check instead of checking for both flags, and
found that it also fixed this bug and passed all the tests.  I also
attempted to devise a few testcases that might trip either variant of my
fix and was unable to find any problems.  It may be that just checking
CE_SKIP_WORKTREE is a better fix, but I'm not sure.  I thought it
was a bit safer to strictly reduce the number of cases where we skip the
up-to-date check rather than just toggling which kind of cases skip it,
and thus went with the current variant of the fix.

Note 2: I also wondered if verify_absent() might have a similar bug, but
despite my attempts to try to devise a testcase that would trigger such
a thing, I couldn't find any problematic testcases.  Thus, this patch
makes no attempt to apply similar changes to verify_absent() and
verify_absent_if_directory().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1011-read-tree-sparse-checkout.sh | 2 +-
 unpack-trees.c                       | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
index 1b2395b8a8..4ed0885bf2 100755
--- a/t/t1011-read-tree-sparse-checkout.sh
+++ b/t/t1011-read-tree-sparse-checkout.sh
@@ -197,7 +197,7 @@ test_expect_success 'read-tree will not throw away dirty changes, non-sparse' '
 	grep -q dirty init.t
 '
 
-test_expect_failure 'read-tree will not throw away dirty changes, sparse' '
+test_expect_success 'read-tree will not throw away dirty changes, sparse' '
 	echo "/*" >.git/info/sparse-checkout &&
 	read_tree_u_must_succeed -m -u HEAD &&
 
diff --git a/unpack-trees.c b/unpack-trees.c
index 98e2f2e0e6..6d9d89c662 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -2059,7 +2059,9 @@ static int verify_uptodate_1(const struct cache_entry *ce,
 int verify_uptodate(const struct cache_entry *ce,
 		    struct unpack_trees_options *o)
 {
-	if (!o->skip_sparse_checkout && (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
+	if (!o->skip_sparse_checkout &&
+	    (ce->ce_flags & CE_SKIP_WORKTREE) &&
+	    (ce->ce_flags & CE_NEW_SKIP_WORKTREE))
 		return 0;
 	return verify_uptodate_1(ce, o, ERROR_NOT_UPTODATE_FILE);
 }
-- 
2.34.1.442.ge63c19bdd2.dirty

