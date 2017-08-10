Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FB3C208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 20:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbdHJUHL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 16:07:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60645 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753017AbdHJUHK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 16:07:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AA519C33F;
        Thu, 10 Aug 2017 16:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aif4tKcF1VFHAiJF7y2+ngoJE30=; b=nIZ5AA
        V9truQIxNHXUP+eT+CaR9/G/pq36QeYzqKrzcHvqf5nYR8kSnyLR4sta3twmmx4s
        iODel8ZgkoumKFgbAHJ25O+f7DpjJDhjgT+tQTl4X271GJdQMe1mdkoq3NtaziA+
        PA77pwoLO5s7/wSo2LsvAyHeuV1goLwHcbgoU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NRBGGXfWT8pjX/9grDGQtqoPVv99JpJh
        SusSy/XhMTCBaS4UdAMKmhVUL7tcsSwtShtnl5XvWQRUzzudzcvMdXemODYQDK3r
        tY83A8fyeX+iHPI1JRcR/UrYTx8kEwrr3uqAv/uIRal8kFWGYeXP2rC9dPxBX0sQ
        Upqb7bYuMj4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6364A9C33E;
        Thu, 10 Aug 2017 16:07:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAF7E9C33D;
        Thu, 10 Aug 2017 16:07:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH V2 1/2] Fix delta integer overflows
References: <1502348462-4992-1-git-send-email-martin@mail.zuhause>
Date:   Thu, 10 Aug 2017 13:07:07 -0700
In-Reply-To: <1502348462-4992-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Thu, 10 Aug 2017 09:01:01 +0200")
Message-ID: <xmqqmv772nmc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D3342DA-7E07-11E7-A6CE-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> From: Martin Koegler <martin.koegler@chello.at>

Just a nitpick on the patch title.  As "git shortlog --no-merges"
output would tell you, we try to prefix the title with a short name
of the area of codebase we are touching, followed by a colon and a
space and then remainder without extra capitalization.  Perhaps

    Subject: delta: fix enconding size larger than an "uint" can hold

> The current delta code produces incorrect pack objects for files > 4GB.
>
> Signed-off-by: Martin Koegler <martin.koegler@chello.at>

I am a bit torn on this change.

The original is indeed bad in that the code does not guarantee that
an intermediate variable like 'l' is not large enough to hold the
true size we know in index->src_size, and in that sense this change
is an improvement.

Given that this is not merely a local storage format but it also is
an interchange format, we would probably want to make sure that the
receiving end (e.g. get_delta_hdr_size() that is used at the
beginning of patch_delta()) on a platform whose size_t is smaller
than that of a platform that produced the delta stream with this
code behaves "sensibly".

If we replaced ulong we use in create/patch delta codepaths with
uint32_t, that would be safer, just because the encoder would not be
able to emit varint that is larger than the receivers to handle.
But that defeats the whole point of using varint() to encode the
sizes in the first place.  It was partly done for space saving, but
more for allowing larger sizes and larger ulong in the future
without having to change the file format.

Perhaps we should teach the receiving end to notice that the varint
data it reads encodes a size that is too large for it to grok and
die.  With that, we can safely move forward with whatever size_t
each platform uses.

Thanks.

> ---
> For next.
>
>  diff-delta.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/diff-delta.c b/diff-delta.c
> index 3797ce6..cd238c8 100644
> --- a/diff-delta.c
> +++ b/diff-delta.c
> @@ -319,7 +319,9 @@ create_delta(const struct delta_index *index,
>  	     const void *trg_buf, unsigned long trg_size,
>  	     unsigned long *delta_size, unsigned long max_size)
>  {
> -	unsigned int i, outpos, outsize, moff, msize, val;
> +	unsigned int i, val;
> +	off_t outpos, moff;
> +	size_t l, outsize, msize;
>  	int inscnt;
>  	const unsigned char *ref_data, *ref_top, *data, *top;
>  	unsigned char *out;
> @@ -336,20 +338,20 @@ create_delta(const struct delta_index *index,
>  		return NULL;
>  
>  	/* store reference buffer size */
> -	i = index->src_size;
> -	while (i >= 0x80) {
> -		out[outpos++] = i | 0x80;
> -		i >>= 7;
> +	l = index->src_size;
> +	while (l >= 0x80) {
> +		out[outpos++] = l | 0x80;
> +		l >>= 7;
>  	}
> -	out[outpos++] = i;
> +	out[outpos++] = l;
>  
>  	/* store target buffer size */
> -	i = trg_size;
> -	while (i >= 0x80) {
> -		out[outpos++] = i | 0x80;
> -		i >>= 7;
> +	l = trg_size;
> +	while (l >= 0x80) {
> +		out[outpos++] = l | 0x80;
> +		l >>= 7;
>  	}
> -	out[outpos++] = i;
> +	out[outpos++] = l;
>  
>  	ref_data = index->src_buf;
>  	ref_top = ref_data + index->src_size;
