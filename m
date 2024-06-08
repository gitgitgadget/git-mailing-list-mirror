Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2F17BAF
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 08:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717834748; cv=none; b=NJgBwPVyIt/xRZqRtgXryWPPX7PzNYI1kwGG5ST0qIdLgwc/5yICqq8Mtpoyw+vEKKG2ejB9wDt4hZRXuKYOWSHZjqumuF5Ry7IOMsP06heomDIR0o7a9Spr5wbbFppaRPBQaRJ15qx5Vh+TPXUUT3zfAjCFrcOYKv7VSsPfqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717834748; c=relaxed/simple;
	bh=hYAZpbMtlBtzzqX2Y6T280griBwsvT36oSD9DMMysO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFSXOI6BWq7ihcXNtpgKfnXM6MRBMaUIPn+1JJ6OqOebzpBqpvCyvG3hRwudv5pfLNaIfyJ2HaZJVzSAyr5mf8nGkclg8KcuQ1Jz7CfMj1PLtr7FSUkYPuW2fw0v0nHUYmrtTACS+1UcOa9goGydcq51u9Gv/+4iOGh8nkg2b2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6991 invoked by uid 109); 8 Jun 2024 08:18:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 08 Jun 2024 08:18:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28553 invoked by uid 111); 8 Jun 2024 08:18:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 08 Jun 2024 04:18:53 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 8 Jun 2024 04:18:55 -0400
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>
Subject: Re: MSan failures in pack-bitmap
Message-ID: <20240608081855.GA2390433@coredump.intra.peff.net>
References: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_smVjSy6j7jpSxHNsxzJfxnHwjLphsqu5jwd8TBhMLp72XPw@mail.gmail.com>

On Fri, Jun 07, 2024 at 07:43:56PM -0700, Kyle Lippincott wrote:

> I believe what's happening is that pack-bitmap.c:2091 grows the packs
> list and sets up some of the fields, but doesn't set pack_int_id. We
> then use it at pack-bitmap.c:1888.
> 
> I investigated, but couldn't prove to myself what value should be
> placed there while growing it, or if it's incorrect to read from it in
> this case (so we shouldn't be in pack-bitmap.c:1888 with this pack).

Hmm, I'm not sure.

In reuse_partial_packfile_from_bitmap(), the code path that creates the
struct only kicks in when the "multi_pack_reuse" flag isn't set. Which
generally would correspond to whether we have a midx. And then the code
in try_partial_reuse() that uses the struct similarly checks
bitmap_is_midx() before looking at the pack_int_id field.

But that changed in 795006fff4 (pack-bitmap: gracefully handle missing
BTMP chunks, 2024-04-15), where we also disable multi_pack_reuse if we
have a midx but it has no BTMP chunk. So we end up in the non-multi code
path to create the struct, but then try_partial_reuse() still realizes
we have a midx and uses that code path.

I guess this gets into the "we have a midx, but are only doing reuse out
of a single pack" case. Which I think is supported, but I'm not familiar
enough with the code to know where the assumption is going wrong.

Anyway...

> Reproducing is potentially non-trivial. This may work:
> 
> make -j CFLAGS="-fsanitize=memory -fsanitize-memory-track-origins
> -fno-omit-frame-pointer -g -O2" CC=clang && \
> make -C t t5326-multi-pack-bitmaps.sh GIT_TEST_OPTS="--verbose --debug"

Yeah, I forgot what a pain MSan is:

  - I needed to use a recent version of clang (the default for Debian
    unstable is clang-16, which is missing intercepts for newer versions
    of glibc strtoimax(), and complains that it does not set the
    outgoing "end" pointer). Using clang-19 fixed that.

  - Since I didn't recompile all of the dependent libraries with MSan
    support, I hit the usual zlib problems discussed long ago in:

     https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/

    and had to resurrect the patch there.

  - While bisecting (which is how I found 795006fff4), some versions
    complain that attr.c does:

      buf = read_blob_data_from_index(istate, path, &size);
      stack = read_attr_from_buf(buf, size, path, flags);

    If reading failed, then "buf" is NULL and size is uninitialized.
    Inside read_attr_from_buf() we bail immediately when we see the NULL
    buf, but MSan complains that we passed the uninitialized "size" at
    all. Newer versions (starting with c793f9cb08) move the NULL check
    into the caller.

An easier (but slower) reproduction is to just use valgrind. After doing
a normal build, running:

  ./t5326-multi-pack-bitmaps.sh --run=1-24 --valgrind-only=24 -i

is enough to see the problem.

-Peff
