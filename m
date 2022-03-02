Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6879BC433F5
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 07:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239788AbiCBH1e (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 02:27:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiCBH1d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 02:27:33 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617FDB12CD
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 23:26:51 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF2D617AE0A;
        Wed,  2 Mar 2022 02:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=357H2frWFmC3uJ+SbexzIKhW9vbOk9OQjUGPuT
        JEpF8=; b=dJG8sO1SUf+MkIYH5oAc7Nr2vauvrfYhbGowcSz4Qd1g6os68tGABM
        qIYWEwpY3pWbrKk26peEVsYYpNFokG9Wy2AvzM/J6GRGoGHr5ScEzRYM81jE0uzK
        GJ6aqL6OFL5XM7Y2CRL5gOb6mkxmlUhiIKrsv+DMH42NPI3jtnuGg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CCC3217AE08;
        Wed,  2 Mar 2022 02:26:50 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3ADA217AE07;
        Wed,  2 Mar 2022 02:26:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout, clone: die if tree cannot be parsed
References: <20220302003613.15567-1-chooglen@google.com>
Date:   Tue, 01 Mar 2022 23:26:47 -0800
In-Reply-To: <20220302003613.15567-1-chooglen@google.com> (Glen Choo's message
        of "Tue, 1 Mar 2022 16:36:13 -0800")
Message-ID: <xmqq5yowolvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1EFF3020-99FA-11EC-B4CA-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Note that there are many other callsites that don't check for NULLs from
> parse_tree_indirect(), and some of which are fairly subtle. I wasn't
> confident in changing those, so I stayed on the conservative side and
> only changed the ones that I could get to segfault.

Thanks.

> -		tree = parse_tree_indirect(old_branch_info->commit ?
> -					   &old_branch_info->commit->object.oid :
> -					   the_hash_algo->empty_tree);
> +
> +		old_commit_oid = old_branch_info->commit ?
> +			&old_branch_info->commit->object.oid :
> +			the_hash_algo->empty_tree;

I guess this is done only so that you can use the object name in the
error message, which is fine.

> +		tree = parse_tree_indirect(old_commit_oid);
> +		if (!tree)
> +			die(_("unable to parse commit %s"),
> +				oid_to_hex(old_commit_oid));

"unable to parse commit" is a bit of a white lie.  In fact, there is
nothing that makes oid_commit_oid the name of a commit object.

"unable to parse object '%s' as a tree" would be more technically
correct, but one random-looking hexadecimal string is almost
indistinguishable from another, and neither would be a very useful
message from the end user's point of view.  I am wondering if we can
use old_branch_info to formulate something easier to understand for
the user.  update_refs_for_switch() seems to compute old_desc as a
human readable name by using old_branch_info->name if available
before falling back to old_branch_info->commit object name, which
might be a source of inspiration.

>  		init_tree_desc(&trees[0], tree->buffer, tree->size);
>  		parse_tree(new_tree);
>  		tree = new_tree;
> diff --git a/builtin/clone.c b/builtin/clone.c
> index a572cda503..0aea177660 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -700,6 +700,8 @@
>  	init_checkout_metadata(&opts.meta, head, &oid, NULL);
>  
>  	tree = parse_tree_indirect(&oid);
> +	if (!tree)
> +		die(_("unable to parse commit %s"), oid_to_hex(&oid));

If we follow the code path, we can positively tell that oid here has
always came from reading HEAD, so "unable to parse HEAD as a tree"
would be an easier version of the message, I think.

Thanks.
