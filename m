Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49170C04A6A
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 23:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjHKX6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjHKX6W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 19:58:22 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019C0171D
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 16:58:21 -0700 (PDT)
Received: (qmail 18848 invoked by uid 109); 11 Aug 2023 23:58:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 23:58:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32512 invoked by uid 111); 11 Aug 2023 23:58:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 19:58:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 19:58:20 -0400
From:   Jeff King <peff@peff.net>
To:     Ronan Pigott <ronan@rjp.ie>
Cc:     git@vger.kernel.org
Subject: Re: Fetching too many tags?
Message-ID: <20230811235820.GA3311880@coredump.intra.peff.net>
References: <20230811180932.GB2816191@coredump.intra.peff.net>
 <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
 <5a0544e570fb962c95840d99994bf45aa638faa8@rjp.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5a0544e570fb962c95840d99994bf45aa638faa8@rjp.ie>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 10:06:43PM +0000, Ronan Pigott wrote:

> > When you use "--no-tags", that explicitly says "do not bother with tags
> > at all". Recent versions of Git have a protocol extension where the
> > client can say "I am only interested in refs/heads/master; don't bother
> > telling me about other stuff". Since the client knows we do not care
> > about tags, it can use that extension to get a much smaller ref
> > advertisement from the server.
> 
> Do you mean the --negotiation-tip fetch option? In my experience, it doesn't
> appear to have much of an effect in this case.

No, the "negotiation" phase only happens when there are objects to
fetch, and the client and server have to agree on which ones. That's not
happening at all in your case (so --negotiation-tip won't have any
effect).

The feature I was thinking of is that in Git's "v2" protocol, the client
gets to speak first, and so it can say "btw, I am only interested in
these refs". v2 became the default in git v2.29 (of course both client
and server have to support it, but kernel.org is definitely up to date
there).

You can see it in action with something like this:

  GIT_TRACE_PACKET=1 git fetch --no-tags origin master

The "ref-prefix" lines are the client telling the server which prefixes
it's interested in (we have to ask for several variants because "master"
from the command line gets fully qualified based on what the other side
offers). Try it without --no-tags and you'll see a wider ref-prefix
request. If you try:

  GIT_TRACE_PACKET=1 git -c protocol.version=0 fetch --no-tags origin master

you'll see the full advertisement, even with --no-tags. In v0, the
server speaks first and just dumps its complete list of refs.

> > By default, Git will report, to the server, commits reachable from all local
> > refs to find common commits in an attempt to reduce the size of the
> > to-be-received packfile. If specified, Git will only report commits reachable
> > from the given tips. This is useful to speed up fetches when the user knows
> > which local ref is likely to have commits in common with the upstream ref being
> > fetched.
> 
> Now, if I understand correctly, the report does not include the tags that we
> already have? 

So there's no negotiation here at all, as I explained above. But when it
does happen, Git should use all refs, including tags and branches, to
try to reach a common point in the history graph. If you run with
GIT_TRACE_PACKET on a request that actually fetches objects, you'll see
"have" and "want" lines from the client.

For a vanilla fetch from a server you regularly fetch from, the
negotiation is pretty boring and fast (the client tells the server about
the old commit at the tip of the branch, and the server immediately says
"OK, I know about that").

A more interesting one is if you fetch the kernel from Linus's repo, and
then fetch from the stable kernel repo after that. Or maybe vice versa.
There you have two histories that share significant chunks, but also
have each diverged. So you should see the client and server dumping
sha1's at each other until they reach a common point. That's a case
where --negotiation-tip can sometimes speed things up.

-Peff
