Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D933F1F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfJMGnQ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 02:43:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:46854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726698AbfJMGnP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 02:43:15 -0400
Received: (qmail 5572 invoked by uid 109); 13 Oct 2019 06:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 13 Oct 2019 06:43:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15434 invoked by uid 111); 13 Oct 2019 06:46:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 13 Oct 2019 02:46:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 13 Oct 2019 02:43:14 -0400
From:   Jeff King <peff@peff.net>
To:     Teddy Reed <teddy.reed@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Cannot shallow clone using GitHub tag refs after commit 34066f06
Message-ID: <20191013064314.GA28018@sigill.intra.peff.net>
References: <20191012183102.337fe74d728a4942a7de5ab7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191012183102.337fe74d728a4942a7de5ab7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 12, 2019 at 06:31:02PM -0400, Teddy Reed wrote:

> Hello, I am trying to debug an issue where a shallow clone (--depth=1)
> fails when the reference is the tip of a tag on a GitHub repository.
> 
> The git client works on versions below 2.22.0-rc0 up until commit
> 34066f06, "fetch: do not consider peeled tags as advertised tips".
> That commit peels refs in the form of "refs/tags/v2.2.2^{}". My
> question is if the intention was to peel these refs and break this
> functionality? I do not know enough about git to understand if the
> behavior before commit 34066f06 was unintended.

This is a known and intended outcome of that commit. In fact, that fetch
was never _supposed_ to work, but it did in certain circumstances for
a few versions (2.14.x through 2.21.x).

Here are a few background facts:

  - upload-pack does not (and never has) considered the peeled value of
    a ref to be "advertised"

  - unless configured otherwise, upload-pack will generally refuse to
    serve requests for objects it didn't advertise. This has been the
    case since day one, _except_ for one interesting exception, which
    I'll get into below.

  - fetch-pack can realize that the server upload-pack is not
    configured to allow unadvertised requests (by the server not
    advertising that capability string), and refuses to even send such a
    request to the server

  - a bug in fdb69d33c4 (in Git 2.14) meant that for this specific case
    (an object mentioned only as a peeled value), fetch-pack's check was
    wrong, and it would ask the server for the object anyway

So prior to the bug in fdb69d33c4, fetch-pack would refuse the request.
After that bug (and until the fix in 34066f06), it would make the
request and the server would sometimes honor it and sometimes not.

And that's where we get into the one exception. Since 051e4005a3
(helping smart-http/stateless-rpc fetch race, 2011-08-05), the server
upload-pack implicitly allows requesting reachable non-tip objects over
http only.  But it does so quietly, without making a capability
advertisement to the client.

So whether this request works depends on your client version, the server
version, and the protocol in use. I didn't test each combo, but it
should be something like:

  server    | client        | protocol     | works?
  -------------------------------------------------
  <1.7.6.1  | any           | http/ssh/git | no
  >=1.7.6.1 | <2.14         | http/ssh/git | no
  >=1.7.6.1 | >=2.14, <2.22 | http         | yes
  >=1.7.6.1 | >=2.14, <2.22 | ssh/git      | no
  >=1.7.6.1 | >=2.22        | http/ssh/git | no

So that's the back-story, but of course it's still annoying when it
doesn't work with a submodule. Where can we go from here?

  - if you enable protocol v2 (by setting `protocol.version` to `2` in
    your git config), its rules are different: it implicitly allows
    fetching any object, reachable or not.

    Arguably GitHub ought to set uploadpack.allowAnySHA1InWant for all
    repositories, to let the v0 protocol behave the same way (after all,
    any such object is available by making a v2 request already). The
    fact that it hasn't is mostly history and inertia, along with some
    open questions about whether v2 was perhaps a bit too cavalier in
    this regard (but at this point, I think it's mostly a done deal).

  - fetch-pack could assume that fetching via http means the server has
    implicitly enabled uploadpack.allowReachableSHA1InWant, which it
    effectively has since 1.7.6.1. Of course we might be talking to
    another server implementation (I have no idea how JGit works there,
    for example)

  - the flip side of that is: upload-pack could always advertise the
    "allow-reachable-sha1-in-want" capability when it's speaking http,
    since it has effectively enabled it anyway.

  - this is mostly of interest for submodules, which is the case for
    your repo. Your output has this:

> Cloning into '/tmp/test-repo2/gflags'...
> error: Server does not allow request for unadvertised object e171aa2d15ed9eb17054558e0b3a6a413bb01067
> Fetched in submodule path 'gflags', but it did not contain e171aa2d15ed9eb17054558e0b3a6a413bb01067. Direct fetching of that commit failed.

   which I think is a problem in the submodule code. If a direct fetch
   doesn't work, it's supposed to do a larger fetch as a fallback
   (exactly to cope with this situation that a server's tips have moved
   on). If it's not getting the object (which we know is referenced
   directly by a tag!) that is a sign that it could be trying harder.

So I think my first suggestion above is something you can do immediately
to make your case work. The rest are possible changes that could be made
in Git. I do feel like one easy path forward, though, is to just assume
we'll flip the default to the v2 protocol at some point, and all of this
will go away.

-Peff
