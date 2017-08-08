Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BFC20899
	for <e@80x24.org>; Tue,  8 Aug 2017 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbdHHVqu (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 17:46:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64006 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752137AbdHHVqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 17:46:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C30D9FFD6;
        Tue,  8 Aug 2017 17:46:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WYF6aXXEJPUZBCxjCLIgnMisr2c=; b=v5QuDJ
        QUZXfjrROPYf6YgyUGuk+e3NLzlkF3ut+Ta9KI3U/APgMhoChU+p+MpjrUftquch
        7qKPkBfwy0ytINCHr3fH6yLZgntE4MlXX+EFrSAKdKlgt5WlUPl9BKiUtr9el8RD
        5cuZVtr+8n0gwsY4YQdw0mO4MwCYTgVJbjIHw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tt6DoOVr9rS3ZYV5+r+NX+b+8osEU8D+
        A1npdsHIkP/pOLOMdsxQ0SOZvQPPMygqIkpg7JJ00HguT5lcUDxiQY+egTg17ly2
        4ujGEYOPBFXAJQGtCAqAjMkcQ5uLALIlkwQ9RWqp3JOQ3fYgPOQqlJXAYrALDQoJ
        2i2cr1taPD0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13C0D9FFD5;
        Tue,  8 Aug 2017 17:46:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7E4AD9FFD4;
        Tue,  8 Aug 2017 17:46:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin Koegler <martin.koegler@chello.at>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] Convert size datatype to size_t
References: <1502222450-20815-1-git-send-email-martin@mail.zuhause>
Date:   Tue, 08 Aug 2017 14:46:40 -0700
In-Reply-To: <1502222450-20815-1-git-send-email-martin@mail.zuhause> (Martin
        Koegler's message of "Tue, 8 Aug 2017 22:00:50 +0200")
Message-ID: <xmqqmv79ag1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 105EED42-7C83-11E7-929D-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Koegler <martin.koegler@chello.at> writes:

> diff --git a/apply.c b/apply.c
> index f2d5991..ea97fd2 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3085,7 +3085,7 @@ static int apply_binary_fragment(struct apply_state *state,
>  				 struct patch *patch)
>  {
>  	struct fragment *fragment = patch->fragments;
> -	unsigned long len;
> +	size_t len;
>  	void *dst;
>  
>  	if (!fragment)

This variable is made size_t because it receives the result size of
patch_delta().  And it later is assigned to img->len field, which
already is size_t before this patch.

Curiously, the patch_delta() invocation with this patch reads like
this:

		dst = patch_delta(img->buf, img->len, fragment->patch,
				  fragment->size, &len);

where patch_delta() is updated (correctly) to:

    void *patch_delta(const void *src_buf, size_t src_size,
                      const void *delta_buf, size_t delta_size,
                      size_t *dst_size)

with this patch.  But "size" field in "struct fragment" is still
"int".  So we'd need to update it as well, not necessarily in this
patch (which is already too big) but as part of a larger whole.

> @@ -3174,7 +3174,7 @@ static int apply_binary(struct apply_state *state,
>  	if (has_sha1_file(oid.hash)) {
>  		/* We already have the postimage */
>  		enum object_type type;
> -		unsigned long size;
> +		size_t size;
>  		char *result;
>  
>  		result = read_sha1_file(oid.hash, &type, &size);

This is to receive the resulting size from read_sha1_file().  It is
assigned to img->len, which is already size_t, so all is good here.

> @@ -3236,7 +3236,7 @@ static int read_blob_object(struct strbuf *buf, const struct object_id *oid, uns
>  		strbuf_addf(buf, "Subproject commit %s\n", oid_to_hex(oid));
>  	} else {
>  		enum object_type type;
> -		unsigned long sz;
> +		size_t sz;
>  		char *result;
>  
>  		result = read_sha1_file(oid->hash, &type, &sz);

By reading the remainder of this function, this conversion also is
good.  sz that is now size_t is used as the size attached to an
existing strbuf like so:

		result = read_sha1_file(oid->hash, &type, &sz);
		if (!result)
			return -1;
		/* XXX read_sha1_file NUL-terminates */
		strbuf_attach(buf, result, sz, sz + 1);

in the part beyond the post context of this hunk.  In the longer
term, sz+1 we see here may want to become the overflow-safe variant
st_add().

As you said in the comment after three-dashes in the patch, a lot
more work is needed and your patch is a good starting point.

I am not sure if we can split the patch somehow to make it easier to
review.  The deceptively small part of your patch, i.e.

 apply.c                  |  6 +++---

needs the above analysis to see if they are correct and what more
work is necessary, and there are 65 more files with ~190 lines
changed.

