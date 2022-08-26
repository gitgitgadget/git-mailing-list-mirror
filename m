Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D322FECAAD2
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 07:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245599AbiHZHsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Aug 2022 03:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245560AbiHZHsS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2022 03:48:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F23CC4809
        for <git@vger.kernel.org>; Fri, 26 Aug 2022 00:48:16 -0700 (PDT)
Received: (qmail 18037 invoked by uid 109); 26 Aug 2022 07:48:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Aug 2022 07:48:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4581 invoked by uid 111); 26 Aug 2022 07:48:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Aug 2022 03:48:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Aug 2022 03:48:15 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2022 at 12:47:53PM +0200, Ævar Arnfjörð Bjarmason wrote:

> What's happening here is that coccinelle can no longer properly parse
> the file after the UNUSED() macros were applied to refs.c.

Ugh. Thanks for finding this.

I'm a little disappointed in coccinelle here. I mean, I get that it
probably can't just use the output of "gcc -E"; it wants to see and
transform the code as written (and maybe even translate macros). But
if it doesn't understand the macros enough to see inside them, there are
a lot of things it is going to get confused by.

A simple example like this shows that it doesn't really see inside them:

  $ cat foo.c
  #define foo(x) bar(x)
  static void fun(int x) { foo(x); }

  $ cat foo.cocci
  expression E;
  @@
  - bar(E);
  + changed(E);

I wonder what it makes of code-generation macros like
for_each_string_list_item(). Or all of commit-slab.

Likewise, the manner in which it fails is unexpected. I could see it
getting confused about the line in question, but why would that cause it
to fail to see the of a strbuf in another function entirely?

I realize that pseudo-parsing C is an incredibly hard problem. But I
also wonder how robust the tool actually is in practice. We've had a lot
of mystery "now why didn't it catch this case" incidents over the years.
Just running the tip of master with --verbose-parsing yields quite a few
"bad" and "parse error" entries in the log. I wonder how much that
contributes.

> We should probably coerce coccinelle into stopping in general if it's
> encountering "BAD:!!!!!" parse errors behind the scenes, as it clearly
> results in broken logic, but offhand (and from briefly browsing the
> manpage) I don't know a way to do that.

You could detect the BAD entries from the log and complain before
returning the exit code to make. But since there are several instances
already, I suspect it's a losing battle. We need some way to actually
_fix_ them. And in the meantime, it does seem to _mostly_ work, as it
clearly has some kind of resync logic.

> But the fix here isn't to delete unused.cocci, but to hold off on the
> UNUSEwork D() patches until we figure out how to make coccinelle jive with
> them.

Yeah, my general skepticism and disappointment above notwithstanding,
this seems like the best path forward from here. I tried a few other
tricks (like --macro-file and --iso-file), but if its parser chokes, I
don't think there's much we can do about it. Even if we wrote a patch to
coccinelle itself (and I have no interest in doing that myself), it
would take a while to become available.

-Peff
