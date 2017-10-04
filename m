Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEDA12036B
	for <e@80x24.org>; Wed,  4 Oct 2017 02:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbdJDCTg (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 22:19:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51803 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751156AbdJDCTg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 22:19:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A54D9EF56;
        Tue,  3 Oct 2017 22:19:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aG1CFWE2EsJzoQ/2Wdd/VU0y2Z8=; b=g4lZAw
        qQscj0b8yxz24MvRY1x2Qdgs8v1INxz3VfKih63HSKm8x9zr0NdFeNb7HDCHOhJw
        WHdA99Hi1A5zKVXkTSZRHxSmSLhfLf9dNJWZ+QU3J+W1vjyzS9h1Lvdq5AZQSMzQ
        JcxeUJRo7tECSLrYlY5iwhCBYEnDoJa806m60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QBBMAkSTKv0KzsEy+aNEC3i0p/ZKGs8h
        4WDEyDOibrLPnBxNNigTVuJ6qOW4KU5SCR20GJXtvbQgIEisBSgytoUmtsA4zT5q
        f65WhbtOfhUnUlJE9n6A2dGP2Gw/ATq5i3Kq3nwRuR7Vf37ibNQItHzGjg4medeg
        ESOmK0UGvkQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 41F039EF55;
        Tue,  3 Oct 2017 22:19:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B4F259EF54;
        Tue,  3 Oct 2017 22:19:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: reset instead of release a strbuf
References: <20171003214646.GZ19555@aiede.mtv.corp.google.com>
        <20171003221740.26325-1-sbeller@google.com>
        <20171003222414.GC19555@aiede.mtv.corp.google.com>
        <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 11:19:33 +0900
In-Reply-To: <20171003234919.qsr54ncmw6cihowi@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 3 Oct 2017 19:49:19 -0400")
Message-ID: <xmqqvajvfydm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 76B4A98A-A8AA-11E7-8886-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  /**
>>   * Release a string buffer and the memory it used. You should not use the
>> - * string buffer after using this function, unless you initialize it again.
>> + * string buffer after using this function.
>>   */
>>  extern void strbuf_release(struct strbuf *);
>
> I think it's actually OK to use the string buffer after this function.
> It's just an empty string.
>
> Perhaps we should be more explicit: this releases any resources and
> resets to a pristine, empty state. I suspect strbuf_detach() probably
> should make the same claim.
>
> Earlier you mentioned:
>
>> It is still not advisable to call strbuf_release until done using a
>> strbuf because it is wasteful, so keep that part of the advice.
>
> Is this what you meant? If so, I think we should probably be more
> explicit in giving people a hint to use strbuf_reset() for efficiency.

Yes, "should not use" above is simply misleading.  Either drop it
altogether, or say something like

	If you find yourself reusing the same strbuf in a loop and
	calling strbuf_release() each iteration, you may want to
	consider if it makes more sense to use strbuf_reset()
	instead in each iteration and calling strbuf_release() at
	the end.

perhaps.
