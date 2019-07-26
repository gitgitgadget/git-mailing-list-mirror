Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D30421F462
	for <e@80x24.org>; Fri, 26 Jul 2019 20:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfGZULY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 16:11:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61871 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfGZULX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 16:11:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9BF2A6B802;
        Fri, 26 Jul 2019 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fTZI3DiLp+v5JQSRliquwRyGos4=; b=fMk8hv
        6u2gCpB+wSrlQcVi7hDklpOfk2WJoNNaSuNmd+E6KG0s9baSCX6XpiXTDRwqEN5O
        IfOCBR9v1YqCjKAq6y7xGL+QMDRNZiXZqIrJ+IfXBO3TndeMK/6PDBddLd210D/R
        ZISjbSxYGV2alPbO1PriaOLAqNMbhr0WDebRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cras/YpcY8nE2343/hA3UOeDg/v3esW2
        OKLJJicJNXPn5EySxfGiPQpBUXHqfTRGPlBOS6KgqR3uhnTiIRGY9FRIeaJoyGL7
        va5my0xKfhH9YnHB5QzhLVgm0uqbJttZi1pW9egDEZX5A0oIPUx/BO3YCpPHx+cG
        QRy8bObIoig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 816376B801;
        Fri, 26 Jul 2019 16:11:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9F2196B800;
        Fri, 26 Jul 2019 16:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 07/20] Use write_index_as_tree() in lieu of write_tree_from_memory()
References: <20190725174611.14802-1-newren@gmail.com>
        <20190726155258.28561-1-newren@gmail.com>
        <20190726155258.28561-8-newren@gmail.com>
Date:   Fri, 26 Jul 2019 13:11:16 -0700
In-Reply-To: <20190726155258.28561-8-newren@gmail.com> (Elijah Newren's
        message of "Fri, 26 Jul 2019 08:52:45 -0700")
Message-ID: <xmqqy30kmu8r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 877641E4-AFE1-11E9-A9E5-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> diff --git a/cache-tree.c b/cache-tree.c
> index 706ffcf188..99144b1704 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -613,14 +613,19 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
>  	int entries, was_valid;
>  	struct lock_file lock_file = LOCK_INIT;
>  	int ret = 0;
> +	int access_disk = !(flags & WRITE_TREE_FROM_MEMORY);

Shouldn't we go one step futher and make the bulk of in-core index
processing into a new helper function, while making
write_index_as_tree() a thin-wrapper around it, i.e.

	write_index_as_tree() 
	{
		lock the index for update;
		read the on-disk index;
		call that new helper function to write a tree;
		update the on-disk index;
	}

and reuse the helper from
merge-recursive.c::write_tree_from_memory() while keeping the call
to the latter in merge_trees_internal()?  Wouldn't that approach
let you do this without adding an extra flag bit?

Also, there used to be a check to ensure that the in-core index fed
to write_tree_from_memory() is fully merged and otherwise dump the
unmerged entries with BUG().  Can we simply lose it?  I know you
return with "error building trees" from merge_trees_internal() but
it does not BUG().
