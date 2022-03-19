Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A2C433EF
	for <git@archiver.kernel.org>; Sat, 19 Mar 2022 10:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242659AbiCSKM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Mar 2022 06:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiCSKM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Mar 2022 06:12:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20372DD9A8
        for <git@vger.kernel.org>; Sat, 19 Mar 2022 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1647684686;
        bh=i3XwaXkUSkTp9GaS76TfM69IfN6nI/IxZD9TbMegYkE=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FVpnTkzXhbXgDBz96CkyAYi6Wx/9clYYxPruQ2ksWSoWyMYfi2MxPHUPkVboonhaU
         FRxpgGxRJJZO6nmPDdiIXte+aYcSELR33YhDVUYKi73tY8SqMYq2isOy/HfOO4D8yn
         Be60SD5x8yBPeSjfhQaxSlz6Z4fqO6KPzd2A9eZw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.26.225]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7gbW-1o9a1s1wGo-014qvk; Sat, 19
 Mar 2022 11:11:26 +0100
Message-ID: <543b06a7-f243-a690-ee81-44f33f7678af@web.de>
Date:   Sat, 19 Mar 2022 11:11:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v11 3/8] object-file.c: refactor write_loose_object() to
 several steps
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
References: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
 <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
 <patch-v11-3.8-f7b02c307fc-20220319T001411Z-avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <patch-v11-3.8-f7b02c307fc-20220319T001411Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Y41VexU6rFXOzc3opv+kphwpga9ZpSIU8PqQ3WkPSRPfwbBwceD
 2K+Su1uYZ0FeIVsGstN3/WK7xzz3k38ZGur5NMi3i5++2pqg06y/CCk1Bkrf2A6CK2AlHet
 WnwW+NJHJurdqLDQc/ZeGWhZykbH87VK4o8U6FxM2XSvqToK6nZh+WJawB62xPK9gufj3cW
 QB6cDq28D7eaB2a0neEng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SPD0/9rBxMw=:ektqtU9rcvaoFV9oiZ4+eJ
 zp0ZCsL8GvNh15MgqafLPUSEtKPp5usubxUvkv6NiLzid1/Du9YoENBIInZu0ZPEHP1IUu3Mu
 qjQynEU5J3SMFtwVXeN+wP4Mhqq8z7bNwkyUFZULVEqxd2nTx52cbLSM4a2LuTAPWldNKSROQ
 Ct04rDGdrwKu7M5tnkbtwe/y/WFYtuNDomD123dsrLxALVgp4BSdiAYqQOQg4K0f+munRWpUV
 AxGT1Aa3cl5pzWATfMNWuFwg4xsyRSn8D4qhl5sF9+T1852Hp8DPz8H8vDHxSVro0uw6DU3We
 6Nq84xT3lUXvsouGtQkTDLOAGWcK6e+dTIbZMyoeSqfq7PbToX5dpaHcgl1VatbQeyky699yQ
 +Gth8xZkQEygn/CIQgiVj3lZSC0Is7YVEW39N4VEmwU8Vnm8mRrUulvPQpBF1rYaqWys/SvUH
 NTXNbu1ohb9rjwtjoelBi2UuTLJPAz28xqjuwD+8PbEe/qrCREoNkY3A82H4BQT1NIxLLoiFs
 7zjoklKVuTTFv5g2yJNNCezyX9vahNWup0YvBkHfb+hLBNRmzxDLAykt+w3OUdvZNTcAeiBS6
 Y5HQJWwwnpREOOUilGa9aW+7Xh+1MDirVLDJc6kvBOjs5N+mFBblpxD14G1ju+lDLGmi6MWFp
 I1eYAhwbQ/xsNmPdSeKe8oZ0t+8zQYF2Uo+vDtpU0JOwY64+nG0IE62usvQIANQ5d/UCo9FeC
 qVqqWDlozUaOCDsIUFFdNBA5/zHxG+3d7u6oFTkm4/YbKCdWFKRvdwQ79GGqb+QHthumw8fva
 xZ1FdSvOpWrowzMGzDC6VP56buCLa+Dwn6V7nmDn1T/KDQby65uvxuO3hqJo+7VjaK4bb4o0j
 nkNuMshT9PNQ0rEGM89ykLX842JPxk7LYl8NqA9ArYrpJ0MayW5aqdUNztHuRZOMNKm1r0j5j
 7cFrnaR194+JyrRRCALmzQ3igTI5iPC3S2DGPfN2bJerzvKVWOxLtFKc0ckWh3QjVxfzuEHNa
 atjrf2cUeNXSKoROpv6kPWvj7jjxO76gxm5s6qVliVkruJlyTF96nomhffghxewBDkJxqavdt
 T5bWph06XZpKhQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.03.22 um 01:23 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When writing a large blob using "write_loose_object()", we have to pass
