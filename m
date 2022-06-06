Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D70DC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 19:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbiFFToO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiFFToG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 15:44:06 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02055181
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 12:44:04 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C0D2711BCDB;
        Mon,  6 Jun 2022 15:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+VdaMSvIYAJr
        bscSesLft079JLiyWWJkHIwxm9D7I2c=; b=ppjgBa+abrr9kiGvuwBqd2dXSVW3
        0wj9GMXad+YTyJis2Yuayp3jNpbcNNY0iZmQrNVXEklWLq7y8Ai4ZrtHwMywt16J
        r6ySUJoscSGWa2tnrukwuPvw2MvPbfT2lLRaEyhTlraQ+dLnEtI2+eBZa2xB/y3+
        DRLNdIRZ/dGgJo0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B6F5E11BCDA;
        Mon,  6 Jun 2022 15:44:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F9CE11BCD8;
        Mon,  6 Jun 2022 15:44:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Neeraj Singh <neerajsi@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v13 5/7] object-file.c: add "stream_loose_object()" to
 handle large object
References: <cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com>
        <cover-v13-0.7-00000000000-20220604T095113Z-avarab@gmail.com>
        <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
Date:   Mon, 06 Jun 2022 12:44:01 -0700
In-Reply-To: <patch-v13-5.7-0b07b29836b-20220604T095113Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 4 Jun
 2022 12:10:26
        +0200")
Message-ID: <xmqqy1y960hq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 04AAAD58-E5D1-11EC-8F96-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> If we want unpack and write a loose object using "write_loose_object",
> we have to feed it with a buffer with the same size of the object, whic=
h
> will consume lots of memory and may cause OOM. This can be improved by
> feeding data to "stream_loose_object()" in a stream.
>
> Add a new function "stream_loose_object()", which is a stream version o=
f
> "write_loose_object()" but with a low memory footprint. We will use thi=
s
> function to unpack large blob object in later commit.

Yay.

> Another difference with "write_loose_object()" is that we have no chanc=
e
> to run "write_object_file_prepare()" to calculate the oid in advance.

That is somewhat curious.  Is it fundamentally impossible, or is it
just that this patch was written in such a way that conflates the
two and it is cumbersome to split the "we repeat the sequence of
reading and deflating just a bit until we process all" and the "we
compute the hash over the data first and then we write out for
real"?

> In "write_loose_object()", we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object.
>
> Still, we need to save the temporary file we're preparing
> somewhere. We'll do that in the top-level ".git/objects/"
> directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we've
> streamed it we'll know the OID, and will move it to its canonical
> path.

This may have negative implications on some filesystems where cross
directory links do not work atomically, but it is a small price to pay.

I am very tempted to ask why we do not do this to _all_ loose object
files.  Instead of running the machinery twice over the data (once to
compute the object name, then to compute the contents and write out),
if we can produce loose object files of any size with a single pass,
wouldn't that be an overall win?

Is the fixed overhead, i.e. cost of setting up the streaming interface,
reasonably large to make it not worth doing for smaller objects?

> "freshen_packed_object()" or "freshen_loose_object()" will be called
> inside "stream_loose_object()" after obtaining the "oid".

That much we can read from the patch text.  Saying just "we do X"
without explaining "why we do so" in the proposed log message leaves
readers more confused than otherwise.  Why is it worth pointing out
in the proposed log message?  Is the reason why we need to do so
involve something tricky?

