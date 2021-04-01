Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4070FC43460
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C5160FE6
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 07:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhDAHzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 03:55:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:39562 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhDAHy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 03:54:57 -0400
Received: (qmail 6894 invoked by uid 109); 1 Apr 2021 07:54:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Apr 2021 07:54:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11741 invoked by uid 111); 1 Apr 2021 07:54:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Apr 2021 03:54:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Apr 2021 03:54:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 10/10] tag: don't misreport type of tagged objects in
 errors
Message-ID: <YGV8UOsYUQt7Lpto@coredump.intra.peff.net>
References: <20210308200426.21824-1-avarab@gmail.com>
 <cover-00.11-00000000000-20210328T021238Z-avarab@gmail.com>
 <patch-10.11-a84f670ac24-20210328T021238Z-avarab@gmail.com>
 <xmqq35wdfaw5.fsf@gitster.g>
 <YGRWqX+qF+Rtqr20@coredump.intra.peff.net>
 <87k0pnkwej.fsf@evledraar.gmail.com>
 <YGTGgFI19fS7Uv6I@coredump.intra.peff.net>
 <87eefvkq5d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eefvkq5d.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 10:46:22PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Neither of those types is the correct one. And the segfault is just a
> > bonus! :)
> >
> > I'd expect similar cases with parsing commit parents and tree pointers.
> > And probably tree entries whose modes are wrong.
> 
> So the segfault happens without my patches,

Yeah, sorry if that was unclear. It is definitely a pre-existing bug.

> but the change is that
> before we'd always get it wrong and say "commit, not a tree", but now
> we'll get it right some of the time. Patching the relevant object.c code
> to emit different messages from the various functions shows that it's
> the oid_is_type*() functions that get it right, but object_as_type() is
> wrong as before.
> 
> So that's certainly something I missed.
> 
> But are there any cases where it makes things worse? Or is it just that
> it's not a full fix in all cases, but only a partial one?

Right, I don't think your patch is making anything worse. It's just that
it does not cover all cases where we see an object as two different
types. Nor can it, since it is relying on code paths that actually parse
the object, and not all of them do.

> > My point is that we are not always coming from parse_object_buffer()
> > when we see these error messages.
> 
> If my solution of relying on the parsed v.s. non-parsed shouldn't we
> just devolve to a full object info lookup when emitting the error? It's
> more expensive, but we're emitting an error anyway...

That's certainly one option (that I suggested earlier in [0]). If we go
that route, then we do not need any of this "the caller passes in an
extra bit to say that it is parsing the object, and it found a tree",
because the error routine in object_as_type() would consult the odb
itself.

But I still think it does not make the error messages fully useful. We
might say "object X is really a tree in the odb, but we previously saw
it as a commit". But we will still have to return NULL from
lookup_tree(), so whatever containing object referenced X, _even though
it has the correct type_, will be the one to propagate the failure up
the stack. It was whoever was responsible for that "previously saw" that
is actually corrupt, and we no longer know who that was.

Which is why I wonder if it is worth even bothering to put a lot of
effort in here. If the issue is just that "X is a foo, not a bar" is
sometimes misleading, then we could solve that by simply making the
message more precise ("we saw X as a foo and a bar; one of them is
wrong"). Even if we could know _which_ is wrong with respect to what's
in the object contents, it isn't all that helpful without being able to
tell the user which object reference was the one that led us to the
wrong conclusion.

-Peff

[0] https://lore.kernel.org/git/YGBHH7sAVsPpVKWd@coredump.intra.peff.net/
