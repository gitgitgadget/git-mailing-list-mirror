Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FDC32A3DA
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761037474; cv=none; b=FcIYMDsJkpUkt/g6L/kmFjKY60NQ73uU/MkaFt63XNnfT3RakXpyDVbCndNRIrZeGtmIZ2n2ocKjKdakFPshBtfDb+F0cfQLjYdC2MdnRnjjPyl71G42qgpdrbTfYiusIIKnofCCeCEd44DIZs7X456MChUI9cYn33ZnVPZHsiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761037474; c=relaxed/simple;
	bh=LLF+4igUXvjiC03xvnhJowHn/ffIV2BqTPalr2PYeMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SqcMERhCRrDCirqpDIvwtOHSu4f6/g9GW54eBkr5GFgtxW2ScjXPLFYMyZkYbaNTnbqWXV3zUs06fpK6HgN85BUqhcc0QW78VIBwWvP+J1YC8NoR0KuOiyTgME9m147jf4N91dMOcK+/+KuOsGBRHqMy5wsg9eTmYL/ny13IwRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=zAlQVk4o; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="zAlQVk4o"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761037460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUPsl5SmmYMn60QdWYGQc9nUveYVF+8igGsF7QXkJvI=;
	b=zAlQVk4ohwA3+NU27I8qoqJY6oU4mKzLUJlVu8x++c2Mgo9mywcLYrSsUaX3M6dCZzrFLR
	BorcaZTr5cUB2muQbgcykYgo0gUrF48WAdYmFRvvbpVPoqnJvN0x7K3GXcrR30yp3iJXl4
	ezy+260wu6V3Oxpgse6jqnjtdojVsg8=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Derrick Stolee <stolee@gmail.com>, Jeff King
 <peff@peff.net>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <87jz0tu3yh.fsf@iotcl.com>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local> <87jz0tu3yh.fsf@iotcl.com>
Date: Tue, 21 Oct 2025 11:04:05 +0200
Message-ID: <87cy6gtym2.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

> Taylor Blau <me@ttaylorr.com> writes:

>> Nice, I am glad to see that we are using a bitmap here rather than the
>> hacky 'char *' that we had originally written. I seem to remember that
>> there was a tiny slow-down when using bitmaps, but can't find the
>> discussion anymore. (It wasn't in the internal PR that I originally
>> opened, and I no longer can read messages that far back in history.)
>>
>> It might be worth benchmarking here to see if using a 'char *' is
>> faster. Of course, that's 8x worse in terms of memory usage, but not a
>> huge deal given both the magnitude and typical number of directory
>> elements (you'd need 1024^2 entries in a single tree to occupy even a
>> single MiB of heap).

Using ewah bitmaps is slightly faster, although the difference is almost
neglible.

    Benchmark 1: bitmap-ewah
      Time (mean =C2=B1 =CF=83):     793.1 ms =C2=B1   6.2 ms    [User: 755=
.1 ms, System: 35.2 ms]
      Range (min =E2=80=A6 max):   784.7 ms =E2=80=A6 804.8 ms    10 runs

    Benchmark 2: bitmap-chars
      Time (mean =C2=B1 =CF=83):     808.9 ms =C2=B1  11.2 ms    [User: 770=
.8 ms, System: 35.4 ms]
      Range (min =E2=80=A6 max):   800.2 ms =E2=80=A6 830.5 ms    10 runs

    Summary
      bitmap-ewah ran
        1.02 =C2=B1 0.02 times faster than bitmap-chars

And ewah bitmap being more memory efficient, it makes more sense to keep
using those.

>> Likewise, I wonder if we should have elemtype here be just 'struct
>> bitmap'. Unfortunately I don't think the EWAH code has a function like:
>>
>>     void bitmap_init(struct bitmap *);
>>
>> and only has ones that allocate for us. So we may consider adding one,
>> or creating a dummy bitmap and copying its contents, or otherwise.

I've done some testing, and to do so I've made bitmap_grow() public.

    Benchmark 1: bitmap-as-pointers
      Time (mean =C2=B1 =CF=83):     783.7 ms =C2=B1   8.9 ms    [User: 744=
.1 ms, System: 37.5 ms]
      Range (min =E2=80=A6 max):   774.4 ms =E2=80=A6 803.4 ms    10 runs

    Benchmark 2: bitmap-as-values
      Time (mean =C2=B1 =CF=83):     856.7 ms =C2=B1  10.5 ms    [User: 816=
.0 ms, System: 38.1 ms]
      Range (min =E2=80=A6 max):   845.7 ms =E2=80=A6 872.5 ms    10 runs

    Summary
      bitmap-as-pointers ran
        1.09 =C2=B1 0.02 times faster than bitmap-as-values

It seems using ewah bitmaps as pointers is faster than using bitmaps as
values. I must admit I'm surprised as well, but in case you want to
double check, here's the patch:

------------------------ >8 ------------------------

diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index c1316e1019..f607c47506 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -47,7 +47,7 @@ static int last_modified_entry_hashcmp(const void *unused=
 UNUSED,
  * Hold a bitmap for each commit we're working with. Each bit represents a=
 path
  * in `lm->all_paths`. Active bit means the path still needs to be dealt w=
ith.
  */
-define_commit_slab(commit_bitmaps, struct bitmap *);
+define_commit_slab(commit_bitmaps, struct bitmap);

 struct last_modified {
        struct hashmap paths;
@@ -65,11 +65,12 @@ struct last_modified {

 static struct bitmap *get_bitmap(struct last_modified *lm, struct commit *=
c)
 {
-       struct bitmap **bitmap =3D commit_bitmaps_at(&lm->commit_bitmaps, c=
);
-       if (!*bitmap)
-               *bitmap =3D bitmap_word_alloc(lm->all_paths_nr / BITS_IN_EW=
ORD);
+       struct bitmap *bm =3D commit_bitmaps_at(&lm->commit_bitmaps, c);
+       if (!bm->word_alloc) {
+               bitmap_grow(bm, lm->all_paths_nr);
+       }

-       return *bitmap;
+       return bm;
 }

 static void last_modified_release(struct last_modified *lm)
@@ -442,7 +443,8 @@ static int last_modified_run(struct last_modified *lm)
                }

 cleanup:
-               bitmap_free(active_c);
+               free(active_c->words);
+               active_c->word_alloc =3D 0;
        }

        if (hashmap_get_size(&lm->paths))
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 55928dada8..2500e3a0d7 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -42,7 +42,7 @@ struct bitmap *bitmap_dup(const struct bitmap *src)
        return dst;
 }

-static void bitmap_grow(struct bitmap *self, size_t word_alloc)
+void bitmap_grow(struct bitmap *self, size_t word_alloc)
 {
        size_t old_size =3D self->word_alloc;
        ALLOC_GROW(self->words, word_alloc, self->word_alloc);
diff --git a/ewah/ewok.h b/ewah/ewok.h
index c29d354236..3316807572 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -188,6 +188,7 @@ struct bitmap *bitmap_word_alloc(size_t word_alloc);
 struct bitmap *bitmap_dup(const struct bitmap *src);
 void bitmap_set(struct bitmap *self, size_t pos);
 void bitmap_unset(struct bitmap *self, size_t pos);
+void bitmap_grow(struct bitmap *self, size_t word_alloc);
 int bitmap_get(struct bitmap *self, size_t pos);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);


--=20
Cheers,
Toon
