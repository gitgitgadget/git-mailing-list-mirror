Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2711C4727F
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 974EC2071E
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgI3MUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 08:20:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:45264 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729484AbgI3MUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:08 -0400
Received: (qmail 23817 invoked by uid 109); 30 Sep 2020 12:20:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2020 12:20:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27758 invoked by uid 111); 30 Sep 2020 12:20:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2020 08:20:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Sep 2020 08:20:06 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20200930122006.GA1900495@coredump.intra.peff.net>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
 <20200929224356.GH1392312@camp.crustytoothpaste.net>
 <20200930004630.GA623061@coredump.intra.peff.net>
 <20200930021925.GI1392312@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930021925.GI1392312@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 30, 2020 at 02:19:25AM +0000, brian m. carlson wrote:

> If you have a suitably new Git, it will fail with an appropriate
> message on both sides.  The client will complain that you are trying to
> use a remote that uses the wrong hash algorithm and the server will
> complain that you have failed to pass a suitable object-format
> extension.  That will look like this:
> 
>   fatal: mismatched object format: server sha256; client sha1
>   fatal: expected flush after ref listing

That makes sense, and the message isn't too bad.

> That's true if you're using protocol v2 at all, or a suitably new Git
> with protocol v1, although the messages may differ slightly.  However,
> if you're using an older Git with v1, then you'll get this:
> 
>   fatal: protocol error: unexpected '304c98b4860fa40b3e04f3e2e24db1a13ab959922a63209685813908c4fabc83 HEAD'
>   fatal: the remote end hung up unexpectedly
> 
> That's because, as you pointed out, we don't get to the point where the
> client fails to send the value.

That makes switching to sha256 on the server a bit of a flag day, then,
doesn't it? Everybody with older Git will not be able to clone such a
repo. That may be OK for some cases, but I suspect it is going to cause
a delay in servers moving to sha256 themselves. Even if a project is
ready to migrate, it may be hesitant to do so because of third parties
outside of its control (whether external tools like CI, or just wanting
to be open to cloning by random users).

On the other hand, any kind of hash negotiation would require on-the-fly
conversion for that case (i.e., a sha256 server serving an older sha1
client needs to produce the alternate-universe sha1 objects). That's
expensive either in CPU or in disk space, and it may well be that
third-party hosting sites would refuse to enable such an option anyway.

> > The only thing we lose is that a recent client who understands sha256
> > wouldn't be able to contact us and do a sha256-over-v1 transaction. But
> > why would they want to do so?
> 
> Because v2 isn't implemented for pushes yet.  The testsuite does not
> even come close to passing unless you have a fully functional remote
> system.  That's why I implemented protocol support, even though it
> wasn't originally planned.
> 
> That was mentioned in the cover letter of the series that introduced
> protocol support.

Yeah, I think I misunderstood the direction there. I took the
object-format capability to mean that the client and server would
negotiate. But it really is the server saying "I'm going to speak this;
you'd better understand it and be able to translate objects on your
side".

I did realize that getting the test suite to pass meant that we'd be
passing sha256 hashes over the wire. But I had assumed that was part of
the strategy to make everything work in a sha256 world, and that more
interoperability stuff was coming on top. I.e., I thought our current
state was less mature than you ended up implementing.

> I should also point out that v2 SSH support doesn't work at all with
> OpenSSH unless the server is specifically configured to allow the
> GIT_PROTOCOL environment variable.  Since there are many use cases for
> people to push Git data over SSH to servers they do not control, there
> is a valid and viable use case for v1 support.  I personally know people
> with shell accounts who could not use v2 over SSH but could viably use
> v1.  Heck, that's even true for our shell host at work.

Thanks, that's an interesting counter-example that I didn't know about.

> In retrospect, we probably should have sent "GIT_PROTOCOL=version=2" as
> part of the shell command and let implementers deal with the fact that
> their SSH servers would need to adequately parse and interpret shell
> commands to function properly.  But it's probably too late to do that
> now without bumping the protocol to v3.

That was definitely discussed, but rejected because of the
interoperability problems. Not just for servers who actually want v2,
but it would mean that the v2 probe would cause existing v1 servers to
stop working. I.e., it would stop being safe to send v2 probes, which
was the whole point of the scheme.

> > My suggestion does also require that we have a v2 receive-pack protocol,
> > which does not yet exist (but following the blueprint for fetch, I don't
> > expect it to be a big deal).
> 
> If someone would like to implement protocol v2 for push in time for
> 2.29, then that could be a viable approach if we can address the serious
> problem of the SSH situation in that time frame as well.

Hmm. I hadn't really thought of 2.29 as the time-frame. In my mind,
sha256 support is still considered experimental, and we are free to
adjust things as necessary. But maybe that's naive. Anything in the
hands of users may be a source of annoying cross-version problems.

> I will admit to being a bit annoyed that we're discussing changes like
> this at this point.  I've tried to be open about the design and
> implementation, answering questions and providing complete branches and
> reasonably thorough cover letters that people can peruse to know what's
> going on even if they aren't interested in the full series themselves.
> LWN has even summarized some of the later work.  It's fine if folks
> don't want to participate in that process, but it's hard to incorporate
> feedback that comes in well after the fact.  I certainly hope the nature
> and content of my SHA-256 work isn't a surprise to regulars on the list,
> because I've clearly failed to communicate effectively if that's the
> case.

That's a fair criticism. I definitely have not followed your work as
closely as I could have (or perhaps should have). I'm glad we're having
this conversation now at least, though. I had some misunderstandings
about how we planned to proceed. And now I have a much better sense of
where you're at with it (and hopefully Zhichen sees that half of what I
wrote in my original reply is BS).

I can live with the scheme you described. The "flag day" thing is really
my biggest reservation, but it may just be something we have to accept.

-Peff
