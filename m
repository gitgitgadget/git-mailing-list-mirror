Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F435C33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBA920CC7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgAaJDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:03:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:49344 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728151AbgAaJDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:03:30 -0500
Received: (qmail 13016 invoked by uid 109); 31 Jan 2020 09:03:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Jan 2020 09:03:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30417 invoked by uid 111); 31 Jan 2020 09:11:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jan 2020 04:11:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jan 2020 04:03:29 -0500
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/7] fix inconsistent uses of the_repo in
 parse_object()'s call chain
Message-ID: <20200131090329.GB2857810@coredump.intra.peff.net>
References: <cover.1580413221.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1580413221.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 30, 2020 at 05:32:16PM -0300, Matheus Tavares wrote:

> The motivation for this patchset is another series I'm working on, to
> make git-grep stop adding submodules' odbs to the alternates list. With
> that, parse_object() will have to be called with the subdmodules' struct
> repository. But it seemed that this function doesn't pass on the
> received repo to some inner calls, which, instead, always use
> the_repository. This series seeks to fix these inconsistencies.

I read over the patches and they all seem sensible. There may be spots
you missed where these functions are subtly using the_repository under
the hood (or where you used the_repository but could have used some
repository pointer tucked away in a struct). But even if that is the
case, it seems clear that all of the changes are going in the correct
direction, and we can continue to iterate on top.

> Note: I also tried to replace some uses of the_hash_algo with the struct
> git_hash_algo from the received repository, for consitency. (In
> practice, I'm not sure if this is very useful right now, but maybe it
> will be relevant for the change to SHA256?) Still, many functions in
> parse_object()'s call chain call oid_to_hex(), which uses the_hash_algo.
> Since changing this would require a much bigger operation, I decided to
> leave it as is, for now.

I'm not sure I look forward to a day where oid_to_hex() needs to take an
extra parameter, just because it will make it more annoying to use. But
we'll have to go there eventually unless we plan to forbid mixing of
repositories with different hashes within the same process.

The hash transition document says:

  To convert recorded submodule pointers, you need to have the converted
  submodule repository in place. The translation table of the submodule
  can be used to look up the new hash.

which I take to mean that the local copy of the submodule needs to match
the superproject hash (this says nothing about what the upstream owner
of the submodule wants to do; we'd be translating on the fly to the new
hash in the local repo). So using the_hash_algo would work either way.

I don't think we're particularly interested in supporting multiple
unrelated repositories within the same process. While that would be
convenient for some cases (e.g., you have a million repositories and
want to look at all of their trees without creating a million
processes), I don't think it's a goal anyone is really working towards
with this "struct repository" layer.

> Note II: Despite receiving a repo through the apply_state struct,
> apply.c:apply_binary() call functions which uses the_repository
> internally. Because of that, I used the_hash_algo in this function in
> patch 6. Should I change it to use apply_state->repo->hash_algo
> anyway?

I think this follows my "it's OK for now because we're going in the
right direction from above". I.e., we probably do eventually want to use
apply_state->repo->hash_algo, just like we probably do eventually want
all those functions to take a repository argument. But by even using
the_hash_algo, you've at least marked the spot for later fixing (the
very final step of this long process will be eradicating all of
the_hash_algo and the_repository from the bottom of the call-stack on
up).

-Peff