> a buffer with the whole content of the blob, and this behavior will
> consume lots of memory and may cause OOM. We will introduce a stream
> version function ("stream_loose_object()") in later commit to resolve
> this issue.
>
> Before introducing that streaming function, do some refactoring on
> "write_loose_object()" to reuse code for both versions.
>
> Rewrite "write_loose_object()" as follows:
>
>  1. Figure out a path for the (temp) object file. This step is only
>     used in "write_loose_object()".
>
>  2. Move common steps for starting to write loose objects into a new
>     function "start_loose_object_common()".
>
>  3. Compress data.
>
>  4. Move common steps for ending zlib stream into a new function
>     "end_loose_object_common()".
>
>  5. Close fd and finalize the object file.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  object-file.c | 129 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 89 insertions(+), 40 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 4c140eda6bf..4fcaf7a36ce 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1943,6 +1943,87 @@ static int create_tmpfile(struct strbuf *tmp, con=
st char *filename)
>  	return fd;
>  }
>
> +/**
> + * Common steps for loose object writers to start writing loose
> + * objects:
> + *
> + * - Create tmpfile for the loose object.
> + * - Setup zlib stream for compression.
> + * - Start to feed header to zlib stream.
> + *
> + * Returns a "fd", which should later be provided to
> + * end_loose_object_common().
> + */
> +static int start_loose_object_common(struct strbuf *tmp_file,
> +				     const char *filename, unsigned flags,
> +				     git_zstream *stream,
> +				     unsigned char *buf, size_t buflen,
> +				     git_hash_ctx *c,
> +				     char *hdr, int hdrlen)
> +{
> +	int fd;
> +
> +	fd =3D create_tmpfile(tmp_file, filename);
> +	if (fd < 0) {
> +		if (flags & HASH_SILENT)
> +			return -1;
> +		else if (errno =3D=3D EACCES)
> +			return error(_("insufficient permission for adding "
> +				       "an object to repository database %s"),
> +				     get_object_directory());
> +		else
> +			return error_errno(
> +				_("unable to create temporary file"));
> +	}
> +
> +	/*  Setup zlib stream for compression */
> +	git_deflate_init(stream, zlib_compression_level);
> +	stream->next_out =3D buf;
> +	stream->avail_out =3D buflen;
> +	the_hash_algo->init_fn(c);
> +
> +	/*  Start to feed header to zlib stream */
> +	stream->next_in =3D (unsigned char *)hdr;
> +	stream->avail_in =3D hdrlen;
> +	while (git_deflate(stream, 0) =3D=3D Z_OK)
> +		; /* nothing */
> +	the_hash_algo->update_fn(c, hdr, hdrlen);
> +
> +	return fd;
> +}
> +
> +/**
> + * Common steps for loose object writers to end writing loose objects:
> + *
> + * - End the compression of zlib stream.
> + * - Get the calculated oid to "parano_oid".
> + * - fsync() and close() the "fd"
> + */
> +static void end_loose_object_common(int fd, int ret, git_hash_ctx *c,
> +				    git_zstream *stream,
> +				    struct object_id *parano_oid,
> +				    const struct object_id *expected_oid,
> +				    const char *die_msg1_fmt,
> +				    const char *die_msg2_fmt)
> +{
> +	if (ret !=3D Z_STREAM_END)
> +		die(_(die_msg1_fmt), ret, expected_oid);
> +	ret =3D git_deflate_end_gently(stream);
> +	if (ret !=3D Z_OK)
> +		die(_(die_msg2_fmt), ret, expected_oid);

stream_loose_object(), added in patch 5, passes NULL as expected_oid,
but these die() messages need a valid value.  end_loose_object_common()
has more parameters than lines of code in its body.  Inline it to allow
fully custom messages?

> +	the_hash_algo->final_oid_fn(parano_oid, c);
> +
> +	/*
> +	 * We already did a write_buffer() to the "fd", let's fsync()
> +	 * and close().
> +	 *
> +	 * We might still die() on a subsequent sanity check, but
> +	 * let's not add to that confusion by not flushing any
> +	 * outstanding writes to disk first.
> +	 */
> +	close_loose_object(fd);
> +}
> +
>  static int write_loose_object(const struct object_id *oid, char *hdr,
>  			      int hdrlen, const void *buf, unsigned long len,
>  			      time_t mtime, unsigned flags)
> @@ -1957,28 +2038,11 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
>
>  	loose_object_path(the_repository, &filename, oid);
>
> -	fd =3D create_tmpfile(&tmp_file, filename.buf);
> -	if (fd < 0) {
> -		if (flags & HASH_SILENT)
> -			return -1;
> -		else if (errno =3D=3D EACCES)
> -			return error(_("insufficient permission for adding an object to repo=
sitory database %s"), get_object_directory());
> -		else
> -			return error_errno(_("unable to create temporary file"));
> -	}
> -
> -	/* Set it up */
> -	git_deflate_init(&stream, zlib_compression_level);
> -	stream.next_out =3D compressed;
> -	stream.avail_out =3D sizeof(compressed);
> -	the_hash_algo->init_fn(&c);
> -
> -	/* First header.. */
> -	stream.next_in =3D (unsigned char *)hdr;
> -	stream.avail_in =3D hdrlen;
> -	while (git_deflate(&stream, 0) =3D=3D Z_OK)
> -		; /* nothing */
> -	the_hash_algo->update_fn(&c, hdr, hdrlen);
> +	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
> +				       &stream, compressed, sizeof(compressed),
> +				       &c, hdr, hdrlen);
> +	if (fd < 0)
> +		return -1;
>
>  	/* Then the data itself.. */
>  	stream.next_in =3D (void *)buf;
> @@ -1993,24 +2057,9 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>  		stream.avail_out =3D sizeof(compressed);
>  	} while (ret =3D=3D Z_OK);
>
> -	if (ret !=3D Z_STREAM_END)
> -		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
> -		    ret);
> -	ret =3D git_deflate_end_gently(&stream);
> -	if (ret !=3D Z_OK)
> -		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
> -		    ret);
> -	the_hash_algo->final_oid_fn(&parano_oid, &c);
> -
> -	/*
> -	 * We already did a write_buffer() to the "fd", let's fsync()
> -	 * and close().
> -	 *
> -	 * We might still die() on a subsequent sanity check, but
> -	 * let's not add to that confusion by not flushing any
> -	 * outstanding writes to disk first.
> -	 */
> -	close_loose_object(fd);
> +	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
> +				N_("unable to deflate new object %s (%d)"),
> +				N_("deflateEnd on object %s failed (%d)"));
>
>  	if (!oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
