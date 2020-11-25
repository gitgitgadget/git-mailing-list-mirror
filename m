Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9FFC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C7B9206B5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 09:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKYJhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:37:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:41892 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgKYJhJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 04:37:09 -0500
Received: (qmail 9094 invoked by uid 109); 25 Nov 2020 09:37:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 25 Nov 2020 09:37:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27724 invoked by uid 111); 25 Nov 2020 09:37:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 25 Nov 2020 04:37:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 25 Nov 2020 04:37:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] crendential-store: use timeout when locking file
Message-ID: <X74lw+fyurzqVbg1@coredump.intra.peff.net>
References: <xmqq361v334r.fsf@gitster.c.googlers.com>
 <20201124193208.74fe4mticgkbxou3@safonso-t430>
 <xmqq4kleif26.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq4kleif26.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 02:08:01PM -0800, Junio C Hamano wrote:

> Simão Afonso <simao.afonso@powertools-tech.com> writes:
> 
> > +credentialStore.fileTimeout::
> > +	The length of time, in milliseconds, for git-credential-store to retry
> > +	when trying to lock the credentials file. Value 0 means not to retry at
> > +	all; -1 means to try indefinitely. Default is 1000 (i.e., retry for
> > +	1s).
> 
> I do not remember what was said in the first round of the review,
> but I wonder if this is the best name for users.  I think it is good
> enough, but do ".lockTimeout" or ".lockTimeoutMS" make it even
> easier to grok, perhaps?

Yeah, I think those are a bit more obvious.

> > +
> > +	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout_ms) < 0)
> > +		die_errno("unable to get credential storage lock in %d ms", timeout_ms);
> 
> Should this be die_errno()?  Looking at lock_file_timeout(), I am
> not sure if the value of errno is valid in all codepaths that return
> failure.

I think it's the right thing here. Inside hold_lock_file_for_update_timeout(),
we'd pass errno to unable_to_lock_die(), etc. So if there is a code path
in lock_file_timeout() that isn't setting errno properly, we should
probably be fixing that.

Another option would be to just pass LOCK_DIE_ON_ERROR here, but I think
for this use I prefer the smaller "unable to lock" to the big "another
git process may have crashed" advice message we'd give in that case.

-Peff
