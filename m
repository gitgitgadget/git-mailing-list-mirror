Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A73C2095B
	for <e@80x24.org>; Sat, 18 Mar 2017 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbdCRRSG (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:18:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54209 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751666AbdCRRSF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:18:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C29686CAD;
        Sat, 18 Mar 2017 13:12:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TASxLAByWNxr
        lpaUcCXACgIkFmI=; b=fwIYLjeO4uDgaCTFreVKJ+IPiiKTzz3jlDJCQ0zNpwg2
        PMPWaK2nhq8EThy1MYjIiveZKnUqLsb5s0fJ3IQX9aSuxPxUPEZki758HK60qL0/
        eWSyzM5Iin4I6yPIQz7Q8p5qsPizWt1EJDN0D2pQ4YMy7w8wS8UZJmgMxhrdIrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XW+L2q
        meDNuixq/Jo53PUK10r7IFIIHyekGiwiBx7H3Axlh3HAqjf/3rnBW0VzspVLHHlA
        RZZiJjRvr0WVAkNENqJhtN6VwxGaye32OvqS32WapSDbVbIlwHXiN+RmApA/qRBR
        eBTnJp7n3ZLkCbfYZPLG/kmfowMQ2K+nHGi38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C80B86CAC;
        Sat, 18 Mar 2017 13:12:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ADCC486CAA;
        Sat, 18 Mar 2017 13:12:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] receive-pack: simplify run_update_post_hook()
References: <ac1c0cfc-b1de-37be-23b3-98ef1081ec4a@web.de>
        <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net>
Date:   Sat, 18 Mar 2017 10:12:07 -0700
In-Reply-To: <20170317222320.nsg3yk3nopjadr5t@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Mar 2017 18:23:20 -0400")
Message-ID: <xmqqshma4ihk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04BDF582-0BFE-11E7-893A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 17, 2017 at 11:02:13PM +0100, Ren=C3=A9 Scharfe wrote:
>
>> Instead of counting the arguments to see if there are any and then
>> building the full command use a single loop and add the hook command
>> just before the first argument.  This reduces duplication and overall
>> code size.
>
> Yeah, I agree one loop is nicer.
>
>> -	argv_array_push(&proc.args, hook);
>>  	for (cmd =3D commands; cmd; cmd =3D cmd->next) {
>>  		if (cmd->error_string || cmd->did_not_exist)
>>  			continue;
>> +		if (!proc.args.argc)
>> +			argv_array_push(&proc.args, hook);
>>  		argv_array_push(&proc.args, cmd->ref_name);
>>  	}
>> +	if (!proc.args.argc)
>> +		return;
>
> It looks at first like the result leaks, because you have to realize
> that the push will modify proc.args.argc.=20

Hmph, I needed to read the original twice to imagine how a paranoid
person can fear leaks.  The return condition says "if args array is
empty, just return" and the thing being empty is an enough indication
to think nothing is leaking, at least for me.

Having said that, I'd admit that the "always push hook and then
clean up before returning if it turns out there is nothing to call
the hook for" is what I would have wrote if I were doing this, but
I'm inclined to think that is not because I would have thought of
both versions and picked the better one, but because I wouldn't have
noticed the "optimization opportunity" Ren=C3=A9 spotted here (not that I
think an extra alloc would matter).

I'll queue the patch as-is, at least for now.

Thanks.

> I wonder if:
>
>   argv_array_push(&proc.args, hook);
>   for (cmd =3D commands; cmd; cmd =3D cmd->next) {
> 	if (!cmd->error_string && !cmd->did_not_exist)
> 		argv_array_push(&proc.args, cmd->ref_name);
>   }
>
>   if (proc.args.argc =3D=3D 1) {
> 	argv_array_clear(&proc.args);
> 	return;
>   }
>
> would be more obvious (at the cost of a pointless malloc in the corner
> case. I can live with it either way.
>
> -Peff
