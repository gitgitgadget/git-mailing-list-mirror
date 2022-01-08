Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F13C43217
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 12:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiAHM3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 07:29:04 -0500
Received: from mout.web.de ([217.72.192.78]:43307 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231898AbiAHM3D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 07:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641644917;
        bh=ifUKOZ5eBoqB4p6wyaZJLkdnMKBVMniGmOwaNEk6/as=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CGHjlqiygDZdzamgQNZaEUxKwFJ3a3ci5Bn0TC4XqXQdPgcGmmAhLgxttFXLhVquv
         0Zac5KzCtxvA3rw2sZjGWTlz6QFnYCmHDGtqgBDuZDDYnxmwLjMsd/YSos3rIcBvVM
         eUSJJ741OTGt9AbuFwJlz1gtAlnd70P6pvoKq75Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MpCqb-1maTVL2rnT-00qOKN; Sat, 08
 Jan 2022 13:28:36 +0100
Message-ID: <d4b89182-1b8e-3af9-ed33-e95171285ec4@web.de>
Date:   Sat, 8 Jan 2022 13:28:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 2/6] object-file.c: refactor write_loose_object() to
 several steps
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20220108085419.79682-3-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220108085419.79682-3-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xt2YjHivWKxvLzyWAUl/5jfUuOMC74dbCn5XYPSl/eZ1GMOKbl1
 4qhKoRDtmeUkASSlZJPE4r2iG5NHsLczN0nHqY0mLcEaHM0NcOm6Cdzo9gILMOb1qTlxEWq
 PF9xSZDkTHWqp8G8QqkO2hG+XeN84ZfzzzQBhk1kZFL3L0RTlomXTdGj9KjX32VvJf3XTGC
 56vQ7V7D1kN4n2FWaQ3ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qo4JwMRhSBc=:UFmlg1AiUKNFwI5gaaA+J4
 soTFnp/aWIldZFv4PxU0RgmNuLGCjPHcK83F/Cp/Km4EGm3ZN8qa0isgnJSa9ms0lS1Sl4rbO
 tC/Y8qJm3HqmKV4r74EBDzcKgk/mipbMS+lQEc8BqiYMYm6jrXnVZ+aEoHmbxaXfmMMfFE/7Y
 9vt95NeNT5bn6FIYTnZEHn+IzH4kNtcPhGxS8ndE+8E+IaLibLtdgvLIrgEA9Tbj88cNIe6tp
 k0tnHPgp9YleET4K1OdveqKX3gdHRmeN4r6/ehyTlLk7vCBxd/MkPCPesuQLhjMycM1BmCt9x
 9wcjYAyztDpGe2SWufbU2RSGGMRIlzW/IagtV9PPOlOBKskPX/4EGz2QZDV4K8H/ObkdHVazW
 keF+n27PGpmGBUBaJ82QJbOLn+DrWNqcNPVEi/89kBKRp2roCo9dC/QeLSa6p+KsvFVfm+ZL6
 A5TZJpQ5X/mqrWdbSykrLZgwYWeL7r893QX768NmnGRO3BmtZRPa5O44kdUHfPbONl8BFR3jv
 7lv2bVdnofr5yxxuchwvCscycfpfNUbnDdHY1eA/Tb4szx+qup27l93pKA81l0s/ziB4wi9pK
 2zlDeeaFyExY54b2j7alAdKzTvZaaj5Nq+sCd3ukmiaJiqX5uUIkbA3UwuYxM/Kkchb4R57RH
 YMi7TuvMrNX2RskeKPt+qiRcySKk2HP64KzgSyZCJRs8/gdQ7aV8rrm2pNMKtsH4LIkVcGn4O
 PavLAl5xXQ2W8+lybW5wGNqsygJMPHI8ysiMbnyPnT2HBCR4ZMdL5aACKCuCBsW6KFzsbBSCL
 XOSRXhdyaymOCG7+sxRUOk/y6zaxg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.01.22 um 09:54 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When writing a large blob using "write_loose_object()", we have to pass
