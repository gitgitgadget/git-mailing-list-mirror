Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0096F1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 17:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFTRoY (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 13:44:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60376 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfFTRoX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 13:44:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A4BA14A853;
        Thu, 20 Jun 2019 13:44:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eEmWg7xwLwgrhj1Ya+fMPWaYvV0=; b=SG5g56
        jPy2qWJ0c9h4JFnJ+MNp687JE1EcB2g0V1DRw41D52vhR+/ZBw7/r2/pwCoO1f11
        UYaCW2sPymG0BD7/dQLY4yC6qep16A5IZ2wtSd/Gfl5cRbSnMdtvQlfNMmwGMLrE
        wXn4mjcFVmej8HbRpSc/a4WJnSlrVw1ULjG20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YNaGUTgwzxJfgTKnBL/J+ZAR0f+/oSvT
        JDgLnyf4okqtC3G3DOD0bquY3ZfVgSE4NNj+pmq0oRS5eUkMcBmbE7BQyjK2bbdS
        CMz2fKXX3itExmQ1tNFNcRlQz8aq907E5bkBx1F1Sq9VKYNTjo8xnAN+RxEBku+M
        w/r/9dYDdG0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2170214A852;
        Thu, 20 Jun 2019 13:44:19 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 815FD14A851;
        Thu, 20 Jun 2019 13:44:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 15/17] khash: rename oid helper functions
References: <20190620073952.GA1539@sigill.intra.peff.net>
        <20190620074141.GO3713@sigill.intra.peff.net>
Date:   Thu, 20 Jun 2019 10:44:17 -0700
In-Reply-To: <20190620074141.GO3713@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 20 Jun 2019 03:41:42 -0400")
Message-ID: <xmqqwohgnocu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 07633F18-9383-11E9-AD44-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> For use in object_id hash tables, we have oid_hash() and oid_equal().
> But these are confusingly similar to the existing oideq() and the
> oidhash() we plan to add to replace sha1hash().
>
> The big difference from those functions is that rather than accepting a
> const pointer to the "struct object_id", we take the arguments by value
> (which is a khash internal convention). So let's make that obvious by
> calling them oidhash_by_value() and oideq_by_value().
>
> Those names are fairly horrendous to type, but we rarely need to do so;
> they are passed to the khash implementation macro and then only used
> internally. Callers get to use the nice kh_put_oid_map(), etc.

The pass-by-value interface feels a bit unforunate but hopefully
"static inline" would help us avoid actually copying the struct left
and right as we make calls to them X-<.


> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  khash.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/khash.h b/khash.h
> index cb2cd3d7e4..f911d2b005 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -324,20 +324,20 @@ static const double __ac_HASH_UPPER = 0.77;
>  		code;												\
>  	} }
>  
> -static inline unsigned int oid_hash(struct object_id oid)
> +static inline unsigned int oidhash_by_value(struct object_id oid)
>  {
>  	return sha1hash(oid.hash);
>  }
>  
> -static inline int oid_equal(struct object_id a, struct object_id b)
> +static inline int oideq_by_value(struct object_id a, struct object_id b)
>  {
>  	return oideq(&a, &b);
>  }
>  
> -KHASH_INIT(oid_set, struct object_id, int, 0, oid_hash, oid_equal)
> +KHASH_INIT(oid_set, struct object_id, int, 0, oidhash_by_value, oideq_by_value)
>  
> -KHASH_INIT(oid_map, struct object_id, void *, 1, oid_hash, oid_equal)
> +KHASH_INIT(oid_map, struct object_id, void *, 1, oidhash_by_value, oideq_by_value)
>  
> -KHASH_INIT(oid_pos, struct object_id, int, 1, oid_hash, oid_equal)
> +KHASH_INIT(oid_pos, struct object_id, int, 1, oidhash_by_value, oideq_by_value)
>  
>  #endif /* __AC_KHASH_H */
