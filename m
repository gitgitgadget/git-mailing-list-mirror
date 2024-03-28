Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF6740856
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648592; cv=none; b=Rq8iT1sCaB6fxtkE8HtlWePiZZ2duJX3v8JcqdqBwcghRhJy02k4HbBEsVelR3UYL+bdO/zRIKOjnnJkuVsar2sP3ts1l8I3ujpc4PRDGmz/f0soOQ9PylDsbRU30APdvV9B5rnkDXb6d85JlAj5XzwaOoNNHshzNunnVA+6L4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648592; c=relaxed/simple;
	bh=TZLXc1tNThgMr1OkQAmvSwCI/JHdK6hskUE7JU4o1dA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7Mf8RjNZ+w9ssi788AkeWvkPOAGaDwSVZs4zaISul9OkXaYdr3EA5r62GiWhuFV8YkZ7dw2WgvcZcP7jSoTCjYURhyYAplg22WIL6YELMSfIyjeuZ10lPozf+Q9wNo4k7ZoD6koM3aC2wmZvTX2SLR0TFxPIkvr5Yan10btdtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=sP0omNuT; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="sP0omNuT"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2971F44D;
	Thu, 28 Mar 2024 17:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711648589;
	bh=TZLXc1tNThgMr1OkQAmvSwCI/JHdK6hskUE7JU4o1dA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sP0omNuTf7EzhgwENPFQDFgRezN4+zeC8r7ND6vAa/3BRZ5uldncyO5ZP+3HmHvg/
	 LulhEF9Dvg6bz6ghNTkFRJEZv5qYge57yih94YCVry83Inx0FADLTP9RYRmogLGZ4n
	 NGqaofF9dptwsrrrUGfB8eUwDhNmuZni6jQErWAc=
Date: Thu, 28 Mar 2024 17:56:29 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] switch to tombstone-free khashl table
Message-ID: <20240328175629.M707542@dcvr>
References: <20240328101356.300374-1-e@80x24.org>
 <xmqqh6gqwdz0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6gqwdz0.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> > Range-diff:
> > -:  ---------- > 1:  3bf3148cab list-objects-filter: use kh_size API
> > 1:  e74965907e ! 2:  09900edb48 treewide: switch to khashl for memory savings
> 
> Do you have the correct range-diff?  The previous round had the
> change to the list-object-filter.c to use kh_size() already.
> 
> But I see the 0 -> NULL fixes.  Perhaps the left-side base was off
> by one when you took the range-diff and there is nothing else going
> on that we should be worried about...

Odd...  I switched to a different machine (w) for v2 due to
connectivity problems to the original machine (m) I did v1 on
and applied the patches sent to the list.

I did end up rebasing v1 on (w) against the newer master:
c75fd8d815 (The eleventh batch, 2024-03-25)
instead of commit 11c821f2f2 (The tenth batch, 2024-03-21)
on (m).

On (w):

	git format-patch -o $OUT/ khashl-base..khashl-v2 \
		 --cover-letter --range-diff=khashl-v1 -v2

Seems to mess up infer_range_diff_ranges and it chose `khashl-v2'
instead of `khash-base' as the `a' part of the range for r1.
(m) doesn't do this, both running 2.44.0.32*-ish

Here it is from (w) with the explicit `a..' part for --range-diff:

	git format-patch -o $OUT/ khashl-base..khashl-v2 \
		 --cover-letter --range-diff=khashl-base..khashl-v1 -v2

Range-diff against v1:
1:  3bf3148cab = 1:  3bf3148cab list-objects-filter: use kh_size API
2:  e74965907e ! 2:  09900edb48 treewide: switch to khashl for memory savings
    @@ Commit message
     
         khashl is an updated version of khash with less memory overhead
         (one bit/bucket instead of two) than the original khash and
    -    similar overall performance.  Insertions are simpler (linear
    -    probing) but deletions may be slightly slower[1].  Of course,
    -    the majority of hash tables in git do not delete individual
    -    elements.
    +    similar overall performance.  According to its author,
    +    insertions are simpler (linear probing) but deletions may be
    +    slightly slower[1].  Of course, the majority of hash tables in
    +    git do not delete individual elements.
     
         Overall memory usage did not decrease much, as the hash tables
         and elements we store in them are big and currently dwarf the
         overhead of the khash internals.  Only around 10 MB in
    -    allocations (not peak use) is saved when doing a no-op `git gc'
    -    of a Linux kernel object store with thousands of refs and
    -    islands.
    +    allocations (and a few dozen KB peak use out of ~6 GB) is saved
    +    when doing a no-op `git gc' of a Linux kernel object store with
    +    thousands of refs and islands.
     
         A summary of differences I've found from khash to khashl:
     
    @@ Commit message
         * flesh out KHASHL_{SET,MAP}_INIT wrappers with *_clear, *_resize,
           and *_release functions
     
    +    * sparse fixes from Junio and Jeff
    +
         [1] https://attractivechaos.wordpress.com/2019/12/28/deletion-from-hash-tables-without-tombstones/
         [2] git clone https://github.com/attractivechaos/klib.git
             2895a16cb55e (support an ensemble of hash tables, 2023-12-18)
    @@ Commit message
           typedef) and was the only place where I had to change a definition.
     
         Signed-off-by: Eric Wong <e@80x24.org>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Jeff King <peff@peff.net>
     
      ## builtin/fast-import.c ##
     @@
    @@ khashl.h (new)
     +#define __KHASHL_IMPL_GET(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
     +	SCOPE khint_t prefix##_getp_core(const HType *h, const khkey_t *key, khint_t hash) { \
     +		khint_t i, last, n_buckets, mask; \
    -+		if (h->keys == 0) return 0; \
    ++		if (!h->keys) return 0; \
     +		n_buckets = (khint_t)1U << h->bits; \
     +		mask = n_buckets - 1U; \
     +		i = last = __kh_h2b(hash, h->bits); \
    @@ khashl.h (new)
     +
     +#define __KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
     +	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { \
    -+		khint32_t *new_used = 0; \
    ++		khint32_t *new_used = NULL; \
     +		khint_t j = 0, x = new_n_buckets, n_buckets, new_bits, new_mask; \
     +		while ((x >>= 1) != 0) ++j; \
     +		if (new_n_buckets & (new_n_buckets - 1)) ++j; \
    @@ khashl.h (new)
     +#define __KHASHL_IMPL_DEL(SCOPE, HType, prefix, khkey_t, __hash_fn) \
     +	SCOPE int prefix##_del(HType *h, khint_t i) { \
     +		khint_t j = i, k, mask, n_buckets; \
    -+		if (h->keys == 0) return 0; \
    ++		if (!h->keys) return 0; \
     +		n_buckets = (khint_t)1U<<h->bits; \
     +		mask = n_buckets - 1U; \
     +		while (1) { \
3:  744e1b7198 = 3:  bfb20eae37 khashl: fix ensemble lookups on empty table
