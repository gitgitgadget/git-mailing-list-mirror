Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9C7C433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhLTMs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 07:48:59 -0500
Received: from smtp.hosts.co.uk ([85.233.160.19]:59024 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231130AbhLTMs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 07:48:58 -0500
Received: from host-92-7-140-211.as13285.net ([92.7.140.211] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mzI63-000BVT-CT; Mon, 20 Dec 2021 12:48:56 +0000
Message-ID: <41bd6eed-0e29-3b52-cfd4-9b9f9ac99c72@iee.email>
Date:   Mon, 20 Dec 2021 12:48:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC PATCH] object-file API: add a format_loose_header() function
Content-Language: en-GB
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <20211217112629.12334-3-chiyutianyi@gmail.com>
 <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <RFC-patch-1.1-bda62567f6b-20211220T120740Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,
(catching up after a week away, and noticed your patch today..)

On 20/12/2021 12:10, Ævar Arnfjörð Bjarmason wrote:
> Add a convenience function to wrap the xsnprintf() command that
> generates loose object headers. This code was copy/pasted in various
> parts of the codebase, let's define it in one place and re-use it from
> there.
>
> All except one caller of it had a valid "enum object_type" for us,
> it's only write_object_file_prepare() which might need to deal with
> "git hash-object --literally" and a potential garbage type. Let's have
> the primary API use an "enum object_type", and define an *_extended()
> function that can take an arbitrary "const char *" for the type.

I recently completed a PR in the Git for Windows build that is focused on
"git hash-object --literally" as a starter for LLP64 large file (>4GB)
compatibility.
(https://github.com/git-for-windows/git/pull/3533), which Dscho has
merged (cc'd).

I'm not sure that the `extended` version will work as expected across
the test suite
as multiple fake object types are tried, though I only skimmed the patch.

I'd support the general thrust, but just wanted to synchronise any changes.

Philip
>
> See [1] for the discussion that prompted this patch, i.e. new code in
> object-file.c that wanted to copy/paste the xsnprintf() invocation.
>
> 1. https://lore.kernel.org/git/211213.86bl1l9bfz.gmgdl@evledraar.gmail.com/
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>
> On Fri, Dec 17 2021, Han Xin wrote:
>
>> From: Han Xin <hanxin.hx@alibaba-inc.com>
>>
>> There are 3 places where "xsnprintf" is used to generate the object
>> header, and I originally planned to add a fourth in the latter patch.
>>
>> According to Ævar Arnfjörð Bjarmason’s suggestion, although it's just
>> one line, it's also code that's very central to git, so reafactor them
>> into a function which will help later readability.
>>
>> Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> I came up with this after my comment on the earlier round suggesting
> to factor out that header formatting. I don't know if this more
> thorough approach is worth it or if you'd like to replace your change
> with this one, but just posting it here as an RFC.
>
>  builtin/index-pack.c |  3 +--
>  bulk-checkin.c       |  4 ++--
>  cache.h              | 21 +++++++++++++++++++++
>  http-push.c          |  2 +-
>  object-file.c        | 14 +++++++++++---
>  5 files changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index c23d01de7dc..900c6539f68 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -449,8 +449,7 @@ static void *unpack_entry_data(off_t offset, unsigned long size,
>  	int hdrlen;
>  
>  	if (!is_delta_type(type)) {
> -		hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX,
> -				   type_name(type),(uintmax_t)size) + 1;
> +		hdrlen = format_loose_header(hdr, sizeof(hdr), type, (uintmax_t)size);
>  		the_hash_algo->init_fn(&c);
>  		the_hash_algo->update_fn(&c, hdr, hdrlen);
>  	} else
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 8785b2ac806..446dea7c516 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -220,8 +220,8 @@ static int deflate_to_pack(struct bulk_checkin_state *state,
>  	if (seekback == (off_t) -1)
>  		return error("cannot find the current offset");
>  
> -	header_len = xsnprintf((char *)obuf, sizeof(obuf), "%s %" PRIuMAX,
> -			       type_name(type), (uintmax_t)size) + 1;
> +	header_len = format_loose_header((char *)obuf, sizeof(obuf),
> +					 type, (uintmax_t)size);
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
>  
> diff --git a/cache.h b/cache.h
> index d5cafba17d4..ccece21a4a2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1309,6 +1309,27 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
>  						    unsigned long bufsiz,
>  						    struct strbuf *hdrbuf);
>  
> +/**
> + * format_loose_header() is a thin wrapper around s xsnprintf() that
> + * writes the initial "<type> <obj-len>" part of the loose object
> + * header. It returns the size that snprintf() returns + 1.
> + *
> + * The format_loose_header_extended() function allows for writing a
> + * type_name that's not one of the "enum object_type" types. This is
> + * used for "git hash-object --literally". Pass in a OBJ_NONE as the
> + * type, and a non-NULL "type_str" to do that.
> + *
> + * format_loose_header() is a convenience wrapper for
> + * format_loose_header_extended().
> + */
> +int format_loose_header_extended(char *str, size_t size, enum object_type type,
> +				 const char *type_str, size_t objsize);
> +static inline int format_loose_header(char *str, size_t size,
> +				      enum object_type type, size_t objsize)
> +{
> +	return format_loose_header_extended(str, size, type, NULL, objsize);
> +}
> +
>  /**
>   * parse_loose_header() parses the starting "<type> <len>\0" of an
>   * object. If it doesn't follow that format -1 is returned. To check
> diff --git a/http-push.c b/http-push.c
> index 3309aaf004a..d1a8619e0af 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -363,7 +363,7 @@ static void start_put(struct transfer_request *request)
>  	git_zstream stream;
>  
>  	unpacked = read_object_file(&request->obj->oid, &type, &len);
> -	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
> +	hdrlen = format_loose_header(hdr, sizeof(hdr), type, (uintmax_t)len);
>  
>  	/* Set it up */
>  	git_deflate_init(&stream, zlib_compression_level);
> diff --git a/object-file.c b/object-file.c
> index eac67f6f5f9..d94609ee48d 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1009,6 +1009,14 @@ void *xmmap(void *start, size_t length,
>  	return ret;
>  }
>  
> +int format_loose_header_extended(char *str, size_t size, enum object_type type,
> +				 const char *typestr, size_t objsize)
> +{
> +	const char *s = type == OBJ_NONE ? typestr : type_name(type);
> +
> +	return xsnprintf(str, size, "%s %"PRIuMAX, s, (uintmax_t)objsize) + 1;
> +}
> +
>  /*
>   * With an in-core object data in "map", rehash it to make sure the
>   * object name actually matches "oid" to detect object corruption.
> @@ -1037,7 +1045,7 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
>  		return -1;
>  
>  	/* Generate the header */
> -	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_type), (uintmax_t)size) + 1;
> +	hdrlen = format_loose_header(hdr, sizeof(hdr), obj_type, size);
>  
>  	/* Sha1.. */
>  	r->hash_algo->init_fn(&c);
> @@ -1737,7 +1745,7 @@ static void write_object_file_prepare(const struct git_hash_algo *algo,
>  	git_hash_ctx c;
>  
>  	/* Generate the header */
> -	*hdrlen = xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len)+1;
> +	*hdrlen = format_loose_header_extended(hdr, *hdrlen, OBJ_NONE, type, len);
>  
>  	/* Sha1.. */
>  	algo->init_fn(&c);
> @@ -2009,7 +2017,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
>  	buf = read_object(the_repository, oid, &type, &len);
>  	if (!buf)
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));
> -	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
> +	hdrlen = format_loose_header(hdr, sizeof(hdr), type, len);
>  	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
>  	free(buf);
>  

