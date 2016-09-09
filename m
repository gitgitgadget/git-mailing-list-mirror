Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6511F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 21:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754414AbcIIVNb (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 17:13:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54877 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753520AbcIIVNa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 17:13:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7C263DBBB;
        Fri,  9 Sep 2016 17:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wbdIK0UyoIZdtb6T9B6z3WnSiQo=; b=mJ7hDy
        vBvrYc1ZgaUPJ9Pj6sZQH1zTYZsW8wRDslxhUrKetLg1GREzGF511Ttnh8hTP0zK
        LeET1+qSCtWh/i5LhFQL3lRjqkOnTOTsFnoDLFEvdI5/v6sBpa+kNLfMye4p2Eyz
        Tx5SEZZ6Q6qyV5gArVt+NMTGIEBJZ+9nLdVaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dATTxMlKsaeNvp5OMezNZjdsxrPvB0m9
        U+moWGPxkiwPrSYd/xvXc/NJqAbPDS5CQv6eQbPmOm1w09st+ua8g2Cec4eObOzP
        JuW3HuoEmcOtjCL7R8s/o3bDzvGPbagvvuu53xwGPBlQqvMPuMEtzEO0i1kWhIq9
        DLP4x3uVuAg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CFB313DBBA;
        Fri,  9 Sep 2016 17:13:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 40B2B3DBB9;
        Fri,  9 Sep 2016 17:13:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Kevin Willford <kewillf@microsoft.com>,
        Xiaolong Ye <xiaolong.ye@intel.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH v3 2/2] patch-ids: define patch-id of merge commits as "null"
References: <20160909203406.5j5pmom442yoe4su@sigill.intra.peff.net>
        <20160909203447.nlyx6v76fpyx2vzl@sigill.intra.peff.net>
Date:   Fri, 09 Sep 2016 14:13:26 -0700
In-Reply-To: <20160909203447.nlyx6v76fpyx2vzl@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 9 Sep 2016 16:34:47 -0400")
Message-ID: <xmqqbmzwaia1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40C79E8C-76D2-11E6-9FE0-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This patch defines the patch-id of a merge commit as
> essentially "null"; it has no patch-id. As a result,
> merges cannot match patch-ids via "--cherry-pick", and
> "format-patch --base" will not list merges in its list of
> prerequisite patch ids.

At first I wondered if such a change would make all merges look the
same, but the patch-ids.c comparison is not for ordering/sorting but
only for equality, so as long as the comparison function knows that
a comparison of anything with "null" yields "They are different", we
are OK.

> diff --git a/patch-ids.c b/patch-ids.c
> index 77e4663..8d06099 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -7,18 +7,40 @@
>  int commit_patch_id(struct commit *commit, struct diff_options *options,
>  		    unsigned char *sha1, int diff_header_only)
>  {
> -	if (commit->parents)
> +	if (commit->parents) {
> +		if (commit->parents->next)
> +			return PATCH_ID_NONE;
>  		diff_tree_sha1(commit->parents->item->object.oid.hash,
>  			       commit->object.oid.hash, "", options);
> -	else
> +	} else
>  		diff_root_tree_sha1(commit->object.oid.hash, "", options);
>  	diffcore_std(options);
> -	return diff_flush_patch_id(options, sha1, diff_header_only);
> +	if (diff_flush_patch_id(options, sha1, diff_header_only))
> +		return PATCH_ID_ERROR;
> +	return PATCH_ID_OK;
> +}

Looks sensible.  Thanks.
