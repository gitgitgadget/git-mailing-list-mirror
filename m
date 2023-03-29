Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C10EC6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 06:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjC2G2w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 02:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjC2G2u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 02:28:50 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155A92D57
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 23:28:44 -0700 (PDT)
Received: (qmail 9147 invoked by uid 109); 29 Mar 2023 06:28:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Mar 2023 06:28:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5870 invoked by uid 111); 29 Mar 2023 06:28:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Mar 2023 02:28:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Mar 2023 02:28:43 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
Message-ID: <20230329062843.GC1793752@coredump.intra.peff.net>
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net>
 <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net>
 <CAPig+cSMYt81fcU8fRNhN9qZ=95jvRNv9YGhkM6PxgdMywWnCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSMYt81fcU8fRNhN9qZ=95jvRNv9YGhkM6PxgdMywWnCA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:07:17PM -0400, Eric Sunshine wrote:

> > I just think chainlint.pl is doing a good enough job of catching it that
> > we can rely on it. I'll be curious if Eric has input there on whether it
> > can do even better, which would remove all of the caveats from the
> > commit message.
> 
> It was an intentional design choice, for the sake of simplicity, _not_
> to make chainlint.pl a shell syntax checker, despite the fact that it
> is genuinely parsing shell code. After all, the shell itself -- by
> which test code will ultimately be executed -- is more than capable of
> diagnosing syntax errors, so why burden chainlint.pl with all that
> extra baggage? Instead, chainlint.pl is focussed on detecting semantic
> problems -- such as broken &&-chain and missing `return 1` -- which
> are of importance to _this_ project.

Yeah, I'm not too surprised to hear any of that, and I almost wrote off
chainlint.pl for this purpose (hence the hand-waving in my commit
message). But after realizing it has to find here-docs anyway to ignore
them, it seemed reasonable to bend it to my will. ;)

Thanks again for your patch.

> [1]: Why is that, by the way? Is `eval` not complaining about the
> unclosed here-doc? Is that something that can be fixed more generally?
> Are there other syntactic problems that go unnoticed?

The behavior varies from shell to shell. Historically, I suspect it was
a deliberate decision to read until EOF, because it lets you stick
arbitrary data at the end of a script, like:

  $ cat foo.sh
  my_prog <<\EOF
  1 2 3 4
  5 6 7 8
  [imagine kilobytes of data tables here]

without having to worry about terminating it. I think I've seen it with
something like:

  {
    echo "uudecode <<\EOF | tar tf -"
    tar cf - Documentation | uuencode -
  } >foo.sh

which makes foo.sh a sort of self-extracting tarball. (As an aside, I
was disappointed that I did not have uuencode installed by default on my
system. How times have changed. ;) ).

These days bash will warn about it, but dash will not:

  $ bash foo.sh | wc -l
  foo.sh: line 129028: warning: here-document at line 1 delimited by end-of-file (wanted `EOF')
  901

  $ dash foo.sh | wc -l
  901

Bash still has a zero exit code, though, so aside from the stderr cruft
(which is hidden unless you are digging in "-v" output), the tests would
pass. I can't remember when bash started warning, though "git log -S" in
its repo suggests it was bash 4.0 in 2009.

-Peff
