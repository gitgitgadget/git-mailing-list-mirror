Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54A357A43
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771844845; cv=none; b=tjnHGdZsoLTwgXbWPISFUMhJjjqNMqLCxjRf9y9JbNp/JrVQa/R3OJ/ko24fYORbAO4CAESAP0RtRpA/cvh/5P7mNUvMg1om9vMGE9ReJtWeK8FgiDb3pEjNt8NwmVM10TsQlw2HCeMDxafC3H6D+HRvMmwfehVncV6ZjtGP92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771844845; c=relaxed/simple;
	bh=jpcTpV8Lnwg6MfHpHb5y93yGej2OlZwa2KD/kKHKcMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MYBfsMD7/JQnzKEIjIAmPDFkfgea3emsC+pPd0x59r9SPI5xwyys/w1G/bSxfiLKkLLZgisgWCxb41fESevw+CTu1wwDqv64/EdzjFs2cnYXJ4BdClCvnL47SA3oXi1/omQs3uQrlKEJisR0ufXZ1tr6klaO61kP1MmpkxmKoJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ELTzxfUy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ELTzxfUy"
Received: (qmail 51840 invoked by uid 109); 23 Feb 2026 11:07:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=jpcTpV8Lnwg6MfHpHb5y93yGej2OlZwa2KD/kKHKcMo=; b=ELTzxfUyiH56vRwlmVUkHCRgf3wSmF8Ywn61T6nRMfXjUOsK7Xmnj9p69Sbv+eWoGORoP/pcjz1usZimAkWRMhSIXwt2tYwaOFDI9nFvSx5kXXAMqo7vv9ectteMc5H++iPxh/kPIe2lzxUyeljHFXeQQM9t9EA8zKxPixePe4xO+hG9maounE5E8oaxgvdj0ql63BMWw0Pz7DXPbTX3H1LMHrB+TgNDo0aCwF9NNrHBCOfyVip1zFiEU7bOCTtzEBM0X18tBc5qP5J058CCQOuGDAvzc/mWxuIcjUcfza9YBNK8SHLQPkrYzyMrcXSHYOLZ/IP9dv2wtYg3Zgm28A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 11:07:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 99962 invoked by uid 111); 23 Feb 2026 11:07:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 06:07:28 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 06:07:22 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] packfile: expose function to read object stream for
 an offset
Message-ID: <20260223110722.GB215364@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223-pks-fsck-fix-v1-3-c29036832b6e@pks.im>

On Mon, Feb 23, 2026 at 10:50:42AM +0100, Patrick Steinhardt wrote:

> The function `packfile_store_read_object_stream()` takes as input an
> object ID and then constructs a `struct odb_read_stream` from it. In a
> subsequent commit we'll want to create an object stream for a given
> combination of packfile and offset though, which is not something that
> can currently be done.
> 
> Extract a new function `packfile_read_object_stream()` that makes this
> functionality available.

Yup, makes sense. There's one part that puzzled me at first (but I
figured out), and one part I'm not quite sure of.

> -int packfile_store_read_object_stream(struct odb_read_stream **out,
> -				      struct packfile_store *store,
> -				      const struct object_id *oid)
> +int packfile_read_object_stream(struct odb_read_stream **out,
> +				struct packed_git *pack,
> +				off_t offset)
>  {
>  	struct odb_packed_read_stream *stream;
>  	struct pack_window *window = NULL;
> -	struct object_info oi = OBJECT_INFO_INIT;
>  	enum object_type in_pack_type;
>  	unsigned long size;
>  
> -	oi.sizep = &size;
> +	in_pack_type = unpack_object_header(pack, &window, &offset, &size);
> +	unuse_pack(&window);
>  
> -	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
> -	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
> -	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
> -	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
> +	if (repo_settings_get_big_file_threshold(pack->repo) >= size)
>  		return -1;
>  
> -	in_pack_type = unpack_object_header(oi.u.packed.pack,
> -					    &window,
> -					    &oi.u.packed.offset,
> -					    &size);
> -	unuse_pack(&window);

Before we were checking big_file_threshold up front, and now we must
call unpack_object_header() first. But that's because we got the size
for "free" as part of the object_info call that found our pack entry.

Now our caller is responsible for finding the entry. Our wrapper _could_
continue to provide us with the size, but I don't think there is any
efficiency to be gained. Once we have the pack/offset pair, both code
paths will call unpack_object_header() to find it cheaply. And the new
code is even a little more efficient.

But what about the checks for deltas? We've dropped them completely. I
think that's OK, though, because later we have:

>  	switch (in_pack_type) {
>  	default:
>  		return -1; /* we do not do deltas for now */

So they were somewhat redundant in the first place, and just avoided
calling unpack_object_header() for cases where we knew we could not use
the result (which again, was already filled by packed_object_info() in
the same way).

Good.

> +int packfile_store_read_object_stream(struct odb_read_stream **out,
> +				      struct packfile_store *store,
> +				      const struct object_id *oid)
> +{
> +	struct pack_entry e;
> +
> +	if (!find_pack_entry(store, oid, &e))
> +		return -1;
> +
> +	return packfile_read_object_stream(out, e.p, e.offset);
> +}

OK. The original read via packfile_store_read_object_info(), which does
a bit more work. It called packed_object_info() and if necessary would
trigger mark_bad_packed_object(). But now that we are leaving it to
packfile_read_object_stream() to look at the header, we don't need to
load any object info, and we have no error code to check.

It does make me wonder, though, if we are missing out on marking bad
objects here. The idea is that we'd usually do something like:

  1. some code wants to access $OID

  2. we find $OID in pack $P

  3. that turns out to be broken for some reason, so we mark it as bad

  4. we try again, skipping $P and finding it in some other pack

But now I wonder if code that tries to stream will skip step 3, and then
in step 4 we'll find the same broken $P over and over.

But I suspect if that is possible, it was already true. We were only
asking for the type and size, so any content-level corruption wouldn't
be caught here and we'd have the same issue. I think the right thing is
probably for the streaming code to know about the pack/oid pair it's
trying to read, and to mark it as bad if it hits an error.

So your patch here might be making the problem a tiny bit worse, but not
in a material way. I think we can ignore it for now.

-Peff
