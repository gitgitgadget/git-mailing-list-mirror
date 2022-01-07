Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9621C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 19:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiAGTa5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 14:30:57 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60194 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbiAGTa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 14:30:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D46716E980;
        Fri,  7 Jan 2022 14:30:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eF1ftLI8TGW21Cdn5AGWL5kyuuGESCiAEz/QeA
        76V7g=; b=IYa+Yv/fD7p0AGsltqbJ146Q4h1g414ahKjCJVNlufdmaV243cFHsK
        iHZS52pmoG4kLPaWWZHFivT2qHSQNpxKsG/z+LD4FDqBoqg4qw0vnuCRvuVXOnP5
        L4aCS8n/D6jblJJEY30V+J5Grusr6WDbKt1E19UmMI0TPVYlZkt0Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 857ED16E97A;
        Fri,  7 Jan 2022 14:30:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F22A416E979;
        Fri,  7 Jan 2022 14:30:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        git@vger.kernel.org
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
        <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
        <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
        <xmqqfsq09ziq.fsf@gitster.g>
        <YdeJ8Ub2Q0/c9kO2@camp.crustytoothpaste.net>
        <4D8B32AE-8316-4907-98F6-097901EC3DC0@jrtc27.com>
        <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net>
Date:   Fri, 07 Jan 2022 11:30:52 -0800
In-Reply-To: <Ydea3EO7wrYc9/Ij@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 7 Jan 2022 01:43:56 +0000")
Message-ID: <xmqq7dbb9wcz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54610B8C-6FF0-11EC-8770-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I'm not opposed to a small amount of finagling for this case, but I am
> very much opposed to defining your C ABI in an intentionally difficult
> way.

I was looking at git_qsort_s() today and thought that its use of
"char buf[1k]" on stack is something we would write for a system
without alloca().

We already have xalloca() wrapper defined in the compat-util header.
Perhaps it is a good idea to use it instead?

Both the true alloca() and xmalloc() we use as a fallback (when
<alloca.h> is not available) are supposed to return a block of
memory that is suitably aligned for any use, no?  

 compat/qsort_s.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git c/compat/qsort_s.c w/compat/qsort_s.c
index 52d1f0a73d..63660a4304 100644
--- c/compat/qsort_s.c
+++ w/compat/qsort_s.c
@@ -49,21 +49,23 @@ int git_qsort_s(void *b, size_t n, size_t s,
 		int (*cmp)(const void *, const void *, void *), void *ctx)
 {
 	const size_t size = st_mult(n, s);
-	char buf[1024];
+	char *tmp;
+	int use_alloca;
 
 	if (!n)
 		return 0;
 	if (!b || !cmp)
 		return -1;
 
-	if (size < sizeof(buf)) {
-		/* The temporary array fits on the small on-stack buffer. */
-		msort_with_tmp(b, n, s, cmp, buf, ctx);
-	} else {
-		/* It's somewhat large, so malloc it.  */
-		char *tmp = xmalloc(size);
-		msort_with_tmp(b, n, s, cmp, tmp, ctx);
+	use_alloca = (size < 1024);
+
+	tmp = use_alloca ? xalloca(size) : xmalloc(size);
+
+	msort_with_tmp(b, n, s, cmp, tmp, ctx);
+
+	if (use_alloca)
+		xalloca_free(tmp);
+	else
 		free(tmp);
-	}
 	return 0;
 }
