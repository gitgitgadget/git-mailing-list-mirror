Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE715C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 18:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378075AbiFPSz5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 14:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbiFPSz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 14:55:56 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78049F01
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655405721;
        bh=xjUt/hJ14LDe/iwnpH0o2N4Xh5DGbqzyygQakcWyaB8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=sAjwt7U8opQ1WNQCEsqdX4u4spbyECITMHMtQ6GmpT+gKAcZRvLQuypNHBDVHfbP0
         Rt36X9Ga+63By0lJ9R3MYIsp9o+0oq1zM+uqc1HB1dOPuVepSEHdNPicxGz/H8xFE1
         vcGIhQuilCi+lmhqw9/3LY72FBW7xL/mCAN6kXxk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.31.99]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MZjIR-1oFGXe37lH-00WsHt; Thu, 16
 Jun 2022 20:55:21 +0200
Message-ID: <3ed80afd-34b3-afd8-5ffb-0187a4475ee1@web.de>
Date:   Thu, 16 Jun 2022 20:55:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH v4 4/6] archive-tar: add internal gzip implementation
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
References: <pull.145.git.gitgitgadget@gmail.com>
 <9df761c3-355a-ede9-7971-b32687fe9abb@web.de>
 <1328fe72-1a27-b214-c226-d239099be673@web.de>
 <220615.86wndhwt9a.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220615.86wndhwt9a.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rtqMzOXEFNgdTAAJS70AxH80acZpQJ3HG3ng7xHW/Q+JHrJdR99
 uhyPMR15J1tvhCHLm1qp2puKSzbxSqJxkw4RjxceXGjEtjwlT69QAEilO8luYRvN4Aivwgv
 SR2SvkjNpWBZEkKgJVrLQQFC6rsEsYEus7FSmceXrXV+vEvVa31XYP1SHugeRxSlpBRfZGH
 GOi+7qXA8L7Qo1duhYzqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MhAYWc4twl0=:yTeTDGXAlCCQvghp2o6Nuv
 KHs8w4W+2TtrSOGbvFlE4IbxzG12dejonpEShFR8dgdf6r/60CVzvxi1X6lSBWEzoVZfkJ1WC
 gJncjHAnEAV7zSW2S1GktGP6sqmI+80jHK3eQpvAC/uHuhhEnCwJLPPdKR6eVjxJBQPV1+AOo
 O4BVbiiERrZJTWXRq4q6ABicdyJBPiBD5iOb9KR7hkurZ786olGqvTdDBOhfbk+wALKCS/VRS
 Bg1YHImK6rHwCXMNWfrJUozW/i7vXVnV1nWgNlpBy4FoH9AcsuGlfBl4qaKwbsfp4PcHPy5C8
 GGD/fExQ+pucQd852GDOgPznrHxiQTIbtohsDdQJYQlGurPFrD9SuKxW4qvg3VuZUm29jyp1l
 aQMexGABDy0C4GT5Hm7wywvFz4KbSNG757FNEKt/B+R0keJc77MaVU4J0ZfvTaDplBp5e4bZ3
 +HAoHmbBpTeEmLzw9Z5jAyJE5ltgHb1O+3OChDYeW5lg+yq4ghMNN4mFOdemc7ILsLCraA5bI
 YQgcEa9XK2bVk+WWmIWn3KEUNDaA6HZesgFlgGL6tbam2eyyJOpeB5stsRXp/KBrrmfPcxkJB
 hgaISW5Rk4Buvomybqv7TAgp7aTsmGLjTFTaZt4uGTBzhP2k+2Fn19KW1Z2atQ7X6lPbjKG1a
 HWPyT9nEzBhq+kFzNjMGGL65k6Ow3J2lgxHn7XQZD3LgRPVsldMxfn3IMuoRQiaGmsUUmSgBL
 1YOeY3lmfZk/1qOpUSQjOUt2fYLe+ZCMotY8dkgiYFrFkDnuhAJeP9yd80KdfM3HrdQ8l+3pR
 21fTSZixd6FFU+QRNxom/VRua2GxOeLcAmYDZsF78awJCHT9QuqqAM2ufkxLPuVca8k+sdZix
 wenvDAck+J4HS7LOgp3oHq2UoW68ayaUNpqUTjjuoRaH/m4EzgmtZhBRh+GjjHXODJNYaDXhM
 2UqbwKaPdTpbJakp/cgtm7gFPEFTzfx3yIhbREyRl5FNwvS5XCtI+kzze2YjzNhR1aM6FBqPx
 dkaNRvYeIhS3R/lGuAOozEoW+nNdwtXtjjNXmVviWUOHrEdL9qFFdy1ubJcQpPDGIEyo8Q0al
 isIbYFPP8YacR8b5ec3+k1Fboz3pdV2GNph
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.22 um 22:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Wed, Jun 15 2022, Ren=C3=A9 Scharfe wrote:
>
>> Git uses zlib for its own object store, but calls gzip when creating tg=
z
>> archives.  Add an option to perform the gzip compression for the latter
>> using zlib, without depending on the external gzip binary.
>>
>> Plug it in by making write_block a function pointer and switching to a
>> compressing variant if the filter command has the magic value "git
>> archive gzip".  Does that indirection slow down tar creation?  Not
>> really, at least not in this test:
>>
>> $ hyperfine -w3 -L rev HEAD,origin/main -p 'git checkout {rev} && make'=
 \
