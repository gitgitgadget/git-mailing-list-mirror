Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 098EA1FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935357AbcJXR2a (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 13:28:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62404 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752030AbcJXR23 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 13:28:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86EEF48A2A;
        Mon, 24 Oct 2016 13:27:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=o+LSCqxnf60t
        HS0CU/2oNmoIbT0=; b=do4dRFUww9HKaMVHVgqTvbk+aUjyJePaIjO+1qioZBHO
        Ky7f54ItB3/xL34LYMlN7+7onjWaa/Nkp60vFAtMA08ivVhppk/4w/MR4K5EwQc3
        McznNO7j2AeiN0JsFjwBMQMVUyE29+gunIE1nKOi3IoV2TRUXkt9N7DalA9ozOI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oUHZvt
        R4OkFcOc509Z+HRwUT85y9vSZFj+FirVPtOqp7NGqTFt86cEMuqYuvyT3eamgsSH
        PnWPNiSd60etPtt6KspTp5f14oRvKDdRY+vV2PCxgpEWf+Gi8joCp0gbUKergucH
        o1rr4y9JezI2Vd/RUSrxzRmzdLruptsehJIMQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EE7F48A29;
        Mon, 24 Oct 2016 13:27:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EADC148A28;
        Mon, 24 Oct 2016 13:27:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
        <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
        <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
        <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
        <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
Date:   Mon, 24 Oct 2016 10:27:25 -0700
In-Reply-To: <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 24 Oct 2016 10:15:57 -0700")
Message-ID: <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 22C2C8B6-9A0F-11E6-A339-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I think it would be preferable to just fix it inline in each place.
>
> Yeah, probably.
>
> My initial reaction to this was
>
>  char *sha1_to_hex(const unsigned char *sha1)
>  {
> -	static int bufno;
> +	static unsigned int bufno;
>  	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
>  	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
>
> "ah, we do not even need bufno as uint; it could be ushort or even
> uchar".  If this were a 256 element ring buffer and the index were
> uchar, we wouldn't even be having this discussion, and "3 &" is a
> way to get a fake type that is a 2-bit unsigned integer that wraps
> around when incremented.
>
> But being explicit, especially when we know that we can rely on the
> fact that the compilers are usually intelligent enough, is a good
> idea, I would think.
>
> Isn't size_t often wider than uint, by the way?  It somehow makes me
> feel dirty to use it when we know we only care about the bottom two
> bit, especially with the explicit "bufno %=3D ARRAY_SIZE(hexbuffer)",
> but I may be simply superstitious in this case.  I dunno.

If we are doing the wrap-around ourselves, I suspect that the index
should stay "int" (not even unsigned), as that is supposed to be the
most natural and performant type on the architecture.  Would it
still result in better code to use size_t instead?



Author: Ren=C3=A9 Scharfe <l.s.r@web.de>
Date:   Sun Oct 23 19:57:30 2016 +0200

    hex: make wraparound of the index into ring-buffer explicit
   =20
    Overflow is defined for unsigned integers, but not for signed ones.
   =20
    We could make the ring-buffer index in sha1_to_hex() and
    get_pathname() unsigned to be on the safe side to resolve this, but
    let's make it explicit that we are wrapping around at whatever the
    number of elements the ring-buffer has.  The compiler is smart enough
    to turn modulus into bitmask for these codepaths that use
    ring-buffers of a size that is a power of 2.
---
 cache.h | 3 +++
 hex.c   | 4 ++--
 path.c  | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 4cba08ecb1..5429df0f92 100644
--- a/cache.h
+++ b/cache.h
@@ -547,6 +547,9 @@ extern int daemonize(void);
 		} \
 	} while (0)
=20
+#define NEXT_RING_ITEM(array, index) \
+	(array)[(index) =3D ((index) + 1) % ARRAY_SIZE(array)]
+
 /* Initialize and use the cache information */
 struct lock_file;
 extern int read_index(struct index_state *);
diff --git a/hex.c b/hex.c
index ab2610e498..5e711b9e32 100644
--- a/hex.c
+++ b/hex.c
@@ -76,9 +76,9 @@ char *oid_to_hex_r(char *buffer, const struct object_id=
 *oid)
=20
 char *sha1_to_hex(const unsigned char *sha1)
 {
-	static int bufno;
+	static size_t bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
-	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
+	return sha1_to_hex_r(NEXT_RING_ITEM(hexbuffer, bufno), sha1);
 }
=20
 char *oid_to_hex(const struct object_id *oid)
diff --git a/path.c b/path.c
index fe3c4d96c6..5b2ab2271f 100644
--- a/path.c
+++ b/path.c
@@ -23,8 +23,8 @@ static struct strbuf *get_pathname(void)
 	static struct strbuf pathname_array[4] =3D {
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
-	static int index;
-	struct strbuf *sb =3D &pathname_array[3 & ++index];
+	static size_t index;
+	struct strbuf *sb =3D &NEXT_RING_ITEM(pathname_array, index);
 	strbuf_reset(sb);
 	return sb;
 }
