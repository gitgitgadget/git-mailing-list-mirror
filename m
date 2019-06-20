Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 529AC1F461
	for <e@80x24.org>; Thu, 20 Jun 2019 16:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfFTQcy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 12:32:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59002 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQcy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 12:32:54 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 94A6416667A;
        Thu, 20 Jun 2019 12:32:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+DZPb8asRNDEIRSQNWFUPWx4xaU=; b=JAa37w
        OQwR5HZqdPhbxhx6HH6aifV43LljXPsWC91R0WPNLEdCpDAK3Y7fEHLG/jLzzo61
        XPIzGcHm+CdJ/Q4ZjYEHfULOYhT3tVXrIE9iAUI55ubvMDBMlQbl8JMrFZxv+Y3M
        oo+NHiHn1WloL8P1DLTg6kWM4m3gNc3rtpDVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mtTPu2Q//d0Blnvq2YhuCZEsc99JtSYD
        9tLvJObz0VHJfzc/HK33udM8IfAf4VR4pyfuHRNZrP1NdRRJ3tFrUF2B9Xo+Rhhf
        qvOzndoqgbi5mQBpr46tQe13+ryozz9eViqKLYzlaCgvU5y1i9H/QbsxrX+Qng6Y
        0xsr9SndWfs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8C1D4166679;
        Thu, 20 Jun 2019 12:32:51 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 00FC5166678;
        Thu, 20 Jun 2019 12:32:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 01/17] describe: fix accidental oid/hash type-punning
References: <20190620073952.GA1539@sigill.intra.peff.net>
        <20190620074050.GA3713@sigill.intra.peff.net>
Date:   Thu, 20 Jun 2019 09:32:49 -0700
In-Reply-To: <20190620074050.GA3713@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 20 Jun 2019 03:40:50 -0400")
Message-ID: <xmqq7e9gp68e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0BD2AC46-9379-11E9-ACF4-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The find_commit_name() function passes an object_id.hash as the key of a
> hashmap. That ends up in commit_name_neq(), which then feeds it to
> oideq(). Which means we should actually be the whole "struct object_id".
>
> It works anyway because pointers to the two are interchangeable. And
> because we're going through a layer of void pointers, the compiler
> doesn't notice the type mismatch.

Wow.  Good eyes.  I wouldn't have noticed this (and for the reasons
you stated, it is very tricky for any clever compiler to notice it).

Impressed.

> But it's worth cleaning up (especially since once we switch away from
> sha1hash() on the same line, accessing the hash member will look doubly
> out of place).

Yup.  Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/describe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 1409cedce2..0a5cde00a2 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -76,7 +76,7 @@ static int commit_name_neq(const void *unused_cmp_data,
>  
>  static inline struct commit_name *find_commit_name(const struct object_id *peeled)
>  {
> -	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled->hash);
> +	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled);
>  }
>  
>  static int replace_name(struct commit_name *e,
