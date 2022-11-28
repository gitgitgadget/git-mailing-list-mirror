Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6AFC4321E
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 05:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiK1FK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 00:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiK1FK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 00:10:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5E12D24
        for <git@vger.kernel.org>; Sun, 27 Nov 2022 21:10:53 -0800 (PST)
Received: (qmail 7022 invoked by uid 109); 28 Nov 2022 05:10:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 28 Nov 2022 05:10:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 330 invoked by uid 111); 28 Nov 2022 05:10:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 28 Nov 2022 00:10:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 28 Nov 2022 00:10:52 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Yoichi Nakayama <yoichi.nakayama@gmail.com>,
        Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v7 3/3] git-jump: invoke emacs/emacsclient
Message-ID: <Y4RC3NZsiy5gXPoJ@coredump.intra.peff.net>
References: <pull.1423.v6.git.1669261642.gitgitgadget@gmail.com>
 <pull.1423.v7.git.1669347422.gitgitgadget@gmail.com>
 <d8233f9617563d7c7168afc6e1abfaba57e54038.1669347422.git.gitgitgadget@gmail.com>
 <221125.8635a7o123.gmgdl@evledraar.gmail.com>
 <CAF5D8-uxZOFi8p0bUMaqJCLFxipXCB9fo_Kx=QE6s=DW8Jspgg@mail.gmail.com>
 <221126.86h6ymmvyc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221126.86h6ymmvyc.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 26, 2022 at 12:52:50AM +0100, Ævar Arnfjörð Bjarmason wrote:

> > Second, there is a difficulty passing arbitrary arguments properly to
> > Emacs Lisp properly.
> > For example, your version will cause error with
> >         git jump grep "hello world"
> > My early patch was doing something similar. But the second problem was
> > hard to deal with,
> > so I switched to using a temporary file.
> 
> To the extent that that's painful couldn't we write the grep expression
> / arguments to the tempfile, then feed the tempfile to the ad-hoc elisp
> code?
> 
> It would then read it, get the argument to grep for, and we'd call (grep
> that-argument).

You'd still need to quote the arguments, since you'll be reading
potentially multiple arguments out of the bytestream of the file[1].

If you're not going to quote, the simplest thing is to generate the
line-oriented output and read that.

If you are going to quote, then you don't need the tempfile at all. You
can shove the command into the eval, as if git-jump were run from emacs
directly (but you want to use the --stdout mode introduced in this
series, and not the git commands directly, because of course they're
non-trivial).

I showed how to do the quoting earlier in the thread. But it is ugly,
and this tempfile hack should work (modulo the gross wait loop
afterwards).

-Peff

[1] Of course you could have a stripped-down version that only greps and
    only takes one argument, but then why are you using git-jump in the
    first place?
