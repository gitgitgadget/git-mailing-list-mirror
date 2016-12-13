Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EAC8203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 18:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964963AbcLMSKK (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 13:10:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57258 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938770AbcLMSKI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 13:10:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40BBF56772;
        Tue, 13 Dec 2016 13:10:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S6sCZkSS7DK/OX4sfu74xk8uwao=; b=vJc0UO
        cIcU93Cm0OZixaQNpYKcsjv7SegFXK0uAvHJjbRJ8WSxPEtgDXOWEeIrWfvIwQT5
        4asuSQTqniEQUsZkDdQ6rCkYgdvevXgoTcw2cHX7b4eTGhNPntnFP2lo8+B44Glt
        lnMMoI4+z+TT/Qra00s5ReWINFIj6My49/zXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cvus20vOi4ZPQeMM2MH9ullXE7AMtzAH
        29tR/UEH8Uk3uKE6yVjLWUVBOvU9e9I8xJqUeb+iOQE1UJZ9eBdQBS1YX3auAHgy
        sx61dc3u26P0BdPN76bIr69AKeq86G6JwOD3zrbN5/rafLntwmvOfURweB3ID2vT
        WGsVgv2uh5A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2887856771;
        Tue, 13 Dec 2016 13:10:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 528F45676C;
        Tue, 13 Dec 2016 13:10:05 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Sixt <j6t@kdbg.org>, Klaus Ethgen <Klaus@Ethgen.ch>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] tmp-objdir: quote paths we add to alternates
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
        <20161212195355.znqlu44lgnke3ltc@sigill.intra.peff.net>
        <d83cd58f-9b52-cbc5-04dd-5aafe2822533@kdbg.org>
        <20161213114414.masgfo7lf7e3utym@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 10:10:04 -0800
In-Reply-To: <20161213114414.masgfo7lf7e3utym@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 06:44:15 -0500")
Message-ID: <xmqqwpf34s5f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FBBA50E-C15F-11E6-BEBE-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The naive conversion is just:
> ...
> -# MINGW does not allow colons in pathnames in the first place
> -test_expect_success !MINGW 'push to repo path with colon' '
> +if test_have_prereq MINGW
> +then
> +	path_sep=';'
> +else
> +	path_sep=':'
> +fi
> ...
> -	git clone --bare . xxx:yyy.git &&
> +	git clone --bare . xxx${path_sep}yyy.git &&

Don't you want to dq the whole thing to prevent the shell from
splitting this into two commands at ';'?  The other one below is OK.

>  
>  	echo change >>file.bin &&
>  	git commit -am change &&
>  	# Note that we have to use the full path here, or it gets confused
>  	# with the ssh host:path syntax.
> -	git push "$PWD/xxx:yyy.git" HEAD
> +	git push "$PWD/xxx${path_sep}yyy.git" HEAD
>  '
>  
>  test_done
>
> Does that work?
>
> -Peff
