Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E927834CFA8
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771843758; cv=none; b=fvlcZl0Y1Dc1VX6MQpTND6Q5PuHOCNFjFLfmWn+0RHlcCOoAVs7oCpCfrwmTFg4yyGC0WWekQfQ2Il2WOuql7Ws2ZEEBJBydl4cubDaYk5sqvnQ68Xj/vX8rYSLo+NEiGT2zOremnxmcCeSunsUAy3YmHqWhFROoWV3o4C+7zDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771843758; c=relaxed/simple;
	bh=MXYb/VCq4UYVV/ZAvwNmO6rkWtm4CmG1YzthjkeF7xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4et9BwBwp5LQ/VIiOy8rLl/gndfp3uneNipwool2Hn5ucNUbLJstHB1sxlgqTzw5k5l08I64aJYjnKpBoT/6uyZL9E7SbntNIOoQvFavezCqSk7hKiYJz9jej2vX+b8C89F+UaitmQN/6EJdnMdeDcfeYRoKBW7guP5WMXTCfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PgDW/hyQ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PgDW/hyQ"
Received: (qmail 51555 invoked by uid 109); 23 Feb 2026 10:49:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=MXYb/VCq4UYVV/ZAvwNmO6rkWtm4CmG1YzthjkeF7xA=; b=PgDW/hyQ73pYHvsH1hYqIMu12f7eQgbb7yiBj1mpH2q277RJiYbVrZKUEKW7+aFbASDtG4yBKTGXLYu+PDvMD0iNpCUxZXAewEFX7LGB1dsIGUcdCm6WmmiyC9SXnDvYjUGb8CJ0MX17vYncBO9ZCGB13ajXg8ZqICHfy7T9JFUI0KrkxeRQlXM9x0TCFGTWVXNON1VTPhak6lmfMzyQEPSVApGZmLVBTkSED0WiB047O5/paSnPclYwR715atHCyeFLG9mA37pD4sAmkyprqJTgjko5XP7U+BOO8MUxB8zGsnSTjdfdFYgt/f9Yoh/LKXbI0M2aiBTnGb1/Q9vqLA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 10:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99500 invoked by uid 111); 23 Feb 2026 10:49:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 05:49:20 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 05:49:15 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] object-file: adapt `stream_object_signature()` to
 take a stream
Message-ID: <20260223104915.GA215364@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-2-c29036832b6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-pks-fsck-fix-v1-2-c29036832b6e@pks.im>

On Mon, Feb 23, 2026 at 10:50:41AM +0100, Patrick Steinhardt wrote:

> The function `stream_object_signature()` is responsible for verifying
> whether the given object ID matches the actual hash of the object's
> contents. In contrast to `check_object_signature()` it does so in a
> streaming fashion so that we don't have to load the full object into
> memory.

Makes sense, and is the first step I expected to see.

The code looks OK, though a few small comments below.

> -int stream_object_signature(struct repository *r, const struct object_id *oid)
> +int stream_object_signature(struct repository *r,
> +			    struct odb_read_stream *st,
> +			    const struct object_id *oid)
>  {
>  	struct object_id real_oid;
> -	struct odb_read_stream *st;
>  	struct git_hash_ctx c;
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen;
>  
> -	st = odb_read_stream_open(r->objects, oid, NULL);
> -	if (!st)
> -		return -1;
> -
>  	/* Generate the header */
>  	hdrlen = format_object_header(hdr, sizeof(hdr), st->type, st->size);
>  
> @@ -160,7 +157,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
>  		git_hash_update(&c, buf, readlen);
>  	}
>  	git_hash_final_oid(&real_oid, &c);
> -	odb_read_stream_close(st);
>  	return !oideq(oid, &real_oid) ? -1 : 0;
>  }

The minimal change for callers would be to give a wrapper like
stream_object_signature_from_oid() or similar, that included the
open/close. But it's not too many lines, and of the two callers, one is
the caller we are trying to split apart anyway. So inlining these bits
in the callers makes sense.

> @@ -330,9 +331,17 @@ struct object *parse_object_with_flags(struct repository *r,
>  
>  	if ((!obj || obj->type == OBJ_NONE || obj->type == OBJ_BLOB) &&
>  	    odb_read_object_info(r->objects, oid, NULL) == OBJ_BLOB) {
> -		if (!skip_hash && stream_object_signature(r, repl) < 0) {
> -			error(_("hash mismatch %s"), oid_to_hex(oid));
> -			return NULL;
> +		if (!skip_hash) {
> +			struct odb_read_stream *stream = odb_read_stream_open(r->objects, oid, NULL);
> +			if (!stream || stream_object_signature(r, stream, repl) < 0) {
> +				error(_("hash mismatch %s"), oid_to_hex(oid));
> +				if (stream)
> +					odb_read_stream_close(stream);
> +				return NULL;
> +			}
> +
> +			if (stream)
> +				odb_read_stream_close(stream);
>  		}

This final "if (stream)" is a noop; we'd have exited the function
already if "!stream".

In the earlier conditional:

  if (!stream || stream_object_signature(r, stream, repl) < 0)

we're combining two error checks: opening the stream and actually
hashing it. That matches the existing code (since it all happened in a
single function), but should we take this opportunity to give more
accurate error messages? I.e., to do:

  if (!stream) {
	error(_("unable to open object stream for %s"), oid_to_hex(oid));
	return NULL;
  }
  if (stream_object_signature(r, stream, repl) < 0) {
	error(_("hash mismatch %s"), oid_to_hex(oid));
	odb_read_stream_close(stream);
	return NULL;
  }
  odb_read_stream_close(stream);

I dunno. It should be quite uncommon to see either of these messages,
but that is sometimes the moment when details are most important.

Also, as an aside, I found it curious that we still need to pass the
repository struct to stream_object_signature(). That's because it needs
to know the correct hash_algo. I wondered if the stream struct itself
might know about that, but it doesn't seem to (it doesn't know anything
about where it came from). So it's unavoidable that we'd need to retain
it.

> @@ -104,6 +105,7 @@ static int verify_packfile(struct repository *r,
>  	QSORT(entries, nr_objects, compare_entries);
>  
>  	for (i = 0; i < nr_objects; i++) {
> +		struct odb_read_stream *stream = NULL;
>  		void *data;
>  		struct object_id oid;
>  		enum object_type type;
> @@ -152,7 +154,9 @@ static int verify_packfile(struct repository *r,
>  							type) < 0)
>  			err = error("packed %s from %s is corrupt",
>  				    oid_to_hex(&oid), p->pack_name);
> -		else if (!data && stream_object_signature(r, &oid) < 0)
> +		else if (!data &&
> +			 (!(stream = odb_read_stream_open(r->objects, &oid, NULL)) ||
> +			  stream_object_signature(r, stream, &oid) < 0))
>  			err = error("packed %s from %s is corrupt",
>  				    oid_to_hex(&oid), p->pack_name);
>  		else if (fn) {
> @@ -163,12 +167,14 @@ static int verify_packfile(struct repository *r,
>  		}
>  		if (((base_count + i) & 1023) == 0)
>  			display_progress(progress, base_count + i);
> -		free(data);
>  
> +		if (stream)
> +			odb_read_stream_close(stream);
> +		free(data);
>  	}

OK, and in this case the final "if" is important, because we just set
"err" and continue through the function. This would be much simpler with
a wrapper, but of course this is the very caller we're planning to fix.

-Peff
