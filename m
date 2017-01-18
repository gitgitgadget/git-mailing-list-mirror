Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA43F1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 18:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbdARSuD (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 13:50:03 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65041 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753156AbdARSuB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 13:50:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DECDD5EE8F;
        Wed, 18 Jan 2017 13:49:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2U0jarc1MZ1GOdtxkD7Qc0d/dIY=; b=xahWBP
        zDfJMiCRQ7WNWD1ot+9+vYUlPT5Oa1XvOlx6UufdgoK7CIBxNn5qQlQ1GU6Neqcu
        Zg50gJfvd/1TooFI/5Ufw++yEJLRrcOGFit5653T9ZEm7rmnbASfOxyufniooTNr
        uX8vAyW3yh3fjMq97U74wjGl6w7g0+f4xZQC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b03ri9Z/Fkal7pYCEwu7GYurXLibxhTH
        Pu2BEqgpc5gG+WjXyCokmbL9bJRL0LdLBfvwWPoJm23117QuwjglJHXVniIUVTX3
        D34cnBWWDRkOy2Yrt1HCRL3oAqkNcE1ZFuFklagf7hD+kKeiRiRbpTxj29b8zqI6
        ntnAoxY766w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6E9E5EE8E;
        Wed, 18 Jan 2017 13:49:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C9C65EE8D;
        Wed, 18 Jan 2017 13:49:26 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     santiago@nyu.edu, git@vger.kernel.org, sunshine@sunshineco.com,
        walters@verbum.org, Lukas Puehringer <luk.puehringer@gmail.com>
Subject: Re: [PATCH v6 4/6] builtin/tag: add --format argument for tag -v
References: <20170117233723.23897-1-santiago@nyu.edu>
        <20170117233723.23897-5-santiago@nyu.edu>
        <xmqqmvepb4oj.fsf@gitster.mtv.corp.google.com>
        <xmqqh94wb4y0.fsf@gitster.mtv.corp.google.com>
        <20170118182843.iyico5jpii6a3z7i@sigill.intra.peff.net>
Date:   Wed, 18 Jan 2017 10:49:24 -0800
In-Reply-To: <20170118182843.iyico5jpii6a3z7i@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 18 Jan 2017 13:28:44 -0500")
Message-ID: <xmqqziio9paj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5D0724A-DDAE-11E6-8383-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index f81273a85a..fbb85ba3dc 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -66,10 +66,10 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, con
>>  }
>>  
>>  typedef int (*each_tag_name_fn)(const char *name, const char *ref,
>> -				const unsigned char *sha1, void *cb_data);
>> +				const unsigned char *sha1, const void *cb_data);
>
> This would bite us later if one of the iterators really does need to
> pass something mutable. But as this iteration interface is confined to
> builtin/tag.c, I think it's a nice simple fix.
>
> A more general fix would be to pass a non-const pointer to const pointer
> (preferably inside a struct for readability). But I don't see any need
> for that complexity here.

My first trial was to loosen the constness of existing variable,
which was OK, but made me feel dirty by turning what does not need
to be mutable into mutable.  The iterator being local made me try
the other way and it turned out that currently there is no need for
mutable callback data ;-)

I agree that this may have to be updated, and if this were more
global thing, we'd better off doing so from the get-go, but for a
calling convention that is limited within a single file, I am more
comfortable saying we'll cross the bridge when we need to.

Thanks.
