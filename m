Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B881C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B828020797
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 18:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i6BC2Jrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJFSlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 14:41:12 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64413 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgJFSlM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 14:41:12 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 47075E72F8;
        Tue,  6 Oct 2020 14:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VCsc39tkXLC8y4ENjdAK86dgAAE=; b=i6BC2J
        rb8+I9XP1cImosGq6pQJYsfQsRF+MAV+S12JcyqwiSNvxldPXEsEipzO+0pyCGDh
        q47MGY3Sdfsae44GTPYuAjN2QZbmJS/FwOgbLjpWdpBK4h0ivS7iNWOMa/P95Tsb
        /5DVF+r0PVCM1DBF6eRL1VzBOXn5GZCjXeqJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X6Tb52RZNdfHDhJ8E4ydz38TE+D23vg9
        GLZ+a7bF9wTuHj5uQEZ7D/UfsQXMOLjuqGOCmxd/hHoFTE83jrGZ98wf1/aUFxDY
        Pyzpt4eBjtxAL6NGIs86gyvviPdwhcjOnjfk/prjsfyuA1CX5qecDAB/Vv91fP4B
        5mQnBWIjkwU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3FD65E72F7;
        Tue,  6 Oct 2020 14:41:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C552E72F6;
        Tue,  6 Oct 2020 14:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] checkout: learn to respect checkout.guess
References: <cover.1601810233.git.liu.denton@gmail.com>
        <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com>
        <xmqqwo057ul5.fsf@gitster.c.googlers.com>
        <20201006080730.GA2419589@generichostname>
Date:   Tue, 06 Oct 2020 11:41:03 -0700
In-Reply-To: <20201006080730.GA2419589@generichostname> (Denton Liu's message
        of "Tue, 6 Oct 2020 01:07:30 -0700")
Message-ID: <xmqqtuv75ha8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DE8223E-0803-11EB-B76D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Sun, Oct 04, 2020 at 10:46:14AM -0700, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>> > The current behavior of git checkout/switch is that --guess is currently
>> > enabled by default. However, some users may not wish for this to happen
>> > automatically. Instead of forcing users to specify --no-guess manually
>> > each time, teach these commands the checkout.guess configuration
>> > variable that gives users the option to set a default behavior.
>> >
>> > Teach the completion script to recognize the new config variable and
>> > disable DWIM logic if it is set to false.
>> >
>> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
>> > ---
>> 
>> Asking for input from Dscho on how to futureproof the tests along
>> the same line as js/default-branch-name-part-2 topic.
>
> Perhaps we could extract lists that are repeated often into common files
> so that they only need to be changed in one place? Something like this:

or we can feed a prefix that is not 'm' so that master, main, or
maint branches are not involved at all in the completion?

>
> -- >8 --
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 7b7bc6e4bd..86da44231d 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1240,8 +1240,8 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
>  	test_cmp expected out
>  '
>  
> -test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
> -	test_completion "git switch " <<-\EOF
> +test_expect_success 'prepare expect files for DWIM tests' '
> +	cat >local-and-unique-remote <<-\EOF &&
>  	branch-in-other Z
>  	master Z
>  	master-in-other Z
> @@ -1249,6 +1249,10 @@ test_expect_success 'git switch - with no options, complete local branches and u
>  	EOF
>  '
>  
> +test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
> +	test_completion "git switch " <local-and-unique-remote
> +'
> +
>  test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
>  	test_completion "git checkout " <<-\EOF
>  	HEAD Z
