Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45754C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiFPFCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiFPFCr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:02:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1DA447
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:02:45 -0700 (PDT)
Received: (qmail 12428 invoked by uid 109); 16 Jun 2022 05:02:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.0.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jun 2022 05:02:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Date:   Thu, 16 Jun 2022 01:02:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Richard Oliver <roliver@roku.com>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        jonathantanmy@google.com
Subject: Re: [PATCH] mktree: learn about promised objects
Message-ID: <Yqq5dLagSfVMzyQH@coredump.intra.peff.net>
References: <77035a0f-c42e-5cb3-f422-03fe81093adb@roku.com>
 <0067c46a-7bfd-db9c-5156-16f032814464@github.com>
 <797af8c8-229f-538b-d122-8ea48067cc19@roku.com>
 <574dc4a9-b3c7-1fd3-8c0e-39071117c7f0@github.com>
 <YqkpRE8nykqVv8cn@nand.local>
 <YqlZb3Ycc71+dPu4@coredump.intra.peff.net>
 <ad9b5ec9-14fd-cd66-be87-2fe1eb24296a@roku.com>
 <xmqqa6adzln6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa6adzln6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 15, 2022 at 02:01:33PM -0700, Junio C Hamano wrote:

> Richard Oliver <roliver@roku.com> writes:
> 
> > Meanwhile, is it worth considering a '--promised-as-missing' option
> > (or a config option) for invocations such as 'mktree --missing' that
> > prevents promised objects being faulted-in? Currently, the only
> > reliable way that I've found to prevent 'mktree --missing' faulting-in
> > promised objects is to remove the remote. Such an option could either
> > set the global variable 'fetch_if_missing' to '0' or could ensure
> > 'OBJECT_INFO_SKIP_FETCH_OBJECT' is passed appropriately.
> 
> I didn't spend too much time on thinking this one through myself,
> but do we really need a separte option?
> [...]
> We by grave mistake at 31c8221a (mktree: validate entry type in
> input, 2009-05-14) started insisting on inspecting objects even when
> allow-mising was given.  I do not think it was sensible, given why
> we had "--missing" as an option to allow users to say "you do not
> have to be too paranoid".
> 
> The codebase is so distant but I think we should probably do a moral
> revert/reconstruct of that commit so that the extra paranoia of the
> said commit applies only when "--missing" is not in effect, or
> something like that.

FWIW, I had the same reaction. I think fixing "--missing" should be the
first step, and would unstick Richard's use case, as I understand it.

There is some value to improving the promisor case, since using
"--missing" is a pretty broad stroke (i.e., you'd fail to actual
corruption of missing non-promisor objects). That could either be
checking the promisor object and type without faulting it in, or just
skipping the type-check for objects after confirming that they're
promisors.

But that can come on top, I think. The use case there is also a bit
narrower.  The local repository does not know about all promised
objects. It can only see the boundaries of objects it doesn't have (so
with --filter=tree:0, for example, a partial clone of a repo with path
"a/b/c" would know about "b" but not "c"). So in the most general case
you'd still have to resort to "--missing", but I suspect in practice
you'd always feed things at that boundary to mktree (otherwise, how
would you even know the oid of "c").

-Peff
