Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388E5C433ED
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0702A610A7
	for <git@archiver.kernel.org>; Fri,  7 May 2021 22:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhEGW6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 May 2021 18:58:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47722 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229470AbhEGW6l (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 May 2021 18:58:41 -0400
Received: (qmail 4720 invoked by uid 109); 7 May 2021 22:57:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 07 May 2021 22:57:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5433 invoked by uid 111); 7 May 2021 22:57:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 07 May 2021 18:57:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 7 May 2021 18:57:39 -0400
From:   Jeff King <peff@peff.net>
To:     Will Chandler <wfc@wfchandler.org>
Cc:     git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
Message-ID: <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
 <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
 <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 07, 2021 at 06:02:17PM -0400, Jeff King wrote:

> On Fri, May 07, 2021 at 05:56:47PM -0400, Jeff King wrote:
> 
> > > +test_expect_success 'directory not created deleting packed ref' '
> > > +	git branch d1/d2/r1 HEAD &&
> > > +	git pack-refs --all &&
> > > +	test_path_is_missing .git/refs/heads/d1/d2 &&
> > > +	git branch -d d1/d2/r1 &&
> > > +	test_path_is_missing .git/refs/heads/d1/d2 &&
> > > +	test_path_is_missing .git/refs/heads/d1
> > > +'
> > 
> > ...this test passes even without your patch applied. I wonder if there's
> > something else required to trigger the problem.
> 
> If I replace "git branch -d" with "git update-ref -d", then the problem
> does trigger (and your patch does indeed clear it up). I wonder what the
> difference is.

I think this comes down to the interfaces. In update-ref, we call
delete_ref(), which creates a transaction to delete the single ref. It
realizes the ref is packed and there is no loose file to delete.

Whereas in git-branch, call the plural delete_refs(), which handles the
packed and loose stores separately. It first deletes everything from the
packed ref store in one go, and then the loose store. And it's actually
the deletion from the loose store which gets weird. The ref isn't
_anywhere_ at this point. So when we try to read it, we don't set the
REF_ISPACKED flag. And thus when it comes time to clean up the loose
ref, we say "not packed, so I guess it's worth calling unlink()". Of
course that syscall fails, but our unlink_or_msg() wrapper turns ENOENT
into success (which is sensible; we want it to be gone, and it is).

And so we think we've deleted a loose ref, and thus call
try_remove_empty_parents(), which cleans up the extra directory.

So I'd argue that it's actually delete_refs() which is called from
git-branch that is a little confused, or possibly even buggy. But I
don't think it's hurting anything, and working around it would probably
be awkward and/or inefficient.

Getting back to your patch, though, you are definitely fixing a problem
with update-ref (which correctly realizes there is no loose ref to clean
up, but forgets that we had to make a lockfile). And the solution you
have looks correct. I think you just need to update the test to exercise
it with "update-ref -d".

-Peff
