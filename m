Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F81E2035F
	for <e@80x24.org>; Tue, 25 Oct 2016 18:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941855AbcJYS2p (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Oct 2016 14:28:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59639 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932538AbcJYS2o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2016 14:28:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A7847580;
        Tue, 25 Oct 2016 14:28:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hHEMDDbPGeTV
        e0ajsFtf1h+N4qs=; b=vgPEPQTChN6g7BppxWjEomm+0/eed6rDRfqKbrVbKyiI
        Pg5yrcD4ZzIOmQ03hmRKIkc7hRnufAIMxKVh0Zvs8tbNvSKwqfq6JQsJSj3MnGGX
        VlAjtdyUOIdVnsZJkKSomdxzMOxe1x8LpxCDVyWfKP0tzf8QfpiJhBXnGoCAJRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Ig/TRB
        gV8jYKB4SAgNWqeIJRFkNz2V5M8igxHdB7ECryd3mOjjgdobJ4vp5rxuDjvC3GII
        v5lKOw2PNHgRnJgovY2wPtLqRSbknF7druCA0Du71NnGp4i0RQsjaxgAfotvXjER
        IBJ2B9QoDc6rMl6GC7T++4o1+uxI/AgDPAf3Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4E2EC4757F;
        Tue, 25 Oct 2016 14:28:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C609D4757E;
        Tue, 25 Oct 2016 14:28:42 -0400 (EDT)
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
        <xmqqshrl7j42.fsf@gitster.mtv.corp.google.com>
        <b1f9054e-fadb-c2d3-bf95-00e88e1fb85b@web.de>
        <xmqq60ohtib5.fsf@gitster.mtv.corp.google.com>
        <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net>
Date:   Tue, 25 Oct 2016 11:28:40 -0700
In-Reply-To: <20161025003023.6vaqofsixana3zno@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Oct 2016 20:30:23 -0400")
Message-ID: <xmqqd1ios2p3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DB8E35FC-9AE0-11E6-BA7A-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 24, 2016 at 04:53:50PM -0700, Junio C Hamano wrote:
>
>> > So how about this?  It gets rid of magic number 3 and works for arra=
y
>> > size that's not a power of two.  And as a nice side effect it can't
>> > trigger a signed overflow anymore.
>>=20
>> Looks good to me.  Peff?
>
> Any of the variants discussed in this thread is fine by me.

OK, here is what I'll queue then.
I assumed that Ren=C3=A9 wants to sign it off ;-).

-- >8 --
From: Ren=C3=A9 Scharfe <l.s.r@web.de>
Date: Sun, 23 Oct 2016 19:57:30 +0200
Subject: [PATCH] hex: make wraparound of the index into ring-buffer expli=
cit

Overflow is defined for unsigned integers, but not for signed ones.

We could make the ring-buffer index in sha1_to_hex() and
get_pathname() unsigned to be on the safe side to resolve this, but
let's make it explicit that we are wrapping around at whatever the
number of elements the ring-buffer has.  The compiler is smart enough
to turn modulus into bitmask for these codepaths that use
ring-buffers of a size that is a power of 2.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 hex.c  | 3 ++-
 path.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hex.c b/hex.c
index ab2610e498..845b01a874 100644
--- a/hex.c
+++ b/hex.c
@@ -78,7 +78,8 @@ char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
-	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);
+	bufno =3D (bufno + 1) % ARRAY_SIZE(hexbuffer);
+	return sha1_to_hex_r(hexbuffer[bufno], sha1);
 }
=20
 char *oid_to_hex(const struct object_id *oid)
diff --git a/path.c b/path.c
index fe3c4d96c6..9bfaeda207 100644
--- a/path.c
+++ b/path.c
@@ -24,7 +24,8 @@ static struct strbuf *get_pathname(void)
 		STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	static int index;
-	struct strbuf *sb =3D &pathname_array[3 & ++index];
+	struct strbuf *sb =3D &pathname_array[index];
+	index =3D (index + 1) % ARRAY_SIZE(pathname_array);
 	strbuf_reset(sb);
 	return sb;
 }
--=20
2.10.1-777-gd068e6bde7

