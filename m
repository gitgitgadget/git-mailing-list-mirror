Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4C5C001DB
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 22:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237101AbjHKWGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 18:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbjHKWGr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 18:06:47 -0400
Received: from out-91.mta0.migadu.com (out-91.mta0.migadu.com [91.218.175.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0003C1716
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 15:06:45 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1691791604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvpNj/0JfdURjpr+Fidc4h2Zpm5rjY+5tSZ9srI8WRg=;
        b=BuKDMDm9vrtSq+lBFa77v+sGGHgpRej8pScfwMO9lBTbIigpWjQkBVZmha8h/jA2yfaCoA
        YB0jr4trjl472W74Hkz/U3Y+pCJvHD/6Qlw5MaQWeJXQhWXVZKFbYIjP1w+smY8oa8KmgT
        U4B5CwLCAwKNXbQlDgtIB4WFT6d7D5s=
Date:   Fri, 11 Aug 2023 22:06:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Ronan Pigott" <ronan@rjp.ie>
Message-ID: <5a0544e570fb962c95840d99994bf45aa638faa8@rjp.ie>
TLS-Required: No
Subject: Re: Fetching too many tags?
To:     "Jeff King" <peff@peff.net>
Cc:     git@vger.kernel.org
In-Reply-To: <20230811180932.GB2816191@coredump.intra.peff.net>
References: <20230811180932.GB2816191@coredump.intra.peff.net>
 <274ec1a2152b0fd53b35c1591f5177e0b0713430@rjp.ie>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> And the answer, then, is that this is how the Git protocol works. The
> server says "here are all the refs I know about", then the client
> decides what it wants from that list and asks the server to send the
> necessary objects, after which it updates its local refs.

Thanks, this clears up some of my confusion. I had thought that the clien=
t sent
the server what we had and that the server would then decide what objects=
 to
send over.

> When you use "--no-tags", that explicitly says "do not bother with tags
> at all". Recent versions of Git have a protocol extension where the
> client can say "I am only interested in refs/heads/master; don't bother
> telling me about other stuff". Since the client knows we do not care
> about tags, it can use that extension to get a much smaller ref
> advertisement from the server.

Do you mean the --negotiation-tip fetch option? In my experience, it does=
n't
appear to have much of an effect in this case.

  $ time git fetch origin master
  From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   * branch                      master     -> FETCH_HEAD
  git fetch origin master  0.13s user 0.04s system 9% cpu 1.793 total
  $ time git fetch --negotiation-tip=3Dmaster origin master
  From https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux
   * branch                      master     -> FETCH_HEAD
  git fetch --negotiation-tip=3Dmaster origin master  0.10s user 0.06s sy=
stem 9% cpu 1.762 total

Is that because (most) the tags point to commits reachable from master?

My prior (apparently incorrect) understanding of the fetch negotiation is=
 based
on my interpretation of the description of this option in git-fetch(1):

> By default, Git will report, to the server, commits reachable from all =
local
> refs to find common commits in an attempt to reduce the size of the
> to-be-received packfile. If specified, Git will only report commits rea=
chable
> from the given tips. This is useful to speed up fetches when the user k=
nows
> which local ref is likely to have commits in common with the upstream r=
ef being
> fetched.

Now, if I understand correctly, the report does not include the tags that=
 we
already have?=20

Cheers,
Ronan
