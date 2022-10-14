Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999EC433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiJNU1q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiJNU1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:27:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930975D701
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:27:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A4961C444D;
        Fri, 14 Oct 2022 16:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Hpyp4sh4VbrNJIY48R3ZqGrGCEuJ8Vg84TNv6Z
        +YAuY=; b=lcP40GG6HNtXTmkTa2oGZ20l5Qe7e71/wFML8NtFMrnwuHdXvG1pVb
        cr4GDY3GEF5GZ/2utoA9UgYxP7stELvVJyyySBEqTbZbdVycOtJ7CtOIu6d1fr14
        +x60IBKoV3NWy8VqM8Aua8dP6h99zGue4nECtI9LCSTXEh9bd6auQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 217021C444C;
        Fri, 14 Oct 2022 16:27:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52A881C444A;
        Fri, 14 Oct 2022 16:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 03/10] run-command API: add and use a run_command_l_opt()
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
        <patch-03.10-fd81d44f221-20221014T153426Z-avarab@gmail.com>
        <xmqqtu468d0k.fsf@gitster.g>
        <Y0nAm4+KL71vyYB8@coredump.intra.peff.net>
Date:   Fri, 14 Oct 2022 13:27:38 -0700
In-Reply-To: <Y0nAm4+KL71vyYB8@coredump.intra.peff.net> (Jeff King's message
        of "Fri, 14 Oct 2022 16:03:39 -0400")
Message-ID: <xmqq8rli881x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5C92276-4BFE-11ED-BFDA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 14, 2022 at 11:40:27AM -0700, Junio C Hamano wrote:
>
>> > @@ -862,11 +858,11 @@ static void write_refspec_config(const char *src_ref_prefix,
>> >  
>> >  static void dissociate_from_references(void)
>> >  {
>> > -	static const char* argv[] = { "repack", "-a", "-d", NULL };
>> 
>> Good to see that this one in a wrong scope can now go away.
>
> It definitely is broader scope than is necessary. I wonder if it makes
> things easier to read, though, the way we would sometimes hoist things
> out of a function into a static-global to make them more obvious. I
> dunno.

Didn't think about it, but it is a worthy point to make.  Unlike the
call to l_opt() buried inside a conditional, it makes it stand out
that what we see upfront is one of the commands the function will
run.  It is especially valuable when a function is almost exclusively
about running a single command, but then we will have a single call
to l_opt() without much preparations or clean-ups around it, so the
visual noise that detracts our eyes away from the actual commands
may not be all that bad, though.

>> >  	char *alternates = git_pathdup("objects/info/alternates");
>> >  
>> >  	if (!access(alternates, F_OK)) {
>> > -		if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
>> > +		if (run_command_l_opt(RUN_GIT_CMD|RUN_COMMAND_NO_STDIN,
>> > +				      "repack",  "-a", "-d", NULL))
>> >  			die(_("cannot repack to clean up"));
>
> I just happened to notice in this one there is a weird extra space
> before "-a".

Yeah, good eyes.

Thanks.
