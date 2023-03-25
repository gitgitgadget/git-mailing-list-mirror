Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1EC6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 08:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjCYITQ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 25 Mar 2023 04:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjCYITJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 04:19:09 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FF21FFE
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:19:06 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id d10so2375030pgt.12
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 01:19:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5SgEldRxxWL1ZK3F6N8KrAJVrnRxhC2bhAdPDSluXIg=;
        b=KC40VwnCffxt0R9mtiXY8WUP3dfz6YqxsUhsdjhmsc2wR3p3iSim/SfoATqJDsWte2
         1HydMpWqUKqLMQuqwr+ZzZhaU/RF9xKMPI9WHGy47PTIJAdq18J01xRU+TuFDR0YJT87
         QPAtGsQpVcFYnKyBFra9PZUWx7vN8bnasY/0QIqpy+bqgif6RshWb6ERMsZo2y+OuCtE
         RTCazqitECaXJtVOmU7qFScOAjyn2VjAlqCIQf0MS2j2VN0qln+E1zLaa2w1EUBoDBt5
         3PRuSgB6pZ1GCCFXScMabPQkvvcu4CQd75SY7WGOmg7gpcV6Bdm6aR81t00G7d8/Fmd2
         QPPQ==
X-Gm-Message-State: AAQBX9dDQMCKJ5BrYNTDHGe50jx4ERymrpc9IT0C0pW5M/C163B9ICjC
        7rg88DChDc7XH1ceKaXEHgnPGXVheR+CtmzIbw0=
X-Google-Smtp-Source: AKy350Y+LILn/6MxducMXgPKjoFvhqxqZMI/NpRXt7wuC4tsFknuYNHmyhD8o46bp34M+Rzk4896LVeeqUTtcTHywrA=
X-Received: by 2002:a05:6a00:894:b0:606:a4bd:8dde with SMTP id
 q20-20020a056a00089400b00606a4bd8ddemr3056654pfj.4.1679732345599; Sat, 25 Mar
 2023 01:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <13accf6f99d367d137eefd02e3f6bf05bf099e00.1679328580.git.phillip.wood@dunelm.org.uk>
 <3714ba2f6528c38eb9c438126316a08b0cefca7c.1679696180.git.git@grubix.eu>
 <20230325063731.GB562387@coredump.intra.peff.net> <CAPig+cT9zjP++ECkTMjh33gzWyh_ho6n8_XYkXTHxnuGiDbnow@mail.gmail.com>
 <20230325075832.GA579632@coredump.intra.peff.net> <20230325080453.GA852237@coredump.intra.peff.net>
In-Reply-To: <20230325080453.GA852237@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 25 Mar 2023 04:18:54 -0400
Message-ID: <CAPig+cTBwAugUL_u_SPebFRj4j1Gv6FMuH8vn+uUy=6_+GXy3A@mail.gmail.com>
Subject: Re: [PATCH] t3070: make chain lint tester happy
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2023 at 4:04 AM Jeff King <peff@peff.net> wrote:
> On Sat, Mar 25, 2023 at 03:58:32AM -0400, Jeff King wrote:
> > It's not your chain-lint script, but rather the builtin one that sticks
> > "(exit 117) &&" in front of the snippet and evals it. So it creates the
> > exact "foo && bar &" situation by prepending a line to the snippet.
>
> And btw, I think that is the answer to "how did Phillip not notice it?".
> When running "make test" these days, we rely on chainlint.pl to detect
> any problems, and then set GIT_TEST_CHAIN_LINT=0 so that the scripts do
> not invoke it again. But that variable also suppresses the internal
> linter, and thus "make test" passes, but running the script individually
> does not.

Indeed, that would explain it.

> It does seem like a recipe for confusion if the two linters are not in
> agreement. I think we might want to either:
>
>   1. Say that the internal linter still has value, and tweak the
>      suppression so it only turns off the extra per-script run of
>      chainlint.pl, and not the internal one (which is cheap-ish to run).

This is appealing since the internal linter is nearly zero-cost,
though doing this would not fully address the "recipe for confusion"
since the two linters would still not be in agreement. This approach
does have the benefit that it gives at least _some_ protection (minus
caveats mentioned below) on platforms where it may be common to
disable chainlint.pl due to slowness, such as Windows.

>   2. Say that the internal linter does not have value, and we should
>      rely on chainlint.pl. In which case we might as well ditch the
>      internal one completely.

The value of the internal linter is fairly limited in that it only
checks top-level &&-chain; it doesn't check inside subprocesses,
blocks, or any compound statement (case/esac, if/fi, while/done,
etc.).

>      I'm OK with this direction, if we're comfortable that there are no
>      real problems that would be caught by the internal one but not the
>      script.

I retained the internal linter in place "just in case" (i.e. in the
event the script missed something legitimate), but I don't feel
strongly about it.
