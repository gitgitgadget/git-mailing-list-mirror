Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15D5C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352378AbiFMVdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352446AbiFMVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:33:01 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DEBE0C
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:32:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5AB6198D2E;
        Mon, 13 Jun 2022 17:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o2jUdzMc+d/yZrMaWlgDLAAvaiPd4co9jO8Vjp
        33PzQ=; b=yPmD1hzFG7p5+eBjEQIHKwu1lGGZUGowU7aJNXwW1EZoReeO+uNjUj
        KBLZkKSneV59Jt18164EnbBkIPeNtK+y+ivtrIe3zE5uR46IjktAa8HcJb+PkZqX
        q8llPTmfoWR94I7UyE+YUzon4Kn7chcFN3Wy4KRTHRChGxDam31Ik=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DD715198D2C;
        Mon, 13 Jun 2022 17:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 82E41198D2B;
        Mon, 13 Jun 2022 17:32:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>
Subject: Re: [PATCH v3] remote-curl: send Accept-Language header to server
References: <pull.1251.v2.git.1654756523475.gitgitgadget@gmail.com>
        <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com>
Date:   Mon, 13 Jun 2022 14:32:23 -0700
In-Reply-To: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Sun, 12 Jun 2022 17:20:21
        +0000")
Message-ID: <xmqq1qvs5jx4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 50BC1648-EB60-11EC-9A0D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> @@ -932,6 +933,10 @@ static int post_rpc(struct rpc_state *rpc, int stateless_connect, int flush_rece
>  	headers = curl_slist_append(headers, needs_100_continue ?
>  		"Expect: 100-continue" : "Expect:");
>  
> +	/* Add Accept-Language header */
> +	if (rpc->hdr_accept_language)
> +		headers = curl_slist_append(headers, rpc->hdr_accept_language);
> +
>  	/* Add the extra Git-Protocol header */
>  	if (rpc->protocol_header)
>  		headers = curl_slist_append(headers, rpc->protocol_header);
> @@ -1080,6 +1085,8 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
>  	strbuf_addf(&buf, "%s%s", url.buf, svc);
>  	rpc->service_url = strbuf_detach(&buf, NULL);
>  
> +	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());
> +
>  	strbuf_addf(&buf, "Content-Type: application/x-%s-request", svc);
>  	rpc->hdr_content_type = strbuf_detach(&buf, NULL);
>  
> @@ -1118,6 +1125,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
>  	free(rpc->service_url);
>  	free(rpc->hdr_content_type);
>  	free(rpc->hdr_accept);
> +	free(rpc->hdr_accept_language);
>  	free(rpc->protocol_header);
>  	free(rpc->buf);
>  	strbuf_release(&buf);
> @@ -1400,6 +1408,7 @@ static int stateless_connect(const char *service_name)
>  	struct discovery *discover;
>  	struct rpc_state rpc;
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *accept_language;
>  
>  	/*
>  	 * Run the info/refs request and see if the server supports protocol
> @@ -1418,6 +1427,9 @@ static int stateless_connect(const char *service_name)
>  		printf("\n");
>  		fflush(stdout);
>  	}
> +	accept_language = http_get_accept_language_header();
> +	if (accept_language)
> +		rpc.hdr_accept_language = xstrfmt("%s", accept_language);

Isn't rpc.hdr_accept_language left uninitialized garbage if
accept_language is NULL?  It is the same bug I pointed out earlier,
whose fix may have to be different.

Has this been tested?  I got immediate segfault with this patch in
'seen'.