> a buffer with the whole content of the blob, and this behavior will
> consume lots of memory and may cause OOM. We will introduce a stream
> version function ("stream_loose_object()") in latter commit to resolve
> this issue.
>
> Before introducing a stream vesion function for writing loose object,
> do some refactoring on "write_loose_object()" to reuse code for both
> versions.
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
>  4. Move common steps for ending zlib stream into a new funciton
>     "end_loose_object_common()".
>
>  5. Close fd and finalize the object file.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 149 +++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 105 insertions(+), 44 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index eb1426f98c..5d163081b1 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1743,6 +1743,25 @@ static void write_object_file_prepare(const struc=
t git_hash_algo *algo,
>  	algo->final_oid_fn(oid, &c);
>  }
>
> +/*
> + * Move the just written object with proper mtime into its final restin=
g place.
> + */
> +static int finalize_object_file_with_mtime(const char *tmpfile,
> +					   const char *filename,
> +					   time_t mtime,
> +					   unsigned flags)

This function is called only once after your series.  Should it be used by
stream_loose_object()?  Probably not -- the latter doesn't have a way to
force a certain modification time and its caller doesn't need one.  So
creating finalize_object_file_with_mtime() seems unnecessary for this
series.

> +{
> +	struct utimbuf utb;
> +
> +	if (mtime) {
> +		utb.actime =3D mtime;
> +		utb.modtime =3D mtime;
> +		if (utime(tmpfile, &utb) < 0 && !(flags & HASH_SILENT))
> +			warning_errno(_("failed utime() on %s"), tmpfile);
> +	}
> +	return finalize_object_file(tmpfile, filename);
> +}
> +
>  /*
>   * Move the just written object into its final resting place.
>   */
> @@ -1828,7 +1847,8 @@ static inline int directory_size(const char *filen=
ame)
>   * We want to avoid cross-directory filename renames, because those
>   * can have problems on various filesystems (FAT, NFS, Coda).
>   */
> -static int create_tmpfile(struct strbuf *tmp, const char *filename)
> +static int create_tmpfile(struct strbuf *tmp, const char *filename,
> +			  unsigned flags)

create_tmpfile() is not mentioned in the commit message, yet it's
changed here.  Hrm.

