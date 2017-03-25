Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE0B2095E
	for <e@80x24.org>; Sat, 25 Mar 2017 17:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751416AbdCYR2G (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 13:28:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53449 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751395AbdCYR2G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 13:28:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FBBB81A29;
        Sat, 25 Mar 2017 13:22:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rjZpyPKvDLo0CykKaeVrWrhQW8M=; b=dIueT8
        aaUQKaZ5CTvgKqegBwm/hhhuJ3M75jNPr2tWdSnhyQ1yxtlJqJql114wlq7dRqXk
        K5i+gCUprrsd6y3Flui5K+pbdrHYzzokoEDKaWgjZMSMvNs2ELg3sAvmqVoBwjwB
        9d/NmLvNQ0Prg24AQNY/bGPmYOnsnJx1/SsfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h1iw8wfzw9lmf25rKAad5PWjrjmsmvyk
        ItYD31Od9AMM/Lr85Fjqqn6DzJ/otSALvkflcG1dZ4e8sZEbSTFVHH2PNcLHoScu
        ytD/Si8T7kzJkGR/JNAfmuXzPWB6G1ut2Cbms3Jbngi4j73dDJ40wd1XZ47+0jpG
        SDcMoz7Es5c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9845481A28;
        Sat, 25 Mar 2017 13:22:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 091C681A27;
        Sat, 25 Mar 2017 13:22:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1dc: safeguard against outside definitions of BIGENDIAN
References: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de>
        <xmqqr31l6ggf.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 25 Mar 2017 10:22:26 -0700
In-Reply-To: <xmqqr31l6ggf.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 24 Mar 2017 23:03:28 -0700")
Message-ID: <xmqqwpbd46gd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9EC849B2-117F-11E7-B351-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Which leads me to wonder if a more robust solution that is in line
> with the original design of sha1dc/sha1.c code may be to do an
> unconditional "#undef BIGENDIAN" before the above block, so that no
> matter what the calling environment sets BIGENDIAN to (including
> "0"), it gets ignored and we always use the auto-selection.

So here is what I came up with as a replacement (this time as a
proper patch not a comment on a patch).

Dscho, could you see if this fixes your build?

Also, could people on big-endian boxes see if this breaks your
setting (relative to the state before this patch)?

Thanks.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Sat, 25 Mar 2017 10:05:13 -0700
Subject: [PATCH] sha1dc: avoid CPP macro collisions

In an early part of sha1dc/sha1.c, the code checks the endianness of
the target platform by inspecting common CPP macros defined on
big-endian boxes, and sets BIGENDIAN macro to 1.  If these common
CPP macros are not defined, the code declares that the target
platform is little endian and does nothing (most notably, it does
not #undef its BIGENDIAN macro).

The code that does so even has this comment

    Note that all MSFT platforms are little endian,
    so none of these will be defined under the MSC compiler.

and later, the defined-ness of the BIGENDIAN macro is used to switch
the implementation of sha1_load() macro.

One thing the code did not anticipate is that somebody might define
BIGENDIAN macro in some header it includes to 0 on a little-endian
target platform.  Because the auto-detection based on common macros
do not touch BIGENDIAN macro when it detects a little-endian target,
such a definition is still valid and then defined-ness test will say
"Ah, BIGENDIAN is defined" and takes the wrong sha1_load().

As this auto-detection logic pretends as if it owns the BIGENDIAN
macro by ignoring the setting that may come from the outside and by
not explicitly unsetting when it decides that it is working for a
little-endian target, solve this problem without breaking that
assumption.  Namely, we can rename BIGENDIAN this code uses to
something much less generic, i.e. SHA1DC_BIGENDIAN.  For extra
protection, undef the macro on a little-endian target.

It is possible to work it around by instead #undef BIGENDIAN in
the auto-detection code, but a macro (or include) that happens later
in the code can be implemented in terms of BIGENDIAN on Windows and
it is possible that the implementation gets upset when it sees the
CPP macro undef'ed (instead of set to 0).  Renaming the private macro
intended to be used only in this file to a less generic name relieves
us from having to worry about that kind of breakage.

Noticed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1dc/sha1.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 6dd0da3608..35e9dd5bf4 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -12,7 +12,7 @@
 
 /*
    Because Little-Endian architectures are most common,
-   we only set BIGENDIAN if one of these conditions is met.
+   we only set SHA1DC_BIGENDIAN if one of these conditions is met.
    Note that all MSFT platforms are little endian,
    so none of these will be defined under the MSC compiler.
    If you are compiling on a big endian platform and your compiler does not define one of these,
@@ -23,8 +23,9 @@
     defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
     defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)
 
-#define BIGENDIAN	(1)
-
+#define SHA1DC_BIGENDIAN	1
+#else
+#undef SHA1DC_BIGENDIAN
 #endif /*ENDIANNESS SELECTION*/
 
 #define rotate_right(x,n) (((x)>>(n))|((x)<<(32-(n))))
@@ -35,11 +36,11 @@
 
 #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1))
 
-#if defined(BIGENDIAN)
+#if defined(SHA1DC_BIGENDIAN)
 	#define sha1_load(m, t, temp)  { temp = m[t]; }
 #else
 	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
-#endif /*define(BIGENDIAN)*/
+#endif /* !defined(SHA1DC_BIGENDIAN) */
 
 #define sha1_store(W, t, x)	*(volatile uint32_t *)&W[t] = x
 
-- 
2.12.2-399-g034667a458

