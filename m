Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4880EC001B0
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 19:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjGOTAa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 15:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGOTA0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 15:00:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D00535AB
        for <git@vger.kernel.org>; Sat, 15 Jul 2023 11:59:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B487196934;
        Sat, 15 Jul 2023 14:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HxR10967/i6r3rXOQuw5Fue8JEFz6AKqPDOTnv
        ETNcs=; b=A5tTkhtdcJaxqzGRocBwQXTnuSNQzOjwgyJ2sma4N2vQIQnvnG9pvo
        V4ZL0epKuP7baKd3RZ1BKRg/VS3eBXFkayV5rgoFZoMiOQVSnpuoDrNm+m6X6uQP
        YoCc7pkjHzWsaiLL4ogyK3QpBUjzK+nEEM9e2vOdUcSOTXzB7nqYI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01E6F196933;
        Sat, 15 Jul 2023 14:56:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65DC5196932;
        Sat, 15 Jul 2023 14:56:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v2 2/3] ref-filter: add new "describe" atom
References: <20230705175942.21090-1-five231003@gmail.com>
        <20230714194249.66862-1-five231003@gmail.com>
        <20230714194249.66862-3-five231003@gmail.com>
        <xmqqilamnrcr.fsf@gitster.g> <ZLLkZ4Vx2quwWwRz@five231003>
Date:   Sat, 15 Jul 2023 11:56:37 -0700
In-Reply-To: <ZLLkZ4Vx2quwWwRz@five231003> (Kousik Sanagavarapu's message of
        "Sat, 15 Jul 2023 23:54:39 +0530")
Message-ID: <xmqq351pm2ai.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5402D57A-2341-11EE-8E20-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> conveys it better or is it too much unnecessary stuff to and should we
> just do
>
> 	struct {
> 		const char **describe_args;
> 	} describe;
>
> leaving the describe_opts array as is and changing the how the switch is
> written.

I think this struct can be replaced with a single

	const char **describe_args;

and then

>> > +static int describe_atom_parser(struct ref_format *format UNUSED,
>> > +				struct used_atom *atom,
>> > +				const char *arg, struct strbuf *err)
>> > +{
>> > +	const char *describe_opts[] = {
>> > +		"",
>> > +		"tags",
>> > +		"abbrev",
>> > +		"match",
>> > +		"exclude",
>> > +		NULL
>> > +	};

this array can simply go away.  Then you can

>> > +	struct strvec args = STRVEC_INIT;
>> > +	for (;;) {
>> > +		int found = 0;
>> > +		const char *argval;
>> > +		size_t arglen = 0;
>> > +		int optval = 0;
>> > +		int opt;
>> > +
>> > +		if (!arg)
>> > +			break;
>> > +
>> > +		for (opt = D_BARE; !found && describe_opts[opt]; opt++) {

rewrite this "for" loop plus the "switch" inside to an if/else
if/else cascade:

		if (match_atom_bool_arg(arg, "tags", &arg, &optval)) {
			... do "tags" thing ...
		} else if (match_atom_arg_value(arg, "abbrev", ...)) {
			... do "abbrev" thing ...
		} else if ...

That way, you do not need any enum anywhere and there is no reason
to have desribe_opts[] array, either.