>  {
>  	int fd, dirlen =3D directory_size(filename);
>
> @@ -1836,7 +1856,9 @@ static int create_tmpfile(struct strbuf *tmp, cons=
t char *filename)
>  	strbuf_add(tmp, filename, dirlen);
>  	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
>  	fd =3D git_mkstemp_mode(tmp->buf, 0444);
> -	if (fd < 0 && dirlen && errno =3D=3D ENOENT) {
> +	do {
> +		if (fd >=3D 0 || !dirlen || errno !=3D ENOENT)
> +			break;

Why turn this branch into a loop?  Is this done to mkdir multiple
components, e.g. with filename being "a/b/c/file" to create "a", "a/b",
and "a/b/c"?  It's only used for loose objects, so a fan-out directory
(e.g. ".git/objects/ff") can certainly be missing, but can their parent
be missing as well sometimes?  If that's the point then such a fix
would be worth its own patch.  (Which probably would benefit from using
safe_create_leading_directories()).

>  		/*
>  		 * Make sure the directory exists; note that the contents
>  		 * of the buffer are undefined after mkstemp returns an
> @@ -1846,17 +1868,72 @@ static int create_tmpfile(struct strbuf *tmp, co=
nst char *filename)
>  		strbuf_reset(tmp);
>  		strbuf_add(tmp, filename, dirlen - 1);
>  		if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)
> -			return -1;
> +			break;
>  		if (adjust_shared_perm(tmp->buf))
> -			return -1;
> +			break;

Or is it just to replace these returns with a jump to the new error
reporting section?

>
>  		/* Try again */
>  		strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
>  		fd =3D git_mkstemp_mode(tmp->buf, 0444);

In that case a break would be missing here.

> +	} while (0);
> +
> +	if (fd < 0 && !(flags & HASH_SILENT)) {
> +		if (errno =3D=3D EACCES)
> +			return error(_("insufficient permission for adding an "
> +				       "object to repository database %s"),
> +				     get_object_directory());
> +		else
> +			return error_errno(_("unable to create temporary file"));
>  	}

Why move this error reporting code into create_tmpfile()?  This function
has a single caller both before and after your series, so the code could
just as well stay at its call-site, avoiding the need to add the flags
parameter.

> +
>  	return fd;
>  }
>
> +static int start_loose_object_common(struct strbuf *tmp_file,
> +				     const char *filename, unsigned flags,
> +				     git_zstream *stream,
> +				     unsigned char *buf, size_t buflen,
> +				     git_hash_ctx *c,
> +				     enum object_type type, size_t len,

The parameters type and len are not used by this function and thus can
be dropped.

> +				     char *hdr, int hdrlen)
> +{
> +	int fd;
> +
> +	fd =3D create_tmpfile(tmp_file, filename, flags);
> +	if (fd < 0)
> +		return -1;
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
> +static void end_loose_object_common(int ret, git_hash_ctx *c,
> +				    git_zstream *stream,
> +				    struct object_id *parano_oid,
> +				    const struct object_id *expected_oid,
> +				    const char *die_msg1_fmt,
> +				    const char *die_msg2_fmt)

Hmm, the signature needs as many lines as the function body.

> +{
> +	if (ret !=3D Z_STREAM_END)
> +		die(_(die_msg1_fmt), ret, expected_oid);
> +	ret =3D git_deflate_end_gently(stream);
> +	if (ret !=3D Z_OK)
> +		die(_(die_msg2_fmt), ret, expected_oid);

These format strings cannot be checked by the compiler.

Considering those two together I think I'd either unify the error
messages and move their strings here (losing the ability for users
to see if streaming was used) or not extract the function and
duplicate its few shared lines.  Just a feeling, though.

> +	the_hash_algo->final_oid_fn(parano_oid, c);
> +}
> +
>  static int write_loose_object(const struct object_id *oid, char *hdr,
>  			      int hdrlen, const void *buf, unsigned long len,
>  			      time_t mtime, unsigned flags)
> @@ -1871,28 +1948,18 @@ static int write_loose_object(const struct objec=
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
> +	/* Common steps for write_loose_object and stream_loose_object to
> +	 * start writing loose oject:
> +	 *
> +	 *  - Create tmpfile for the loose object.
> +	 *  - Setup zlib stream for compression.
> +	 *  - Start to feed header to zlib stream.
> +	 */
> +	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
> +				       &stream, compressed, sizeof(compressed),
> +				       &c, OBJ_NONE, 0, hdr, hdrlen);
> +	if (fd < 0)
> +		return -1;
>
>  	/* Then the data itself.. */
>  	stream.next_in =3D (void *)buf;
> @@ -1907,30 +1974,24 @@ static int write_loose_object(const struct objec=
t_id *oid, char *hdr,
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
> +	/* Common steps for write_loose_object and stream_loose_object to
> +	 * end writing loose oject:
> +	 *
> +	 *  - End the compression of zlib stream.
> +	 *  - Get the calculated oid to "parano_oid".
> +	 */
> +	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
> +				N_("unable to deflate new object %s (%d)"),
> +				N_("deflateEnd on object %s failed (%d)"));
> +
>  	if (!oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>
>  	close_loose_object(fd);
>
> -	if (mtime) {
> -		struct utimbuf utb;
> -		utb.actime =3D mtime;
> -		utb.modtime =3D mtime;
> -		if (utime(tmp_file.buf, &utb) < 0 &&
> -		    !(flags & HASH_SILENT))
> -			warning_errno(_("failed utime() on %s"), tmp_file.buf);
> -	}
> -
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf,
> +					       mtime, flags);
>  }
>
>  static int freshen_loose_object(const struct object_id *oid)
