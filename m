Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7134120954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbdLDO2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:28:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52020 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752466AbdLDO2p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:28:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 710D2C893E;
        Mon,  4 Dec 2017 09:28:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7keu0L4LaAZ05gfEeuW8POaIoqc=; b=BQKoDJ
        SroHuzLVtJXnXtG22N5T6pRBZW0E3V0a+b/HAXvYlw7BkJg3o2+trodu6EZE+yYZ
        GInbeWWjTxlQgNfOBS86RFNlaUzYfY6RpIsKA6oWsQzwa1ETizP8MJKu3nSnRGNJ
        4IC1Q9Kk0dYJuTxIV7cs5Oeu48PDWBz03Mj9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N07m7n+WcRTKgABPjdybh99SQ6v80auZ
        DFc0t87PDXgQ/wTKR7qm7F/j15jp1RxPlEDI4AKWCjyYowHcWvpTTlXMmjwJ0lkw
        TjrYBsRs/o/Uie9Y1PQI/pU3p5kYOPESDqHxMzJk8x0hTZM+nIlqSvOzsmGtrlVP
        hGyixrNItqI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6924DC893D;
        Mon,  4 Dec 2017 09:28:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D79F8C893C;
        Mon,  4 Dec 2017 09:28:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] diff: use skip_to_optional_val_default()
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
        <20171204125617.4931-4-chriscool@tuxfamily.org>
Date:   Mon, 04 Dec 2017 06:28:42 -0800
In-Reply-To: <20171204125617.4931-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 4 Dec 2017 13:56:17 +0100")
Message-ID: <xmqqd13uo9d1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6E6CC84A-D8FF-11E7-974F-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> -	} else if (!strcmp(arg, "--submodule"))
> -		options->submodule_format = DIFF_SUBMODULE_LOG;
> -	else if (skip_prefix(arg, "--submodule=", &arg))
> +	} else if (skip_to_optional_val_default(arg, "--submodule", &arg, "log"))
>  		return parse_submodule_opt(options, arg);

It may be annoying if we later diagnose that DIFF_SUBMODULE_LOG may
not be used in the context (e.g. together with some other optoins
that are set in "options" variable) and have to throw an error
message at the user.  parse_submodule_opt() would not know if that
string "log" came from the user or substituted by the helper, and in
the latter case, "don't use --submodule=log here" is a message that
is not quite appropriate.

This may be minor enough not matter in practice, but I dunno.  I
didn't look at other hunks in this step very carefully but I would
expect that whenever you use "default" to substitute, you'll have
the same information lossage.

