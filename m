Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30888C2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1DB2076E
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="NG73gJ6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDGSh3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 14:37:29 -0400
Received: from mout.web.de ([212.227.15.14]:37707 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbgDGSh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586284640;
        bh=c/Ym3a1WZphRZrbzdoIZNsO/CsdQt+eR3FJw/XwR6Qw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=NG73gJ6uw1WAkp71h0ui1ZoMVO55cROeF+msha25mocZPWLRvofOvEjUxLZNvflTQ
         nqtO9pzQmrdGjM93gwG76cI84/b3F3XZfpFGXXg1GgJ/whPUxQtg/GLbI9trl/gt7r
         pUKgqtwlFu2M0wJ2+sVg8pmTUJKA03tw877AbdbE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MhDRB-1ji6uv1L05-00MM9t; Tue, 07
 Apr 2020 20:37:20 +0200
Subject: Re: [PATCH] fast-import: replace custom hash with hashmap.c
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200403121508.GA638328@coredump.intra.peff.net>
 <6926f6fe-2e5c-bcbc-fd0a-5b9a70eed06c@web.de>
 <20200405185951.GA1309762@coredump.intra.peff.net>
 <020726d4-5a5c-e751-2824-d05004823326@web.de>
 <20200406183542.GA23753@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3fd73ee7-14e7-9acd-798e-cb841997f4d7@web.de>
Date:   Tue, 7 Apr 2020 20:37:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200406183542.GA23753@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VmpcvzqkCbQ/rQzRIwbmy5oL06Pp9XmOftP+sCMeBcanpC6rcAh
 JDiGCwdcytmpr2zxeK3DdCJhnhyVzxX39NcAuEQQig2KMqvnjOBjs7p5d4v50iEWGXtC0EG
 cTRQK54KKg/7B59QyiqgTZWUaRERFc/ZqC7oa7NQNxCN2tAWBR7KPxj/wUhwv/FnkNo0L8D
 O1U2wvNxIFR6r7fNAkN9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KHf9yvzzbvk=:gJhDcXua0lPuszP01cbUgA
 LHTPm8Rae0Z7VAL/mxXP3FOOzPhp6yfm6ojW4HB7zMPVdcsHjps3XnvT+DPFX+Bx7981T7+P8
 tWkkqE0ntH//kX6MXpdo9zRykyS3Yx8xXzU/OxQxLMlBY0nKwxisvQ4LgeBPtLeeT22Cz+xO6
 UJj3wUZAPbxqbjarqjQdV4g6s4H+0CKC4RHzjBVO6wQpHF+hOON/XiDy/VCRVahrVi4xiZL7g
 NdhVkwA2fTAF2khB+VPG3QHgEZDMLgGp1HS/uJYvoBSqU6TnLSXrhyMxBZTKnzpagVdFrKMuS
 FKV5GJqpudIF1DLbS6pPN/zWzhm7T/E+1wdVVIiW9gjUdNkj3IYep+9XKaXFn56SqbGQ/dsDJ
 l+ad4DnoZPEIJPa5Sz/SZoaMdmab2JzDYeXxUgajsK+o7mEAOIzLTOx0tDKm11W01oUfnPTgS
 UNlHqvJ1ik4YYuZrlwBdLom82dKlSCdjuEbomq83BBuraa862/LvQq/s0kyY5z4vy7qcGWBjN
 DhW/FSB67lneQJsOS60slfJKzPR3u0Gd1GMz31Xv/WrnWTDbs+XgT1pjdWVUsxoUzVHFp2Gjo
 8vCFjPdb+Mh4eTkKTqA0jUiHKNtJronm0zljnEfUv9mdzyaWatlvAfhcwKyuuDiVrAK+kR2Qz
 y4CK3LWfBm8VXBrAwHFF2PmDkOqFiRxuf47QN8gHt381+oHMxLb/jZ95W82Xn5p0x4bdXvhxN
 cG/9mauc8I4SPQ/bWEBBQvWUpzBJQaaMrACoKWf2iEfxVPrMRfiWGF8mwJK3O3ksz21fzoNf7
 dwZZUmSSrLv77Sn05IDr2EJEd9ApBzvyXVArU5qNrvLUN0NzQFqleiiORz3rY98eiXU6jEky4
 eZH3v9lRzw1M2xAkS8kqRhqWvgmuckG3QwUCwyC6jeE6AKg59fF4bLMJj5KsMBsJriCThdZ3F
 GwlsnwDjVUb1dpUonjvFmOiXwNz4YEJuCxRs6M2MeR/8w6edVL50x2Pan5+mG2fr253Jjzm8P
 GfjnUs8aoSfPiBrO65AlBIHRZBPdKYNBHqdurT8xLMAJD/USMim1UB/YRkPlMWVV1tGBmmFLr
 8FWG/NrvlosZF9Ph4gtICFhtm7Ay7Vz5l8Qymc85P5FK93g8G1DixueHXFEnvhcPCrQ1OrRuz
 vJYebRRdB+JbUtERwr+MpD2ncO+KnGisdDGAIPHKDB0XtTo0Bb+qiHAqHwcer2JInuvbvGSJi
 MuT0Q92dnhSdzrNsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.04.20 um 20:35 schrieb Jeff King:
> On Mon, Apr 06, 2020 at 08:07:45PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>> Interesting. I re-ran mine just to double check, and got:
>> [...]
>> A second run today reported:
>>
>> Test                        origin/master         HEAD
>> -----------------------------------------------------------------------=
----
>> 9300.1: export (no-blobs)   61.58(59.93+1.40)     60.63(59.35+1.22) -1.=
5%
>> 9300.2: import (no-blobs)   239.64(239.00+0.63)   246.02(245.18+0.82) +=
2.7%
>>
>> git describe says v5.4-3890-g86fd3e9df543 in that repo.
>
> I'm on v5.6-rc7-188-g1b649e0bcae7, but I can't imagine it makes a big
> difference.
>
>> Dunno.  My PC has thermal issues and stressing it for half an hour stra=
ight
>> may cause it to throttle?
>
> Yeah. I wonder what the variance is between the 3 runs (assuming you're
> using ./run and doing 3). I.e., is one run in the first set much faster
> than the others, and we pick it as best-of-3.

I did use run with the default three laps.  Ran p9300 directly with
patch v2 applied instead now, got this:

Test                        this tree
=2D----------------------------------------------
9300.1: export (no-blobs)   64.80(60.95+1.47)
9300.2: import (no-blobs)   210.00(206.02+2.04)
9300.1: export (no-blobs)   62.58(60.74+1.35)
9300.2: import (no-blobs)   209.07(206.78+1.96)
9300.1: export (no-blobs)   61.33(60.17+1.03)
9300.2: import (no-blobs)   207.73(205.47+2.04)

> But we
> really do lie to container_of(). See remote.c, for example. In
> make_remote(), we call hashmap_get() with a pointer to lookup_entry,
> which is a bare "struct hashmap_entry". That should end up in
> remotes_hash_cmp(), which unconditionally computes a pointer to a
> "struct remote".

Ugh.  Any optimization level would delay that to after the keydata
check, though, I guess.

There's also function pointer casting going on (with patch_util_cmp()
and sequence_entry_cmp()), which is undefined behavior IIUC.

