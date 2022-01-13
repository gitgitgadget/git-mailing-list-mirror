Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C83C433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 23:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbiAMXfS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiAMXfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 18:35:18 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B3C061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 15:35:17 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id b13so29051442edn.0
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 15:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LL/2ibFLxwAzzREvJixdGuvQwPEVeTTmG2WOsS+tyVM=;
        b=AjTvHcPb/JUdNtMw9X/n6fqsUiQo8Jsx/JkKkbVktkV80Fp0KlIqq6R5THuKpX1RfQ
         mIWlIMV+83VGFLP4t9jX6vRjcblF8nh9OzKYs1dh0RpJvXoLI3eC2LGhRTNnG2Ovigh6
         G5nZvGeo+fbFTfQKp0vhOn1upPUDZkmclk2T6bhG5Qo5rTeaUOYdpZhjI2MEfsu+GYm2
         si90vlCMvyUyDu4hiMx2fTwwfXoqLy/uBjzPmL8corpVP5rN9bPoiMyPAL1LK32Zlicc
         +yYxfcJ3m2JtjzCsg7FfNEcgpm9FLcPG10SSwVXiM4yWrHyCE1SbaZv+76Jb561kj0mx
         9o0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LL/2ibFLxwAzzREvJixdGuvQwPEVeTTmG2WOsS+tyVM=;
        b=0FyxgBTxFOF1RDsWOUJcYMcHOTqQ3N6N5revsaSTLB9YySqroUfLq6MKRIOs3cLzzG
         3s/qDRXls3bGcCetGqrk54ISQgru+4cOqLAYX+jcXlWkLuakQkh6fxsJJlYp13817NfC
         OkCHksgJNGAYQU4gtRszqjFiAQMqYYViuhB5Ye0NnyADZLPfEzT7L/1ZU6R2MF6MOStX
         qLTGPytwSN+Y8DWVmzOFiUbi2siOYp0EK5BytHokuSpDUJfx+UKLsY1PQQyacVMZV8eR
         WJSLbGW6OvQDt+ZifiYPBNi2/gPhHicCh5Gnb3NSbmd5CBbwBKObEHMqJJDEW1XtvS7p
         loSQ==
X-Gm-Message-State: AOAM531lPucWiT4i2uYztRzHv36Z9HdlSqgI0anc+B8NgFrmDcZXLLTJ
        zrA2DGW8mcxTyv74z4/ymEeb1GTXWURyJiLXuFKCLdd5CWg=
X-Google-Smtp-Source: ABdhPJzs2B3C+4FbtxQDm++3ZOmJ0mOThkSU3Yzhg56J4WbuV5SYP1OGu6syZCkZar9Db/B1diVTlLqILgzSuyusU7k=
X-Received: by 2002:a17:906:dc8e:: with SMTP id cs14mr5059443ejc.269.1642116916208;
 Thu, 13 Jan 2022 15:35:16 -0800 (PST)
MIME-Version: 1.0
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com> <e68028ebe0afc1bb9e623efbdd30de5a8f0740bf.1642092230.git.gitgitgadget@gmail.com>
In-Reply-To: <e68028ebe0afc1bb9e623efbdd30de5a8f0740bf.1642092230.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 13 Jan 2022 15:35:03 -0800
Message-ID: <CABPp-BGHWJ9-E-OBu_be4dSovZKzS5PYEsc4DsA4VOjOZkcGMA@mail.gmail.com>
Subject: Re: [PATCH 5/5] Accelerate clear_skip_worktree_from_present_files()
 by caching
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 8:43 AM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Trying to clear the skip-worktree bit from files that are present does
> present some computational overhead, for sparse-checkouts.  (We do not
> do the bit clearing in non-sparse-checkouts.)  Optimize it as follows:
>
...
> (NOTE: t/perf/ appears to have timing resolution only down to 0.01 s,
> which presents significant measurement error when timings only differ by
> 0.01s.  I don't trust any such timings below, and yet all the optimized
> results differ by at most 0.01s.)

To follow up on this using using a tool with higher precision for a
few selected cases:

> Test        Before Series    Unoptimized              Optimized
> -------------------------------------------------------------------------=
----
...
> *git add -A*
> full-v3     0.40(0.30+0.07)  0.56(0.36+0.17) +40.0%   0.39(0.30+0.07) -2.=
5%

In hyperfine, the results were:

before-series,full-v3$ hyperfine '~/floss/git/git add -A'
Benchmark #1: ~/floss/git/git add -A
  Time (mean =C2=B1 =CF=83):     129.4 ms =C2=B1   3.0 ms    [User: 84.0 ms=
, System: 59.9 ms]
  Range (min =E2=80=A6 max):   122.5 ms =E2=80=A6 138.3 ms    24 runs

