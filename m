Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA102207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 06:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754634AbcIMGXc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 02:23:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59020 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751198AbcIMGXc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 02:23:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5C503EEC4;
        Tue, 13 Sep 2016 02:23:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y4+O6ucetMWEUzcpIfXrfeZG5eQ=; b=SIUmNx
        9MFco3Mi5B26GKup8ZUScXokDLpeqNdH1VGmBfDJqukFlCFtzG0UYOp9QyXQo4Di
        Qmz/1tDNeK4l4mlz9q4rlFZGDF8ZqXqWYuJgEf+XjAKyBjSYQmkglmmIljalK/FS
        trq6t8VMbMrYwN+1FKk3/a1LKbjcSGxRrePwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UIlpq99h7ukoa9luMDBQcj7CuCcLs8yT
        gw+r3eQq5Yuxoq1FRmlPjDUdd8b2jAUk4FGSe0FASDEKF6SDHNofOVXopYESsquQ
        UTr4LQ9KSFjQ2xrnzpYzFtsu7BYQoItwDiHG7uMScDhoRWGpwANKThxbxm5n0Kc2
        1mjGuSCLduw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE1873EEC3;
        Tue, 13 Sep 2016 02:23:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 27B1D3EEC1;
        Tue, 13 Sep 2016 02:23:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?utf-8?Q?J=C3=A9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2 v8] pack-objects: respect --local/--honor-pack-keep/--incremental when bitmap is in use
References: <20160910150110.18844-1-kirr@nexedi.com>
Date:   Mon, 12 Sep 2016 23:23:18 -0700
In-Reply-To: <20160910150110.18844-1-kirr@nexedi.com> (Kirill Smelkov's
        message of "Sat, 10 Sep 2016 18:01:10 +0300")
Message-ID: <xmqqd1k8wc6h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 90B8B264-797A-11E6-A45D-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kirill Smelkov <kirr@nexedi.com> writes:

> +static int want_found_object(int exclude, struct packed_git *p)
> +{
> +	if (exclude)
> +		return 1;
> +	if (incremental)
> +		return 0;
> +
> +	/*
> +	 * When asked to do --local (do not include an object that appears in a
> +	 * pack we borrow from elsewhere) or --honor-pack-keep (do not include
> +	 * an object that appears in a pack marked with .keep), finding a pack
> +	 * that matches the criteria is sufficient for us to decide to omit it.
> +	 * However, even if this pack does not satisfy the criteria, we need to
> +	 * make sure no copy of this object appears in _any_ pack that makes us
> +	 * to omit the object, so we need to check all the packs.
> +	 *
> +	 * We can however first check whether these options can possible matter;
> +	 * if they do not matter we know we want the object in generated pack.
> +	 * Otherwise, we signal "-1" at the end to tell the caller that we do
> +	 * not know either way, and it needs to check more packs.
> +	 */
> +	if (!ignore_packed_keep &&
> +	    (!local || !have_non_local_packs))
> +		return 1;
> +
> +	if (local && !p->pack_local)
> +		return 0;
> +	if (ignore_packed_keep && p->pack_local && p->pack_keep)
> +		return 0;
> +
> +	/* we don't know yet; keep looking for more packs */
> +	return -1;
> +}

Moving this logic out to this helper made the main logic in the
caller easier to grasp.

> @@ -958,15 +993,30 @@ static int want_object_in_pack(const unsigned char *sha1,
>  			       off_t *found_offset)
>  {
>  	struct packed_git *p;
> +	int want;
>  
>  	if (!exclude && local && has_loose_object_nonlocal(sha1))
>  		return 0;
>  
> +	/*
> +	 * If we already know the pack object lives in, start checks from that
> +	 * pack - in the usual case when neither --local was given nor .keep files
> +	 * are present we will determine the answer right now.
> +	 */
> +	if (*found_pack) {
> +		want = want_found_object(exclude, *found_pack);
> +		if (want != -1)
> +			return want;
> +	}
>  
>  	for (p = packed_git; p; p = p->next) {
> +		off_t offset;
> +
> +		if (p == *found_pack)
> +			offset = *found_offset;
> +		else
> +			offset = find_pack_entry_one(sha1, p);
> +
>  		if (offset) {
>  			if (!*found_pack) {
>  				if (!is_pack_valid(p))
> @@ -974,31 +1024,9 @@ static int want_object_in_pack(const unsigned char *sha1,
>  				*found_offset = offset;
>  				*found_pack = p;
>  			}
> +			want = want_found_object(exclude, p);
> +			if (want != -1)
> +				return want;
>  		}
>  	}

As Peff noted in his earlier review, however, MRU code needed to be
grafted in to the caller (an update to the MRU list was done in the
code that was moved to the want_found_object() helper).  I think I
did it correctly, which ended up looking like this:

                want = want_found_object(exclude, p);
                if (!exclude && want > 0)
                        mru_mark(packed_git_mru, entry);
                if (want != -1)
                        return want;

I somewhat feel that it is ugly that the helper knows about exclude
(i.e. in the original code, we immediately returned 1 without
futzing with the MRU when we find an entry that is to be excluded,
which now is done in the helper), and the caller also knows about
exclude (i.e. the caller knows that the helper may return positive
in two cases, it knows that MRU marking needs to happen only one of
the two cases, and it also knows that "exclude" is what
differentiates between the two cases) at the same time.

But probably the reason why I feel it ugly is only because I knew
how the original looked like.  I dunno.



