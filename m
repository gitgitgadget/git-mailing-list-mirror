Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DBCC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 00:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 436C22333B
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 00:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbhAFX76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:59:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56925 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbhAFX76 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:59:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CA1D7A385E;
        Wed,  6 Jan 2021 18:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kqbdAtwgWKSIyMk6RuuoFL1XDx8=; b=pOZFHr
        9krYT8AIIfjsMnSAs3la0PzMNhkIiy6fyrtc1+kK3RjuujDHfIlcmC4hko3CW5Xg
        bOEloBFTSz+aun+RSZQJs2pOC20Wjc6LZ1wBv+aeg4wb05rzqI1uW/ozy1mG3tuz
        7Vv19ymvyvsP1jlASsVI7RI1FxdyETcktTO/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q2krupqssEU8HUG12Mv52dZfWNPIl0ri
        ql0a+7eEvCmRJNMygYa7Zi57W7zEUBlp3a4KqF0Z0eZHccM1QlgtV5HCzpb/Ifm+
        J6Nm5kC4+zkKgmuZ+L9Fb9PBPYv1RJ/0daMWhJ0ihw4WbZyr/+eJjasKwmlmI4xg
        wddxAodiczM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C21A3A385D;
        Wed,  6 Jan 2021 18:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53C2DA385C;
        Wed,  6 Jan 2021 18:59:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     me@ikke.info, git@vger.kernel.org
Subject: Re: [PATCH v2] t4129: don't fail if setgid is set in the test
 directory
References: <88398ff952a68e8d134dcd50ef0772bb6fc3b456.1609339792.git.matheus.bernardino@usp.br>
        <b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br>
Date:   Wed, 06 Jan 2021 15:59:14 -0800
In-Reply-To: <b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 5 Jan 2021 12:47:39 -0300")
Message-ID: <xmqqlfd5obvx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E571D04-507B-11EB-BB5E-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> +# Get the modebits from a file or directory, ignoring the setgid bit (g+s).
> +# This bit is inherited by subdirectories at their creation. So we remove it
> +# from the returning string to prevent callers from having to worry about the
> +# state of the bit in the test directory.
> +#

We probably do not use "chmod g+s" manually on regular files, so I
may be being overly "correct", but shouldn't these be done only for
directories?

>  test_modebits () {
> -	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|'
> +	ls -ld "$1" | sed -e 's|^\(..........\).*|\1|' \
> +			  -e 's|^\(......\)S|\1-|' -e 's|^\(......\)s|\1x|'

That is, 

			  -e 's|^\(d.....\)S|\1-|' -e 's|^\(d.....\)s|\1x|'

instead of applying the rule to any filetype.

Will queue as-is, as the distinction probably would not matter in
practice.

Thanks.
