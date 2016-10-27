Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A7F20193
	for <e@80x24.org>; Thu, 27 Oct 2016 21:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030412AbcJ0VSb (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 17:18:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62558 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964799AbcJ0VSa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 17:18:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90D234986D;
        Thu, 27 Oct 2016 17:18:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hJ6Jgf4h3hOT
        BfI2ReXWruk5asM=; b=Fl6sCSQpBhs2+2A9g2EpbkTDyfyUTiky8crN8v979/48
        /urJeWfspRXU4AckWXZ2MR1DkxGXn5Sjb671UFwQ65fAUEbo2jqjP0rgrxop+LKB
        mMf42rGQ+duajSsj5R+8XyLE27V+uaZsWwcRIZYUj6GkzT2eLrqk+qbRTqmE7KM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Aifjjs
        gdatx0hpW4jCjU1gfrn2+P2CEOsqBRAAg04DI13sgF0fbF0+7wtj6+ylFoRVLKvD
        uaJt8QQdcETiALc5xPmMu9eLAqC0IYZ3WPmnlHPQ/xHTR7G+3Mgcxu5uELmLPx3p
        UchP5iq6odLXRgUeVv76eNinDHvQ1cehagcgw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88CEA4986A;
        Thu, 27 Oct 2016 17:18:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E533549863;
        Thu, 27 Oct 2016 17:18:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] convert.c: stream and fast search for binary
References: <20161009095649.1886-1-tboegi@web.de>
        <20161012134727.28365-1-tboegi@web.de>
Date:   Thu, 27 Oct 2016 14:18:25 -0700
In-Reply-To: <20161012134727.28365-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 12 Oct 2016 15:47:27 +0200")
Message-ID: <xmqqd1il5w4e.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E731560E-9C8A-11E6-89AE-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> When statistics are done for the autocrlf handling, the search in
> the content can be stopped, if e.g
> - a search for binary is done, and a NUL character is found
> - a search for CRLF is done, and the first CRLF is found.
>
> Similar when statistics for binary vs non-binary are gathered:
> Whenever a lone CR or NUL is found, the search can be aborted.
>
> When checking out files in "auto" mode, any file that has a "lone CR"
> or a CRLF will not be converted, so the search can be aborted early.
>
> Add the new bit, CONVERT_STAT_BITS_ANY_CR,
> which is set for either lone CR or CRLF.
>
> Many binary files have a NUL very early and it is often not necessary
> to load the whole content of a file or blob into memory.
>
> Split gather_stats() into gather_all_stats() and gather_stats_partly()
> to do a streaming handling for blobs and files in the worktree.
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

I'll try to review in reverse order, as this seems to be doing too
many things at once and cannot get my head around it without going
top down.

