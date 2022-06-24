Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ED3C433EF
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiFXUZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jun 2022 16:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiFXUZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jun 2022 16:25:24 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C67C875
        for <git@vger.kernel.org>; Fri, 24 Jun 2022 13:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1656102291;
        bh=jnusv9OEcDKTWn1ClG4khtEF45nF4y4e0UempuM22XM=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Y3cCgSS+nJmF9Je21g+bsEe5KD5WhjfoPkpW+njR5zf2xX98h0BnH18me9OkA0b/g
         1wYnUuzZcra1n+xTWtaVvzQ/PAugb1heJTMPyc3TbVZp+Ej8oTbystX6KF0PmdTeLe
         xbV4q9jJDI4FuV6fB950hCtPHdexShHqqTGsHjys=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.19.130]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjPUE-1nOeYj32yo-00ksDL; Fri, 24
 Jun 2022 22:24:51 +0200
Message-ID: <9c3fc76e-a0ec-c401-07b1-748c006eddda@web.de>
Date:   Fri, 24 Jun 2022 22:24:48 +0200
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
 <3ed80afd-34b3-afd8-5ffb-0187a4475ee1@web.de>
 <220624.8635fujn3o.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <220624.8635fujn3o.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+1i1blpTvw3uRPpyC6CqErWJoVBUcGbIWLHLQCGVjTUjOK6igwc
 ezJqeRBq8n5rTYbLYvQs4RbYz8b1R0m5I/BZBsg0UPPyjOQzt64uf8CZfx5Nf0p0LPJ0XNb
 3juyEgqV/SA55sF00wEXctz0D7VnA/DaWOM9SUwUC39cDxMLXU3/r8JbEokKtE+srp1HOQ1
 fwbQ5ZcNdlACS1deD/8tA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oGY7t6pZ/C4=:zHp0oICc9dM5D6ooZx2s6o
 Pzsmtf8aa8k8xwn6STiJV8ZvX7s+Gt0TO0XfSpEgDM2r3XqxKMg6tSWAhmVOT/qhefvuTpAs1
 DoWaO99hXRIoXiflaDE6HumbklnpeazdS9X5R1mEutGg4zaxaOyUnOwzG6Zs3Jj2iyMPaDzBV
 5/yqbZYGA1zaTdiIB0WfOwnuUteAplUtrRRbdgznIdJxuEZrQ3UhJG6iUZqkMUDB+GswdCRSl
 XNO89jiqZUWzPArIr2kcJlF+ZE+6xuNktFo1Qplr2B4Co7YQj73BniE5yMuVgJa1c1EQyieIz
 8IbztPLyFAPQdt7dazNd0vsaxOVPRcLdS+Oqs3oudtFsfzU+obQZCq4Y6TgaOdftnPK75B6RN
 G/qStRSj8R4KA8+fXEvcHWlbMLj39s/MxHocaBH1GaP9cd1/EHZHpHdyiUAKNBaH6YG02JCGi
 aV/v88H59jC03kFM6AhqU8l45V46TvWbSjJCgmrYKIzGEkEXAyNiosgsr969MseWjS64X/qVs
 vlIZpgDuKIN0whMPgxnd6Am3QWvJPxBw12OOzNJ75gv9lF31Ll35AUPLSUodDYX8EEYtcona7
 PIhA5mBcEQWjZwaMzKWNwOuW8P9VxXeKm9Sa41G45xHYvvuoYnsmGhYFkFze5Wy0Rj8qFUd4E
 pEwHQtsksgYDzGZVrjdYLrMnN/2RrdwMVIaM2VsCQoDua8bPiVpxE19KeUhPyeaZQW+lVKlBW
 UVI3b5gtrEq22WDKwjGB3kvhh932oeomvNRYbGApqHrTz6Gg+AFxde5pZlWG2zmQ/7VNlawCD
 ql8ULQtDJesL63zb4LChnubdDEgIpwSePZefNMVlkg6MPJ6lmubvKjRquMxUacg92WLcl0ZHU
 CrrXVARiySQg8xj83w5dI4xR2e5ejSwsWXvwt5ArASW2FBwXG7TILCU8qZ0YPrta69s+RA8AY
 GzIFdkpuJxhbWxI0x7zjurCb76GrVki69B7FERyITIdRayQdhZkHXKrtpAd7wbnm7mtfR/EU1
 E+wxuJiAcMIhUnjX3b4x93MiIz1KM64pwMCNJgImikk9bOEZ/yyU5ZULpsOErKXS+xsqXP2jB
 GnxixIAtGLV5Kz63fkug73W/jjNUWVcvG1o2xK3T3a4z+JjUL176yIZfw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.06.22 um 13:13 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Jun 16 2022, Ren=C3=A9 Scharfe wrote:
