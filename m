Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046A8201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 19:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbdBTTVH (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Feb 2017 14:21:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:58846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdBTTVG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 14:21:06 -0500
Received: (qmail 28267 invoked by uid 109); 20 Feb 2017 19:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 19:21:05 +0000
Received: (qmail 15828 invoked by uid 111); 20 Feb 2017 19:21:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Feb 2017 14:21:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2017 14:21:03 -0500
Date:   Mon, 20 Feb 2017 14:21:03 -0500
From:   Jeff King <peff@peff.net>
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     git@vger.kernel.org
Subject: Re: Sending informational messages from upload-pack
Message-ID: <20170220192103.6v66lpghgir3erhn@sigill.intra.peff.net>
References: <148761588216.31363.15518967793189077139@typhoon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148761588216.31363.15518967793189077139@typhoon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2017 at 07:38:02PM +0100, Lukas Fleischer wrote:

> It would be handy to be able to show a message to the user when
> cloning/fetching from a repository (e.g. to show a warning if a
> repository is deprecated). This should technically already be possible
> using the current pack protocol and sidebands. However, to my knowledge,
> there is no easy way to configure this on the server side; writing a
> wrapper around git-upload-pack(1) or replacing git-upload-pack(1) seem
> to be the only options.

I wouldn't recommend wrapping upload-pack. You don't know you have a
sideband until partway through the upload-pack conversation. And clients
do not expect sideband at all until we get to the pack-sending part of
the protocol (I think; I just quickly verified the location of the
demuxer async code in fetch-pack.c, but I didn't dig into it in depth).

So I don't think you can do a MOTD or similar in a backwards-compatible
way. You're only allowed to talk if the conversation results in an
actual pack being sent.

> What I have in mind is something like a post-upload hook whose stdout
> and stderr are redirected to sideband 2 and 3, respectively. The commit
> message of 20b20a22f (upload-pack: provide a hook for running
> pack-objects, 2016-05-18) suggests that such a hook should be
> implemented as a "config variable hook" rather than a regular hook.

Yeah, because of the "upload-pack is special and untrusted" rule, this
can't be a regular hook. I think the config mechanism used by 20b20a22f
would be the right approach.

If my fetch-pack assertion above is right, technically the hook added by
20b20a22f is sufficient for your purposes, if your hook looks like:

  echo >&2 "pre-pack message"
  git pack-objects "$@"
  echo >72 "post-pack message"

but I would not be opposed to having pre-/post- hooks that run
separately, if only for the convenience of the admin.

> One could think of additional parameters passed to such a hook. For the
> purposes I intend to use this, no parameters are needed. However, a
> fixed per-repository MOTD would be too inflexible since we are using
> namespaces and database accesses to determine whether a repository is
> "deprecated".

There was a proposed post-upload-pack hook a long time ago that
collected clone/fetch stats, and we used it at GitHub for many years.
These days we use something much more invasive that dumps stats from
every git invocation over a Unix socket.

> Am I missing any "easy" already supported way to add such messages
> without patching Git or writing a git-upload-pack(1) wrapper? If not,
> does this sound general and useful enough to become an official feature?
> Are there any alternative suggestions on how to display such messages?

I don't think there's any other mechanism to do what you're asking,
aside from the hook in 20b20a22f.

-Peff
