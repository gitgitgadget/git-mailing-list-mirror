Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C59C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 23:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CE32072E
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 23:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="sYD1vyqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHQXnv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:43:51 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62280 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHQXnt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 19:43:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EDBEEE13CF;
        Mon, 17 Aug 2020 19:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3bqWM36ldIfEKPDmbE3upR3tL4s=; b=sYD1vy
        qL2LBpozXuFo9L/2DFAy4nzWPtLHTMrmG444rs9YubSHhYpYF2cwLAhVzJ+7W2GN
        MVNy6KnKnKoSuwqVCY9M6fEfIn6cEG8mmNY8qu+1l3KYqs0T5B8/sTB/E3nyRlut
        54Dglfd8xF/g4X39059A/B0ZRAKHvgumrPnlI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SOZs04Wu/rKVldehkj1KNEuHjUaMB9il
        zG9j7U5k5oyfI+on/Xbe2Hoy0pQ44/WjVONDGfkb/B/e/B1gwbsp1AF3H18IYEBp
        9/nYlgK4aMXg+fV8uD51b6cGJR1Qax0oM61/9NSHKzpsIGPA/okTI83fcbq7Zx5t
        xb026kYeg5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E6856E13CE;
        Mon, 17 Aug 2020 19:43:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E1B72E13CD;
        Mon, 17 Aug 2020 19:43:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC 3/3] refspec: add support for negative refspecs
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
        <20200815002509.2467645-3-jacob.e.keller@intel.com>
Date:   Mon, 17 Aug 2020 16:43:40 -0700
In-Reply-To: <20200815002509.2467645-3-jacob.e.keller@intel.com> (Jacob
        Keller's message of "Fri, 14 Aug 2020 17:25:09 -0700")
Message-ID: <xmqq5z9gzvmb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7B51EEAC-E0E3-11EA-BDE2-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> Refspecs today are commutative, meaning that order doesn't expressly
> matter. Rather than forcing an implied order, negative refspecs will
> always be applied last. That is, in order to match, a ref must match at
> least one positive refspec, and match none of the negative refspecs.
> This is similar to how negative pathspecs work.

Yes, enumerate what positive ones match and then exclude what
negative ones match from the result is a time-tested pattern our
users know how things work.

> @@ -530,6 +530,9 @@ static struct ref *get_ref_map(struct remote *remote,
>  		tail = &rm->next;
>  	}
>  
> +	/* apply any negative refspecs now to prune the list of refs */
> +	ref_map = apply_negative_refspecs(ref_map, rs);
> +
>  	ref_map = ref_remove_duplicates(ref_map);

How was the ordering here decided?  Should it result the same set if
negative ones are excluded after duplicates are removed?

> @@ -1441,6 +1445,8 @@ int match_push_refs(struct ref *src, struct ref **dst,
>  		string_list_clear(&src_ref_index, 0);
>  	}
>  
> +	*dst = apply_negative_refspecs(*dst, rs);
> +

The block of code whose tail is shown in the pre-context has
prepared "delete these refs because we no longer have them" to the
other side under MATCH_REFS_PRUNE but that was done based on the
*dst list before we applied the negative refspec.  Is the ordering
of these two correct, or should we filter the dst list with negative
ones and use the resulting one in pruning operation?

> +	if (item->negative) {
> +		struct object_id unused;
> +
> +		/*
> +		 * Negative refspecs only have a LHS, which indicates a ref
> +		 * (or pattern of refs) to exclude from other matches. This
> +		 * can either be a simple ref, a glob pattern, or even an
> +		 * exact sha1 match.
> +		 */

"a ref (or pattern of refs)" is clarified with the next sentence
anyway, so let's not say it, e.g.

	... only have a LHS, which indicates what to exclude from
	other matches.

