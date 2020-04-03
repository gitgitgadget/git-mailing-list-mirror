Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD9C2BA12
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F642077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YNu98U9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDCSxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:53:44 -0400
Received: from mout.web.de ([217.72.192.78]:58347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728329AbgDCSxo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585940010;
        bh=GtNJsnOc23J9IG5ihWclLsg7LpdhPUl65R7o99KvJ5s=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YNu98U9/MfkUxSJuOyBsfQNmDyX24lnUQYH9aeG23AcJ+MPheBCkr4ekV9IMhEDVn
         rfB1hlPFrYgPHtyllK9NlyS5+Q0INBGbVQ0G2fiv1vTw4J3+WpbaQEcDHfwgnBzUTi
         RYEFV9DelQkQhK6pSqFln4YhZUIR/fDLOYEek7xE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAMpq-1jUvp22fVK-00BeQn; Fri, 03
 Apr 2020 20:53:30 +0200
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200403121508.GA638328@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
Date:   Fri, 3 Apr 2020 20:53:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403121508.GA638328@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tBEce6/n6No3lI88JcOYXvZidOjH7MvTI4EBcGVf2lGWJ3Ka4zX
 bYF1j6H0Nyd//tVVLsZ+QS0Ay6kOEwCp/0jFpOPeuwXL3zS4YgDsuJQ6WhUQ5H2Z3gGC/8e
 erzBWvupIDjW6jFgn19NvGfOyg64IwILTZElZvzdicwIw5NLvX+AfM792GBPNnvCNzRExwP
 62AKvcd1+0BSrkyPb+a9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:10ZtGAAVtLk=:9PmJyDJbcKgEzpc+IE3aS4
 kHedldqk3aN4vKlkjsOL3N02rJIbjG3dHhWn/ML6ZgCaW7Qx/osRHsznSyDvplbZOYLIJ85TN
 9vqMao85EQxtjFHhq4COgL/ZiyMLB4lz8M7IXVp+7U8L6WtHiV69qcjeCiFwAtg0fAT7WpIfE
 WSLdRE0HokpErSmJyEGdlfnCNZ/hEXFC5SMPt15L3ALiXGj6AgLu3oTcNJYZxL52xOdFpvocy
 m7w8JiKfXuyGcz1z0zabiH4o/ppHWvZvwNbFDaDGYr6xYMUmFXl1CjyhR1H1gQrz2o6eJy4yY
 5b8feEsC6YX2O9vnY/cUGg1rLm1LrAGqUqPhrBZsxKX+NCr7YadvMb0K0V722fU+VeAvp/xED
 UHwxdZFaDsMF2vzDP6Zd6WHf4Gu6zaexDPFnhjtdJrwpgRfkZmbiifqXo5McsevPDDs7j/bpd
 6HEqVmYyRHvjUU1mGfhO1ueNrwxhx31OFujE8YVqn4EjVFbUGuiYDXTIzQA3Eh34y7pV9OyTw
 y4y/cVjRKgS9q8XNMo1RilB4V2nQj63a2pKnM6ZksbQ5jdiT3F+vtpULEOpEQl/zMwirHRwiB
 HzGth1ED35W5D9o/XzZxeFyi5QM3tSrHOhDwvD/ZA8A3cIEiAAHDsOUEkD5iYVeZZjcOAe4ht
 ZwIIIKK8III2yQ0xBsBMaSE5MVYK0SJaVu9ucSZCkwOkJnPntu8l0hsdYNl42Lh5CyRur2McI
 uDBzv+oWZAmsB/UuzzBYFB8U+BnVAcLzUP07k2FSplepzikFTz6Dj60UXoy6ZRRBVazK6wvSq
 9coj254hog+JGtv8/BBQqbO57MQtCWgiCzlcDqRyQzGmfTVsrmuLULpUeucLZiXXI7fubSipX
 /UHU1LN4tHdFugQ2qUMXnrxmVfDQ4BMwQNWY3OXc0DOk5TFp3nSuDRLlGnWckKoyUlKH97od+
 Dwm8jvSQTv0rHYTxY7VhnyUaTbLjISr5NLPOOwy4eWkO9rdu0DAmOId+j4RHs+BZVPADjoAoh
 nqNV0TmNp5j2JJrlLVD13gNi3T4z5x1eReVn/WfF+V9/t/lMkN+uKUPbo116FfJDPeToeSqNb
 allsAcu4f4mbPksMu/0cGzirAUJMu7ywyvM9s4fYDFfvyAJSGSEwJaNjwk1f2PRN3a24ZyEYT
 TWYMXS3lYGHk9O8MkArrzblTMWUxl05XFot9px5AzlJ4EpqOu0SBxwOBExEk5HXr8MxvY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.20 um 14:15 schrieb Jeff King:
> We use a custom hash in fast-import to store the set of objects we've
> imported so far. It has a fixed set of 2^16 buckets and chains any
> collisions with a linked list. As the number of objects grows larger
> than that, the load factor increases and we degrade to O(n) lookups and
> O(n^2) insertions.
>
> We can scale better by using our hashmap.c implementation, which will
> resize the bucket count as we grow. This does incur an extra memory cost
> of 8 bytes per object, as hashmap stores the integer hash value for each
> entry in its hashmap_entry struct (which we really don't care about
> here, because we're just reusing the embedded object hash). But I think
> the numbers below justify this (and our per-object memory cost is
> already much higher).
>
> I also looked at using khash, but it seemed to perform slightly worse
> than hashmap at all sizes, and worse even than the existing code for
> small sizes. It's also awkward to use here, because we want to look up a
> "struct object_entry" from a "struct object_id", and it doesn't handle
> mismatched keys as well. Making a mapping of object_id to object_entry
> would be more natural, but that would require pulling the embedded oid
> out of the object_entry or incurring an extra 32 bytes per object.
>
> In a synthetic test creating as many cheap, tiny objects as possible
>
>   perl -e '
>       my $bits =3D shift;
>       my $nr =3D 2**$bits;
>
>       for (my $i =3D 0; $i < $nr; $i++) {
>               print "blob\n";
>               print "data 4\n";
>               print pack("N", $i);
>       }
>   ' $bits | git fast-import
>
> I got these results:
>
>   nr_objects   master       khash      hashmap
>   2^20         0m4.317s     0m5.109s   0m3.890s
>   2^21         0m10.204s    0m9.702s   0m7.933s
>   2^22         0m27.159s    0m17.911s  0m16.751s
>   2^23         1m19.038s    0m35.080s  0m31.963s
>   2^24         4m18.766s    1m10.233s  1m6.793s

I get similar numbers.

>
> which points to hashmap as the winner. We didn't have any perf tests for
> fast-export or fast-import, so I added one as a more real-world case.
> It uses an export without blobs since that's significantly cheaper than
> a full one, but still is an interesting case people might use (e.g., for
> rewriting history). It will emphasize this change in some ways (as a
> percentage we spend more time making objects and less shuffling blob
> bytes around) and less in others (the total object count is lower).
>
> Here are the results for linux.git:
>
>   Test                        HEAD^                 HEAD
>   ----------------------------------------------------------------------=
------
>   9300.1: export (no-blobs)   67.64(66.96+0.67)     67.81(67.06+0.75) +0=
.3%
>   9300.2: import (no-blobs)   284.04(283.34+0.69)   198.09(196.01+0.92) =
-30.3%

My numbers look a bit different for this, not sure why:

Test                        origin/master         HEAD
=2D-----------------------------------------------------------------------=
---
9300.1: export (no-blobs)   69.36(66.44+1.56)     67.89(66.07+1.56) -2.1%
9300.2: import (no-blobs)   295.10(293.83+1.19)   283.83(282.91+0.91) -3.8=
%

They are still in favor of the patch, just not as strongly as yours.

>
> It only has ~5.2M commits and trees, so this is a larger effect than I
> expected (the 2^23 case above only improved by 50s or so, but here we
> gained almost 90s). This is probably due to actually performing more
> object lookups in a real import with trees and commits, as opposed to
> just dumping a bunch of blobs into a pack.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  fast-import.c                      | 62 +++++++++++++++++++-----------
>  t/perf/p9300-fast-import-export.sh | 23 +++++++++++
>  2 files changed, 62 insertions(+), 23 deletions(-)
>  create mode 100755 t/perf/p9300-fast-import-export.sh
>

I have to warn you up front: I'm not familiar with hashmap or
fast-import, so I'll focus on stylistic topics -- bikeshedding.  The
actual change looks reasonable to me overall and the performance is
convincing.

> diff --git a/fast-import.c b/fast-import.c
> index 202dda11a6..0ef6defc10 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -39,12 +39,28 @@
>
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	struct object_entry *next;
> +	struct hashmap_entry ent;
>  	uint32_t type : TYPE_BITS,
>  		pack_id : PACK_ID_BITS,
>  		depth : DEPTH_BITS;
>  };
>
> +static int object_entry_hashcmp(const void *map_data,
> +				const struct hashmap_entry *eptr,
> +				const struct hashmap_entry *entry_or_key,
> +				const void *keydata)
> +{
> +	const struct object_id *oid =3D keydata;
> +	const struct object_entry *e1, *e2;
> +
> +	e1 =3D container_of(eptr, const struct object_entry, ent);
> +	if (oid)
> +		return oidcmp(&e1->idx.oid, oid);
> +
> +	e2 =3D container_of(entry_or_key, const struct object_entry, ent);
> +	return oidcmp(&e1->idx.oid, &e2->idx.oid);

Other hashmap users express this more tersely, similar to this:

	const struct object_entry *e1, *e2;

	e1 =3D container_of(eptr, const struct object_entry, ent);
	e2 =3D container_of(entry_or_key, const struct object_entry, ent);
	return oidcmp(&e1->idx.oid, keydata ? keydata : &e2->idx.oid);

> +}
> +
>  struct object_entry_pool {
>  	struct object_entry_pool *next_pool;
>  	struct object_entry *next_free;
> @@ -178,7 +194,7 @@ static off_t pack_size;
>  /* Table of objects we've written. */
>  static unsigned int object_entry_alloc =3D 5000;
>  static struct object_entry_pool *blocks;
> -static struct object_entry *object_table[1 << 16];
> +static struct hashmap object_table;
>  static struct mark_set *marks;
>  static const char *export_marks_file;
>  static const char *import_marks_file;
> @@ -455,44 +471,42 @@ static struct object_entry *new_object(struct obje=
ct_id *oid)
>
>  static struct object_entry *find_object(struct object_id *oid)
>  {
> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
> -	struct object_entry *e;
> -	for (e =3D object_table[h]; e; e =3D e->next)
> -		if (oideq(oid, &e->idx.oid))
> -			return e;
> +	struct hashmap_entry lookup_entry, *e;
> +
> +	hashmap_entry_init(&lookup_entry, oidhash(oid));
> +	e =3D hashmap_get(&object_table, &lookup_entry, oid);
> +	if (e)
> +		return container_of(e, struct object_entry, ent);

(Worth repeating:) No casting trick, yay!

>  	return NULL;
>  }
>
>  static struct object_entry *insert_object(struct object_id *oid)
>  {
> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
> -	struct object_entry *e =3D object_table[h];
> +	struct object_entry *e;
> +	struct hashmap_entry lookup_entry, *hashent;
>
> -	while (e) {
> -		if (oideq(oid, &e->idx.oid))
> -			return e;
> -		e =3D e->next;
> -	}
> +	hashmap_entry_init(&lookup_entry, oidhash(oid));
> +	hashent =3D hashmap_get(&object_table, &lookup_entry, oid);
> +	if (hashent)
> +		return container_of(hashent, struct object_entry, ent);

That duplicates find_object()...

>
>  	e =3D new_object(oid);
> -	e->next =3D object_table[h];
>  	e->idx.offset =3D 0;
> -	object_table[h] =3D e;
> +	e->ent.hash =3D lookup_entry.hash;

... except for this part.  Would it make sense to replace this line with
a call to hashmap_entry_init()?  Seems cleaner to me.  It would look
like this:

	struct object_entry *e =3D find_object(oid);

	if (e)
		return e;

	e =3D new_object(oid);
	e->idx.offset =3D 0;
	hashmap_entry_init(&e->ent, oidhash(oid));
	hashmap_add(&object_table, &e->ent);
	return e;

> +	hashmap_add(&object_table, &e->ent);
>  	return e;
>  }
>
>  static void invalidate_pack_id(unsigned int id)
>  {
> -	unsigned int h;
>  	unsigned long lu;
>  	struct tag *t;
> +	struct hashmap_iter iter;
> +	struct object_entry *e;
>
> -	for (h =3D 0; h < ARRAY_SIZE(object_table); h++) {
> -		struct object_entry *e;
> -
> -		for (e =3D object_table[h]; e; e =3D e->next)
> -			if (e->pack_id =3D=3D id)
> -				e->pack_id =3D MAX_PACK_ID;
> +	hashmap_for_each_entry(&object_table, &iter, e, ent) {
> +		if (e->pack_id =3D=3D id)
> +			e->pack_id =3D MAX_PACK_ID;
>  	}
>
>  	for (lu =3D 0; lu < branch_table_sz; lu++) {
> @@ -3511,6 +3525,8 @@ int cmd_main(int argc, const char **argv)
>  	avail_tree_table =3D xcalloc(avail_tree_table_sz, sizeof(struct avail_=
tree_content*));
>  	marks =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));
>
> +	hashmap_init(&object_table, object_entry_hashcmp, NULL, 0);
> +
>  	/*
>  	 * We don't parse most options until after we've seen the set of
>  	 * "feature" lines at the start of the stream (which allows the comman=
d
> diff --git a/t/perf/p9300-fast-import-export.sh b/t/perf/p9300-fast-impo=
rt-export.sh
> new file mode 100755
> index 0000000000..c3c743d04a
> --- /dev/null
> +++ b/t/perf/p9300-fast-import-export.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +test_description=3D'test fast-import and fast-export performance'
> +. ./perf-lib.sh
> +
> +test_perf_default_repo
> +
> +# Use --no-data here to produce a vastly smaller export file.
> +# This is much cheaper to work with but should still exercise
> +# fast-import pretty well (we'll still process all commits and
> +# trees, which account for 60% or more of objects in most repos).
> +#
> +# Use --rencode to avoid the default of aborting on non-utf8 commits,
> +# which lets this test run against a wider variety of sample repos.
> +test_perf 'export (no-blobs)' '
> +	git fast-export --reencode=3Dyes --no-data HEAD >export
> +'
> +
> +test_perf 'import (no-blobs)' '
> +	git fast-import --force <export
> +'
> +
> +test_done
>
