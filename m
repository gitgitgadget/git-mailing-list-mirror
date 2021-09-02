Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570FBC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 00:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3698761074
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 00:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhIBA7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 20:59:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60599 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhIBA7J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 20:59:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72E6D14BC21;
        Wed,  1 Sep 2021 20:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VO4qp4X1RHL9ukqUBGiZS8syUpObBvD4NEJAT9
        CCw4Y=; b=BfwWs0ljocXb4xbDGJDdqmgHO4QJ2jpdPn52mY/hiYMJwO0W6FZS1G
        cIjOzZA88+8xXPdcqYrw4eOVuQtcj9jEFYRpwj2PlTnLF+T/B60r1MZ2jXGniyBA
        1+85ddY82lbkkzNVcQ3CZe0ewaawSUF0OzuDl3iHPotxfYj6MlPSo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B16614BC20;
        Wed,  1 Sep 2021 20:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B4BEC14BC1F;
        Wed,  1 Sep 2021 20:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     gitgitgadget@gmail.com, git@vger.kernel.org,
        philipoakley@iee.email, sobomax@gmail.com, sobomax@sippysoft.com
Subject: Re: [PATCH v2] Make ident dynamic, not just a hardcoded value of
 "$Id".
References: <pull.1074.v2.git.git.1629952119446.gitgitgadget@gmail.com>
        <20210826203713.45139-1-matheus.bernardino@usp.br>
Date:   Wed, 01 Sep 2021 17:58:06 -0700
In-Reply-To: <20210826203713.45139-1-matheus.bernardino@usp.br> (Matheus
        Tavares's message of "Thu, 26 Aug 2021 17:37:13 -0300")
Message-ID: <xmqqr1e77q01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D6B9391E-0B88-11EC-BCB1-FA11AF6C5138-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> Hi, Maksym
>
> I haven't read the entire patch (and I don't normally use the ident feature),
> but I left a few comments below: 
>
> On Thu, Aug 26, 2021 at 1:28 AM Maksym Sobolyev via GitGitGadget <gitgitgadget@gmail.com> wrote:
>>
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
>> index 83fd4e19a4..9e486f3e8d 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -382,6 +382,14 @@ sign `$` upon checkout.  Any byte sequence that begins with
>>  `$Id:` and ends with `$` in the worktree file is replaced
>>  with `$Id$` upon check-in.
>>
>> +The `ident` attribute can also provide an optional value,
>> +which if supplied is going to be used for expansion instead of
>> +the string `Id`.
>> +
>> +------------------------
>> +*.[ch]         ident=FreeBSD
>> +------------------------
>
> What happens if there is a ':' or '$' in the custom id name?

It is a valid question.  I actually think these two bytes should be
excluded from the custom ID string --- FWIW, I also do not think
there is any practical problem if we limited the set of characters
to [A-Za-z0-9] and nothing else.

> You might want to take a look at the other ident tests in
> t0021-conversion.sh and perhaps addapt/copy some of them to ensure that
> the expected behavior persists when using a custom id name. For example,
> quickly changing the "$Id:" references to "$customId:" and replacing
> "ident" with "ident=customId", I seem to get at least one test failure:
>
> --- expected-output     2021-08-26 19:40:07.181596662 +0000
> +++ expanded-keywords   2021-08-26 19:40:07.188263463 +0000
> @@ -6,5 +6,5 @@
>  $customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
>  $customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
>  $customId: NoTerminatingSymbol
> -$customId: Foreign Commit With Spaces $
> +$customId: bebd07c752ffffd6779e1056db5de66c3bb733ed $
>  $customId: NoTerminatingSymbolAtEOF
> \ No newline at end of file
> error: last command exited with $?=1
> not ok 3 - expanded_in_repo
>
> (But I haven't dig further, and this was just a quick test, so it could be my
> fault.)

If we are not restricting the characters that can be used in the
custom ID placeholder, we probably should have tests that use
allowed but unusual characters.

Thanks.
