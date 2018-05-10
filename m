Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DC5D1F406
	for <e@80x24.org>; Thu, 10 May 2018 15:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966231AbeEJPWY (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 11:22:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:34978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S964827AbeEJPWX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 11:22:23 -0400
Received: (qmail 7601 invoked by uid 109); 10 May 2018 15:22:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 May 2018 15:22:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25311 invoked by uid 111); 10 May 2018 15:22:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 10 May 2018 11:22:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2018 11:22:21 -0400
Date:   Thu, 10 May 2018 11:22:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 5/6] get_short_oid: sort ambiguous objects by type,
 then SHA-1
Message-ID: <20180510152221.GB6462@sigill.intra.peff.net>
References: <20180501184016.15061-10-avarab@gmail.com>
 <20180510124303.6020-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180510124303.6020-6-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 12:43:02PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Now we'll instead show:
> 
>     hint:   e8f2650052 tag v2.17.0
>     hint:   e8f21caf94 commit 2013-06-24 - bash prompt: print unique detached HEAD abbreviated object name
>     hint:   e8f26250fa commit 2017-02-03 - Merge pull request #996 from jeffhostetler/jeffhostetler/register_rename_src
>     hint:   e8f2bc0c06 commit 2015-05-10 - Documentation: note behavior for multiple remote.url entries
>     hint:   e8f2093055 tree
>     hint:   e8f25a3a50 tree
>     hint:   e8f28d537c tree
>     hint:   e8f2cf6ec0 tree
>     hint:   e8f21d02f7 blob
>     hint:   e8f21d577c blob
>     hint:   e8f2867228 blob
>     hint:   e8f2a35526 blob

I said already that I like the output, but this time I'll actually read
the code. ;)

It all looks good to me, with the exception of a few documentation nits
I'll mention below.

> A note on the implementation: Derrick rightly pointed out[1] that
> we're bending over backwards here in get_short_oid() to first
> de-duplicate the list, and then emit it, but could simply do it in one
> step.
> 
> The reason for that is that oid_array_for_each_unique() doesn't
> actually require that the array be sorted by oid_array_sort(), it just
> needs to be sorted in some order that guarantees that all objects with
> the same ID are adjacent to one another, which (barring a hash
> collision, which'll be someone else's problem) the sort_ambiguous()
> function does.

If we were to go this route, I think it would make sense to add a
sorting function pointer to "struct oid_array". I'm OK with punting on
it for now, though.

> diff --git a/Documentation/technical/api-oid-array.txt b/Documentation/technical/api-oid-array.txt
> index b0c11f868d..94b529722c 100644
> --- a/Documentation/technical/api-oid-array.txt
> +++ b/Documentation/technical/api-oid-array.txt
> @@ -35,13 +35,18 @@ Functions
>  	Free all memory associated with the array and return it to the
>  	initial, empty state.
>  
> +`oid_array_for_each`::
> +	Iterate over each element of the list, executing the callback
> +	function for each one. Does not sort the list, so any custom
> +	hash order is retained. If the callback returns a non-zero
> +	value, the iteration ends immediately and the callback's
> +	return is propagated; otherwise, 0 is returned.
> +
>  `oid_array_for_each_unique`::
> -	Efficiently iterate over each unique element of the list,
> -	executing the callback function for each one. If the array is
> -	not sorted, this function has the side effect of sorting it. If
> -	the callback returns a non-zero value, the iteration ends
> -	immediately and the callback's return is propagated; otherwise,
> -	0 is returned.
> +	Iterate over each unique element of the list in sort order ,
> +	but otherwise behaves like `oid_array_for_each`. If the array
> +	is not sorted, this function has the side effect of sorting
> +	it.

Extra space in "sort order ,".

I'd probably say "sorted order", but that might be a matter of
preference.

Also, your parallel verb tenses don't agree. ;) It should be "Iterate
... but otherwise behave", not "behaves".

> +	/*
> +	 * Between object types show tags, then commits, and finally
> +	 * trees and blobs.
> +	 *
> +	 * The object_type enum is commit, tree, blob, tag, but we
> +	 * want tag, commit, tree blob. Cleverly (perhaps too
> +	 * cleverly) do that with modulus, since the enum assigns 1 to
> +	 * commit, so tag becomes 0.
> +	 */
> +	a_type_sort = a_type % 4;
> +	b_type_sort = b_type % 4;
> +	return a_type_sort > b_type_sort ? 1 : -1;

This is amusingly clever, and should be very efficient. I'm glad there's
a comment at least, though.

-Peff