>
>> Am 15.06.22 um 22:32 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>> [...]
>> Understandable, and you can set tar.tgz.command=3D'gzip -cn' to get the
>> old behavior.  Saving energy is a better default, though.
>
> I disagree with that in general, a big reason for why git won out over
> other VCS's is that it wasn't as slow. I think we should primarily be
> interested in the time a user might end up staring at the screen.
>
> I understand the concern to have "git archive" just work, e.g. if you
> uninstall gzip(1) (although that seems rather obscure, but perhaps this
> is for more minimal setups).

The previous attempt came from/via Git on Windows.

> I don't think saving energy is a virtue, *maybe* it is, but maybe your
> computer is powered by hydro, solar or nuclear instead of coal, so even
> if we're taking global energy policy into account for changes to git
> it's highly context dependant.

Or a device runs on battery power and saving energy keeps it running a
bit longer.  Or it's housed in a data center and saving energy helps
reduce cooling requirements.

> In any case, this is also true for pretty much any other git command
> that might spawn processes or threads, e.g. "git grep":
>
> 	$ hyperfine -w3 -L cpus 0,0-7 'taskset --cpu-list {cpus} ./git grep foo=
.*bar' -r 10
> 	Benchmark 1: taskset --cpu-list 0 ./git grep foo.*bar
> 	  Time (mean =C2=B1 =CF=83):      39.3 ms =C2=B1   1.2 ms    [User: 20.=
0 ms, System: 18.6 ms]
> 	  Range (min =E2=80=A6 max):    38.2 ms =E2=80=A6  41.8 ms    10 runs
>
> 	Benchmark 2: taskset --cpu-list 0-7 ./git grep foo.*bar
> 	  Time (mean =C2=B1 =CF=83):      28.1 ms =C2=B1   1.3 ms    [User: 43.=
5 ms, System: 51.0 ms]
> 	  Range (min =E2=80=A6 max):    26.6 ms =E2=80=A6  31.2 ms    10 runs
>
> 	Summary
> 	  'taskset --cpu-list 0-7 ./git grep foo.*bar' ran
> 	    1.40 =C2=B1 0.08 times faster than 'taskset --cpu-list 0 ./git grep=
 foo.*bar'
>
> Here we use less than 1/2 the user/system time when I pin it to 1 cpu,
> but we're 40% slower.
>
> So this is a bit of a digression, but this particular thing seems much
> better left to the OS or your hardware's CPU throttling policy. To the
> extent that we care perhaps more fitting would be to have a global
> core.wrapper-cmd option or something, so you could pass all git commands
> through "taskset" (or your local equivalent), or just use shell aliases.

Not sure what conclusion to draw from these numbers.  Perhaps that
computation is not the bottleneck here (increasing the number of cores by
700% increases speed only by 40%)?  That coordination overhead makes up a
big percentage and there might be room for improvement/tuning?

In any case, I agree we should leave scheduling decisions at runtime to
the OS.

>> The runtime in the real world probably includes lots more I/O time.  Th=
e
>> tests above are repeated and warmed up to get consistent measurements,
>> but big repos are probably not fully kept in memory like that.

On top of that I guess only few people create tgz files at all.  Most of
them I would expect to be created automatically (and cached) by sites
like kernel.org.  So I imagine people rather create tar.xz, tar.zst or
zip archives these days.  Or use git at both ends (push/pull), as they
should. ;-)  I have no data to support this guess, though.

But yeah, the tradeoff sounds a bit weird: Give 17% duration, get 2% CPU
time back -- sounds like a ripoff.  In your example below it's 12%
longer duration for 5% saved CPU time, which sounds a bit better, but
still not terribly attractive.

