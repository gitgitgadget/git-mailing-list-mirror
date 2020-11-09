Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF35AC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69A0B20789
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgKIW2J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:28:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:52004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732105AbgKIW2I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:28:08 -0500
Received: (qmail 4681 invoked by uid 109); 9 Nov 2020 22:28:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2020 22:28:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28090 invoked by uid 111); 9 Nov 2020 22:28:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 17:28:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 17:28:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] t1400: Avoid touching refs on filesystem
Message-ID: <20201109222807.GB670413@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
 <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
 <xmqqpn4mb9bv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn4mb9bv.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 11:48:20AM -0800, Junio C Hamano wrote:

> This is a tangent, but what makes this test doubly interesting is
> that "git update-ref -d HEAD" would have allowed us to make it a
> non-repository if HEAD were detached, and it seems that we do not
> require "--force" to do so.  We probably should forbid removing HEAD
> that id detached without "--force", which is such a destructive
> operation.

Yeah, I'd agree that is a good direction (but it definitely is a tangent
that should come in a separate series).

> >  cp -f .git/HEAD .git/HEAD.orig
> >  test_expect_success 'delete symref without dereference' '
> >  	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
> >  	git update-ref --no-deref -d HEAD &&
> > -	test_path_is_missing .git/HEAD
> > +	test_must_fail git show-ref --verify -q HEAD
> >  '
> 
> This is an example of breaking the repository.  I am not sure if the
> test_must_fail is a good replacement--it would fail even if you say
> "git show-ref --verify -q refs/heads/$branch" where $branch is a
> name of a branch that exists, no?

Perhaps we could more directly check that the repository is broken.
Coupled with the ceiling-limit from earlier in the script, then:

  git rev-parse --git-dir

should fail. Maybe that reveals the intent of what we're expecting a
little more clearly (and more so than your "show-ref before and after
restoring HEAD" example does, in my opinion).

I do have to wonder if this test even cares about HEAD. Could it equally
well work on another symref, like refs/remotes/origin/HEAD?

-Peff
