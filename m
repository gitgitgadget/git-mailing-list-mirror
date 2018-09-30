Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C5C1F453
	for <e@80x24.org>; Sun, 30 Sep 2018 05:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeI3LwZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 07:52:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:36614 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727707AbeI3LwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 07:52:25 -0400
Received: (qmail 14444 invoked by uid 109); 30 Sep 2018 05:20:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Sep 2018 05:20:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9832 invoked by uid 111); 30 Sep 2018 05:20:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Sep 2018 01:20:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Sep 2018 01:20:51 -0400
Date:   Sun, 30 Sep 2018 01:20:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kyle Hubert <khubert@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] Improvement to only call Git Credential Helper once
Message-ID: <20180930052051.GC32120@sigill.intra.peff.net>
References: <20180928163716.29947-1-khubert@gmail.com>
 <20180929081705.GI2174@sigill.intra.peff.net>
 <xmqqk1n486o1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk1n486o1.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 12:06:38PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Wow, what's old is new again. Here's more or less the same patch from
> > 2012:
> >
> >   https://public-inbox.org/git/20120407033417.GA13914@sigill.intra.peff.net/
> >
> > Unfortunately, some people seem to rely on this multi-helper behavior. I
> > recommend reading the whole thread, as there are some interesting bits
> > in it (that I had always meant to return to, but somehow 6 years went
> > by).
> 
> After reading that thread again, my version of summary is that
> 
>  - storing the credential obtained from a helper back to the same
>    helper may be pointless at best and may incur end-user
>    interaction (e.g. asking for symmetric encryption key before the
>    data hits the disk), but it can be used as a "we used what you
>    gave us successfully" ping-back signal.  We may not have designed
>    approve() to do "store" back to the same helper by default and
>    instead to do so only when asked by the helper, if we knew
>    better.  But an unconditional change of behaviour will break
>    existing users and helpers.
> 
>  - storing the credential obtained from a helper to a different
>    helper may have security implications, and we may not have
>    designed approve() to do "store" by default to all helpers if we
>    knew better.  But an unconditional change of behaviour will break
>    existing users and helpers.

Yeah, I agree with that summary, except I want to pick a nit with the
very last sentence.

You're not wrong that it will break those existing users, but there are
security implications. If you're expecting and relying on that behavior,
then all is well with the current code, and you'd be annoyed by a
change. But if you're not expecting it, the system is not just broken:
it may be leaking credentials from a higher-security first-choice helper
to a lower-security second-choice one.

And that's why I wonder if it might be the right thing to break
compatibility in this case.

> Assuming that the above summary is accurate, I think the former is
> easier to solve.  In the ideal end game state, we would also have
> "accepted" in the protocol and call the helper that gave us the
> accepted credential material with an earlier "get" (if the helper is
> updated to understand "accepted").  The "accepted" may not even need
> to receive the credential material as the payload.

I think you can really solve both by adding a "retrieved" key to the
store step of the protocol (which can be done in a backwards-compatible
way, since all sides are supposed to ignore keys they don't understand).

Then a helper which understands "retrieved" can say "Oh, this came from
another helper; I don't need to store it". And that includes things that
might have come from itself! Likewise, helpers might take options to
tell them how to behave. So the "do some https thing and cache it"
combination from that earlier thread would be:

  [credential]
  helper = magic-https-thing
  helper = cache

and the safe version of "try high-security thing, and then fall back to
caching" would be:

  [credential]
  helper = high-security-thing
  helper = cache --no-retrieved

(that keeps the default matching the current behavior, but obviously we
could flip it if we wanted to have a safer default but leave the
existing case with an escape hatch).

> The latter is trickier, as there are design considerations.
> 
>  - We may want to allow the helper that gives the credential back
>    from the outside world upon "get" request to say "you can 'store'
>    this to other helpers of this kind but not of that kind".  If we
>    want to do so, we'd need to extend what is returned from the
>    helper upon "get" (e.g. "get2" will give more than what "get"
>    does back).

I don't think you need a "get2". The helpers should be free to pass back
extra keys (but old versions of Git just won't do anything with them).

>  - We may want to allow the helper that receives the credential
>    material from others to behave differently depending on where it
>    came from, and what other helpers done to it (e.g. even a new
>    credential the end user just typed may not want to go to all
>    helpers; an on-disk helper may feel "I'd take it if the only
>    other helpers that responded to 'store' are the transient
>    'in-core' kind, but otherwise I'd ignore").  I am not offhand
>    sure what kind of flexibility and protocol extension is
>    necessary.

If we have a "retrieved" flag, it could be "retrieved=some-helper" to
show which helper it came from. One tricky thing, though, is that
helpers do not always have a simple name (they can be arbitrary shell
expressions).

>  - We may want to be able to override the preference the helper
>    makes in the above two.  The user may want to say "Only use this
>    on-disk helper as a read-only source and never call 'store' on it
>    to add new entries (or update an existing one)."

Yes. I think if we go this route that helpers would just annotate
credentials they pass back (e.g., a key that says "this credential has
property foo") and other credentials would take user direction to
respect them (e.g., credential-cache would grow an option to say "do not
cache things with property foo").

The final patch in that earlier thread:

  https://public-inbox.org/git/20120408071300.GB13662@sigill.intra.peff.net/

showed what it would look like to just pass the properties around
between the helpers. That would be enough so that an individual helper
"foo" could:

  - set a key like "from=foo"

  - treat "from=foo" as a no-op for the "store" step (thus avoiding
    the ask-for-passphrase-again problem that started this current thread)

And then other helpers like credential-cache could grow options like
"--ignore=from", which would not cache anything that has a non-empty
"from" property.

-Peff