Look at it from a different angle: This basic sequential implementation
is better for non-interactive tgz creation due to its slightly lower
CPU usage, which we cannot achieve with any parallel process setup.
It's easier to deploy because it doesn't need gzip.  Its runtime hit
isn't *that* hard, and people interested primarily in speed should
parallelize the expensive part, deflate, not run the cheap tar creation
parallel to a single-threaded deflate.  I.e. they should already run
pigz (https://zlib.net/pigz/).

$ hyperfine -L gz gzip,pigz -w3 'git -C ../linux archive --format=3Dtar HE=
AD | {gz} -cn'
Benchmark 1: git -C ../linux archive --format=3Dtar HEAD | gzip -cn
  Time (mean =C2=B1 =CF=83):     20.764 s =C2=B1  0.007 s    [User: 24.119=
 s, System: 0.606 s]
  Range (min =E2=80=A6 max):   20.758 s =E2=80=A6 20.781 s    10 runs

Benchmark 2: git -C ../linux archive --format=3Dtar HEAD | pigz -cn
  Time (mean =C2=B1 =CF=83):      6.077 s =C2=B1  0.023 s    [User: 29.708=
 s, System: 1.599 s]
  Range (min =E2=80=A6 max):    6.037 s =E2=80=A6  6.125 s    10 runs

Summary
  'git -C ../linux archive --format=3Dtar HEAD | pigz -cn' ran
    3.42 =C2=B1 0.01 times faster than 'git -C ../linux archive --format=
=3Dtar HEAD | gzip -cn'

>>> Can't we have our 6/6 cake much easier and eat it too by learning a
>>> "fallback" mode, i.e. we try to invoke gzip, and if that doesn't work
>>> use the "internal" one?
>>
>> Interesting idea, but I think the existing config option suffices.  E.g=
.
>> a distro could set it in the system-wide config file if/when gzip is
>> installed.
>
> I think in practice distros are unlikely to have such triggers for
> "package X is installed, let's set config Y". I mean, e.g. Debian can do
> that with its packaging system, but it's expecting a lot.

I don't *expect* any reaction either way, but packagers *can* go with a
custom config if they see the need.

> Why not flip
> the default depending on if start_command() fails?

Because it's harder to test and support due to its more complicated
behavior, and I don't see why it would be needed.

>>> Re the "eco mode": I also wonder how much of the overhead you're seein=
g
>>> for both that 17% and 2% would go away if you pin both processes to th=
e
>>> same CPU, I can't recall the command offhand, but IIRC taskset or
>>> numactl can do that. I.e. is this really measuring IPC overhead, or
>>> I-CPU overhead on your system?
>>
>> I'd expect that running git archive and gzip at the same CPU core takes
>> more wall-clock time than using zlib because inflating the object files
>> and deflating the archive are done sequentially in both scenarios.
>> Can't test it on macOS because it doesn't offer a way to pin programs t=
o
>> a certain core, but e.g. someone with access to a Linux system can chec=
k
>> that using taskset(1).
>
> Here's a benchmark, this is your hyperfine command, just with taskset
> added. It's an 8-core box, so 0-7 is "all CPUs" (I think...):
>
> 	hyperfine -w3 \
> 		-L cpus 0,0-7 \
> 		-L command 'gzip -cn','git archive gzip' \
> 		'taskset --cpu-list {cpus} ./git -c tar.tgz.command=3D"{command}" arch=
ive --format=3Dtgz HEAD'
>
> Which gives me:
>
> 	Benchmark 1: taskset --cpu-list 0 ./git -c tar.tgz.command=3D"gzip -cn"=
 archive --format=3Dtgz HEAD
> 	  Time (mean =C2=B1 =CF=83):      1.561 s =C2=B1  0.029 s    [User: 1.5=
03 s, System: 0.058 s]
> 	  Range (min =E2=80=A6 max):    1.522 s =E2=80=A6  1.622 s    10 runs
>
> 	Benchmark 2: taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"gzip -c=
n" archive --format=3Dtgz HEAD
> 	  Time (mean =C2=B1 =CF=83):      1.337 s =C2=B1  0.029 s    [User: 1.5=
35 s, System: 0.075 s]
> 	  Range (min =E2=80=A6 max):    1.298 s =E2=80=A6  1.388 s    10 runs
>
> 	Benchmark 3: taskset --cpu-list 0 ./git -c tar.tgz.command=3D"git archi=
ve gzip" archive --format=3Dtgz HEAD
> 	  Time (mean =C2=B1 =CF=83):      1.493 s =C2=B1  0.032 s    [User: 1.4=
53 s, System: 0.040 s]
> 	  Range (min =E2=80=A6 max):    1.462 s =E2=80=A6  1.572 s    10 runs
>
> 	Benchmark 4: taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"git arc=
hive gzip" archive --format=3Dtgz HEAD
> 	  Time (mean =C2=B1 =CF=83):      1.503 s =C2=B1  0.026 s    [User: 1.4=
66 s, System: 0.036 s]
> 	  Range (min =E2=80=A6 max):    1.469 s =E2=80=A6  1.542 s    10 runs
>
> 	Summary
> 	  'taskset --cpu-list 0-7 ./git -c tar.tgz.command=3D"gzip -cn" archive=
 --format=3Dtgz HEAD' ran
> 	    1.12 =C2=B1 0.03 times faster than 'taskset --cpu-list 0 ./git -c t=
ar.tgz.command=3D"git archive gzip" archive --format=3Dtgz HEAD'
> 	    1.12 =C2=B1 0.03 times faster than 'taskset --cpu-list 0-7 ./git -c=
 tar.tgz.command=3D"git archive gzip" archive --format=3Dtgz HEAD'
> 	    1.17 =C2=B1 0.03 times faster than 'taskset --cpu-list 0 ./git -c t=
ar.tgz.command=3D"gzip -cn" archive --format=3Dtgz HEAD'
>
> Whic I think should control for the IPC overhead v.s. the advantage of
> multicore. I.e. we're faster with "gzip -cn" on multicore, but the
> internal implementation has an advantage when it comes to

Right, #1, #3 and #4 all run sequentially, but #1 has the pipe overhead
to deal with as well, which adds 5 percentage points to its runtime.

Ren=C3=A9
