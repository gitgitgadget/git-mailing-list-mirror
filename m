Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 017671F404
	for <e@80x24.org>; Thu,  4 Jan 2018 17:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbeADRoX (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 12:44:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:43230 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751656AbeADRoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 12:44:22 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F20E7844DA;
        Thu,  4 Jan 2018 12:44:20 -0500 (EST)
Received: from [192.168.1.71] (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 64468844C7;
        Thu,  4 Jan 2018 12:44:20 -0500 (EST)
Subject: Re: [PATCH 10/40] external-odb: implement external_odb_get_direct
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-11-chriscool@tuxfamily.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <4ce872c0-8f4b-602a-9ee3-cf429cc6a146@jeffhostetler.com>
Date:   Thu, 4 Jan 2018 12:44:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180103163403.11303-11-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/3/2018 11:33 AM, Christian Couder wrote:
> This is implemented only in the promisor remote mode
> for now by calling fetch_object().
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>   external-odb.c | 15 +++++++++++++++
>   external-odb.h |  1 +
>   odb-helper.c   | 13 +++++++++++++
>   odb-helper.h   |  3 ++-
>   4 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/external-odb.c b/external-odb.c
> index d26e63d8b1..5d0afb9762 100644
> --- a/external-odb.c
> +++ b/external-odb.c
> @@ -76,3 +76,18 @@ int external_odb_has_object(const unsigned char *sha1)
>   			return 1;
>   	return 0;
>   }
> +
> +int external_odb_get_direct(const unsigned char *sha1)
> +{
> +	struct odb_helper *o;
> +
> +	external_odb_init();
> +
> +	for (o = helpers; o; o = o->next) {
> +		if (odb_helper_get_direct(o, sha1) < 0)
> +			continue;
> +		return 0;
 > +	}

Would this be simpler said as:
	for (o = ...)
		if (!odb_helper_get_direct(...))
			return 0;


> +
> +	return -1;
> +}
> diff --git a/external-odb.h b/external-odb.h
> index 9a3c2f01b3..fd6708163e 100644
> --- a/external-odb.h
> +++ b/external-odb.h
> @@ -4,5 +4,6 @@
>   extern int has_external_odb(void);
>   extern const char *external_odb_root(void);
>   extern int external_odb_has_object(const unsigned char *sha1);
> +extern int external_odb_get_direct(const unsigned char *sha1);
>   
>   #endif /* EXTERNAL_ODB_H */
> diff --git a/odb-helper.c b/odb-helper.c
> index 1404393807..4b70b287af 100644
> --- a/odb-helper.c
> +++ b/odb-helper.c
> @@ -4,6 +4,7 @@
>   #include "odb-helper.h"
>   #include "run-command.h"
>   #include "sha1-lookup.h"
> +#include "fetch-object.h"
>   
>   struct odb_helper *odb_helper_new(const char *name, int namelen)
>   {
> @@ -52,3 +53,15 @@ int odb_helper_has_object(struct odb_helper *o, const unsigned char *sha1)
>   	return !!odb_helper_lookup(o, sha1);
>   }
>   
> +int odb_helper_get_direct(struct odb_helper *o,
> +			  const unsigned char *sha1)
> +{
> +	int res = 0;
> +	uint64_t start = getnanotime();
> +
> +	fetch_object(o->dealer, sha1);
> +
> +	trace_performance_since(start, "odb_helper_get_direct");
> +
> +	return res;

'res' will always be 0, so the external_odb_get_direct() will
only do the first helper.  i haven't looked at the rest of the
series yet, so maybe you've already addressed this.

Also, I put a TODO comment in the fetch_object() header to
consider returning an error/success, so maybe that could help
here too.

> +}
> diff --git a/odb-helper.h b/odb-helper.h
> index 9395e606ce..f4bc66b0ef 100644
> --- a/odb-helper.h
> +++ b/odb-helper.h
> @@ -20,5 +20,6 @@ struct odb_helper {
>   extern struct odb_helper *odb_helper_new(const char *name, int namelen);
>   extern int odb_helper_has_object(struct odb_helper *o,
>   				 const unsigned char *sha1);
> -
> +extern int odb_helper_get_direct(struct odb_helper *o,
> +				 const unsigned char *sha1);
>   #endif /* ODB_HELPER_H */
> 
