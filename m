Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6521420954
	for <e@80x24.org>; Thu,  7 Dec 2017 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdLGSvC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 13:51:02 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50227 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750882AbdLGSvB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 13:51:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F1EFC26E6;
        Thu,  7 Dec 2017 13:51:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9XZFP4UEwUOSz+YDSOX4/daCE8c=; b=vt72wt
        HEAgwC4iJFdBoA6I4tKrfisNPNcjZVNntZjKXlcOJNxoc3yw4bkHVz9jECjzpQb8
        AboBbv7MkHgOgHYSCzcdbOgA+BtEJuDHxQXQozDMoDg7bnpuXY3LOXrVusckTaVp
        ics1d4dKg2eGuG4JGbHM0GjSYEdLPFILumWCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PQCH7u+63kjN7FHrxjMmOVNXFwaoOIIk
        tUc9q/dTrMp3rfG3/p/pmUsjVAnZEpJ6nBXkpeeIGGqaRR+IwHH701HFmMgo+StZ
        9xgIlAI99cFEtAUZed8Jm+ulZm352esIjLPbMU5aTDnh7kKYoJiPZMVViJOnPchU
        vuoh4gsUshk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83D1BC26E5;
        Thu,  7 Dec 2017 13:51:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E2C69C26E4;
        Thu,  7 Dec 2017 13:50:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [WIP 08/15] connect: discover protocol version outside of get_remote_heads
References: <20171020171839.4188-1-bmwill@google.com>
        <20171204235823.63299-1-bmwill@google.com>
        <20171204235823.63299-9-bmwill@google.com>
Date:   Thu, 07 Dec 2017 10:50:58 -0800
In-Reply-To: <20171204235823.63299-9-bmwill@google.com> (Brandon Williams's
        message of "Mon, 4 Dec 2017 15:58:16 -0800")
Message-ID: <xmqq7etye5il.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 911434C8-DB7F-11E7-83E4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> @@ -193,7 +195,17 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>  		if (!conn)
>  			return args.diag_url ? 0 : 1;
>  	}
> -	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
> +
> +	packet_reader_init(&reader, fd[0], NULL, 0);
> +
> +	switch (discover_version(&reader)) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		get_remote_heads(&reader, &ref, 0, NULL, &shallow);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}

We see quite a few hunks just like this one appear in this patch.
The repetition is a bit disturbing.  I wonder if we want a wrapper
around the "reader-init && discover-version && return an error if
the protocol version is not known" dance.  That would allow us to
write this part of the code like so:

	struct packet_reader reader;

	if (connection_preamble(&reader, fd[0]))
		die("unknown protocol version");
	get_remote_heads(&reader, &ref, 0, NULL, &shallow);

or something like that.

By the way, is that really a BUG()?  Getting a connection and the
other end declaring a protocol version you do not yet understand is
not a bug in your program---it is a normal runtime error, no?
