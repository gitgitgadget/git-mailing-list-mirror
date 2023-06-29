Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3A6EB64D9
	for <git@archiver.kernel.org>; Thu, 29 Jun 2023 19:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjF2TGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jun 2023 15:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjF2TE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2023 15:04:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FA422C
        for <git@vger.kernel.org>; Thu, 29 Jun 2023 12:02:12 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D01E1988FA;
        Thu, 29 Jun 2023 15:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aJCzIeKcyr2u5YlCV26HBD+eSW+2YSxxpDLlt0
        BfziU=; b=DtjgtyiiFBWBzj47UYh2TIEf7yal1GokcQF2VcFk5IehXuxvBIaM3V
        XSpTHbGn4ryrCt7UQi/5pL47auYbQDTc3BTSyanDhqqHvezKNrIF9rFpYa3HJ/75
        90janRcyHDrqVjOCIqtv0kPK6zeWQAj4tZi07SGYWV/2Qq2lB7N7o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D3911988F8;
        Thu, 29 Jun 2023 15:02:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 333AA1988F5;
        Thu, 29 Jun 2023 15:02:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/3] split-index: accept that a base index can be empty
References: <pull.1554.git.1688044991.gitgitgadget@gmail.com>
        <81118ce106222993ef17586fb0f249d8319f3b90.1688044991.git.gitgitgadget@gmail.com>
Date:   Thu, 29 Jun 2023 12:02:09 -0700
In-Reply-To: <81118ce106222993ef17586fb0f249d8319f3b90.1688044991.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 29 Jun 2023
        13:23:09 +0000")
Message-ID: <xmqqcz1e9jny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73297B0A-16AF-11EE-958A-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> We are about to fix an ancient bug where `do_read_index()` pretended
> that the index was not initialized when there are no index entries.
>
> Before the `index_state` structure gained the `initialized` flag in
> 913e0e99b6a (unpack_trees(): protect the handcrafted in-core index from
> read_cache(), 2008-08-23), that was the best we could do (even if it was
> incorrect: it is totally possible to read a Git index file that contains
> no index entries).

Yeah, I very much remember how that single bit made our live much
easier.

> This pattern was repeated also in 998330ac2e7 (read-cache: look for
> shared index files next to the index, too, 2021-08-26), which we fix
> here by _not_ mistaking an empty base index for a missing
> `sharedindex.*` file.

Ahh, this is in the codepath to deal with a separate worktree.  We
allow sharing of the "sharedindex.*" file across worktrees and
entries read from the "index" files from individual worktrees to
overlay it.  But we also do allow worktrees to have their own
"sharedindex.*" file, which is what the commit in question wanted to
do, and the way it (wanted to) implement was

 - check the "gitdir" version first, as before
 - if that did not exist, then look at the one next to "index"

but "if that did not exist" was implemented incorrectly and did not
account for the case where that "gitdir" version was an empty index.

So, instead, updated code checks and reads the "gitdir" version *if*
the file exists, regardless of how many entries there are in it.

Makes sense.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  read-cache.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index b10caa9831c..e15a472f54f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2455,12 +2455,14 @@ int read_index_from(struct index_state *istate, const char *path,
>  
>  	base_oid_hex = oid_to_hex(&split_index->base_oid);
>  	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
> -	trace2_region_enter_printf("index", "shared/do_read_index",
> -				   the_repository, "%s", base_path);
> -	ret = do_read_index(split_index->base, base_path, 0);
> -	trace2_region_leave_printf("index", "shared/do_read_index",
> -				   the_repository, "%s", base_path);
> -	if (!ret) {
> +	if (file_exists(base_path)) {
> +		trace2_region_enter_printf("index", "shared/do_read_index",
> +					the_repository, "%s", base_path);
> +
> +		ret = do_read_index(split_index->base, base_path, 0);
> +		trace2_region_leave_printf("index", "shared/do_read_index",
> +					the_repository, "%s", base_path);
> +	} else {
>  		char *path_copy = xstrdup(path);
>  		char *base_path2 = xstrfmt("%s/sharedindex.%s",
>  					   dirname(path_copy), base_oid_hex);
