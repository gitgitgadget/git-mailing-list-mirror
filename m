Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5232F2A1B2
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457091; cv=none; b=SOBgAkHRVDWUUDI8lmmCiRE/8D+uSE9uR8Dxpt3daHqf8J06pIA8xIFz66qGX3VC2gtJZLBb/Yrr+JMipYy2Y7IeDTteg25oPt4gjF51YsnpXI6tOYZSFNlhALstuB7DFvLaS8VyM6M+nQtSmaLwwDRGD6LQt2VOtvlup+gVADo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457091; c=relaxed/simple;
	bh=UPwKvOGQSP9WgJa41775l72LeieXxU/QwSJnuXd3cws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+w4nA16IqMucdQimFa0XsHPcfU3pf8EDZbQdKIMOSPQ+SM3okeKf31wmrRA1wAPNqcow3NyqbndakDlmGLjSAR0toYU1yezJFJqT5ko7qKDy++ffWnVTu4QRt0RfGDBN4n26nbhJRhqd+aFqp4PZkuoF0yO1LOZfG34LzBKLAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TC55Buzf; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TC55Buzf"
Received: (qmail 19718 invoked by uid 109); 18 Nov 2025 09:11:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=UPwKvOGQSP9WgJa41775l72LeieXxU/QwSJnuXd3cws=; b=TC55BuzfPV20LFqwg4ptQgnvpqnzHAEsWKq0nPCLYTHoDvB18It1/f3BBRvl/m0XtDRMnBvXV40eeOFRc2V81UhgRPYAP/iV9oIjvffw+yyv68NjBsfaMzOKFsAtmi789ejAKiFkHfL5xuqB2yNocu8InrUt9sKAD4S/4ifERiEt+/YwKkjM3/IpNjudrb7PrxNg+qXZR82w6Bk6IKngUqH7D9UwJ4WXYZ1MUvY2pcUQBB1YP7D7CYx8dK2jNF9EaqaCs1z87VmHFKZiGw+jGZTWHQXezLgnHNxqJAxoYs10Iv8SExLvprx9PCHWrmjPwp0guQrO7Dywey/yiw56fw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:11:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27349 invoked by uid 111); 18 Nov 2025 09:11:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:11:32 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:11:27 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/9] asan bonanza
Message-ID: <20251118091127.GA4175601@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

On Wed, Nov 12, 2025 at 02:55:22AM -0500, Jeff King wrote:

> This series fixes a handful of issues that ASan finds in our test suite
> if we tweak a few options to let it look deeper.

Here's a v2 based on feedback:

  - added the extra assertion in the midx code

  - meson changes are squashed into patch 3

  - The cache-tree integer parsing is more robust around total garbage
    inputs (with no digits at all). I agree with the reviewers that it
    would be nice to have a robust, reusable integer parsing function.
    But I think it's non-trivial to do (and I left more comments in the
    thread). I'd like to stick here to just fixing the memory issues
    without making anything worse (which I think this version does).

    Note that since the new helper takes an out-parameter, we have to
    match the type more strictly to what the callers have. So it is now
    parse_int(), and not parse_long().

