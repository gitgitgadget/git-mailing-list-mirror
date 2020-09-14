Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D80C433E2
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB980208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 20:06:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="micTbNZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbgINUGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:06:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61467 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINUGf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 16:06:35 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B3E6C69DC5;
        Mon, 14 Sep 2020 16:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/i/sBam3AbHle4SlbCnyCzJOqI=; b=micTbN
        ZC0koyQVOIwg1Orf1btbGJOJgwUGuvfkf9eLVUgKN64Gli/P2QG1c6n2XMq15DR3
        Jghua6XLI987QFGZdxUmWxm8Ms7AnzWgar0y7n3ZbtNp8CE+xkjTVkICZd4AwNkf
        gqagKziuKBv5nNV4DPJ8jqlEaW4kfkTuJB9Fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=twHXrU8qXJHrcuifasP+X7V/jCBmsK20
        GOwI8mvRfd9/5vCFXItcVUtd/N2Dg+zSe1ZwIZ1gCvk8inRdmAkW5xHAV9CKBviu
        yr/XDg1UnbmeRy7922BkcKm7DeQFaic3wL/usv69IZJqDBjnFpASTJmz3wZCx9u3
        JNxeFxsoO2s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AB98D69DC4;
        Mon, 14 Sep 2020 16:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B4B969DC3;
        Mon, 14 Sep 2020 16:06:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
        Jeff King <peff@peff.net>
Subject: Re: sub-fetches discard --ipv4|6 option
References: <20200914121906.GD4705@pflmari>
Date:   Mon, 14 Sep 2020 13:06:32 -0700
In-Reply-To: <20200914121906.GD4705@pflmari> (Alex Riesen's message of "Mon,
        14 Sep 2020 14:19:06 +0200")
Message-ID: <xmqqk0wwktrr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9301C46-F6C5-11EA-A82A-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 82ac4be8a5..5e06c07106 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1531,6 +1531,10 @@ static void add_options_to_argv(struct argv_array *argv)
>  		argv_array_push(argv, "-v");
>  	else if (verbosity < 0)
>  		argv_array_push(argv, "-q");
> +	if (family == TRANSPORT_FAMILY_IPV4)
> +		argv_array_push(argv, "--ipv4");
> +	else if (family == TRANSPORT_FAMILY_IPV6)
> +		argv_array_push(argv, "--ipv6");
>  
>  }
>  
> Am I missing something obvious?

I think something obvious was missed back wne -4/-6 was added at
c915f11e (connect & http: support -4 and -6 switches for remote
operations, 2016-02-03) ;-).

The other candidate was 9c4a036b (Teach the --all option to 'git
fetch', 2009-11-09) that introduced this helper to relay various
options, but back then there weren't -4/-6 invented yet, so...

It is somewhat sad that we need to manually relay these down, but I
do not offhand think of a way to automate this sensibly.

Thanks for noticing.