post-optim,full-v3$ hyperfine '~/floss/git/git add -A'
Benchmark #1: ~/floss/git/git add -A
  Time (mean =C2=B1 =CF=83):     133.4 ms =C2=B1   3.0 ms    [User: 85.6 ms=
, System: 61.4 ms]
  Range (min =E2=80=A6 max):   129.7 ms =E2=80=A6 142.7 ms    22 runs

Since 133.4/129.4 ~ 1.0309, we see that we have +3.1% on the execution
timing due to changes in this series.  Notably, the number is actually
positive as we'd expect since we are clearly doing more work, whereas
the t/perf system reports -2.5% due to measurement inaccuracy.

> full-v4     0.37(0.28+0.07)  0.54(0.37+0.16) +45.9%   0.38(0.29+0.07) +2.=
7%
> sparse-v3   0.06(0.04+0.05)  0.08(0.05+0.05) +33.3%   0.06(0.05+0.04) +0.=
0%
> sparse-v4   0.05(0.03+0.05)  0.05(0.04+0.04) +0.0%    0.06(0.04+0.05) +20=
.0%

before-series,sparse-v4$ hyperfine '~/floss/git/git add -A'
Benchmark #1: ~/floss/git/git add -A
  Time (mean =C2=B1 =CF=83):      37.0 ms =C2=B1   1.1 ms    [User: 23.1 ms=
, System: 47.8 ms]
  Range (min =E2=80=A6 max):    35.6 ms =E2=80=A6  42.1 ms    72 runs

post-optim,sparse-v4$ hyperfine '~/floss/git/git add -A'
Benchmark #1: ~/floss/git/git add -A
  Time (mean =C2=B1 =CF=83):      37.3 ms =C2=B1   0.9 ms    [User: 22.8 ms=
, System: 48.7 ms]
  Range (min =E2=80=A6 max):    36.2 ms =E2=80=A6  40.7 ms    72 runs

37.3/37.0 ~ 1.008, so a +0.8% on execution timing.  Hard to measure,
and nice that hyperfine automatically chooses to run this 72 times
just to ensure the data is more reliable.  (Also, the +0.8% is much
more believable than the +20.0% from lack of measurement accuracy,
especially combined with data below)

> *git diff*
> full-v3     0.07(0.04+0.04)  0.24(0.11+0.14) +242.9%  0.07(0.04+0.04) +0.=
0%
> full-v4     0.07(0.03+0.05)  0.24(0.13+0.12) +242.9%  0.08(0.04+0.05) +14=
.3%

before-series,full-v4$ hyperfine '~/floss/git/git diff'
Benchmark #1: ~/floss/git/git diff
  Time (mean =C2=B1 =CF=83):      69.9 ms =C2=B1   1.9 ms    [User: 37.5 ms=
, System: 47.6 ms]
  Range (min =E2=80=A6 max):    66.5 ms =E2=80=A6  74.0 ms    44 runs

post-optim,full-v4$ hyperfine '~/floss/git/git diff'
Benchmark #1: ~/floss/git/git diff
  Time (mean =C2=B1 =CF=83):      73.0 ms =C2=B1   1.7 ms    [User: 40.7 ms=
, System: 47.1 ms]
  Range (min =E2=80=A6 max):    70.3 ms =E2=80=A6  76.2 ms    40 runs

So 73.0/69.9 ~ 1.044, so a +4.4% to the execution timing -- much less
than the +14.3% reported due to lack of measurement accuracy.

(If I had used ~/floss/git/bin-wrappers/git instead of
~/floss/git/git, the timings would have been going from 72.3ms to
75.1ms, representing a +3.9% increase instead.  Probably doesn't
matter, but just in case folks were curious about what if I used the
bin-wrappers.)

> sparse-v3   0.02(0.01+0.04)  0.02(0.01+0.04) +0.0%    0.02(0.01+0.05) +0.=
0%
> sparse-v4   0.02(0.02+0.03)  0.02(0.01+0.04) +0.0%    0.02(0.01+0.04) +0.=
0%

Here, the timings went from 17.5ms to 17.6ms, or +0.6%.  It's really
hard to measure the overhead of the changes of my patch series when
sparse-index is in use, which makes sense since the extra loop only
has to check the toplevel directory, not any of the entries under it.
But it does show just a minor cost in runtime due to the new added
check.



I think the original commit message makes it clear that with the (new)
optimization, the timings are quite reasonable, but maybe this little
extra flavor helps for anyone who was just looking at the percentage
changes.  The timings and timing differences really need to be bigger
than the precision in order to trust the percentage differences, which
just wasn't the case for t/perf here.  But t/perf was good enough to
show that the timings after my series are roughly the same as before
the series (never more than 0.01s slower).
