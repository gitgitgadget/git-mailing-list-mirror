Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16242C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 21:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiAGVaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 16:30:06 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60197 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiAGVaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 16:30:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EF66816F8A2;
        Fri,  7 Jan 2022 16:30:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uOanZGd1lN/a
        ctWT++YJZ1C8b8REvf+KL/Ymg52dL3A=; b=V5exM+3sSkYNoYf8/oAcYiqu1c7u
        FdbKpRSOQFNbO64VRks2s6IrbEa5xxA1pqY02DapHqvEY6rohGGP06EhBfWuQIzc
        2MnDpdCIcGPN1k/izy31OHEY7OGvKJZFJfMTge/ljGWND+LuT77pgIWn6Oa13qSX
        7inUQDSHm8bQIl8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E7C5A16F8A1;
        Fri,  7 Jan 2022 16:30:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D04B816F89A;
        Fri,  7 Jan 2022 16:30:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
        <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
        <xmqqfsq09ziq.fsf@gitster.g>
        <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
        <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
        <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
        <xmqq7dbb9wcz.fsf@gitster.g>
        <40077881-e91a-dfba-5950-cdc03719264d@web.de>
Date:   Fri, 07 Jan 2022 13:30:00 -0800
In-Reply-To: <40077881-e91a-dfba-5950-cdc03719264d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 7 Jan 2022 21:56:49 +0100")
Message-ID: <xmqqzgo76xpj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F8D59E20-7000-11EC-8493-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> If falling back to malloc(3) is fine in general then I wonder if we can
> just it use always.  This would save two branches and make buffer
> management trivial here.  How much worse is malloc(3) on platforms with
> alloca(3)?  Do we sort lots of short lists somewhere?  In other words:
> Does this stack allocation optimization actually make a measurable
> difference?

Well all the preimage of this came from your 04ee8b87 (compat: add
qsort_s(), 2017-01-22), so you tell me ;-)

> Heap fragmention should not be a concern here, at least, because the
> pattern of requesting, using and releasing a single allocation won't
> leave holes.

Sure.  Even in a multi-threaded environment that should be true.

----- >8 --------- >8 --------- >8 --------- >8 --------- >8 -----
Subject: compat/qsort_s.c: avoid using potentially unaligned access

The compatibility definition for qsort_s() uses "char buffer[1024]"
on the stack to avoid making malloc() calls for small temporary
space, which essentially hand-rolls alloca().

But the elements of the array being sorted may have alignment needs
more strict than what an array of bytes may have. &buf[0] may be
word aligned, but using the address as if it stores the first
element of an array of a struct, whose first member may need to be
aligned on double-word boundary, would be a no-no.

We could use xalloca() from git-compat-util.h, or alloca() directly
on platforms with HAVE_ALLOCA_H, but let's try using unconditionally
xmalloc() before we know the performance characteristics of the
callers.

It may not make much of an argument to inspect the current callers
and say "it shouldn't matter to any of them", but anyway:

 * The one in object-name.c is used to sort potential matches to a
   given ambiguous object name prefix in the error path;

 * The one in pack-write.c is done once per a pack .idx file being
   written to create the reverse index, so (1) the cost of malloc()
   overhead is dwarfed by the cost of the packing operation, and (2)
   the number of entries being sorted is the number of objects in a
   pack;

 * The one in ref-filter.c is used by "branch --list", "tag --list",
   and "for-each-ref", only once per operation.  We sort an array of
   pointers with entries, each corresponding to a ref that is shown.

 * The one in string-list.c is used by sort_string_list(), which is
   way too generic to assume any access patterns, so it may or may
   not matter, but I do not care too much ;-)

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 compat/qsort_s.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git c/compat/qsort_s.c w/compat/qsort_s.c
index 52d1f0a73d..0f7ff30f5f 100644
--- c/compat/qsort_s.c
+++ w/compat/qsort_s.c
@@ -49,21 +49,15 @@ int git_qsort_s(void *b, size_t n, size_t s,
 		int (*cmp)(const void *, const void *, void *), void *ctx)
 {
 	const size_t size =3D st_mult(n, s);
-	char buf[1024];
+	char *tmp;
=20
 	if (!n)
 		return 0;
 	if (!b || !cmp)
 		return -1;
=20
-	if (size < sizeof(buf)) {
-		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf, ctx);
-	} else {
-		/* It's somewhat large, so malloc it.  */
-		char *tmp =3D xmalloc(size);
-		msort_with_tmp(b, n, s, cmp, tmp, ctx);
-		free(tmp);
-	}
+	tmp =3D xmalloc(size);
+	msort_with_tmp(b, n, s, cmp, tmp, ctx);
+	free(tmp);
 	return 0;
 }