> +int stream_loose_object(struct input_stream *in_stream, size_t len,
> +			struct object_id *oid)
> +{
> +	int fd, ret, err =3D 0, flush =3D 0;
> +	unsigned char compressed[4096];
> +	git_zstream stream;
> +	git_hash_ctx c;
> +	struct strbuf tmp_file =3D STRBUF_INIT;
> +	struct strbuf filename =3D STRBUF_INIT;
> +	int dirlen;
> +	char hdr[MAX_HEADER_LEN];
> +	int hdrlen;
> +
> +	/* Since oid is not determined, save tmp file to odb path. */
> +	strbuf_addf(&filename, "%s/", get_object_directory());
> +	hdrlen =3D format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
> +
> +	/*
> +	 * Common steps for write_loose_object and stream_loose_object to
> +	 * start writing loose objects:
> +	 *
> +	 *  - Create tmpfile for the loose object.
> +	 *  - Setup zlib stream for compression.
> +	 *  - Start to feed header to zlib stream.
> +	 */
> +	fd =3D start_loose_object_common(&tmp_file, filename.buf, 0,
> +				       &stream, compressed, sizeof(compressed),
> +				       &c, hdr, hdrlen);
> +	if (fd < 0) {
> +		err =3D -1;
> +		goto cleanup;
> +	}
> +
> +	/* Then the data itself.. */
> +	do {
> +		unsigned char *in0 =3D stream.next_in;
> +
> +		if (!stream.avail_in && !in_stream->is_finished) {
> +			const void *in =3D in_stream->read(in_stream, &stream.avail_in);
> +			stream.next_in =3D (void *)in;
> +			in0 =3D (unsigned char *)in;
> +			/* All data has been read. */
> +			if (in_stream->is_finished)
> +				flush =3D 1;
> +		}
> +		ret =3D write_loose_object_common(&c, &stream, flush, in0, fd,
> +						compressed, sizeof(compressed));
> +		/*
> +		 * Unlike write_loose_object(), we do not have the entire
> +		 * buffer. If we get Z_BUF_ERROR due to too few input bytes,
> +		 * then we'll replenish them in the next input_stream->read()
> +		 * call when we loop.
> +		 */
> +	} while (ret =3D=3D Z_OK || ret =3D=3D Z_BUF_ERROR);
>
> +	if (stream.total_in !=3D len + hdrlen)
> +		die(_("write stream object %ld !=3D %"PRIuMAX), stream.total_in,
> +		    (uintmax_t)len + hdrlen);

> +	/* Common steps for write_loose_object and stream_loose_object to

Style.

> +	 * end writing loose oject:
> +	 *
> +	 *  - End the compression of zlib stream.
> +	 *  - Get the calculated oid.
> +	 */
> +	if (ret !=3D Z_STREAM_END)
> +		die(_("unable to stream deflate new object (%d)"), ret);

Good to check this, after the loop exits above.  I was expecting to
see it immediately after the loop, but here is also OK.

> +	ret =3D end_loose_object_common(&c, &stream, oid);
> +	if (ret !=3D Z_OK)
> +		die(_("deflateEnd on stream object failed (%d)"), ret);
> +	close_loose_object(fd, tmp_file.buf);
> +
> +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
> +		unlink_or_warn(tmp_file.buf);
> +		goto cleanup;

So, we were told to write an object, we wrote to a temporary file,
and we wanted to mark the object to be recent and found that there
indeed is already the object.  We remove the temporary and do not
leave the new copy of the object, and the value of err at this point
is 0 (success) which is what is returned from cleanup: label.

Good.

> +	}
> +
> +	loose_object_path(the_repository, &filename, oid);
> +
> +	/* We finally know the object path, and create the missing dir. */
> +	dirlen =3D directory_size(filename.buf);
> +	if (dirlen) {
> +		struct strbuf dir =3D STRBUF_INIT;
> +		strbuf_add(&dir, filename.buf, dirlen);
> +
> +		if (mkdir_in_gitdir(dir.buf) && errno !=3D EEXIST) {
> +			err =3D error_errno(_("unable to create directory %s"), dir.buf);
> +			strbuf_release(&dir);
> +			goto cleanup;
> +		}
> +		strbuf_release(&dir);
> +	}
> +
> +	err =3D finalize_object_file(tmp_file.buf, filename.buf);
> +cleanup:
> +	strbuf_release(&tmp_file);
> +	strbuf_release(&filename);
> +	return err;
> +}
> +

