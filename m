Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B5C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 16:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347220AbiCPQ5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 12:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbiCPQ5n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 12:57:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EB24A92D
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 09:56:28 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7A4C216D3FE;
        Wed, 16 Mar 2022 12:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jYGsiLbFp1h5BCr7NBhf5IapsXaLc0ap2WZdUV
        WdCXI=; b=rPTXJ0xXVeTa0xDWhpNlChU8yCAag/4cG/mjQCGW5uAzbjmxaYeeBn
        lR1drMxTlpyQeC4NsTdmT2/L5Sva27kSm5eobEsT3vurKaUFegfgZ9Xu5FwbJql0
        Y3wBJ6p/hPWRbV5yZ0S+cvPJ8vWKXRwgDS9n1Jf81T/FFcfdCySic=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72BA416D3FD;
        Wed, 16 Mar 2022 12:56:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E696B16D3FC;
        Wed, 16 Mar 2022 12:56:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 3/6] object-name: make get_oid quietly return an error
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
        <20220310173236.4165310-4-sandals@crustytoothpaste.net>
Date:   Wed, 16 Mar 2022 09:56:22 -0700
In-Reply-To: <20220310173236.4165310-4-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 10 Mar 2022 17:32:33 +0000")
Message-ID: <xmqqo825n8eh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 027D7CA8-A54A-11EC-8FC1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> A reasonable person looking at the signature and usage of get_oid and
> friends might conclude that in the event of an error, it always returns
> -1.  However, this is not the case.  Instead, get_oid_basic dies if we
> go too far back into the history of a reflog (or, when quiet, simply
> exits).
>
> This is not especially useful, since in many cases, we might want to
> handle this error differently.  Let's add a flag here to make it just
> return -1 like elsewhere in these code paths.
>
> Note that we cannot make this behavior the default, since we have many
> other codepaths that rely on the existing behavior, including in tests.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  cache.h       | 21 +++++++++++----------
>  object-name.c |  6 +++++-
>  2 files changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 825ec17198..416a9d9983 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1366,16 +1366,17 @@ struct object_context {
>  	char *path;
>  };
>  
> -#define GET_OID_QUIETLY           01
> -#define GET_OID_COMMIT            02
> -#define GET_OID_COMMITTISH        04
> -#define GET_OID_TREE             010
> -#define GET_OID_TREEISH          020
> -#define GET_OID_BLOB             040
> -#define GET_OID_FOLLOW_SYMLINKS 0100
> -#define GET_OID_RECORD_PATH     0200
> -#define GET_OID_ONLY_TO_DIE    04000
> -#define GET_OID_REQUIRE_PATH  010000
> +#define GET_OID_QUIETLY            01
> +#define GET_OID_COMMIT             02
> +#define GET_OID_COMMITTISH         04
> +#define GET_OID_TREE              010
> +#define GET_OID_TREEISH           020
> +#define GET_OID_BLOB              040
> +#define GET_OID_FOLLOW_SYMLINKS  0100
> +#define GET_OID_RECORD_PATH      0200
> +#define GET_OID_ONLY_TO_DIE     04000
> +#define GET_OID_REQUIRE_PATH   010000
> +#define GET_OID_RETURN_FAILURE 020000

I do not think we want this change.  The next time somebody adds an
overly long symbol, we reformat all the lines, making it hard to
spot that the change is only adding a single new symbol?

I think we'd rather go the other way not to tempt people into
right-aligning these constants, either by rewriting them into

	#define GET_OID_QUIETLY<TAB>(1U << 1)
	#define GET_OID_COMMIT<TAB>(1U << 2)
	#define GET_OID_COMMITTISH<TAB>(1U << 3)
	...
	
in a separate preliminary patch without adding a new symbol, or
adding the new symbol unaligned and without touching existing lines.

> diff --git a/object-name.c b/object-name.c
> index 92862eeb1a..daa3ef77ef 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -911,13 +911,17 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
>  						len, str,
>  						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
>  				}
> -			} else {
> +			} else if (!(flags & GET_OID_RETURN_FAILURE)) {
>  				if (flags & GET_OID_QUIETLY) {
>  					exit(128);
>  				}
>  				die(_("log for '%.*s' only has %d entries"),
>  				    len, str, co_cnt);
>  			}
> +			if (flags & GET_OID_RETURN_FAILURE) {
> +				free(real_ref);
> +				return -1;
> +			}
>  		}

So, without the new bit, we used to die loudly or quietly.  The new
bit allows us to return an error to the caller without dying
ourselves.

You can call the bit _RETURN_ERROR and not to worry about the
right-alignment above ;-), but better yet, how about calling it
_GENTLY, which is how we call such a variant of behaviour?

