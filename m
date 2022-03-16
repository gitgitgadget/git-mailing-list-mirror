Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175EBC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 17:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354555AbiCPR1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 13:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357402AbiCPR1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 13:27:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385939FE5
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 10:26:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2549A126F69;
        Wed, 16 Mar 2022 13:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZM/cHTZK4Hgkte7NhM+mT55oBrXP+BPdtetgFT
        ftE7I=; b=B4KIlCipmxUNIiJ5u/m4yNyKPj/ioA0ty2qYWJB1iqTrqI8D3B4gkX
        Vjx6jwoZcItZFQgKF4NhpFiPNdrfx7YUiX7iQMQrwUzDUMSwZzBxVX6A0szVxc1c
        Z8iAVbqimjMIR/wKy5XZCIdEcthxW8gXUOHXqfGYk5f4bGiJvaP0g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DC2D126F68;
        Wed, 16 Mar 2022 13:26:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7B7B3126F67;
        Wed, 16 Mar 2022 13:26:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 5/6] builtin/stash: provide a way to import stashes from
 a ref
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-6-sandals@crustytoothpaste.net>
Date:   Wed, 16 Mar 2022 10:26:28 -0700
In-Reply-To: <20220310173236.4165310-6-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:35 +0000")
Message-ID: <xmqqa6dpn70b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3749B722-A54E-11EC-AB7B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> @@ -104,6 +109,7 @@ static struct strbuf stash_index_path = STRBUF_INIT;
>   * b_commit is set to the base commit
>   * i_commit is set to the commit containing the index tree
>   * u_commit is set to the commit containing the untracked files tree
> + * c_commit is set to the first parent (chain commit) when importing and is otherwise unset
>   * w_tree is set to the working tree
>   * b_tree is set to the base tree
>   * i_tree is set to the index tree
> @@ -114,6 +120,7 @@ struct stash_info {
>  	struct object_id b_commit;
>  	struct object_id i_commit;
>  	struct object_id u_commit;
> +	struct object_id c_commit;
>  	struct object_id w_tree;
>  	struct object_id b_tree;
>  	struct object_id i_tree;

With the redesign that an exported chain is a series of two-parent
merges, where the first parent is used to string them together in a
single strand of pearls and the second parent is the stash entry,
the above change becomes totally unnecessary, right?  The import
side will be doing a first-parent walk of the export, pushing the
second parent into reflog of refs/stash---we may want sanity check
these second parents with assert_stash_like(), but there is no need
to re-synthesize the stash entries anymore, which would simplify the
implementation quite a bit, right?
		
Namely:

> +static int do_import_stash(const char *rev)
> +{
> +	struct object_id oid;
> +	size_t nitems = 0, nalloc = 0;
> +	struct stash_info *items = NULL;
> +	int res = 0;
> +
> +	if (get_oid(rev, &oid))
> +		return error(_("not a valid revision: %s"), rev);
> +
> +	/*
> +	 * Walk the commit history, finding each stash entry, and load data into
> +	 * the array.
> +	 */
> +	for (size_t i = 0;; i++, nitems++) {
> +		int ret;
> +
> +		if (nalloc <= i) {
> +			size_t new = nalloc * 3 / 2 + 5;
> +			items = xrealloc(items, new * sizeof(*items));
> +			nalloc = new;
> +		}
> +		memset(&items[i], 0, sizeof(*items));
> +		/* We want this to be quiet because it might not exist. */
> +		ret = get_stash_info_for_import(&items[i], &oid);

The new helper function is not necessary; we can use vanilla
get_stash_info() on the second parent to get the same information,
and we do not really need to keep it in core.  We can sanity check
the shape of the imported stash entry right away and discard
everything except for the commit object name.

> +	/*
> +	 * Now, walk each entry, adding it to the stash as a normal stash
> +	 * commit.
> +	 */
> +	for (ssize_t i = nitems - 1; i >= 0; i--) {
> +		struct commit_list *parents = NULL;
> +		struct commit_list **next = &parents;
> +		struct object_id out;
> +		char *msg;
> +
> +		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].b_commit), next);
> +		next = commit_list_append(lookup_commit_reference(the_repository, &items[i].i_commit), next);
> +		if (items[i].has_u)
> +			next = commit_list_append(lookup_commit_reference(the_repository,
> +								   &items[i].u_commit),
> +						  next);
> +
> +		msg = write_commit_with_parents(&out, &items[i], parents);

And this part becomes completely unnecessary if we reuse what the
origin repository already had, which directly can be ...

> +		if (!msg) {
> +			res = -1;
> +			goto out;
> +		}
> +		if (do_store_stash(&out, msg, 1)) {

... fed to this call.

