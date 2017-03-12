Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF94D202C1
	for <e@80x24.org>; Sun, 12 Mar 2017 17:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935174AbdCLRyV (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Mar 2017 13:54:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52059 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935061AbdCLRyT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2017 13:54:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E379A856C5;
        Sun, 12 Mar 2017 13:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oBRxVfNs5h+7iwZHt/5m5iIdcJU=; b=WX11SL
        83I2lbcu/UohatT0WbacHeXh9MZm7ylMtAtmW34tyygZQhjKDk/Vvc+g9R1Pa5KQ
        mkEllZC/A4y3KNVQgc6R23q5PZCOv2qYkA9bZ2FGn7QeuDgYZgE4tKCOcqYW4204
        kYKCQq8c9mGJAwYtWjlh/Pip8HkGmUJggLMYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ioVlyDNG6VvdgL8Gq+I7ii31/roiywJn
        40Zy3Xe1IlqcfQ2kjo6QlWzrn9jTdy/DMIzEHrkgiCwcBxBSGnBpnuG/Lj6OfcTK
        H4OgHf2KHhVT6VabHGstMuySvuWQMmfaBs9kU37BdJgoeizixpeucCQ+iFrNaY1A
        0xmAUoD4gtU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7D36856C4;
        Sun, 12 Mar 2017 13:54:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3EAD2856C3;
        Sun, 12 Mar 2017 13:54:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [RFC PATCH] Move SHA-1 implementation selection into a header file
References: <20170311222818.518541-1-sandals@crustytoothpaste.net>
        <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net>
Date:   Sun, 12 Mar 2017 10:54:16 -0700
In-Reply-To: <20170312130149.czir5hcbosqlmkhb@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 12 Mar 2017 09:01:49 -0400")
Message-ID: <xmqqfuiiv0s7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E964D66C-074C-11E7-9682-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/Makefile b/Makefile
> index 9f0eae428..0d65d50e9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -690,6 +690,7 @@ XDIFF_LIB = xdiff/lib.a
>  VCSSVN_LIB = vcs-svn/lib.a
>  
>  GENERATED_H += common-cmds.h
> +GENERATED_H += hash.h
> ...
> -BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
> -	$(COMPAT_CFLAGS)
> +BASIC_CFLAGS += $(COMPAT_CFLAGS)
>   ...
> +hash.h:
> +	$(QUIET_GEN)echo '#include $(SHA1_HEADER)' >$@+ && \
> +	{ cmp $@+ $@ >/dev/null 2>/dev/null || mv $@+ $@; }
> +

That looks sensible.  We do not have to adjust the code to update
GIT-BUILD-OPTIONS and friends in this patch because the current way
to force rebuilding when SHA1_HEADER changes is by letting
GIT-CFLAGS file notice the change, and the new "hash.h" itself will
let the $(MAKE) notice if a different hash implementation is chosen
for the build.


