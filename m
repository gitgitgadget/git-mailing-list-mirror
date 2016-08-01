Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 700F21F855
	for <e@80x24.org>; Mon,  1 Aug 2016 18:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754654AbcHASZ6 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 14:25:58 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54344 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753938AbcHASZz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 14:25:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 73E6632A4D;
	Mon,  1 Aug 2016 14:17:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zjmy0Vr7NwHEvYIyGcGo0Q9ww2s=; b=PyT+9E
	SF3OkmClh8Y0NR+AgI8n0XqBnwoBN1YKDt5ZpcmvXRrq+Y62prGgoJnGgR/47Tda
	ec3gxg2HvHmpiOnSixdWHhVftWzpj3GgNfAXFOZ3EIndoSxzWil/8inkipyLxvrQ
	/XgNmL6xizqdzV9nExVxa+uCKA79lG+1XB3Yk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fcSDpWlkpVQduW94TBm+3okMJGO0VxtA
	srNoscpRophypqJsqtXhVKvXiGWMoh9T4rqHJbtCB9xGIvTgRMBPwfb8B2mfA5Zl
	HIetCyNSECvcsJlqGBJyqSUrhIj1ackzXM3U+qHrNupsKUJDcfX6GHqg0AKAk8IG
	QcEnMdJXuDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6B66232A4C;
	Mon,  1 Aug 2016 14:17:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DAF8632A4B;
	Mon,  1 Aug 2016 14:17:32 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Kirill Smelkov <kirr@nexedi.com>
Cc:	Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
	=?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
	Isabelle Vallet <isabelle.vallet@nexedi.com>,
	Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
	Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-objects: Teach --use-bitmap-index codepath to respect --local, --honor-pack-keep and --incremental
References: <20160729074051.GA5987@teco.navytux.spb.ru>
	<20160729074656.23813-1-kirr@nexedi.com>
Date:	Mon, 01 Aug 2016 11:17:30 -0700
In-Reply-To: <20160729074656.23813-1-kirr@nexedi.com> (Kirill Smelkov's
	message of "Fri, 29 Jul 2016 10:46:56 +0300")
Message-ID: <xmqqy44gjqv9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 372DC2B6-5814-11E6-973B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> Since 6b8fda2d (pack-objects: use bitmaps when packing objects) there
> are two codepaths in pack-objects: with & without using bitmap
> reachability index.
>
> However add_object_entry_from_bitmap(), despite its non-bitmapped
> counterpart add_object_entry(), in no way does check for whether --local
> or --honor-pack-keep or --incremental should be respected. In
> non-bitmapped codepath this is handled in want_object_in_pack(), but
> bitmapped codepath has simply no such checking at all.
>
> The bitmapped codepath however was allowing to pass in all those options
> and with bitmap indices still being used under such conditions -
> potentially giving wrong output (e.g. including objects from non-local or
> .keep'ed pack).
>
> We can easily fix this by noting the following: when an object comes to
> add_object_entry_from_bitmap() it can come for two reasons:
>
>     1. entries coming from main pack covered by bitmap index, and
>     2. object coming from, possibly alternate, loose or other packs.
>
> For "2" we always have pack not yet found by bitmap traversal code, and
> thus we can simply reuse non-bitmapped want_object_in_pack() to find in
> which pack an object lives and also for taking omitting decision.
>
> For "1" we always have pack already found by bitmap traversal code and we
> only need to check that pack for same criteria used in
> want_object_in_pack() for found_pack.
>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Discussed-with: Jeff King <peff@peff.net>
> ---

I do not think I suggested much of this to deserve credit like this,
though, as I certainly haven't thought about the pros-and-cons
between adding the same "some object in pack may not want to be in
the output" logic to the bitmap side, or punting the bitmap codepath
when local/keep are involved.

> +/* Like want_object_in_pack() but for objects coming from-under bitmapped traversal */
> +static int want_object_in_pack_bitmap(const unsigned char *sha1,
> +				      struct packed_git **found_pack,
> +				      off_t *found_offset)
> +{
> +	struct packed_git *p = *found_pack;
> +
> +	/*
> +	 * There are two types of requests coming here:
> +	 * 1. entries coming from main pack covered by bitmap index, and
> +	 * 2. object coming from, possibly alternate, loose or other packs.
> +	 *
> +	 * For "1" we always have *found_pack != NULL passed here from
> +	 * traverse_bitmap_commit_list(). (*found_pack is bitmap_git.pack
> +	 * actually).
> +	 *
> +	 * For "2" we always have *found_pack == NULL passed here from
> +	 * traverse_bitmap_commit_list() - since this is the way bitmap
> +	 * traversal passes here "extended" bitmap entries.
> +	 */
> +
> +	/* objects not covered by bitmap */
> +	if (!p)
> +		return want_object_in_pack(sha1, 0, found_pack, found_offset);
> +	/* objects covered by bitmap - we only have to check p wrt local and .keep */

I am assuming that p != NULL only means "this object exists in THIS
pack", without saying anything about "this object may also exist in
other places", but "we only have to check" implies that "p != NULL"
means "this object exists *ONLY* in this pack and nowhere else".

Puzzled.


> +	if (incremental)
> +		return 0;
> +	if (local && !p->pack_local)
> +		return 0;
> +	if (ignore_packed_keep && p->pack_local && p->pack_keep)
> +		return 0;
> +
> +	return 1;
> +}
> +
