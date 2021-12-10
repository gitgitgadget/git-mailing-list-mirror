Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5409C433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 09:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhLJJHg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 04:07:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:48530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234120AbhLJJHf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 04:07:35 -0500
Received: (qmail 17964 invoked by uid 109); 10 Dec 2021 09:04:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Dec 2021 09:04:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28251 invoked by uid 111); 10 Dec 2021 09:04:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Dec 2021 04:04:03 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Dec 2021 04:04:00 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC] fetch: update refs in a single transaction
Message-ID: <YbMYAA1EuFX4Z/5x@coredump.intra.peff.net>
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
 <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
 <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net>
 <YbGsJnTQov6byXzF@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbGsJnTQov6byXzF@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 09, 2021 at 08:11:34AM +0100, Patrick Steinhardt wrote:

> > For the files-backend code, I think system errors would naturally fall
> > out in the same code. Failing to write() or rename() is not much
> > different than failing to get the lock in the first place. So
> > "partial-update" and "non-atomic" behavior would end up the same anyway,
> > and we do not need to expose the third mode to the user.
> 
> I think I disagree here. Failing to write() to me is quite different
> from failing to take a lock: the first one is an unexpected system-level
> error and brings us into a situation where we ain't got no clue why it
> happened. The second one is a logical error that is entirely expected
> given that lockfiles are explicitly designed for this failure mode, so
> we know why they happen. With this in mind, I'd argue that we should
> only continue with the transaction in the latter case, and abort on
> unexpected system-level errors.

Just to be clear, it's not that I necessarily think these error types
are logically related. I only meant that once you are detecting and
recovering from one type, it would be easy to implement it either way.

I'd be OK with either type of behavior. If that was the only difference
between partial-update and non-atomic, though, I'm not sure if that
merits exposing the complexity of a "third mode" to the user. But I
don't feel strongly about it either way.

> > I suspect the surgery needed for the ref-transaction code to allow
> > non-atomic updates would be pretty big, though. It involves checking
> > every error case to make sure it is safe to continue rather than
> > aborting (and munging data structures to mark particular refs as
> > "failed, don't do anything further for this one").
> 
> I hope that it's not going to be that bad if we restrict it to the
> "prepare" phase, but that may just be wishful thinking.

Yeah, maybe. :) I didn't look closely, so it may not be too bad. I just
remember the refs system being very finicky about things like failure,
races, etc. But I'm sure you'll figure it out once you start looking
closely. :)

One thing to watch out for is that in the files backend, _part_ of the
update may be shared by multiple refs: updating the packed-refs file (if
we are deleting refs). So if you are deleting "refs/heads/foo" and
"refs/heads/bar", but taking the lock on "foo" fails, you'd want to make
sure only to delete "bar" from packed-refs, not "foo".

-Peff
