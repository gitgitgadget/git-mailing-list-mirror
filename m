Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB22CE79A1
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 21:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjIYVL0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjIYVLZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 17:11:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B786109
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 14:11:19 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 642571CB5BE;
        Mon, 25 Sep 2023 17:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=41lQIci0EJ/tDVqeqFrcXrkXFzMf9D0arAqGRq
        701Ac=; b=BGsYUNN6HzwVDL/rjbQNYo0TswCN7d2VIJx6vIdshaNxxEPTYpC028
        +Cid0J3IdQRdVz5BxT8T/jiL+J//gVj+2DSAEu24Md99KL9wwVt3LtTiIH0y01KK
        Dst106Rw4mj3KcCZUxRMnHm94YXToPyCCa1QedF3M0VOiKwCCF3IE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B5421CB5BD;
        Mon, 25 Sep 2023 17:11:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BB44A1CB5BC;
        Mon, 25 Sep 2023 17:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 1/3] transport-helper: no connection restriction in
 connect_helper
In-Reply-To: <20230923152201.14741-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Sat, 23 Sep 2023 23:21:59 +0800")
References: <xmqqy1h2f5dv.fsf@gitster.g>
        <20230923152201.14741-2-worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 14:11:16 -0700
Message-ID: <xmqqjzserma3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 116AEFF6-5BE8-11EE-8659-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Remove the restriction in the "connect_helper()" function and give the
> function "process_connect_service()" the opportunity to establish a
> connection using ".connect" or ".stateless_connect" for protocol v2. So
> we can connect with a stateless-rpc and do something useful. E.g., in a
> later commit, implements remote archive for a repository over HTTP
> protocol.

OK.  Given that process_connect_service() does this:

	if (data->connect) {
		strbuf_addf(&cmdbuf, "connect %s\n", name);
		ret = run_connect(transport, &cmdbuf);
	} else if (data->stateless_connect &&
		   (get_protocol_version_config() == protocol_v2) &&
		   (!strcmp("git-upload-pack", name) ||
		    !strcmp("git-upload-archive", name))) {
		strbuf_addf(&cmdbuf, "stateless-connect %s\n", name);
		ret = run_connect(transport, &cmdbuf);
		if (ret)
			transport->stateless_rpc = 1;
	}

in the spirit of the original "safety valve", it becomes tempting to
suggest we make sure at least .connect or .stateless_connect exists
in the transport to be safe, but then we will need to keep the logic
of safety valve in connect_helper() and the actual dispatching in
process_connect_service() in sync, which is a maintenance burden.

It however makes me wonder if we should add

	else
		die(_("operation not supported by protocol"));

at the end of the "if/else if" cascade in process_connect_service(),
so that callers that end up following this callpath with a transport
that defines neither would be caught.

Other than that, the patch is as good as the previous round, and the
explanation is vastly easier to understand.

Thanks.

> Helped-by: Junio C Hamano <gitster@pobox.com>
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
