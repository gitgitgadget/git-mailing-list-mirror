Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD819C5519F
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601DB22228
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgKLSvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:51:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:56250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgKLSvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:51:47 -0500
Received: (qmail 21755 invoked by uid 109); 12 Nov 2020 18:51:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 18:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 523 invoked by uid 111); 12 Nov 2020 18:51:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 13:51:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 13:51:46 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: How do I "git fetch" with a custom <refspec> but a default
 remote?
Message-ID: <20201112185146.GD701197@coredump.intra.peff.net>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
 <20201111151754.31527-1-avarab@gmail.com>
 <877dqqhd3s.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877dqqhd3s.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 03:19:19PM +0100, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Nov 11 2020, Ævar Arnfjörð Bjarmason wrote:
> 
> > In any case, this is one thing that came out of that
> > investigation. The code we're keeping by moving it to git-submodule.sh
> > can also be replaced by some C code we have, but I wanted to leave
> > that to another submission (if I'll get to it), and make this simply a
> > code removal.
> 
> I may have missed a way to do $subject, but I don't think it's
> possible.

I'm pretty certain it's not. I've run into this before and looked for a
solution without finding one (in my case I was not scripting, but was
just too lazy to type "origin").

> I came up with this patch:
> [...]
> So it works, but what do we think about this calling convention? Do we
> have any prior art for commands that take positional arguments like
> <remote> and <refspec> where you'd like to use a default for an earlier
> argument to provide a subsequent one?

It seems perfectly reasonable to me. The logic for parsing (that users
must understand) is: if --default-remote is specified, act as if the
default remote was specified as the first argument.

I can't think offhand of a case exactly like this, but certainly options
like "git tag -d" influences how the non-option arguments are parsed.

> To make it more general and consistent we'de probably like a --remote=*
> and --refspec arguments, so the invocation would be:
> 
>     git fetch ([--remote=]<name> | --default-remote) [([--refspec=]<refspec> | --default-refspec)]
> 
> But maybe I'm overthinking it...

If we were starting from scratch, then I think that might have been
nicer, because --default-remote would be implied if there is no
"--remote" option. And then my lazy-to-type:

  git fetch topic

would just work. But given that we have the positional <remote>
parameter already, I don't think adding --remote gives much value. And
it raises the question of what "git fetch --remote=foo --remote=bar"
means (I think the answer is last-one-wins).

Slightly orthogonal, but I've occasionally also wished for:

  git fetch @{upstream}

or

  git fetch @{push}

to grab the latest copy of related branches. Those are a _bit_ funny in
that we usually resolve those names to the local tracking branch. But I
think the semantics are clear (we get to that tracking branch by
applying fetch refspecs to a particular remote).

I mention it only in case it gives you any bright ideas on how the
command-line parsing would work there.

-Peff
