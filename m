Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87D01F404
	for <e@80x24.org>; Thu,  1 Feb 2018 19:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeBATQZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 14:16:25 -0500
Received: from siwi.pair.com ([209.68.5.199]:60581 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753197AbeBATQY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 14:16:24 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 93D2184585;
        Thu,  1 Feb 2018 14:16:23 -0500 (EST)
Received: from [10.160.98.99] (unknown [167.220.148.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 32DB48457F;
        Thu,  1 Feb 2018 14:16:23 -0500 (EST)
Subject: Re: [PATCH 12/26] ls-refs: introduce ls-refs server command
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-13-bmwill@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e2fb1a05-3cbd-5226-7796-c5b89c9d3955@jeffhostetler.com>
Date:   Thu, 1 Feb 2018 14:16:22 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180103001828.205012-13-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/2/2018 7:18 PM, Brandon Williams wrote:
> Introduce the ls-refs server command.  In protocol v2, the ls-refs
> command is used to request the ref advertisement from the server.  Since
> it is a command which can be requested (as opposed to mandatory in v1),
> a client can sent a number of parameters in its request to limit the ref
> advertisement based on provided ref-patterns.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>   Documentation/technical/protocol-v2.txt | 26 +++++++++
>   Makefile                                |  1 +
>   ls-refs.c                               | 97 +++++++++++++++++++++++++++++++++
>   ls-refs.h                               |  9 +++
>   serve.c                                 |  2 +
>   5 files changed, 135 insertions(+)
>   create mode 100644 ls-refs.c
>   create mode 100644 ls-refs.h
> 
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index b87ba3816..5f4d0e719 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -89,3 +89,29 @@ terminate the connection.
>   Commands are the core actions that a client wants to perform (fetch, push,
>   etc).  Each command will be provided with a list capabilities and
>   arguments as requested by a client.
> +
> + Ls-refs
> +---------
> +
> +Ls-refs is the command used to request a reference advertisement in v2.
> +Unlike the current reference advertisement, ls-refs takes in parameters
> +which can be used to limit the refs sent from the server.
> +
> +Ls-ref takes in the following parameters wraped in packet-lines:
> +
> +  symrefs: In addition to the object pointed by it, show the underlying
> +	   ref pointed by it when showing a symbolic ref.
> +  peel: Show peeled tags.
> +  ref-pattern <pattern>: When specified, only references matching the
> +			 given patterns are displayed.
> +
> +The output of ls-refs is as follows:
> +
> +    output = *ref
> +	     flush-pkt
> +    ref = PKT-LINE((tip | peeled) LF)
> +    tip = obj-id SP refname (SP symref-target)
> +    peeled = obj-id SP refname "^{}"
> +
> +    symref = PKT-LINE("symref" SP symbolic-ref SP resolved-ref LF)
> +    shallow = PKT-LINE("shallow" SP obj-id LF)

Do you want to talk about ordering requirements on this?
I think packed-refs has one, but I'm not sure it matters here
where the client or server sorts it.

Are there any provisions for compressing the renames, like in the
reftable spec or in index-v4 ?

It doesn't need to be in the initial version.  Just asking.  We could
always add a "ls-refs-2" command that builds upon this.

Thanks,
Jeff
