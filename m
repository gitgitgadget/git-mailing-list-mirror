Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDD0C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6564E20786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTzAlBo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgKKH1K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:27:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59755 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgKKH1K (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 02:27:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA4EFE2DC6;
        Wed, 11 Nov 2020 02:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=k3B/mIC7+7t2qOKsr5pJvdeD4BU=; b=KTzAlBo/hwjeRFTYW9ct
        N3iDZCaqI7DPq2bDKU1xQb01W9joHHGY838r9xldnWsXP/S+pok0vsBl2OfvwMXN
        dxfOg6izfP0WZaisfVd0jOPuiWPO4vfJhLlM3+sdId+Toimp8GVXLYzAyR8Jvj4a
        hS+cvbytwmYUzug+qPc0iqk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=GzyOPQ5rzPt+BE8cy4MnQg45wMv7N4sDHqzWdhIEYZiSLq
        j309/eIxHSYCjcdzUUYmayvFEMiiFZCC1yoIet4FWth9LKLVKef6iAOPBz4XAhwQ
        lb4ikU/J96q+EFQIfeIqp10BAqw6n8gP5CnY+zwNJr4tH+kQ3CHK6BxrjdHy4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E3B4EE2DC5;
        Wed, 11 Nov 2020 02:27:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D856E2DC4;
        Wed, 11 Nov 2020 02:27:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 06/26] test: completion: add run_func() helper
References: <20201110212136.870769-1-felipe.contreras@gmail.com>
        <20201110212136.870769-7-felipe.contreras@gmail.com>
Date:   Tue, 10 Nov 2020 23:27:04 -0800
Message-ID: <xmqq1rh05p6f.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D1A6AEC-23EF-11EB-8EBD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Pretty straightforward: runs functions.

Hmph, sorry but this is not straight-forward at least to me.  Yes,
the helper runs whatever is given on the command line, but then it
does "print_comp", too.  And the proposed log message is not
entirely clear on the most important thing: why?

What is this "helper" meant to help?  Reduce repetition?

> +run_func ()
> +{
> +	local -a COMPREPLY &&
> +	"$@" && print_comp
> +}
> +
>  # Test high-level completion
>  # Arguments are:
>  # 1: typed text so far (cur)
> @@ -452,8 +458,7 @@ test_expect_success '__gitcomp_direct - puts everything into COMPREPLY as-is' '
>  	EOF
>  	(
>  		cur=should_be_ignored &&
> -		__gitcomp_direct "$(cat expected)" &&
> -		print_comp
> +		run_func __gitcomp_direct "$(cat expected)"

This is an no-op rewrite, as we used to do the gitcomp-direct
followed by print-comp, which is exactly what the helper does.  So
the helper does reduce repetition, which by itself would be a good
thing but is there other benefit we are trying to seek (there does
not have to be any)?

>  test_expect_success '__gitcomp - doesnt fail because of invalid variable name' '
> -	__gitcomp "$invalid_variable_name"
> +	run_func __gitcomp "$invalid_variable_name"

This one changes the behaviour in that it starts running print_comp
which we didn't run.  It may be a good thing and improvement, but
then we'd better advertise it in the proposed log message.

>  '
>  
>  read -r -d "" refs <<-\EOF
> @@ -586,7 +591,7 @@ test_expect_success '__gitcomp_nl - no suffix' '
>  '
>  
>  test_expect_success '__gitcomp_nl - doesnt fail because of invalid variable name' '
> -	__gitcomp_nl "$invalid_variable_name"
> +	run_func __gitcomp_nl "$invalid_variable_name"

Likewise.

>  '


Thanks.
