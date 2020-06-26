Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E47C433E0
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 20:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA266207FC
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 20:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFZUfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:35:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:44334 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFZUfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 16:35:40 -0400
Received: (qmail 11470 invoked by uid 109); 26 Jun 2020 20:35:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jun 2020 20:35:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31508 invoked by uid 111); 26 Jun 2020 20:35:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2020 16:35:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jun 2020 16:35:39 -0400
From:   Jeff King <peff@peff.net>
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Craig H Maynard <chmaynard@me.com>, git@vger.kernel.org
Subject: Re: Regarding Git and Branch Naming
Message-ID: <20200626203539.GA1173768@coredump.intra.peff.net>
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
 <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 11:33:53AM -0700, Chris Torek wrote:

> On Fri, Jun 26, 2020 at 10:19 AM Craig H Maynard <chmaynard@me.com> wrote:
> > Does the git init command really need to create a default branch? Perhaps that step could be left to the user.
> 
> The HEAD pseudo-ref must exist and must contain a valid OID or
> branch name.  (If it does not exist, Git says that the directory
> is not a repository.  Perhaps this test could be weakened, but
> that's definitely a fairly big change.)
> 
> In a new, empty repository there are no valid OIDs, so HEAD must
> contain a branch name.  The branch itself need not exist, but
> whatever name is in HEAD is the branch that will be created
> when the user makes the first commit.

We definitely _could_ extend HEAD to allow a "not pointing at anything"
state. Presumably for reading that would behave like the "pointing at a
branch that doesn't exist yet" case. But I think the experience it
creates for writing is not very good. I.e., I think the best we could do
is something like:

  $ git init
  $ git add some-files
  $ git commit -m whatever
  fatal: HEAD does not point to any branch
  hint: use "git checkout -b <branch>" to make commits on <branch>

Perhaps that's not _too_ bad, but it feels a bit unfriendly (and
definitely more likely to cause backwards compatibility issues than
picking _some_ default name). There would also be a lot of corner cases
to cover and debug (e.g., "git checkout foo" moving away from the "no
branch" state should make the usual complaints if we'd have to overwrite
or modify index and untracked files).

-Peff
