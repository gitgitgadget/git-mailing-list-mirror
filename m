Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EF351F855
	for <e@80x24.org>; Wed, 27 Jul 2016 20:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758039AbcG0Ukl (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 16:40:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757334AbcG0Ukk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 16:40:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B9141305FA;
	Wed, 27 Jul 2016 16:40:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mPjA/+2c/nyWiKyi/+mAQYL2sTI=; b=HKnRz7
	ietDf7ItLGn1Ii0Bl9ODCE2dgUa4k2kkh34Bod8dKbjMiUJkkM7sL/Almkr9gdgn
	hjNwSjVX3FlD8WNs4enKXuzQYpge5gYZ7Ci7UmHE/nh5yphbICAkX1HiTHFvLtHc
	ahXoN8rR1VaCvE9AJWT62KIzueBqgETMUbAQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h/A4eOEb3vvPgFExHvJ8juxIpUaPrKqe
	XSKid5TCeRPWzCuJWAGBOPSgg1tipBW2rpriFtkN+3/xvthriyixuWrcquU4nIvC
	PPCCuoslRMOcoK5HmpZ4mnsNj1VOkVIhsiQaWMSzCfBtu9FH4tcPAjyeZ0sl3dD2
	toULGmgRYWY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A95CE305F9;
	Wed, 27 Jul 2016 16:40:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1241C305F8;
	Wed, 27 Jul 2016 16:40:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org,
	Vicent Marti <tanoku@gmail.com>
Subject: Re: [PATCH] pack-objects: Use reachability bitmap index when generating non-stdout pack too
References: <20160725185313.GA13007@sigill.intra.peff.net>
	<20160727201506.GA15204@teco.navytux.spb.ru>
Date:	Wed, 27 Jul 2016 13:40:36 -0700
In-Reply-To: <20160727201506.GA15204@teco.navytux.spb.ru> (Kirill Smelkov's
	message of "Wed, 27 Jul 2016 23:15:06 +0300")
Message-ID: <xmqqlh0mvmpn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60DFCDEE-543A-11E6-A7A0-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> > From: Kirill Smelkov <kirr@nexedi.com>
> Subject: [PATCH 1/2] pack-objects: Make sure use_bitmap_index is not active under
>  --local or --honor-pack-keep
>
> Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> are two codepaths in pack-objects: with & without using bitmap
> reachability index.
>
> However add_object_entry_from_bitmap(), despite its non-bitmapped
> counterpart add_object_entry(), in no way does check for whether --local
> or --honor-pack-keep should be respected. In non-bitmapped codepath this
> is handled in want_object_in_pack(), but bitmapped codepath has simply
> no such checking at all.
>
> The bitmapped codepath however was allowing to pass --local and
> --honor-pack-keep and bitmap indices were still used under such
> conditions - potentially giving wrong output (including objects from
> non-local or .keep'ed pack).
>
> Instead of fixing bitmapped codepath to respect those options, since
> currently no one actually need or use them in combination with bitmaps,
> let's just force use_bitmap_index=0 when any of --local or
> --honor-pack-keep are used and add appropriate comment about
> not-checking for those in add_object_entry_from_bitmap()
>
> Suggested-by: Jeff King <peff@peff.net>
> ---
>  builtin/pack-objects.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 15866d7..d7cf782 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -1055,6 +1055,12 @@ static int add_object_entry_from_bitmap(const unsigned char *sha1,
>  	if (have_duplicate_entry(sha1, 0, &index_pos))
>  		return 0;
>  
> +	/*
> +	 * for simplicity we always want object to be in pack, as
> +	 * use_bitmap_index codepath assumes neither --local nor --honor-pack-keep
> +	 * is active.
> +	 */

I am not sure this comment is useful to readers.

Unless the readers are comparing add_object_entry() and this
function and wondering why this side lacks a check here, iow, when
they are merely following from a caller of this function through
this function down to its callee to understand what goes on, this
comment would not help them and only confuse them.

If we were to say something to help those who are comparing these
two functions, I think we should be more explicit, i.e.

    The caller disables use-bitmap-index when --local or
    --honor-pack-keep options are in effect because bitmap code is
    not prepared to handle them.  Because the control does not reach
    here if these options are in effect, the check with
    want_object_in_pack() to skip objects is not done.

or something like that.

Or is the rest of the bitmap codepath prepared to handle these
options and it is just the matter of adding the missing check with
want_object_in_pack() here to make it work correctly?

>  	create_object_entry(sha1, type, name_hash, 0, 0, index_pos, pack, offset);
>  
>  	display_progress(progress_state, nr_result);
> @@ -2776,6 +2782,15 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
>  	if (!use_internal_rev_list || !pack_to_stdout || is_repository_shallow())
>  		use_bitmap_index = 0;
>  
> +	/*
> +	 * "lazy" reasons not to use bitmaps; it is easier to reason about when
> +	 * neither --local nor --honor-pack-keep is in action, and so far no one
> +	 * needed nor implemented such support yet.
> +	 */

Justifying comment like this is a good idea, but the comment above
does not make it very clear that this is a correctness fix, i.e. if
we do not disable, the code will do a wrong thing.

The other logic to disable use of bitmap we can see in the
pre-context would also benefit from some description as to why;
6b8fda2d (pack-objects: use bitmaps when packing objects,
2013-12-21) didn't do a very good job in that---the reason is not
clear in its log message, either.

> +	if (local || ignore_packed_keep)
> +		use_bitmap_index = 0;
> +
> +

I see one extra blank line here ;-)

>  	if (pack_to_stdout || !rev_list_all)
>  		write_bitmap_index = 0;

Thanks.
