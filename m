Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E80A1FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 06:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967119AbdCYGDd (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 02:03:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59891 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965616AbdCYGDc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 02:03:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 04CF47C916;
        Sat, 25 Mar 2017 02:03:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=78Zqa32Avtw1HRebYwwCkcB8qt4=; b=nBdiBv
        AOGZe5iPTmKFCtTnj0s/jlagt9lKCARvvLbdem01Zz9YxPxLos+eIkVJ1hZ+ZlD6
        swvqpSgJPTdvmwyRFnbcvgaKV2PoD0uQR/CdvHWaGhT5nDzvMfvKRMUGGBTaSOzK
        qNg72atQ2Dx5v2jdMQAfGMXCNPaAKCY2LpIxY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dRtJ1CYnXNz663lrMqBRJmCCQKa9+GiW
        y+oQgXK4Yh5PkNBltarl5vCF4Evfjo14mdrAEc/16KOl9Gf6IHOQyYFa6+c2n6mJ
        mXfQZv31gy6xt4W233SoIRnXue/vtbngKco0cCfHbbyMdpCR9lgEPpg6Vq6ly1zT
        d6VMfMtCFtI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1AF37C915;
        Sat, 25 Mar 2017 02:03:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6560F7C914;
        Sat, 25 Mar 2017 02:03:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1dc: safeguard against outside definitions of BIGENDIAN
References: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de>
Date:   Fri, 24 Mar 2017 23:03:28 -0700
In-Reply-To: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Fri, 24 Mar 2017 23:52:10 +0100
        (CET)")
Message-ID: <xmqqr31l6ggf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C4AAFFF8-1120-11E7-BD63-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
> index 6dd0da36084..d99db4f2e1b 100644
> --- a/sha1dc/sha1.c
> +++ b/sha1dc/sha1.c
> @@ -35,7 +35,7 @@
>  
>  #define sha1_mix(W, t)  (rotate_left(W[t - 3] ^ W[t - 8] ^ W[t - 14] ^ W[t - 16], 1))
>  
> -#if defined(BIGENDIAN)
> +#if defined(BIGENDIAN) && BIGENDIAN != 0
>  	#define sha1_load(m, t, temp)  { temp = m[t]; }
>  #else
>  	#define sha1_load(m, t, temp)  { temp = m[t]; sha1_bswap32(temp); }
>
> base-commit: c21884356fab0bc6bc5fa6abcadbda27a112a76c

Is this change _only_ for Windows where BIGENDIAN happens to be
defined to be 0?

If we only assume that BIGENDIAN can be either (0) Not set at all by
platform headers, (1) Not set or set to "0" on little-endian
systems, or (2) Set to any value other than "0" on big-endian
systems, then the patch looks OK.

But it feels a bit too brittle [*1*].

Looking at sha1dc/sha1.c, I notice that it begins like so:

    /*
       Because Little-Endian architectures are most common,
       we only set BIGENDIAN if one of these conditions is met.
       Note that all MSFT platforms are little endian,
       so none of these will be defined under the MSC compiler.
       If you are compiling on a big endian platform and your
       compiler does not define one of these, you will have to add
       whatever macros your tool chain defines to indicate
       Big-Endianness.
     */
    #if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || \
        (defined(__BYTE_ORDER__) && (__BYTE_ORDER__ == __BIG_ENDIAN__)) || \
        defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) ||  defined(__AARCH64EB__) || \
        defined(_MIPSEB) || defined(__MIPSEB) || defined(__MIPSEB__)

    #define BIGENDIAN	(1)

    #endif /*ENDIANNESS SELECTION*/

Notice:

 - It does not consider BIGENDIAN can be set from the outside (i.e.
   it does not say "#ifndef BIGENDIAN" around the above auto
   selection).

 - It considers the actual value of BIGENDIAN given from the outside
   is expendable (i.e. if somehow the caller sets it to 2, it is
   reset to 1 if __BYTE_ORDER and friends tells us we are on a
   big-endian box.

 - It really wants to tell little endian machines not to set
   BIGENDIAN (i.e. lack of "#else" that does "#undef BIGENDIAN").

Which leads me to wonder if a more robust solution that is in line
with the original design of sha1dc/sha1.c code may be to do an
unconditional "#undef BIGENDIAN" before the above block, so that no
matter what the calling environment sets BIGENDIAN to (including
"0"), it gets ignored and we always use the auto-selection.

Anyway, thanks for noticing and raising the issue.


[Footnote]

*1* The "brittle" comment is because the assumption feels a bit too
    narrow, and if we want to solve this without assuming too much
    (i.e. stop thinking about "I just want to fix Windows; I do not
    care about a more general and robust solution"), I think we
    could solve it for something that completely violates your
    assumption.  For example, a platform where something like this
    is used in the header to switch behaviour depending on the
    endianness:

	/* Symbolic constants */
	#define BIGENDIAN 0
	#define LITTLEENDIAN 1
	...

	/* Say which one MY build is */
	#define MYENDIAN BIGENDIAN
	...

	#if MYENDIAN == LITTLEENDIAN
	... code for little endian systems ...
	#else /* MYENDIAN == BIGENDIAN */
	... code for big endian systems ...
	#endif

    would break your patch.  Such a big-endian box will end up using
    the wrong definition of sha1_load().  The original happens to
    choose the right definition by accident, as the header's design
    is that MYENDIAN describes the box you are on, though.

    But as my analysis of how BIGENDIAN is set in the sha1.c file
    itself shows, I think it would be a more robust solution if we
    made sure that we do not pay attention to BIGENDIAN coming from
    the outside world at all, i.e. "#undef" upfront.

    Another possibility would be to rename BIGENDIAN used in
    sha1dc/sha1.c file to something a lot less generic,
    e.g. SHA1DC_BIGENDIAN.


