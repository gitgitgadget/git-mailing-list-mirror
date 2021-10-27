Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1800C433EF
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA34660F02
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 21:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhJ0Vel (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 17:34:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57087 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbhJ0Vea (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 17:34:30 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9DF5F12A3;
        Wed, 27 Oct 2021 17:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yedYOuO5Lgcax08mlS6EwRwCBpq4x2ff0Fszy5
        zEet0=; b=O0ID7gXdy4E7DlCsGIft4PCiN09A8VPsE0aFBoM4tcA8l6pGy7VZ7D
        /XhWI027gN/7bkXUjhrOfOR1vkzzIz7cDNnObCUsOtcD9+29b9XTiTEUPPDCAeEL
        1K4NJ+sFYMtxuzTnAwpmVAZ8+798R+W9M/bNg28ZDEk96yS4aHnrg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE823F12A2;
        Wed, 27 Oct 2021 17:32:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E6CACF12A1;
        Wed, 27 Oct 2021 17:32:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/3] sparse-index: add ensure_correct_sparsity function
References: <pull.1059.v2.git.1634849307.gitgitgadget@gmail.com>
        <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
        <9d6511db0728e9880a96f3d9e3a025a9ddc5bc9e.1635358812.git.gitgitgadget@gmail.com>
        <bf73e2d2-a2ab-8364-d505-1bd5bba3efd2@gmail.com>
Date:   Wed, 27 Oct 2021 14:32:02 -0700
In-Reply-To: <bf73e2d2-a2ab-8364-d505-1bd5bba3efd2@gmail.com> (Derrick
        Stolee's message of "Wed, 27 Oct 2021 16:07:11 -0400")
Message-ID: <xmqqbl3aupbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 53DD83E0-376D-11EC-AD50-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> +int convert_to_sparse(struct index_state *istate, int flags)
>> +{
>> +	/*
>> +	 * If the index is already sparse, empty, or otherwise
>> +	 * cannot be converted to sparse, do not convert.
>> +	 */
>> +	if (istate->sparse_index || !istate->cache_nr ||
>> +	    !is_sparse_index_allowed(istate, flags))
>> +		return 0;

Shouldn't we also at least do this?  Blindly blowing away the entire
cache-tree and rebuilding it from scratch may be hiding a latent bug
somewhere else, but is never supposed to be needed, and is a huge
waste of computational resources.

I say "at least" here, because a cache tree that is partially valid
should be safely salvageable---at least that was the intention back
when I designed the subsystem.

 sparse-index.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git c/sparse-index.c w/sparse-index.c
index bc3ee358c6..a95c3386f3 100644
--- c/sparse-index.c
+++ w/sparse-index.c
@@ -188,17 +188,19 @@ int convert_to_sparse(struct index_state *istate, int flags)
 	if (index_has_unmerged_entries(istate))
 		return 0;
 
-	/* Clear and recompute the cache-tree */
-	cache_tree_free(&istate->cache_tree);
-	/*
-	 * Silently return if there is a problem with the cache tree update,
-	 * which might just be due to a conflict state in some entry.
-	 *
-	 * This might create new tree objects, so be sure to use
-	 * WRITE_TREE_MISSING_OK.
-	 */
-	if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
-		return 0;
+	if (!cache_tree_fully_valid(&istate->cache_tree)) {
+		/* Clear and recompute the cache-tree */
+		cache_tree_free(&istate->cache_tree);
+		/*
+		 * Silently return if there is a problem with the cache tree update,
+		 * which might just be due to a conflict state in some entry.
+		 *
+		 * This might create new tree objects, so be sure to use
+		 * WRITE_TREE_MISSING_OK.
+		 */
+		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
+			return 0;
+	}
 
 	remove_fsmonitor(istate);
 
