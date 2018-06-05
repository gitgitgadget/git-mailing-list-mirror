Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905E91F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752091AbeFETLf (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:11:35 -0400
Received: from avasout01.plus.net ([84.93.230.227]:51749 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752052AbeFETLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:11:34 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id QHMifuFZpeLIJQHMjfRPjg; Tue, 05 Jun 2018 20:11:33 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Y6bWTCWN c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=1XWaLZrsAAAA:8 a=iVOjKs69Pf87B1Our74A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 2/8] upload-pack: implement ref-in-want
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
References: <20180605175144.4225-1-bmwill@google.com>
 <20180605175144.4225-3-bmwill@google.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4c134e17-bf63-0bf8-c014-edbe4d1239ad@ramsayjones.plus.com>
Date:   Tue, 5 Jun 2018 20:11:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605175144.4225-3-bmwill@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNudWcUhsC6EOSMV/cK31bRQRjw2WLGFr8lruKX7zxdgX3n0FYXheJrL9fbNDYoVoz3PlHjLyQFTiBcvjCnNSGME9hppvBSbOZ/lmcuQEWeLCRA2jv1U
 30u+QhCVlFIT5GClSh4zuWPyI74A4kdfa+WkoyOGUMkn1IQ01WiS+76Qjz6l0HKr0cGW9DLMpE6F8Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 05/06/18 18:51, Brandon Williams wrote:
> Currently, while performing packfile negotiation, clients are only
> allowed to specify their desired objects using object ids.  This causes
> a vulnerability to failure when an object turns non-existent during
> negotiation, which may happen if, for example, the desired repository is
> provided by multiple Git servers in a load-balancing arrangement.
> 
> In order to eliminate this vulnerability, implement the ref-in-want
> feature for the 'fetch' command in protocol version 2.  This feature
> enables the 'fetch' command to support requests in the form of ref names
> through a new "want-ref <ref>" parameter.  At the conclusion of
> negotiation, the server will send a list of all of the wanted references
> (as provided by "want-ref" lines) in addition to the generated packfile.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt                |   4 +
>  Documentation/technical/protocol-v2.txt |  28 ++++-
>  t/t5703-upload-pack-ref-in-want.sh      | 153 ++++++++++++++++++++++++
>  upload-pack.c                           |  64 ++++++++++
>  4 files changed, 248 insertions(+), 1 deletion(-)
>  create mode 100755 t/t5703-upload-pack-ref-in-want.sh
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index ab641bf5a..acafe6c8d 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3479,6 +3479,10 @@ Note that this configuration variable is ignored if it is seen in the
>  repository-level config (this is a safety measure against fetching from
>  untrusted repositories).
>  
> +uploadpack.allowRefInWant::
> +	If this option is set, `upload-pack` will support the `ref-in-want`
> +	feature of the protocol version 2 `fetch` command.
> +
>  url.<base>.insteadOf::
>  	Any URL that starts with this value will be rewritten to
>  	start, instead, with <base>. In cases where some site serves a
> diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
> index 49bda76d2..8367e09b8 100644
> --- a/Documentation/technical/protocol-v2.txt
> +++ b/Documentation/technical/protocol-v2.txt
> @@ -299,12 +299,21 @@ included in the client's request:
>  	for use with partial clone and partial fetch operations. See
>  	`rev-list` for possible "filter-spec" values.
>  
> +If the 'ref-in-want' feature is advertised, the following argument can
> +be included in the client's request as well as the potential addition of
> +the 'wanted-refs' section in the server's response as explained below.
> +
> +    want-ref <ref>
> +	Indicates to the server than the client wants to retrieve a
> +	particular ref, where <ref> is the full name of a ref on the
> +	server.
> +
>  The response of `fetch` is broken into a number of sections separated by
>  delimiter packets (0001), with each section beginning with its section
>  header.
>  
>      output = *section
> -    section = (acknowledgments | shallow-info | packfile)
> +    section = (acknowledgments | shallow-info | wanted-refs | packfile)
>  	      (flush-pkt | delim-pkt)
>  
>      acknowledgments = PKT-LINE("acknowledgments" LF)
> @@ -319,6 +328,10 @@ header.
>      shallow = "shallow" SP obj-id
>      unshallow = "unshallow" SP obj-id
>  
> +    wanted-refs = PKT-LINE("wanted-refs" LF)
> +		  *PKT-Line(wanted-ref LF)

s/PKT-Line/PKT-LINE/

ATB,
Ramsay Jones

