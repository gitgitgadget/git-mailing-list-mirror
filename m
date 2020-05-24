Return-Path: <SRS0=NZH0=7G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CEC433E0
	for <git@archiver.kernel.org>; Sun, 24 May 2020 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 090B120787
	for <git@archiver.kernel.org>; Sun, 24 May 2020 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lmptondA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgEXXPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 May 2020 19:15:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65405 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387863AbgEXXPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 May 2020 19:15:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AD6368421;
        Sun, 24 May 2020 19:15:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CRP1j5Flv/rhgG24wAs7ETnA/Gs=; b=lmpton
        dA42CjHZzWXGu+VrWGvADvBt6X70oneZT4S5plpHHe0YCHq0HRcFlBQoyKu2bfW3
        BKnp0KBgXYam7DhBxcmyQJ6PdkM45bzSsEB55yVZK2iz8tyAM+IqJGOup+c3ZLlP
        0bQbshBg4fh8tcTnoSHIzJt3LosRO+kBHJuZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yZVHIdWo9BOsf9sBPdEqSgdiwjoaRbug
        3+T3rP+s+88CX75ys5FgAGv020rtwnW2VBzS9/HtsI+P7wMaehtVAMI1CK3Bjklk
        pj4Y1Uvy50vyXlOTZAN8O6vbeElg0sx7RE13CFMxF+TZ92tHB1aENXAcEg8hxlbV
        PqNE6HQd/yI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 45CAC6841F;
        Sun, 24 May 2020 19:15:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C910E6841C;
        Sun, 24 May 2020 19:15:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Shourya Shukla <shouryashukla.oo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, congdanhqx@gmail.com,
        sunshine@sunshineco.com, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3] submodule: port subcommand 'set-branch' from shell to C
References: <20200521163819.12544-1-shouryashukla.oo@gmail.com>
        <nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet>
Date:   Sun, 24 May 2020 16:15:01 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2005230012090.56@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sat, 23 May 2020 00:21:01 +0200 (CEST)")
Message-ID: <xmqqtv05orgq.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65D0A77E-9E14-11EA-9DEE-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> +	config_set_in_gitmodules_file_gently(config_name, opt_branch);
>
> What happens if this fails? E.g. when the permission is denied or disk is
> full? This C code would then still `return 0`, pretending that it
> succeeded. But the original shell script calls `git submodule--helper
> config [...]` which calls `module_config()`, which in turn passes through
> the return value of the `config_set_in_gitmodules_file_gently()` call.
>
> In other words, you need something like this:
>
> 	int ret;
>
> 	[...]
>
> 	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
>
> 	free(config_name);
> 	return ret;

Making sure we check the return value of helper functions we call is
a good discipline, but this is not quite enough.

> So I think we'll also need this (it's unrelated to your patch, at least
> unrelated enough that it merits its own, separate patch):
>
> -                       return commands[i].fn(argc - 1, argv + 1, prefix);
> +                       return !!commands[i].fn(argc - 1, argv + 1, prefix);

I checked (not all but most of the) functions in that commands[]
table and they all seem to return 0 for success and positive
non-zero for failure.

config_set_in_gitmodules_file_gently() takes the return value of a
helper function in its 'ret', gives an warning if it is negative,
and returns that 'ret' literally to the caller.  You suggestion
allows module_set_branch() return a negative value as-is.  You'd
need to return !!ret from there.

The "unrelated" change becomes only necessary if you do not do the
!!ret in module_set_branch(); otherwise it is unneeded, I think.

Thanks.

