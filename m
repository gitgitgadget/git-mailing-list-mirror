Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336991F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfIERmE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:42:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55463 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfIERmE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:42:04 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB1A7291C1;
        Thu,  5 Sep 2019 13:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g/Ocjh4uhaan
        kpXbXunzUU1aqjQ=; b=CkQVBjhcxUoCqc2UUHBYNj/DBf06pchK6b4xo53gCw6c
        aWYrV2sUSEtVrnBSvi1vzKVjAph73pvrCs7QMLls3XK+vFFCccFhk+nzw8khAJBW
        DW/wjgH0woSYcqvRz4quCc9GPqHA+KTRzc5RMvsfjagH2bWTOLM6WRb4yZw+mKw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=etK5h9
        kX+7P3QJgQB3HAYxNeDozdxnhUil9Rq1oLDHx0OGhnWqHQatxoFXZm2fmXSdfzB/
        pMHRHq5kB1wCCwbfks5kzmhX0l2Z96CCqYh1Lhikys6IiYrqFL44nZavfKtDlein
        DPHGUDHFi7Yc906EvDdqWZ+481l9BdmCPsV0c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E2810291C0;
        Thu,  5 Sep 2019 13:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4DB70291BF;
        Thu,  5 Sep 2019 13:41:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Fix maybe-uninitialized warnings found by gcc 9 -flto
References: <20190905082459.26816-1-s-beyer@gmx.net>
Date:   Thu, 05 Sep 2019 10:41:57 -0700
In-Reply-To: <20190905082459.26816-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Thu, 5 Sep 2019 10:24:59 +0200")
Message-ID: <xmqqlfv2r66y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 759F41D0-D004-11E9-A945-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephan Beyer <s-beyer@gmx.net> writes:

> diff --git a/fast-import.c b/fast-import.c
> index b44d6a467e..58f73f9105 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -903,7 +903,8 @@ static int store_object(
>  	struct object_entry *e;
>  	unsigned char hdr[96];
>  	struct object_id oid;
> -	unsigned long hdrlen, deltalen;
> +	unsigned long hdrlen;
> +	unsigned long deltalen =3D 0;
>  	git_hash_ctx c;
>  	git_zstream s;

[in my attempt to imitate R=C3=A9ne...]

In this function, deltalen is used only when delta !=3D NULL, i.e.

	if (delta) {
		s.next_in =3D delta;
		s.avail_in =3D deltalen;
	} else {
		s.next_in =3D (void *)dat->buf;
		s.avail_in =3D dat->len;
	}
	...
	if (delta) {
		...
		hdrlen =3D encode_in_pack_object_header(hdr, sizeof(hdr),
						      OBJ_OFS_DELTA, deltalen);
	...

Could delta become non-NULL without deltalen getting set?  We see
these before all uses of delta/deltalen in this function.

	if (last && last->data.len && last->data.buf && last->depth < max_depth
		&& dat->len > the_hash_algo->rawsz) {

		delta_count_attempts_by_type[type]++;
		delta =3D diff_delta(last->data.buf, last->data.len,
			dat->buf, dat->len,
			&deltalen, dat->len - the_hash_algo->rawsz);
	} else
		delta =3D NULL;

If diff_delta() returns non-NULL without touching deltalen, we'd be
in trouble.  We see this in delta.h

static inline void *
diff_delta(const void *src_buf, unsigned long src_bufsize,
	   const void *trg_buf, unsigned long trg_bufsize,
	   unsigned long *delta_size, unsigned long max_delta_size)
{
	struct delta_index *index =3D create_delta_index(src_buf, src_bufsize);
	if (index) {
		void *delta =3D create_delta(index, trg_buf, trg_bufsize,
					   delta_size, max_delta_size);
		free_delta_index(index);
		return delta;
	}
	return NULL;
}

so the question is if create_delta() can return non-NULL without
touching delta_size.  In diff-delta.c::create_delta(), *delta_size
is assigned once at the very end, when the function returns a
pointer to an allocated memory 'out'.  All the "return" statement
other than that last one literally returns "NULL".

So it seems that this is a case the compiler getting confused.




