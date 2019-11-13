Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60721F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 03:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfKMDsD (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 22:48:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57183 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfKMDsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 22:48:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9027BA4ABC;
        Tue, 12 Nov 2019 22:48:01 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Aku2jrIJOLcOuRn1r3mAADwpdqk=; b=x9figE
        BZhM9zUIhc7zYHypTWlLVdh1bw+qJtbpvkLSX4gHZsnjUhZY3WsWbE87JPaVlIIf
        nuPCPZHri5Z8ykHx5Nw8/4qHB1mYuvseVWttKHgg/rcBgG4/Fd83zwxdG4/bkQRm
        42ZyVTw99lUz1ukIuqltUcYeP0Ghz00XJXFcs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NWWg9+qvt/lKEYghKiIvQ2ZdM1ULVM/m
        lFirGKA5HREqqpfJGl68gbbqfrtSKQSccJCU3FZeRKuolt+t8kW09gaVYCs9XYeB
        g7MzrEMtd3NgK3wtcoVu1V3Zjl6f0RiwwbW3pF0O+xfvd9H1CWpI1wJhKkz0+blT
        Lg/4dz3KlZI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88A02A4ABB;
        Tue, 12 Nov 2019 22:48:01 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B783FA4AB8;
        Tue, 12 Nov 2019 22:47:58 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: do people find t5504.8 flaky?
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
        <20190423030254.GA19604@sigill.intra.peff.net>
        <20191113000747.GQ4348@szeder.dev>
        <20191113010337.GA20023@sigill.intra.peff.net>
Date:   Wed, 13 Nov 2019 12:47:56 +0900
In-Reply-To: <20191113010337.GA20023@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 12 Nov 2019 20:03:37 -0500")
Message-ID: <xmqqh838bfo3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 623825CC-05C8-11EA-9851-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So really, what we want for this case is to just get the remote status,
> like so:
>
> diff --git a/send-pack.c b/send-pack.c
> index 34c77cbb1a..d4db965b96 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -565,19 +565,19 @@ int send_pack(struct send_pack_args *args,
>  
>  	if (need_pack_data && cmds_sent) {
>  		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> -			for (ref = remote_refs; ref; ref = ref->next)
> -				ref->status = REF_STATUS_NONE;
>  			if (args->stateless_rpc)
>  				close(out);
>  			if (git_connection_is_socket(conn))
>  				shutdown(fd[0], SHUT_WR);
>  
>  			/*
>  			 * Do not even bother with the return value; we know we
> -			 * are failing, and just want the error() side effects.
> +			 * are failing, and just want the error() side effects,
> +			 * as well as marking refs with the remote status (if
> +			 * we get one).
>  			 */
>  			if (status_report)
> -				receive_unpack_status(&reader);
> +				receive_status(&reader, remote_refs);
>  
>  			if (use_sideband) {
>  				close(demux.out);
>
> I was worried at first that we might make things worse for the case that
> the network has hung up completely (which would cause pack-objects to
> fail, but also cause us to not get anything from the remote). But this
> is really no worse. Even in the existing code, we'd complain to stderr
> about trying to read the unpack status. And then when we read the remote
> ref status, as soon as we see a bad packet we just quietly stop reading
> (thus leaving any unmentioned refs as EXPECTING_REPORT).
>
> So with that second patch above, the test failure goes away for me.

Nicely analyzed and patched.

