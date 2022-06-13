Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF73C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 19:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbiFMTow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiFMToc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 15:44:32 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F953813F5
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 11:15:21 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 166E2136206;
        Mon, 13 Jun 2022 14:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wt1k7vm4b+1joqNAI698WUNZIqWBjB7ya0eP8h
        FcyzE=; b=LeiupI1HUx/gdJyY+QjTsgzgQecptpwVKuvXcbE1UtsMI5DrUo/Q7+
        nfAx9FSfqWsh/mlxkF9l6SBIqtbYtg51DTymjSU94IypkRCvgMaC/fcMREAYhzB0
        jzx97Z/EmiATPOyMoyJ2xv+fG60zirCmaR4dQ02xF8/4dinZqcTE0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D62E136205;
        Mon, 13 Jun 2022 14:15:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 67677136204;
        Mon, 13 Jun 2022 14:15:17 -0400 (EDT)
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
Date:   Mon, 13 Jun 2022 11:15:16 -0700
In-Reply-To: <pull.1251.v3.git.1655054421697.gitgitgadget@gmail.com> (Li
        Linchao via GitGitGadget's message of "Sun, 12 Jun 2022 17:20:21
        +0000")
Message-ID: <xmqqk09k77m3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C73A43D8-EB44-11EC-A4C6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Li Linchao via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Range-diff vs v2:
>
>  1:  a2dd9d4070e ! 1:  99a4e23ceb1 remote-curl: send Accept-Language header to server
>      @@ Commit message
>           remote-curl: send Accept-Language header to server
>       
>           Git server end's ability to accept Accept-Language header was introduced
>      -    in f18604bbf2(http: add Accept-Language header if possible), but this is
>      -    only used by very early phase of the transfer, that's HTTP GET request to
>      -    discover references. For other phases, like POST request in the smart HTTP
>      -    the server side don't know what language the client speaks.
>      +    in f18604bbf2 (http: add Accept-Language header if possible, 2015-01-28),
>      +    but this is only used by very early phase of the transfer, which is HTTP
>      +    GET request to discover references. For other phases, like POST request
>      +    in the smart HTTP, the server does not know what language the client
>      +    speaks.


OK.

>      -+	accept_language = http_get_accept_language_header();
>      -+	if (accept_language) {
>      -+		strbuf_addstr(&buf, accept_language);
>      -+		rpc->hdr_accept_language = strbuf_detach(&buf, NULL);
>      -+	}
>      ++	rpc->hdr_accept_language = xstrdup_or_null(http_get_accept_language_header());

Nice.

>      +@@ remote-curl.c: static int rpc_service(struct rpc_state *rpc, struct discovery *heads,
>      + 	free(rpc->service_url);
>      + 	free(rpc->hdr_content_type);
>      + 	free(rpc->hdr_accept);
>      ++	free(rpc->hdr_accept_language);
>      + 	free(rpc->protocol_header);
>      + 	free(rpc->buf);
>      + 	strbuf_release(&buf);

OK.

>      +@@ remote-curl.c: static int stateless_connect(const char *service_name)
>      + 	free(rpc.service_url);
>      + 	free(rpc.hdr_content_type);
>      + 	free(rpc.hdr_accept);
>      ++	free(rpc.hdr_accept_language);
>      + 	free(rpc.protocol_header);
>      + 	free(rpc.buf);
>      + 	strbuf_release(&buf);

OK.

Thanks.  Will queue.
