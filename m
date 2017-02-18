Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB78201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 01:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbdBRBYi (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 20:24:38 -0500
Received: from avasout04.plus.net ([212.159.14.19]:47328 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752071AbdBRBYh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 20:24:37 -0500
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout04 with smtp
        id m1Qa1u00222aPyA011QbY6; Sat, 18 Feb 2017 01:24:35 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=Groywg9C c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=iKrn8l-KAAAA:8 a=lKq3IniVJJsc8X6z9u8A:9 a=QEXdDO2ut3YA:10
 a=vz8bQswTWcriz0i0jksL:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v3 16/19] sha1_file: introduce an nth_packed_object_oid
 function
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-17-sandals@crustytoothpaste.net>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <fc5aff14-a047-1a51-c40c-8918098f1f59@ramsayjones.plus.com>
Date:   Sat, 18 Feb 2017 01:24:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170218000652.375129-17-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18/02/17 00:06, brian m. carlson wrote:
> There are places in the code where we would like to provide a struct
> object_id *, yet read the hash directly from the pack.  Provide an
> nth_packed_object_oid function that is similar to the
> nth_packed_object_sha1 function.
> 
> In order to avoid a potentially invalid cast, nth_packed_object_oid
> provides a variable into which to store the value, which it returns on
> success; on error, it returns NULL, as nth_packed_object_sha1 does.
> 
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  cache.h     |  6 ++++++
>  sha1_file.c | 17 ++++++++++++++---
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index e03a672d15..4f3bfc5ee7 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1608,6 +1608,12 @@ extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
>   * error.
>   */
>  extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
> +/*
> + * Like nth_packed_object_oid, but write the data into the object specified by
                             ^^^
... Like nth_packed_object_sha1, but ...

Having said that, if the intent is to eventually replace that function with
the new nth_packed_object_oid(), then it is probably not a good idea to
describe this function in terms of the function it will obsolete. ;-)

ATB,
Ramsay Jones

> + * the the first argument.  Returns the first argument on success, and NULL on
> + * error.
> + */
> +extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
>  
>  /*
>   * Return the offset of the nth object within the specified packfile.
> diff --git a/sha1_file.c b/sha1_file.c
> index ec957db5e1..777b8e8eae 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2628,6 +2628,17 @@ const unsigned char *nth_packed_object_sha1(struct packed_git *p,
>  	}
>  }
>  
> +const struct object_id *nth_packed_object_oid(struct object_id *oid,
> +					      struct packed_git *p,
> +					      uint32_t n)
> +{
> +	const unsigned char *hash = nth_packed_object_sha1(p, n);
> +	if (!hash)
> +		return NULL;
> +	hashcpy(oid->hash, hash);
> +	return oid;
> +}
> +
>  void check_pack_index_ptr(const struct packed_git *p, const void *vptr)
>  {
>  	const unsigned char *ptr = vptr;
> @@ -3788,13 +3799,13 @@ static int for_each_object_in_pack(struct packed_git *p, each_packed_object_fn c
>  	int r = 0;
>  
>  	for (i = 0; i < p->num_objects; i++) {
> -		const unsigned char *sha1 = nth_packed_object_sha1(p, i);
> +		struct object_id oid;
>  
> -		if (!sha1)
> +		if (!nth_packed_object_oid(&oid, p, i))
>  			return error("unable to get sha1 of object %u in %s",
>  				     i, p->pack_name);
>  
> -		r = cb(sha1, p, i, data);
> +		r = cb(oid.hash, p, i, data);
>  		if (r)
>  			break;
>  	}
> 
