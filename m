Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907B3CE79A8
	for <git@archiver.kernel.org>; Tue, 19 Sep 2023 17:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjISRTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Sep 2023 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjISRTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2023 13:19:05 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE429F
        for <git@vger.kernel.org>; Tue, 19 Sep 2023 10:18:59 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 011A02C6F1;
        Tue, 19 Sep 2023 13:18:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=TrG0b0ip4tPidpi+PUiELIu/YTv1JQB5olnxvY
        q2eSQ=; b=Zo0vafRTYZU0oCihxw9AHFfrmIKu9ebuqxc3umw1uXlfGd6K7hR8aL
        JjEYSYo7WUTC1aiAxtUd+pjyMvtvwtZ12+b83UqptVAPmxxjkI8rMKr+jgV+nygw
        dC1tq0xe32B1ZbPoIAqXsw9StPp/6w54+ZW9SQOVY62A/5p9DLCv4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ECF002C6F0;
        Tue, 19 Sep 2023 13:18:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7D7FC2C6EE;
        Tue, 19 Sep 2023 13:18:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 1/2] transport-helper: no connection restriction in
 connect_helper
In-Reply-To: <20230919064156.13892-1-worldhello.net@gmail.com> (Jiang Xin's
        message of "Tue, 19 Sep 2023 14:41:55 +0800")
References: <20230919064156.13892-1-worldhello.net@gmail.com>
Date:   Tue, 19 Sep 2023 10:18:52 -0700
Message-ID: <xmqqy1h2f5dv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C1CCFCA-5710-11EE-924F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> For protocol-v2, "stateless-connection" can be used to establish a
> stateless connection between the client and the server, but trying to
> establish http connection by calling "transport->vtable->connect" will
> fail. This restriction was first introduced in commit b236752a87
> (Support remote archive from all smart transports, 2009-12-09) by
> adding a limitation in the "connect_helper()" function.

The above description may not be technically wrong per-se, but I
found it confusing.  The ".connect method must be defined" you are
removing was added back when there was no "stateless" variant of the
connection initiation.  Many codepaths added by that patch did "if
.connect is there, call it, but otherwise die()" and I think the
code you were removing was added as a safety valve, not a limitation
or restriction.  Later, process_connect_service() learned to handle
the .stateless_connect bit as a fallback for transports without
.connect method defined, and the commit added that feature, edc9caf7
(transport-helper: introduce stateless-connect, 2018-03-15), forgot
that the caller did not allow this fallback.

	When b236752a (Support remote archive from all smart
	transports, 2009-12-09) added "remote archive" support for
	"smart transports", it was for transport that supports the
	.connect method.  connect_helper() function protected itself
	from getting called for a transport without the method
	before calling process_connect_service(), which did not work
	wuth such a transport.

	Later, edc9caf7 (transport-helper: introduce
	stateless-connect, 2018-03-15) added a way for a transport
	without the .connect method to establish a "stateless"
	connection in protocol-v2, process_connect_service() was
	taught to handle the "stateless" connection, making the old
	safety valve in its caller that insisted that .connect
	method must be defined too strict, and forgot to loosen it.

or something along that line would have been easire to follow, at
least to me.

> Remove the restriction in the "connect_helper()" function and use the
> logic in the "process_connect_service()" function to check the protocol
> version and service name. By this way, we can make a connection and do
> something useful. E.g., in a later commit, implements remote archive
> for a repository over HTTP protocol.

OK.  

b236752a87 was to allow "remote archive from all smart transports",
but unfortunately HTTP was not among "smart transports".  This
series is to update smart HTTP transport (aka "stateless") to also
support it?  Interesting.

> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  transport-helper.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/transport-helper.c b/transport-helper.c
> index 49811ef176..2e127d24a5 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -662,8 +662,6 @@ static int connect_helper(struct transport *transport, const char *name,
>  
>  	/* Get_helper so connect is inited. */
>  	get_helper(transport);
> -	if (!data->connect)
> -		die(_("operation not supported by protocol"));
>  
>  	if (!process_connect_service(transport, name, exec))
>  		die(_("can't connect to subservice %s"), name);