> Now the hashmap_entry there is at the beginning of the struct, so the
> offset is 0 and the two pointers are the same. So while the pointer's
> type is incorrect, we didn't compute an invalid pointer value. And
> traditionally the hashmap code required that it be at the front of the
> containing struct, but that was loosened recently (and container_of
> introduced) in 5efabc7ed9 (Merge branch 'ew/hashmap', 2019-10-15).

Hmm, OK.

> And grepping around, I don't see any cases where it's _not_ at the
> beginning. So perhaps this is a problem waiting to bite us.

Possibly.

Speaking of grep, I ended up with this oneliner to show all the
comparison functions used with hashmaps:

git grep -W -f <(git grep -wh hashmap_init | cut -f2 -d, | grep -v -e ' .*=
 ' -e NULL -e '^ *$' | sed 's/ //; s/.*)//; s/^/int /' | sort -u)

But I didn't learn much from looking at them, except that most have
that unconditional container_of.

>> Stuffing the oidhash() result into a variable and using it twice with
>> hashmap_entry_init() would work as well.  This would make the reason fo=
r
>> the duplicate find_object() code obvious, while keeping struct
>> hashmap_entry opaque.
>
> I'd prefer not to use a separate variable, as that requires giving it a
> type.

Specifying the type that oidhash() returns and hashmap_entry_init()
accepts is redundant and inconvenient, but that line should be easy to
find and adapt when the function signatures are eventually changed.
Which is perhaps never going to happen anyway?

> Perhaps:
>
>   hashmap_entry_init(&e->ent, lookup_entry.hash);
>
> which is used elsewhere is OK? That still assumes there's a hash field,
> but I think hashmap has always been pretty up front about that (the real
> sin in the original is assuming that nothing else needs to be
> initialized).

That conflicts with that statement from the hashmap.h:

 * struct hashmap_entry is an opaque structure representing an entry in th=
e
 * hash table.

Patch v2 looks good to me, though!

Ren=C3=A9
