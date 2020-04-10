Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E530C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8EA20753
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 21:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgDJVbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:31:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:40260 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726582AbgDJVbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 17:31:47 -0400
Received: (qmail 8323 invoked by uid 109); 10 Apr 2020 21:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 10 Apr 2020 21:31:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3307 invoked by uid 111); 10 Apr 2020 21:42:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Apr 2020 17:42:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Apr 2020 17:31:46 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200410213146.GA2075494@coredump.intra.peff.net>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407235116.GE137962@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 07, 2020 at 04:51:16PM -0700, Emily Shaffer wrote:

> On Tue, Apr 07, 2020 at 04:01:32PM -0700, Emily Shaffer wrote:
> > Thoughts?
> 
> Jonathan Nieder and I discussed this a little bit offline, and he
> suggested another thought:
> 
> [hook "unique-name"]
>   pre-commit = ~/path-to-hook.sh args-for-precommit
>   pre-push = ~/path-to-hook.sh
>   order = 001

Yeah, giving each block a unique name lets you give them each an order.
It seems kind of weird to me that you'd define multiple hook types for a
given name. And it doesn't leave a lot of room for defining
per-hook-type options; you have to make new keys like pre-push-order
(though that does work because the hook names are a finite set that
conforms to our config key names).

What if we added a layer of indirection: have a section for each type of
hook, defining keys for that type. And then for each hook command we
define there, it can have its own section, too. Maybe better explained
with an example:

  [hook "pre-receive"]
  # put any pre-receive related options here; e.g., a rule for what to
  # do with hook exit codes (e.g., stop running, run all but return exit
  # code, ignore failures, etc)
  fail = stop

  # And we can define actual hook commands. This one refers to the
  # hookcmd block below.
  command = foo

  # But if there's no such hookcmd block, we could just do something
  # sensible, like defaulting hookcmd.X.command to "X"
  command = /path/to/some-hook.sh

  [hookcmd "foo"]
  # the actual hook command to run
  command = /path/to/another-hook
  # other hook options, like order priority
  order = 123

I think both this schema and the one you wrote above can express the
same set of things. But you don't _have_ to pick a unique name if you
don't want to. Just doing:

  [hook "pre-receive"]
  command = /some/script

would be valid and useful (and that's as far as 99% of use cases would
need to go).

-Peff