>> './git -C ../linux archive --format=3Dtar HEAD # {rev}'
>
> Shameless plug: https://lore.kernel.org/git/211201.86r1aw9gbd.gmgdl@evle=
draar.gmail.com/
>
> I.e. a "hyperfine" wrapper I wrote to make exactly this sort of thing
> easier.
>
> You'll find that you need less or no --warmup with it, since the
> checkout flip-flopping and re-making (and resulting FS and other cache
> eviction) will go away, as we'll use different "git worktree"'s for the
> two "rev".

OK, but requiring hyperfine alone is burden enough for reviewers.

I had a try anyway and it took me a while to realize that git-hyperfine
requires setting the Git config option hyperfine.run-dir band that it
ignores it on my system.  Had to hard-code it in the script.

> (Also, putting those on a ramdisk really helps)
>
>> Benchmark #1: ./git -C ../linux archive --format=3Dtar HEAD # HEAD
>>   Time (mean =C2=B1 =CF=83):      4.044 s =C2=B1  0.007 s    [User: 3.9=
01 s, System: 0.137 s]
>>   Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.059 s    10 runs
>>
>> Benchmark #2: ./git -C ../linux archive --format=3Dtar HEAD # origin/ma=
in
>>   Time (mean =C2=B1 =CF=83):      4.047 s =C2=B1  0.009 s    [User: 3.9=
03 s, System: 0.138 s]
>>   Range (min =E2=80=A6 max):    4.038 s =E2=80=A6  4.066 s    10 runs
>>
>> How does tgz creation perform?
>>
>> $ hyperfine -w3 -L command 'gzip -cn','git archive gzip' \
>> './git -c tar.tgz.command=3D"{command}" -C ../linux archive --format=3D=
tgz HEAD'
>> Benchmark #1: ./git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive=
 --format=3Dtgz HEAD
>>   Time (mean =C2=B1 =CF=83):     20.404 s =C2=B1  0.006 s    [User: 23.=
943 s, System: 0.401 s]
>>   Range (min =E2=80=A6 max):   20.395 s =E2=80=A6 20.414 s    10 runs
>>
>> Benchmark #2: ./git -c tar.tgz.command=3D"git archive gzip" -C ../linux=
 archive --format=3Dtgz HEAD
>>   Time (mean =C2=B1 =CF=83):     23.807 s =C2=B1  0.023 s    [User: 23.=
655 s, System: 0.145 s]
>>   Range (min =E2=80=A6 max):   23.782 s =E2=80=A6 23.857 s    10 runs
>>
>> Summary
>>   './git -c tar.tgz.command=3D"gzip -cn" -C ../linux archive --format=
=3Dtgz HEAD' ran
>>     1.17 =C2=B1 0.00 times faster than './git -c tar.tgz.command=3D"git=
 archive gzip" -C ../linux archive --format=3Dtgz HEAD'
>>
>> So the internal implementation takes 17% longer on the Linux repo, but
>> uses 2% less CPU time.  That's because the external gzip can run in
>> parallel on its own processor, while the internal one works sequentiall=
y
>> and avoids the inter-process communication overhead.
>>
>> What are the benefits?  Only an internal sequential implementation can
>> offer this eco mode, and it allows avoiding the gzip(1) requirement.
>
> I had been keeping one eye on this series, but didn't look at it in any
> detail.
>
> I found this after reading 6/6, which I think in any case could really
> use some "why" summary, which seems to mostly be covered here.
>
> I.e. it's unclear if the "drop the dependency on gzip(1)" in 6/6 is a
> reference to the GZIP test dependency, or that our users are unlikely to
> have "gzip(1)" on their systems.

It's to avoid a run dependency; the build/test dependency remains.

> If it's the latter I'd much rather (as a user) take a 17% wallclock
> improvement over a 2% cost of CPU. I mostly care about my own time, not
> that of the CPU.

Understandable, and you can set tar.tgz.command=3D'gzip -cn' to get the
old behavior.  Saving energy is a better default, though.

The runtime in the real world probably includes lots more I/O time.  The
tests above are repeated and warmed up to get consistent measurements,
but big repos are probably not fully kept in memory like that.

> Can't we have our 6/6 cake much easier and eat it too by learning a
> "fallback" mode, i.e. we try to invoke gzip, and if that doesn't work
> use the "internal" one?

Interesting idea, but I think the existing config option suffices.  E.g.
a distro could set it in the system-wide config file if/when gzip is
installed.

> Re the "eco mode": I also wonder how much of the overhead you're seeing
> for both that 17% and 2% would go away if you pin both processes to the
> same CPU, I can't recall the command offhand, but IIRC taskset or
> numactl can do that. I.e. is this really measuring IPC overhead, or
> I-CPU overhead on your system?

I'd expect that running git archive and gzip at the same CPU core takes
more wall-clock time than using zlib because inflating the object files
and deflating the archive are done sequentially in both scenarios.
Can't test it on macOS because it doesn't offer a way to pin programs to
a certain core, but e.g. someone with access to a Linux system can check
that using taskset(1).

Ren=C3=A9
