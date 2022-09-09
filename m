Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C77ECAAD5
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 02:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiIICSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 22:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIICSU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 22:18:20 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F261582B
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 19:17:14 -0700 (PDT)
Received: (qmail 29704 invoked by uid 109); 9 Sep 2022 02:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Sep 2022 02:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27432 invoked by uid 111); 9 Sep 2022 02:17:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 22:17:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 22:17:09 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lana Deere <lana.deere@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix
 extension
Message-ID: <YxqiJW4cSp4cBR22@coredump.intra.peff.net>
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
 <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
 <xmqq1qslpprv.fsf@gitster.g>
 <xmqqtu5hoamx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu5hoamx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 08, 2022 at 01:48:38PM -0700, Junio C Hamano wrote:

> The new code assumes that branch.<name>.merge is a full refname, and
> strvec_push() is the right thing to do, when we add the knowledge
> that the current branch we are on by default merges with their
> refs/heads/frotz.  We just ask them to advertise refs/heads/frotz
> and they do not need to advertise refs/tags/frotz etc. let alone
> refs/tags/refs/heads/frotz so using expand_ref_prefix() here is
> wrong.

Right. When I was writing the patch I had no inkling that branch.*.merge
could ever be anything but a fully qualified ref. I don't think I've
ever seen one that isn't, and the documentation is vague. It says:

  [...]The value is handled like the remote part of a refspec, and must match
  a ref which is fetched from the remote[...]

I took "match" to mean a full string match. That text comes from
b888d61c83 (Make fetch a builtin, 2007-09-10); before that it said "the
value has exactly to match a remote part of one of the refspecs...".

But documentation aside, if we've been allowing:

  git config branch.master.merge master

to work forever, then perhaps we need to continue to support it. I
dunno.

> It means that the patch claims that remote.c::branch_merge_matches()
> assume that branch->merge[i]->src may not be a full refname by
> calling refname_match() on it, which is incorrect and may need to be
> corrected.  But that is totally outside the scope of this fix.

I make no claims. ;) I just didn't even consider a non-qualified ref to
be a possibility.

The code in fetch's add_merge_config() that does branch_merge_matches()
comes from 85682c1903 (Correct handling of branch.$name.merge in
builtin-fetch, 2007-09-18), but I don't see any indication there that
non-qualified refs were intended.

So I could either way: non-qualified refs in branch.*.merge has always
worked, and we should continue to support it. Or it was never intended
to work, and we are not obligated to continue supporting random things.

I do think "continue supporting" would probably just mean using
expand_ref_prefix() here as you suggest. It does increase the size of
our request, and the work the server has to do when it matches the
prefixes (which is inherently linear on the number of prefixes we give
it).

One thing we could do, but my patch doesn't, is skip sending this prefix
when it is a subset of the default refspec (i.e., in the default config
refs/heads/foo is already part of refs/heads/, so there is no need to
specify it separately). That doesn't really help if we expand the
prefix, though. The default refspec doesn't include:

  refs/remotes/refs/heads/foo/HEAD

which is exactly the kind of thing we'd ask for. Maybe that is all
premature optimization, though.

-Peff
