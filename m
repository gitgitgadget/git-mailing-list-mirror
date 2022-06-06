Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9E0C433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 18:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbiFFSf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 14:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiFFSfy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 14:35:54 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A653116D
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 11:35:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C205E19F359;
        Mon,  6 Jun 2022 14:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=JJBRvx/vG0l7
        GWjH8yRbqqhgWdwUZG6xDl7AZdgcvVs=; b=X5tyI6/51r00rw1CQIQ5HukOAQwf
        cI40BSI6TRkls/m7525cY8iXssmR4o6nhLOGXLsJAMjacs7A9qF3CaUJVBfrG969
        r8VdtvPXigv2QXh2gNiC+SJrZMKe171/6zYBERp6PTo0nmxel3z+w1OpnvGH8RiW
        /El+x9brYGKUR8M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B915019F357;
        Mon,  6 Jun 2022 14:35:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0D2AC19F356;
        Mon,  6 Jun 2022 14:35:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han Xin <chiyutianyi@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 1/7] unpack-objects: low memory footprint for
 get_data() in dry_run mode
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
Date:   Mon, 06 Jun 2022 11:35:45 -0700
In-Reply-To: <patch-v13-1.7-12873fc9915-20220604T095113Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 4 Jun
 2022 12:10:22
        +0200")
Message-ID: <xmqqpmjl7i7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7B40B4E4-E5C7-11EC-B967-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> As the name implies, "get_data(size)" will allocate and return a given
> amount of memory. Allocating memory for a large blob object may cause t=
he
> system to run out of memory. Before preparing to replace calling of
> "get_data()" to unpack large blob objects in latter commits, refactor
> "get_data()" to reduce memory footprint for dry_run mode.
>
> Because in dry_run mode, "get_data()" is only used to check the
> integrity of data, and the returned buffer is not used at all, we can
> allocate a smaller buffer and reuse it as zstream output. Therefore,

"reuse" -> "use"

> in dry_run mode, "get_data()" will release the allocated buffer and
> return NULL instead of returning garbage data.

It makes it sound as if we used to return garbage data, but I do not
think that is what happened in reality.  Perhaps rewrite the last
sentence like

	Make the function return NULL in the dry-run mode, as no
	callers use the returned buffer.

or something?

The overall logic sounds quite sensible.

> The "find [...]objects/?? -type f | wc -l" test idiom being used here
> is adapted from the same "find" use added to another test in
> d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).


> +/*
> + * Decompress zstream from stdin and return specific size of data.

"specific size"?  The caller specifies the size of data (because it
knows a-priori how many bytes the zstream should inflate to), so

    Decompress zstream from the standard input into a newly
    allocated buffer of specified size and return the buffer.

or something, perhaps.  In any case, it needs to say that the caller
is responsible for giving the "right" size.

> + * The caller is responsible to free the returned buffer.
> + *
> + * But for dry_run mode, "get_data()" is only used to check the
> + * integrity of data, and the returned buffer is not used at all.
> + * Therefore, in dry_run mode, "get_data()" will release the small
> + * allocated buffer which is reused to hold temporary zstream output
> + * and return NULL instead of returning garbage data.
> + */
>  static void *get_data(unsigned long size)
>  {
>  	git_zstream stream;
> -	void *buf =3D xmallocz(size);
> +	unsigned long bufsize =3D dry_run && size > 8192 ? 8192 : size;
> +	void *buf =3D xmallocz(bufsize);

OK.

>  	memset(&stream, 0, sizeof(stream));
> =20
>  	stream.next_out =3D buf;
> -	stream.avail_out =3D size;
> +	stream.avail_out =3D bufsize;
>  	stream.next_in =3D fill(1);
>  	stream.avail_in =3D len;
>  	git_inflate_init(&stream);
> @@ -125,8 +136,15 @@ static void *get_data(unsigned long size)

What's hidden in the pre-context is this bit:

		int ret =3D git_inflate(&stream, 0);
		use(len - stream.avail_in);
		if (stream.total_out =3D=3D size && ret =3D=3D Z_STREAM_END)
			break;
		if (ret !=3D Z_OK) {
			error("inflate returned %d", ret);
			FREE_AND_NULL(buf);
			if (!recover)
				exit(1);
			has_errors =3D 1;
			break;
		}

and it is correct to use "size", not "bufsize", for this check.
Unless we receive exactly the caller-specified "size" bytes from the
inflated zstream with Z_STREAM_END, we want to detect an error and
bail out.

I am not sure if this is not loosening the error checking in the
dry-run case, though.  In the original code, we set the avail_out
to the total expected size so

 (1) if the caller gives too small a size, git_inflate() would stop
     at stream.total_out with ret that is not STREAM_END nor OK,
     bypassing the "break", and we catch the error.

 (2) if the caller gives too large a size, git_inflate() would stop
     at the true size of inflated zstream, with STREAM_END and would
     not hit this "break", and we catch the error.

With the new code, since we keep refreshing avail_out (see below),
git_inflate() does not even learn how many bytes we are _expecting_
to see.  Is the error checking in the loop, with the updated code,
catch the mismatch between expected and actual size (plausibly
caused by a corrupted zstream) the same way as we do in the=20
non dry-run code path?

>  		}
>  		stream.next_in =3D fill(1);
>  		stream.avail_in =3D len;
> +		if (dry_run) {
> +			/* reuse the buffer in dry_run mode */
> +			stream.next_out =3D buf;
> +			stream.avail_out =3D bufsize;
> +		}
>  	}
>  	git_inflate_end(&stream);
> +	if (dry_run)
> +		FREE_AND_NULL(buf);
>  	return buf;
>  }
