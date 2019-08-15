Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 828CF1F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfHOTGw (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 15:06:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52828 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbfHOTGw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 15:06:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 29E9316E652;
        Thu, 15 Aug 2019 15:06:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L/Iy+7YgN1orjVct+13RVIgtn1o=; b=p2ltxX
        Ui0DJc8Ur78wc/20eJRBP43XaJ7Nqz1uGeYHZT3iM66Vk/gk05owhQUtZDCTh/0z
        1ZrysW0Eyz4Rfqa/3c0ieghkz5H8N+ekJE8ZwX+PMHpJJsFxnbC0qjvRtGEg3jzu
        IXE8aPj66bvlT+TGAOIh/oirM/8rcr86dmFBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TsQBN5dbJW7tVU5RokYdo+gaL6W2m4dS
        OZEObv429ni3Ly4g9q2kXbdOo0rx7c7BwCbwaJrnnXcH8PB8X3pzQR4DgWej8Bto
        ntV10ZF6Dfn9Yx4E41wfGgAd1ffE7VmUSeJvlsoruCetdodkFSoFsEVsur0pOp4v
        7+HRZDwQzXg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FF3216E651;
        Thu, 15 Aug 2019 15:06:50 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89BB916E650;
        Thu, 15 Aug 2019 15:06:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH v3] diff-lib.c: handle empty deleted ita files
References: <20190712150235.12633-1-vcnaik94@gmail.com>
        <20190801161558.12838-1-vcnaik94@gmail.com>
Date:   Thu, 15 Aug 2019 12:06:48 -0700
In-Reply-To: <20190801161558.12838-1-vcnaik94@gmail.com> (Varun Naik's message
        of "Thu, 1 Aug 2019 09:15:58 -0700")
Message-ID: <xmqqv9uy2qpj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5915C2A-BF8F-11E9-95E3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Varun Naik <vcnaik94@gmail.com> writes:

> diff --git a/diff-lib.c b/diff-lib.c
> index 61812f48c2..29dba467d5 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -433,8 +433,11 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  
>  	/*
>  	 * Something removed from the tree?
> +	 * Consider a file deleted from the index and added as ita to be "deleted",
> +	 * even though it should arguably be "modified", because we want empty
> +	 * deleted ita files to appear in the diff.
>  	 */
> -	if (!idx) {
> +	if (!idx || (cached && ce_intent_to_add(idx))) {
>  		diff_index_show_file(revs, "-", tree, &tree->oid, 1,
>  				     tree->ce_mode, 0);
>  		return;

There is already half of the same logic near the beginning of this
function, no?

	/*
	 * i-t-a entries do not actually exist in the index (if we're
	 * looking at its content)
	 */
	if (o->index_only &&
	    revs->diffopt.ita_invisible_in_index &&
	    idx && ce_intent_to_add(idx)) {
		idx = NULL;
		if (!tree)
			return;	/* nothing to diff.. */
	}

IOW, when ita-invisible-in-index flag is set, idx is made NULL and
all the rest of the function behaves as if there is no such entry in
the index (e.g. relative to HEAD it looks as if the entry is removed
in the index).

So for example, when ita-invisible-in-index is not set, this piece,
just above the part you touched, kicks in:

	/*
	 * Something added to the tree?
	 */
	if (!tree) {
		show_new_file(revs, idx, cached, match_missing);
		return;
	}

and says "no such entry in the tree, but you have an I-T-A entry
there in the index".

It is unclear why we can unconditionally declare "I-T-A entry does
not exist, the entry was in the tree but not in the index" in the
code you touched, without consulting ita-invisible-in-index flag.
It feels awfully inconsistent to me.

Of course, consistency could go the other way around, and the right
fix to achieve consistency might turn out to be to drop the check
for ita-invisible-in-index flag (and perhaps the flag itself) from
the early part of this function.  I dunno.

Thanks.