> @@ -338,11 +401,15 @@ static int crlf_to_worktree(const char *path, con=
st char *src, size_t len,
>  {
>  	char *to_free =3D NULL;
>  	struct text_stat stats;
> +	unsigned search_only =3D 0;
> =20
>  	if (!len || output_eol(crlf_action) !=3D EOL_CRLF)
>  		return 0;
> =20
> -	gather_stats(src, len, &stats);
> +	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_CRLF=
)
> +		search_only =3D CONVERT_STAT_BITS_ANY_CR | CONVERT_STAT_BITS_BIN;
> +
> +	gather_all_stats(src, len, &stats, search_only);
>  	if (!will_convert_lf_to_crlf(len, &stats, crlf_action))
>  		return 0;

This special case to decide whether we would limit the search_only
flag has too much intimate knowledge of what happens inside
will_convert_lf_to_crlf().  It knows that output_eol(crlf_action)
not being EOL_CRLF is the very first thing the function checks, too.

Makes one wonder if the check for output_eol(crlf_action) can be
removed from will_convert_lf_to_crlf(), no?  It is not apparent if
that is a good idea for the other caller in crlf_to_git().

gather_all_stats() will give up immediately when it sees either
ANY_CR or BIN.  If CR appears before we see any BIN, stat_bits would
not have BITS_BIN even if the buffer may have BIN byte later.  It is
OK because either lonecr or crlf would be non-zero, and
will_convert_lf_to_crlf() would return 0.  If BIN apepars before we
see any CR, neither lonecr nor crlf will become non-zero even if the
buffer may have CR byte later, but again it is OK because
will_convert_lf_to_crlf() will return 0 in that case.

This looks too brittle, even though it is correct.

> @@ -253,7 +300,8 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
>  {
>  	struct text_stat stats;
>  	char *dst;
> -	int convert_crlf_into_lf;
> +	int has_crlf_to_convert;
> +	unsigned search_only =3D 0;
> =20
>  	if (crlf_action =3D=3D CRLF_BINARY ||
>  	    (src && !len))
> @@ -266,12 +314,16 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
>  	if (!buf && !src)
>  		return 1;
> =20
> -	gather_stats(src, len, &stats);
> +	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF)
> +		search_only =3D CONVERT_STAT_BITS_BIN;
> +
> +	gather_all_stats(src, len, &stats, search_only);
> +
>  	/* Optimization: No CRLF? Nothing to convert, regardless. */
> -	convert_crlf_into_lf =3D !!stats.crlf;
> +	has_crlf_to_convert =3D !!stats.crlf;

The comment here may need to say a lot more, now we do not even
count .crlf in some cases because of "search_only" setting.

>  	if (crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_AUTO_INPU=
T || crlf_action =3D=3D CRLF_AUTO_CRLF) {

The new "search_only" criteria above was added to match this if
block; it is not as bad as the previous one in crlf_to_worktree()
that knows, and must be kept in sync with, what a separate function
will_convert_lf_to_crlf() does, but still it is horrible for both
maintainability and readability.  Can you devise some mechanism to
ensure that these two if statements will stay in sync?

> -		if (convert_is_binary(len, &stats))
> +		if (stats.stat_bits & CONVERT_STAT_BITS_BIN)
>  			return 0;

We no longer need the helper function convert_is_binary() and
instead need only STATS_BITS_BIN bit, so the control flow that
reaches this point is obviously correct (assuming that
gather_all_stats() that is limited with search_only option counts
things correctly, that is).

But what happens when we don't return here?  We didn't get the full
stats out of gather_all_stats() and continue.  Let's see what
happens in that case...

>  		/*
>  		 * If the file in the index has any CR in it, do not convert.
> @@ -280,24 +332,35 @@ static int crlf_to_git(const char *path, const ch=
ar *src, size_t len,
>  		if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
>  			checksafe =3D SAFE_CRLF_FALSE;
>  		else if (has_cr_in_index(path))
> -			convert_crlf_into_lf =3D 0;
> +			has_crlf_to_convert =3D 0;
>  	}

So at this point, we cannot trust what is in "stats" (we may have
come out of the above if() statement because it wasn't binary after
all).  It is unclear to me if we may or may not be able to trust
has_crlf_to_convert at this point.  If crlf_action was one of the
three magic values that caused search_only for BITS_BIN set, then
stats.crlf may or may not have seen CRLF---if a NUL came before any
CRLF, gather_all_stats() would have returned without seeing a CRLF
that exists, and otherwise it may have seen one and counted, so
has_crlf_to_convert that is set immediately after gather_all_stats()
returned cannot be trusted at all, when BITS_BIN was set in the
result.

What saves this codepath is that we would have returned at this
point if BITS_BIN was set in the result, so stats.crlf immediately
after gather_all_stats() returned can be trusted in that case, which
in turn means has_crlf_to_convert can also be trusted here.  Whew.

I hate to say this, and it certainly is not the fault of this patch,
but the result of applying this patch is undecipherable without a
great effort and is too brittle.  A reviewer or any future developer
who has to touch this codepath should not be forced to do this kind
of analysis.  Either the code should make everything I wrote above
clear by itself, or more in-code comment must talk about these
things.

Anyway, let's say we established that has_crlf_to_convert and
checksafe can be trustable at this point in the control flow, and
let's keep reading.

>  	if (checksafe && len) {
>  		struct text_stat new_stats;
>  		memcpy(&new_stats, &stats, sizeof(new_stats));
>  		/* simulate "git add" */
> -		if (convert_crlf_into_lf) {
> +		if (has_crlf_to_convert) {
>  			new_stats.lonelf +=3D new_stats.crlf;
>  			new_stats.crlf =3D 0;
> +			/* all crlf, if any, are gone. Update the bits */
> +			new_stats.stat_bits =3D stats.stat_bits & CONVERT_STAT_BITS_BIN;
> +			if (new_stats.lonelf)
> +				new_stats.stat_bits |=3D CONVERT_STAT_BITS_TXT_LF;
> +			if (new_stats.lonecr)
> +				new_stats.stat_bits |=3D CONVERT_STAT_BITS_ANY_CR;

What's happening here?  stats.crlf and stats.lonelf are both
trustable, because even when BITS_BIN optimization were asked when
calling gather_all_stats(), we wouldn't come here if the
optimization actually kicked in.  If we convert crlf to lf, the
result would have more lonelf than the original by the number of
crlf to be converted, and the result would have no crlf, and
new_stats are adjusted to pretend as if we have ran the stat over
the buffer after conversion.  You further adjust .stat_bits, which
were not necessary in the old code.  The new comment says "Update
the bits" but what it should make it clear is why the new code cares
about the bits when the old code didn't.  ANY_CR is the new thing
and is understandable, but old code didn't flip TXT_LF bit.  Is it a
bugfix in the old code and it should have done so without your "find
partially and return early" optimization?  If so, that should have
been a separate patch to be understandable.

I am guessing that this is an attempt to future-proof the contents
of new_stats, so that will_convert_lf_to_crlf() can take a short-cut
by looking at these bits, even though currently it does not look at
any bit other than BITS_BIN.  If that is the case, that needs to be
told to the reader.  "Update the bits" is something any reader can
see.  You need to tell them why you are updating the bits.

>  		}
>  		/* simulate "git checkout" */
>  		if (will_convert_lf_to_crlf(len, &new_stats, crlf_action)) {
>  			new_stats.crlf +=3D new_stats.lonelf;
>  			new_stats.lonelf =3D 0;
> +			new_stats.stat_bits =3D stats.stat_bits & CONVERT_STAT_BITS_BIN;
> +			if (new_stats.crlf)
> +				new_stats.stat_bits |=3D CONVERT_STAT_BITS_TXT_CRLF | CONVERT_STAT=
_BITS_ANY_CR;
> +			if (new_stats.lonecr)
> +				new_stats.stat_bits |=3D CONVERT_STAT_BITS_ANY_CR;
>  		}
>  		check_safe_crlf(path, crlf_action, &stats, &new_stats, checksafe);

Likewise.  Is this future-proofing new_stats to allow check_safe_crlf()
to use them in the future?


> @@ -86,41 +97,62 @@ static void gather_stats(const char *buf, unsigned =
long size, struct text_stat *
>   * The same heuristics as diff.c::mmfile_is_binary()
>   * We treat files with bare CR as binary
>   */
> -static int convert_is_binary(unsigned long size, const struct text_sta=
t *stats)
> +static void convert_nonprintable(struct text_stat *stats)
>  {
> -	if (stats->lonecr)
> -		return 1;
> -	if (stats->nul)
> -		return 1;
>  	if ((stats->printable >> 7) < stats->nonprintable)
> -		return 1;
> -	return 0;
> +		stats->stat_bits |=3D CONVERT_STAT_BITS_BIN;
>  }

When search_only is set to BIN, stat_bits would have BIN if we saw
any non-printable control byte, so calling convert_nonprintable() at
the end of gather_all_stats() to flip the BIN bit on with
printable/nonprintable ratio has no effect in that case.  If we
didn't see a non-printable control byte, gather_stats_partly()
wouldn't have set BIN in the result but then we know the count of
printable and nonprintable are trustworthy, so comparison to flip
the bit makes sense.

The presense of lonecr does not matter, as that would have flipped
BIN, too.  So does the check for NUL, too, has become unnecessary.

I think the end result may be likely to be correct, but with too
many things going on at once, I cannot be confident in saying so.

This probably should be done as four more patches to become
reviewable.

 - One to use the CONVERT_STAT_BITS a lot more for the conversion
   decision than before,=20

 - another to allow the caller to tell gather_stats() to give up
   early with the "search_only" bits,=20

 - another to update the get_*_convert_stats() functions to use
   get_convert_stats_sha1(), and then finally=20

 - use the streaming interface when reading from blob and file.

or something line that.


Thanks.

