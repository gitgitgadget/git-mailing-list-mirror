Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968C8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Jun 2022 01:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiFIB1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiFIB1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 21:27:50 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623A2BC2
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 18:27:48 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kyleam.com; s=key1;
        t=1654738066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pYdfU5cTAFjyymBZ07OlZ5G1GjTS2+Cg7jaG4Bikhi8=;
        b=ZYastEm2C8IyRu7hAl6kRSlb/yJsUdHIWI0MCB26AP6yQ/+O5W/58inHJFduV0iWbhgESo
        ETbdJ/zBBXMWNPTpU2cMz9tGN1078EBNr+v5Y/yvWM3oisg3QpgyccEH4/uw/dLSD2wpGL
        /2fPB60yWfXoRCeWhLgRKdGecEN/Xqz7X4orqJzG7pCsEygMG2JIJAS49Do+pmCekrL2zv
        KrA2oefjVBeJDho7yJg7gcPIgiEszxGJE4JPDQuqbDV4+gmifNpbqiZ0Wwb1rBrBLKh8vS
        gUwK/6STvbQ1mKZfs9Nk2w0vgmEEgCeXrY0QyT1vqw5E8LannVZGgF6F77kzbA==
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jeff King <peff@peff.net>
Cc:     Tassilo Horn <tsdh@gnu.org>, Tao Klerks <tao@klerks.biz>,
        git@vger.kernel.org
Subject: Re: [BUG?] Major performance issue with some commands on our repo's
 master branch
In-Reply-To: <YqEyh5opAaJxph2+@coredump.intra.peff.net>
References: <87h750q1b9.fsf@gnu.org>
 <CAPMMpohzqKo-+q-tOcXymmzGxuOY-mf2NPRviHURm8-+3MPjZg@mail.gmail.com>
 <87y1yb2xc8.fsf@gnu.org> <YqEyh5opAaJxph2+@coredump.intra.peff.net>
Date:   Wed, 08 Jun 2022 21:27:43 -0400
Message-ID: <87sfoe7hio.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: kyleam.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King writes:

> I suspect the issue may be quite subtle. Even you asked for
> "--no-patch", the underlying diff may still be used for other things.
> For example, simplifying away TREESAME commits. I.e., ones which did not
> change anything from their parents after applying path restrictions,
> diff-filters, etc. There may be other cases, too (e.g., --follow).
>
> I think the code could be written to realize that none of those features
> are in use, and disable the diff entirely in favor of checking whether
> the two trees has the same object id. That would yield _mostly_ the same
> behavior, though there are probably corner cases (e.g., a tree with an
> odd mode entry, say, may get parsed so as to produce an empty diff, even
> though it's not byte for byte identical). That may be an acceptable
> tradeoff. But I think the code would be a bit brittle (it needs to know
> about all the cases where a diff might matter, and we may add more
> later).

Do you think it'd be safe to make --no-patch imply --diff-merges=3Doff, as
Tao suggested elsewhere in this thread?

  https://lore.kernel.org/git/CAPMMpog-7eDOrgSU9GjV4G9rk5RkL-PJhaUAO3_0p2Yx=
fRf=3DLA@mail.gmail.com

If so, it seems like that'd be a good way to get speedups for some merge
commits.  For example, here are hyperfine timings for the current tip of
git.git's master branch:

  Benchmark #1: git show --no-patch --format=3D%h 1e59178e3f
    Time (mean =C2=B1 =CF=83):      47.8 ms =C2=B1   1.5 ms    [User: 43.2 =
ms, System: 4.6 ms]
    Range (min =E2=80=A6 max):    46.8 ms =E2=80=A6  54.4 ms    59 runs
=20=20=20
    Warning: Statistical outliers were detected. Consider re-running
    this benchmark on a quiet PC without any interferences from other
    programs. It might help to use the '--warmup' or '--prepare'
    options.
=20=20=20
  Benchmark #2: git show --no-patch --diff-merges=3Doff --format=3D%h 1e591=
78e3f
    Time (mean =C2=B1 =CF=83):       3.2 ms =C2=B1   0.2 ms    [User: 2.5 m=
s, System: 0.8 ms]
    Range (min =E2=80=A6 max):     2.9 ms =E2=80=A6   6.8 ms    688 runs
=20=20=20
    Warning: Command took less than 5 ms to complete. Results might be
    inaccurate.
=20=20=20=20
    Warning: Statistical outliers were detected. Consider [...]
    options.
=20=20=20
  Benchmark #3: git log --no-walk --format=3D%h 1e59178e3f
    Time (mean =C2=B1 =CF=83):       3.2 ms =C2=B1   0.1 ms    [User: 2.4 m=
s, System: 0.8 ms]
    Range (min =E2=80=A6 max):     2.9 ms =E2=80=A6   4.2 ms    697 runs
=20=20=20
    Warning: Command took less than 5 ms to complete. Results might [...]
=20=20=20=20
    Warning: Statistical outliers were detected. Consider [...]
=20=20=20=20
=20=20=20
  Summary
    'git log --no-walk --format=3D%h 1e59178e3f' ran
      1.01 =C2=B1 0.08 times faster than 'git show --no-patch --diff-merges=
=3Doff --format=3D%h 1e59178e3f'
     14.98 =C2=B1 0.79 times faster than 'git show --no-patch --format=3D%h=
 1e59178e3f'