Range diff is below.

  [1/9]: compat/mmap: mark unused argument in git_munmap()
  [2/9]: pack-bitmap: handle name-hash lookups in incremental bitmaps
  [3/9]: Makefile: turn on NO_MMAP when building with ASan
  [4/9]: cache-tree: avoid strtol() on non-string buffer
  [5/9]: fsck: assert newline presence in fsck_ident()
  [6/9]: fsck: avoid strcspn() in fsck_ident()
  [7/9]: fsck: remove redundant date timestamp check
  [8/9]: fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
  [9/9]: t: enable ASan's strict_string_checks option

 Makefile      |  1 +
 cache-tree.c  | 50 ++++++++++++++++++++++++++----------
 compat/mmap.c |  2 +-
 fsck.c        | 71 ++++++++++++++++++++++++++++++++++++---------------
 meson.build   |  8 +++++-
 pack-bitmap.c | 29 ++++++++++++++++++---
 t/test-lib.sh |  1 +
 7 files changed, 122 insertions(+), 40 deletions(-)

 1:  e24015d41b =  1:  3ce5bd39b5 compat/mmap: mark unused argument in git_munmap()
 2:  e217fb0e3b !  2:  9908283c33 pack-bitmap: handle name-hash lookups in incremental bitmaps
    @@ pack-bitmap.c: static uint32_t bitmap_num_objects(struct bitmap_index *index)
     +static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
     +{
     +	if (bitmap_is_midx(index)) {
    -+		while (index && pos < index->midx->num_objects_in_base)
    ++		while (index && pos < index->midx->num_objects_in_base) {
    ++			ASSERT(bitmap_is_midx(index));
     +			index = index->base;
    ++		}
     +
     +		if (!index)
     +			BUG("NULL base bitmap for object position: %"PRIu32, pos);
 3:  8c85dad3c5 <  -:  ---------- Makefile: turn on NO_MMAP when building with ASan
 -:  ---------- >  3:  fe3421f6ec Makefile: turn on NO_MMAP when building with ASan
 4:  38d42984da !  4:  5e228f2c90 cache-tree: avoid strtol() on non-string buffer
    @@ Commit message
              further. You'd mostly get stopped by seeing non-digits in the oid
              field (and if it is likewise truncated, there will still be 20 or
              more bytes of the index checksum). So it's possible, though
    -         unlikely, to see read off the end of the mmap'd buffer. Of course a
    +         unlikely, to read off the end of the mmap'd buffer. Of course a
              malicious index file can fake the oid and the index checksum to all
              (ASCII) 0's.
     
    @@ cache-tree.c: void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
      	trace2_region_leave("cache_tree", "write", the_repository);
      }
      
    -+static long parse_long(const char **ptr, unsigned long *len_p)
    ++static int parse_int(const char **ptr, unsigned long *len_p, int *out)
     +{
     +	const char *s = *ptr;
     +	unsigned long len = *len_p;
    -+	long ret = 0;
    ++	int ret = 0;
     +	int sign = 1;
     +
     +	while (len && *s == '-') {
    @@ cache-tree.c: void cache_tree_write(struct strbuf *sb, struct cache_tree *root)
     +		s++;
     +		len--;
     +	}
    ++
    ++	if (s == *ptr)
    ++		return -1;
    ++
     +	*ptr = s;
     +	*len_p = len;
    -+	return sign * ret;
    ++	*out = sign * ret;
    ++	return 0;
     +}
     +
      static struct cache_tree *read_one(const char **buffer, unsigned long *size_p)
    @@ cache-tree.c: static struct cache_tree *read_one(const char **buffer, unsigned l
     -	cp = buf;
     -	it->entry_count = strtol(cp, &ep, 10);
     -	if (cp == ep)
    -+	it->entry_count = parse_long(&buf, &size);
    -+	if (!size || *buf != ' ')
    ++	if (parse_int(&buf, &size, &it->entry_count) < 0)
      		goto free_return;
     -	cp = ep;
     -	subtree_nr = strtol(cp, &ep, 10);
     -	if (cp == ep)
    --		goto free_return;
    ++	if (!size || *buf != ' ')
    + 		goto free_return;
     -	while (size && *buf && *buf != '\n') {
     -		size--;
     -		buf++;
     -	}
     -	if (!size)
     +	buf++; size--;
    -+	subtree_nr = parse_long(&buf, &size);
    ++	if (parse_int(&buf, &size, &subtree_nr) < 0)
    ++		goto free_return;
     +	if (!size || *buf != '\n')
      		goto free_return;
      	buf++; size--;
 5:  73e921a34e =  5:  1d6814233c fsck: assert newline presence in fsck_ident()
 6:  95e8961df9 =  6:  8cf8152449 fsck: avoid strcspn() in fsck_ident()
 7:  34baa85dae =  7:  563c3006e4 fsck: remove redundant date timestamp check
 8:  f5ff2dc8ef =  8:  6f88309d76 fsck: avoid parse_timestamp() on buffer that isn't NUL-terminated
 9:  1b5c0e7ce7 =  9:  ad1a1f6a82 t: enable ASan's strict_string_checks option
