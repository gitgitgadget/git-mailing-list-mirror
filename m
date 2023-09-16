Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0883CD37B2
	for <git@archiver.kernel.org>; Sat, 16 Sep 2023 05:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjIPFuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Sep 2023 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjIPFuU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2023 01:50:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE01BD3
        for <git@vger.kernel.org>; Fri, 15 Sep 2023 22:50:15 -0700 (PDT)
Received: (qmail 1413 invoked by uid 109); 16 Sep 2023 05:50:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 16 Sep 2023 05:50:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9039 invoked by uid 111); 16 Sep 2023 05:50:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 16 Sep 2023 01:50:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 16 Sep 2023 01:50:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] merge-ort: drop custom err() function
Message-ID: <20230916055013.GD13092@coredump.intra.peff.net>
References: <20230914093409.GA2254811@coredump.intra.peff.net>
 <20230914093948.GA2254894@coredump.intra.peff.net>
 <CABPp-BEhgZB3Q5VKTznOFwt2+Ptcf6ffyJSbXXnmoa_4_zRAVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEhgZB3Q5VKTznOFwt2+Ptcf6ffyJSbXXnmoa_4_zRAVg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 15, 2023 at 07:54:28PM -0700, Elijah Newren wrote:

> Oops, when I simplified the err() function copied from
> merge-recursive.c in one way, I failed to notice that it enabled
> further simplifications.

Ah, I didn't even realize that it had been copied from there. That makes
a lot more sense now.

> >   2. It formats the error string into a strbuf, prepending "error: ",
> >      and then feeds the result into error(). But this is wrong! The
> >      error() function already adds the prefix, so we end up with:
> >
> >         error: error: Failed to execute internal merge
> 
> ...and the same problem can be found in merge-recursive.c's err() function.
> 
> Not sure what current opinions on whether we should bother fixing
> those up.  I do intend on nuking merge-recursive.c, but I obviously
> haven't had much Git time this year.

Hmm, I'm not sure that it does. It has this code:

          if (opt->buffer_output < 2)
                  flush_output(opt);
          else {
                  strbuf_complete(&opt->obuf, '\n');
                  strbuf_addstr(&opt->obuf, "error: ");
          }

so we only add the extra "error:" tag when we are in a buffering mode
that writes into the strbuf (indicated by a high buffer_output field).

And then later, after formatting the new string into opt->obuf, we do
this:

          if (opt->buffer_output > 1)
                  strbuf_addch(&opt->obuf, '\n');
          else {
                  error("%s", opt->obuf.buf);
                  strbuf_reset(&opt->obuf);
          }

So we call error() iff buffer is low, in which case we would not have
added the prefix earlier. And that makes sense. If we are collecting
messages in obuf, we cannot use error(), and we have to handle the
prefix ourselves.

So I think it's correct? If you started with merge-recursive's err() and
then stripped it down to remove the extra buffering stuff, I can see
that it would be a natural error to accidentally leave in the extra
prefix while doing so.

I certainly find the code confusing (the split "< 2" and "> 1"
conditions to trigger related cases is a nice obfuscation bonus), but I
_think_ it's right. And if the end goal is to ditch merge-recursive.c, I
don't think it's worth spending any more brain power on it.

> > A few of these messages starts with capital letters, which is unlike our
> > usual error message style. I didn't clean that up here. We could do so
> > on top,
> 
> There are two of these.  In my defense, they were copied verbatim from
> merge-recursive.c.  And I, um, never noticed the problem over there
> before copying.  Or after.

That makes sense. We have a ton of these lurking in the code base. I
usually try to clean them up when I touch relevant lines, but I wasn't
sure about the path_msg thing here.

> Yeah, all callers of err()/error() are for things that should never
> happen regardless of repository contents and should result in an
> instant abort, whereas anything calling path_msg() is a conflict or
> informational message that is expected for various kinds of repository
> data -- these messages are accumulated and later shown.

That makes sense in general. And I think most of these err() calls are
of that form (in fact, I'd expect most corruption to just trigger a
die() at a low level anyway, but we've been slowly lib-ifying that
away).

The one that gave me pause was my "the external merge driver gave us a
failure" case that I used for testing. In theory we could say "oops,
your merge driver is broken" and keep going. But I think it's not just
"broken", but "oops, your merge driver died with a signal", since a
non-zero exit just means conflicts. So at that point probably something
really has gone terribly wrong (not necessarily with Git, but with your
merge driver!).

> Another distinction is that any call to path_msg() is associated to a
> very specific path (or a few specific paths in special cases like
> renames or add/add with conflict modes), whereas none of the calls to
> err()/error() have a specific path they are about.  This serves a few
> purposes:

I think some of them are about specific paths. We hit err() if
merge_3way() returns -1, but that call can of course also result in a
regular conflict.

But if they're catastrophic errors anyway (as above), this part is kind
of moot.

> Anyway, long story short is that I think continuing to use error()
> instead of path_msg() or something else makes sense here.  The capital
> to lowercase cleanups make sense; we could even #leftoverbits for that
> piece.

Sounds good. I'll post a patch in a second, just to take care of it
while we're thinking about it.

-Peff
