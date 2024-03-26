Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DD1CFB5
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475328; cv=none; b=VYafGyQR6PlLOdAF0NL5LDYoGTTEJ1ikJpGDdvOSHVyHyiQjNalSeIFTceQ0JeqD+oV7inmbpXZnelNwWvjOG1x6xyukO9lg09eVPBqvdM5dREsfrP7jIxBMppSAeNwZKumiEbbWask7xtgO9fdTyqGCpJc1OMVLKXOtrm3z3TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475328; c=relaxed/simple;
	bh=bGAIPXNKispFKxXfSFpaE9aXmFD3UmG5H1ehW7odBio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YLK6HIa+rAsHNaTssQrqtCEZoK+XijRCF7FFgsKqGdXdHtQdBt00m/NDxtXWGs56C4P7TLN0z62zVLWT+2wE+MCENYRd4/ciDLeiEjWKRbLQvHplQxnBfdZ7RhJvCAxhp15a1bLYkFcV64jp/sMNxjV8FvTl5U3iGsgcw7OZMX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jlkzLS/Y; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jlkzLS/Y"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 948282EBC2;
	Tue, 26 Mar 2024 13:48:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=bGAIPXNKispFKxXfSFpaE9aXmFD3UmG5H1ehW7
	odBio=; b=jlkzLS/Yv94xhpdMmIibS88zY7SZIyQJ6oZvlMVqz2wURifR2U0H4I
	dRdEGFpgNnsoK2ft2KOqQjOktYQAwAib+veilHZnaAMlDFozWqJy2tn3dguD5ast
	/hQ+47vfnEOQtmTbKFlNoFLKqpQDmkj9KjA3h5HtVNj27V3HxmSCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 8D1CD2EBC1;
	Tue, 26 Mar 2024 13:48:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2C6262EBC0;
	Tue, 26 Mar 2024 13:48:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Wong <e@80x24.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] treewide: switch to khashl for memory savings
In-Reply-To: <20240325230704.262272-3-e@80x24.org> (Eric Wong's message of
	"Mon, 25 Mar 2024 23:07:02 +0000")
References: <20240325230704.262272-1-e@80x24.org>
	<20240325230704.262272-3-e@80x24.org>
Date: Tue, 26 Mar 2024 10:48:40 -0700
Message-ID: <xmqqttksanpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 15B829CA-EB99-11EE-8E26-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Eric Wong <e@80x24.org> writes:

> khashl is an updated version of khash with less memory overhead
> (one bit/bucket instead of two) than the original khash and
> similar overall performance.  Insertions are simpler (linear
> probing) but deletions may be slightly slower[1].  Of course,
> the majority of hash tables in git do not delete individual
> elements.

$ make builtin/fast-import.sp ;# part of make sparse
    SP builtin/fast-import.c
builtin/fast-import.c: note: in included file (through oidset.h, packfile.h):
khashl.h:516:1: error: Using plain integer as NULL pointer
khashl.h:516:1: error: Using plain integer as NULL pointer
make: *** [Makefile:3237: builtin/fast-import.sp] Error 1

I found IMPL_GET and IMPL_DEL's use of (h->keys == 0) were giving
one of these two, and managed to reduce the error to just one with
the attached patch, but I don't know what the other error is coming
from.

 khashl.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git c/khashl.h w/khashl.h
index 8ffe80fbb2..663e36cd2d 100644
--- c/khashl.h
+++ w/khashl.h
@@ -101,7 +101,7 @@ static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 26
 #define __KHASHL_IMPL_GET(SCOPE, HType, prefix, khkey_t, __hash_fn, __hash_eq) \
 	SCOPE khint_t prefix##_getp_core(const HType *h, const khkey_t *key, khint_t hash) { \
 		khint_t i, last, n_buckets, mask; \
-		if (h->keys == 0) return 0; \
+		if (!h->keys) return 0; \
 		n_buckets = (khint_t)1U << h->bits; \
 		mask = n_buckets - 1U; \
 		i = last = __kh_h2b(hash, h->bits); \
@@ -183,7 +183,7 @@ static kh_inline khint_t __kh_h2b(khint_t hash, khint_t bits) { return hash * 26
 #define __KHASHL_IMPL_DEL(SCOPE, HType, prefix, khkey_t, __hash_fn) \
 	SCOPE int prefix##_del(HType *h, khint_t i) { \
 		khint_t j = i, k, mask, n_buckets; \
-		if (h->keys == 0) return 0; \
+		if (!h->keys) return 0; \
 		n_buckets = (khint_t)1U<<h->bits; \
 		mask = n_buckets - 1U; \
 		while (1) { \



	
