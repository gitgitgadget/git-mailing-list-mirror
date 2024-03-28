Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932827BB1E
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620844; cv=none; b=fpzLoiE/5bf4wbpR6i2GrT3ddqYdIpZlCZILsfRA/nRaH1KnnUEA1YQT4ySvoVa4JrFxNB9LgFLbm4i6eIKgZ0d9n1uhW0SMxcFzTA7KsJULrRTvR1cSjzOEW2q85KEyf95OgMZHtso+4ZEp0Re0+Jm9f/gQVo8i358NWoJFrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620844; c=relaxed/simple;
	bh=cKIWLc4CJKXctf+IXdubcdIK8aCnI9m9ip//qdHucDo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oN9tLAGdqgVtpvXOdMpl7mXTcRkZAc4E/QbZ6iMLa2js2tULrS7Z2mP6s5E4Hpi0n72ZM7Dm8PvJwFXKP+bxJNl5EVA6f/5hI5a2YtcdzOkNJQC9qGGLWwXMxvARNGN21+HLoW8Ham0xtf8QOtcvFPn7bHNtSWpHRQP/uML5lv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=t80sxHSZ; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="t80sxHSZ"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785D81F44D
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 10:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1711620836;
	bh=cKIWLc4CJKXctf+IXdubcdIK8aCnI9m9ip//qdHucDo=;
	h=From:To:Subject:Date:From;
	b=t80sxHSZEsnNHFAXT7BDYTX4Vy6ARHKh3si9d3fLcq6gfzCMPJ3dJaIpv10cs+imY
	 5zIuHqheYpXZoxuBcPQVNcfUj5mbCT+VetHR4JIBn7liJnoNx6uGT/yh5+Qs3EVQvj
	 hbMJh/GPGdL/vwSxZJIQPwFxhx765Oav5MNuBXcE=
From: Eric Wong <e@80x24.org>
To: git@vger.kernel.org
Subject: [PATCH 0/3] switch to tombstone-free khashl table
Date: Thu, 28 Mar 2024 10:13:53 +0000
Message-ID: <20240328101356.300374-1-e@80x24.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is another step in slowly reducing memory usage of `git gc'
and associated tasks.  khashl is an updated version of khash
which eliminates tombstones for deleted elements to save space.

The overall memory improvement with our codebase is tiny (a few
dozen KB out of several GB at peak, about 10MB over the lifetime
of a process).  Any memory reduction at all is welcome at this
point; and khashl comes with some new optional features and
enhancements which may come in handy someday.

I haven't been able to validate CPU-dependent improvements
claimed by the author due to system noise from working on a
shared server.  No aberrant behavior has been noticed in
day-to-day `production' use on public facing servers.

Keep in mind the switch linear probing for performance is
consistent with findings made for the open-coded ->obj_hash in
object.c

Fortunately, this set of changes is unintrusive; but I'm
hoping to have more time to make deeper changes this year.

Eric Wong (3):
  list-objects-filter: use kh_size API
  treewide: switch to khashl for memory savings
  khashl: fix ensemble lookups on empty table

 builtin/fast-import.c       |   2 +-
 builtin/fsmonitor--daemon.c |   4 +-
 delta-islands.c             |   4 +-
 khash.h                     | 338 -----------------------
 khashl.h                    | 522 ++++++++++++++++++++++++++++++++++++
 list-objects-filter.c       |   2 +-
 object-store-ll.h           |   2 +-
 object-store.h              |   7 +-
 oidset.h                    |   2 +-
 pack-bitmap.h               |   2 +-
 10 files changed, 535 insertions(+), 350 deletions(-)
 delete mode 100644 khash.h
 create mode 100644 khashl.h

Range-diff:
-:  ---------- > 1:  3bf3148cab list-objects-filter: use kh_size API
1:  e74965907e ! 2:  09900edb48 treewide: switch to khashl for memory savings
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
2:  744e1b7198 = 3:  bfb20eae37 khashl: fix ensemble lookups on empty table
