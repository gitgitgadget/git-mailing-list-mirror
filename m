Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039973191CA
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114570; cv=none; b=qxGnZu2krOjCsC4CPiMDeAty4ZZtUOeQaU3LNvXQR5uK3Z5Dy/oHi2V0o3BXhwvuY+dPr7dW+kXE2PEqK2ynoSQSZRK2EfWxQ0ydYnc52M+78NKbabU98ThYF/6Yc4UUmllez7/HJMueQaz26q+Al8j0ub4pjBnH+eZC4O+GBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114570; c=relaxed/simple;
	bh=MpDGHfjZOP2VbWFFV+jt0I+xKaxkMvxeWdR0iTbrbV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VLOPW4zZHiGYBrs0ztQxXhVCQ8GUjPKE4pez4wwPvq6Nw2dzKyU87bnBJ6VUl4cvTniIB6oFOchqM0OLWw/rkY6n1GG+y6udpLyn7wZZxm8i6arJheurHIdqhaDmb0D1lPnzlgO79+cWsMUntB/4GFfJxN+W2F9ijYb8LwkPPGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=iwJvvam2; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="iwJvvam2"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770114566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DlJdNJIq5zgI/egpWdkRESb0g4P3BDHf8B4VuvCAq8I=;
	b=iwJvvam2UyouRZaHcPsFKIif+rcSVVSHVWnmlAtIDd2UtEKEdTufFHHE3o92Pyy3uJKoGf
	U3s3Mji0KadWGkrf4IgytIxg/S6mB4HYqU6KxG+sLkZ0pKebK/HjNpbMW8u7eBPK8z51I0
	pF4dCtqwOeJ/lNzzTbkzy9afzmLWyZ4=
From: Toon Claes <toon@iotcl.com>
To: git@vger.kernel.org
Cc: l.s.r@web.de,
	Toon Claes <toon@iotcl.com>
Subject: [PATCH] cocci: extend MEMZERO_ARRAY() rules
Date: Tue,  3 Feb 2026 11:29:03 +0100
Message-ID: <20260203102908.749954-1-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In December we've added the MEMZERO_ARRAY() macro. I wrote the initial version,
and Junio made improvements to it. But I realized not all cases where
MEMZERO_ARRAY() was used were detected by coccinelle. So I've been improving the
rules further. But due to the holidays I forgot had this patch laying around,
and now during cleanup I ran into it again.

As far as I can tell, all cases that now use MEMZERO_ARRAY() would have been
converted by coccinelle automatically.

As pointed out by René[1], "0x0" can be replaced by "0", and coccinelle can also
be used to drop unneeded parentheses.

I'm not entirely sure it's worth applying this patch, as the original
MEMZERO_ARRAY() date back a month or two. So I don't mind if this patch would be
dismissed.

[1]: https://lore.kernel.org/git/f02b628f-b9d7-4436-88ee-3255e02cb0f3@web.de/


Kind regards,
Toon

-- 8< --

Recently the MEMZERO_ARRAY() macro was introduced. In that commit also
coccinelle rules were added to capture cases that can be converted to
use that macro.

Later a few more cases were manually converted to use the macro, but
coccinelle didn't capture those. Extend the rules to capture those as
well.

In various cases the code could be further beautified by removing
parentheses which are no longer needed. Modify the coccinelle rules to
optimize those as well and fix them.

During conversion indentation also used spaces where tabs should be
used, fix that in one go.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 contrib/coccinelle/array.cocci | 36 ++++++++++++++++++++++++++++------
 diffcore-delta.c               |  2 +-
 ewah/bitmap.c                  |  4 ++--
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.cocci
index d306f6a21e..e71baea00b 100644
--- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -107,9 +107,32 @@ type T;
 T *ptr;
 expression n;
 @@
-- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
--                                 \| sizeof(*ptr)
--                                 \) )
+- memset(ptr, \( 0 \| '\0' \), \( (n) \| n \) * \( sizeof(T)
+-                                               \| sizeof(ptr[...])
+-                                               \| sizeof(*ptr)
+-                                               \) )
++ MEMZERO_ARRAY(ptr, n)
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- memset(ptr, \( 0 \| '\0' \), \( sizeof(T)
+-                              \| sizeof(ptr[...])
+-                              \| sizeof(*ptr)
+-                              \) * \( (n) \| n \) )
++ MEMZERO_ARRAY(ptr, n)
+
+@@
+type T;
+T[] ptr;
+expression n;
+@@
+- memset(ptr, \( 0 \| '\0' \), \( (n) \| n \) * \( sizeof(T)
+-                                               \| sizeof(ptr[...])
+-                                               \| sizeof(*ptr)
+-                                               \) )
 + MEMZERO_ARRAY(ptr, n)

 @@
@@ -117,7 +140,8 @@ type T;
 T[] ptr;
 expression n;
 @@
-- memset(ptr, \( 0x0 \| 0 \), n * \( sizeof(T)
--                                 \| sizeof(*ptr)
--                                 \) )
+- memset(ptr, \( 0 \| '\0' \), \( sizeof(T)
+-                              \| sizeof(ptr[...])
+-                              \| sizeof(*ptr)
+-                              \) * \( (n) \| n \) )
 + MEMZERO_ARRAY(ptr, n)
diff --git a/diffcore-delta.c b/diffcore-delta.c
index 2de9e9ccff..2b7db39983 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -135,7 +135,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
 	hash->alloc_log2 = i;
 	hash->free = INITIAL_FREE(i);
-	MEMZERO_ARRAY(hash->data, ((size_t)1 << i));
+	MEMZERO_ARRAY(hash->data, (size_t)1 << i);

 	n = 0;
 	accum1 = accum2 = 0;
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index bf878bf876..c378e0ab78 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -46,7 +46,7 @@ static void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
 	size_t old_size = self->word_alloc;
 	ALLOC_GROW(self->words, word_alloc, self->word_alloc);
-	MEMZERO_ARRAY(self->words + old_size, (self->word_alloc - old_size));
+	MEMZERO_ARRAY(self->words + old_size, self->word_alloc - old_size);
 }

 void bitmap_set(struct bitmap *self, size_t pos)
@@ -192,7 +192,7 @@ void bitmap_or_ewah(struct bitmap *self, struct ewah_bitmap *other)
 		self->word_alloc = other_final;
 		REALLOC_ARRAY(self->words, self->word_alloc);
 		MEMZERO_ARRAY(self->words + original_size,
-		              (self->word_alloc - original_size));
+			      self->word_alloc - original_size);
 	}

 	ewah_iterator_init(&it, other);
--
2.53.0.rc1.267.g6e3a78c723
