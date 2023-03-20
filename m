Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A814C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 17:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjCTRQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 13:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjCTRQL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 13:16:11 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B9B311C8
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 10:12:03 -0700 (PDT)
Received: (qmail 18823 invoked by uid 109); 20 Mar 2023 17:10:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Mar 2023 17:10:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25102 invoked by uid 111); 20 Mar 2023 17:10:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 20 Mar 2023 13:10:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 20 Mar 2023 13:10:51 -0400
From:   Jeff King <peff@peff.net>
To:     Stanislav Malishevskiy via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Stanislav Malishevskiy <stanislav.malishevskiy@gmail.com>,
        Stanislav Malishevskiy <s.malishevskiy@auriga.com>
Subject: Re: [PATCH v2] http: add support for different sslcert and sslkey
 types.
Message-ID: <20230320171051.GA2615782@coredump.intra.peff.net>
References: <pull.1474.git.git.1679233875803.gitgitgadget@gmail.com>
 <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1474.v2.git.git.1679327330032.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 20, 2023 at 03:48:49PM +0000, Stanislav Malishevskiy via GitGitGadget wrote:

> From: Stanislav Malishevskiy <s.malishevskiy@auriga.com>
> 
> Basically git work with default curl ssl type - PEM. But for support
> eTokens like SafeNet tokens via pksc11 need setup 'ENG' as sslcert type
> and as sslkey type. So there added additional options for http to make
> that possible.

Seems like a reasonable thing to want, and the patch looks pretty clean.
Two small points:

>  http.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

There are no tests here. I think it might be possible to add them, but
our https test support is currently optional, and has bit-rotted a bit
over the years. There's some discussion here:

  https://lore.kernel.org/git/Y9s7vyHKXP+TQPRm@pobox.com/

So I don't think it makes sense to block this patch over the lack of
tests, but it's something we might keep in mind to add if the test
situation improves.

> @@ -1014,10 +1020,14 @@ static CURL *get_curl_handle(void)
>  
>  	if (ssl_cert)
>  		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
> +	if (ssl_cert_type)
> +		curl_easy_setopt(result, CURLOPT_SSLCERTTYPE, ssl_cert_type);

We're just feeding curl whatever string the user gave us (which is good,
since we don't know which ones are valid). But what happens with:

  GIT_SSL_CERT_TYPE=bogus git fetch ...

Should we check for an error here, or will the actual request later
complain properly?

-Peff
