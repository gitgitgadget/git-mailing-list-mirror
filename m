Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513B2C433FE
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 13:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJQN0p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 09:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiJQN0l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 09:26:41 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627111ADB6
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 06:26:40 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3616015B75F;
        Mon, 17 Oct 2022 09:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=RcDRm1iPZnVBLxcnAgWUDEcb8Q33xGr03qdiKRiKLXE=; b=wvbu
        j09WkEAztWYiHxaCGpqFUDL+QsWa9wx3wDf62fhDbVN1BOvvsqt3khfvY48L8W85
        0WNbzO9QlSdqsWi32vmGcKB93CIiM+0D/rzKDBE8aYPLPWtBOQnV4dZCWUh/lhyE
        oFBrdDyoqXWskdc8ynCqrZSF7fENiP28yS02vhI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C09415B75E;
        Mon, 17 Oct 2022 09:26:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 835DE15B75D;
        Mon, 17 Oct 2022 09:26:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Subject: Re: [PATCH v3 1/9] tree: do not use the_repository for tree
 traversal methods.
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
        <79959a54eb4c1a0812b1f4643530069a63e549f4.1665973401.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 06:26:37 -0700
Message-ID: <xmqq4jw237jm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 546A1AFC-4E1F-11ED-9967-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Alphadelta14 via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Alphadelta14 <alpha@alphaservcomputing.solutions>

I'll fix this line to match all the other patches in the series
before applying.

> Expect that tree walking may switch repository contexts for cases
> such as submodules.
> Added compatibility macros for existing cases.
>
> Annotate an existing issue where repo is wrong when traversing.
>
> Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
> ---


> @@ -58,7 +58,11 @@ int read_tree_at(struct repository *r,
>  				    oid_to_hex(&entry.oid),
>  				    base->buf, entry.path);
>  
> -			if (parse_commit(commit))
> +			// FIXME: This is the wrong repo instance (it refers to the superproject)
> +			// it will always fail as is (will fix in later patch)
> +			// This current codepath isn't executed by any existing callbacks
> +			// so it wouldn't show up as an issue at this time.

	/*
	 * We write our multi-line comments
	 * this way.
	 */

My suspicion is that the if/else if/ cascade for GITLINK assumes
that the caller earlier did add_submodule_odb() to make sure any
object it needs should be available via the_repository->objects
object store.  If your caller (presumably "archive that is trying to
learn the --recurse-submodules option") hasn't learned to do so yet
at this step, it is understandable if it fails.

> +			if (repo_parse_commit(r, commit))
>  				die("Invalid commit %s in submodule path %s%s",
>  				    oid_to_hex(&entry.oid),
>  				    base->buf, entry.path);

> +#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
> +#define parse_tree(tree) repo_parse_tree(the_repository, tree)
> +#define parse_tree_gently(tree, quiet_on_missing) repo_parse_tree_gently(the_repository, tree, quiet_on_missing)
> +#define parse_tree_indirect(oid) repo_parse_tree_indirect(the_repository, oid)
> +#endif

Good.
