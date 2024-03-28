Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398D23DBBF
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641159; cv=none; b=AwlKhtvjAAmGcS7iCqiKwsF1RCB9O8KRM8Uwdnhk9RWRZ73FDrg8rvjfd44IGRwxWt/HcT3wtQbGWheBl1Gol9kNfbAUv+2xRdM6hFAOwMvC7bl5I0qZT/WOS9Ay8u2QS3Q8gG22XS9VZby/3pN3MU7nnrSsHG5EanlPJevA1KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641159; c=relaxed/simple;
	bh=QcmEr6kKuifYcTv0c8s482zx1veJ6dOCetrEkhu35iY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MecNWi78ZsGQ5oAeZVhBIEt7vwXbg1lFvmwE8+HVCaTZMKXtq+L1whM5xyrGW36cgJ0k1tHzJPvLZdW3GDjYAqdghU8LHk3hakM6Vy4AxOAm989iTWfEm0WLoEv8P9BJ1jl+uZM2aT+CxlsEjoa/sR2adgXaNig3i1h5xcswMzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IfyNt4ZK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IfyNt4ZK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 164F91EB05F;
	Thu, 28 Mar 2024 11:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QcmEr6kKuifYcTv0c8s482zx1veJ6dOCetrEkh
	u35iY=; b=IfyNt4ZK8kBq27Wz3GDSeQixdqd/cszLrGRKNlnyGIbmfJrThOsyyP
	7s4swEoyY1WAoPKxILDLAUXHl5kqi3T98eKiR7irPhxPVCgjDzxYGvluyEl6Mx1l
	VsMWxSLMITopbj1vh0emU4NDiSYBwjV/NBQGkkL5+Os3vyzDZNyxk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F2891EB05E;
	Thu, 28 Mar 2024 11:52:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7775B1EB05D;
	Thu, 28 Mar 2024 11:52:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/3] switch to tombstone-free khashl table
In-Reply-To: <20240328101356.300374-1-e@80x24.org> (Eric Wong's message of
	"Thu, 28 Mar 2024 10:13:53 +0000")
References: <20240328101356.300374-1-e@80x24.org>
Date: Thu, 28 Mar 2024 08:52:35 -0700
Message-ID: <xmqqh6gqwdz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 32AB0862-ED1B-11EE-899E-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Wong <e@80x24.org> writes:

> Fortunately, this set of changes is unintrusive; but I'm
> hoping to have more time to make deeper changes this year.
>
> Eric Wong (3):
>   list-objects-filter: use kh_size API
>   treewide: switch to khashl for memory savings
>   khashl: fix ensemble lookups on empty table
>
>  builtin/fast-import.c       |   2 +-
>  builtin/fsmonitor--daemon.c |   4 +-
>  delta-islands.c             |   4 +-
>  khash.h                     | 338 -----------------------
>  khashl.h                    | 522 ++++++++++++++++++++++++++++++++++++
>  list-objects-filter.c       |   2 +-
>  object-store-ll.h           |   2 +-
>  object-store.h              |   7 +-
>  oidset.h                    |   2 +-
>  pack-bitmap.h               |   2 +-
>  10 files changed, 535 insertions(+), 350 deletions(-)
>  delete mode 100644 khash.h
>  create mode 100644 khashl.h
>
> Range-diff:
> -:  ---------- > 1:  3bf3148cab list-objects-filter: use kh_size API
> 1:  e74965907e ! 2:  09900edb48 treewide: switch to khashl for memory savings

Do you have the correct range-diff?  The previous round had the
change to the list-object-filter.c to use kh_size() already.

But I see the 0 -> NULL fixes.  Perhaps the left-side base was off
by one when you took the range-diff and there is nothing else going
on that we should be worried about...

>     @@ Commit message
>      
>          khashl is an updated version of khash with less memory overhead
>          (one bit/bucket instead of two) than the original khash and
>     -    similar overall performance.  Insertions are simpler (linear
>     -    probing) but deletions may be slightly slower[1].  Of course,
>     -    the majority of hash tables in git do not delete individual
>     -    elements.
>     +    similar overall performance.  According to its author,
>     +    insertions are simpler (linear probing) but deletions may be
>     +    slightly slower[1].  Of course, the majority of hash tables in
>     +    git do not delete individual elements.
>      
>          Overall memory usage did not decrease much, as the hash tables
>          and elements we store in them are big and currently dwarf the
>          overhead of the khash internals.  Only around 10 MB in
>     -    allocations (not peak use) is saved when doing a no-op `git gc'
>     -    of a Linux kernel object store with thousands of refs and
>     -    islands.
>     +    allocations (and a few dozen KB peak use out of ~6 GB) is saved
>     +    when doing a no-op `git gc' of a Linux kernel object store with
>     +    thousands of refs and islands.
>      
>          A summary of differences I've found from khash to khashl:
>      
>     @@ Commit message
>          * flesh out KHASHL_{SET,MAP}_INIT wrappers with *_clear, *_resize,
>            and *_release functions
>      
>     +    * sparse fixes from Junio and Jeff
>     +
>          [1] https://attractivechaos.wordpress.com/2019/12/28/deletion-from-hash-tables-without-tombstones/
>          [2] git clone https://github.com/attractivechaos/klib.git
>              2895a16cb55e (support an ensemble of hash tables, 2023-12-18)
>     @@ Commit message
>            typedef) and was the only place where I had to change a definition.
>      
>          Signed-off-by: Eric Wong <e@80x24.org>
>     +    Helped-by: Junio C Hamano <gitster@pobox.com>
>     +    Helped-by: Jeff King <peff@peff.net>
>      
>       ## builtin/fast-import.c ##
>      @@
>     @@ khashl.h (new)
>      +#define __KHASHL_IMPL_GET(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
>      +	SCOPE khint_t prefix##_getp_core(const HType *h, const khkey_t *key, khint_t hash) { \
>      +		khint_t i, last, n_buckets, mask; \
>     -+		if (h->keys == 0) return 0; \
>     ++		if (!h->keys) return 0; \
>      +		n_buckets = (khint_t)1U << h->bits; \
>      +		mask = n_buckets - 1U; \
>      +		i = last = __kh_h2b(hash, h->bits); \
>     @@ khashl.h (new)
>      +
>      +#define __KHASHL_IMPL_RESIZE(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
>      +	SCOPE void prefix##_resize(HType *h, khint_t new_n_buckets) { \
>     -+		khint32_t *new_used = 0; \
>     ++		khint32_t *new_used = NULL; \
>      +		khint_t j = 0, x = new_n_buckets, n_buckets, new_bits, new_mask; \
>      +		while ((x >>= 1) != 0) ++j; \
>      +		if (new_n_buckets & (new_n_buckets - 1)) ++j; \
>     @@ khashl.h (new)
>      +#define __KHASHL_IMPL_DEL(SCOPE, HType, prefix, khkey_t, __hash_fn) \
>      +	SCOPE int prefix##_del(HType *h, khint_t i) { \
>      +		khint_t j = i, k, mask, n_buckets; \
>     -+		if (h->keys == 0) return 0; \
>     ++		if (!h->keys) return 0; \
>      +		n_buckets = (khint_t)1U<<h->bits; \
>      +		mask = n_buckets - 1U; \
>      +		while (1) { \
> 2:  744e1b7198 = 3:  bfb20eae37 khashl: fix ensemble lookups on empty table
