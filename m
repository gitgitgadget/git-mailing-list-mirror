Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5ACC433DB
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0883664F18
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 19:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhCRTrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 15:47:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:41408 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231552AbhCRTr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 15:47:28 -0400
Received: (qmail 782 invoked by uid 109); 18 Mar 2021 19:47:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Mar 2021 19:47:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24262 invoked by uid 111); 18 Mar 2021 19:47:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Mar 2021 15:47:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 18 Mar 2021 15:47:27 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
Message-ID: <YFOuT6L0dsrCGTBk@coredump.intra.peff.net>
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 17, 2021 at 09:06:06PM +0100, Han-Wen Nienhuys wrote:

> I'm working on some extensions to Gerrit for which it would be very
> beneficial if we could tell from the reflog if an update is a
> fast-forward or not: if we find a SHA1 in the reflog, and see there
> were only FF updates since, we can be sure that the SHA1 is reachable
> from the branch, without having to open packfiles and decode commits.

I left some numbers in another part of the thread, but IMHO performance
isn't that compelling a reason to do this these days, if you are using
commit-graphs.

Just walking the reflog might be _slightly_ faster, though not
necessarily (it depends on whether the depth of the object graph or the
depth of the reflog chain is deeper). It might matter more if you are
using a more exotic storage scheme, where switching from accessing
reflogs to objects implies extra round-trips to a server (e.g., custom
storage backends with JGit; I don't know the state of the art in what
Google is doing there).

> For the reftable format, I think we could store this easily by
> introducing more record types. Today we have 0 = deletion, 1 = update,
> and we could add 2 = FF update, 3 = non-FF update.
> 
> However, the textual reflog format doesn't easily allow for this.
> However, we might add a convention, eg. have the message start with
> 'FF' or 'NFF' depending on the nature of the update.
> 
> Does this make sense, and if yes is it worth proposing a change?

At GitHub we do something similar. We don't generally use reflogs much
at all, but we keep a custom "audit log": a single append-only file that
records every ref update in the repository. And its format just happens
to be one reflog entry per line, prefixed by the updated ref.

And there we do generally annotate the FF-ness of an update by stuffing
it into the free-form message field (in fact, we shove in a small JSON
object, so we record multiple fields like the pushing id, IP, etc).

But the main goal there isn't performance (and in fact we don't
generally consult it for anything outside of debugging). The reason we
record FF-ness is for later debugging or analysis. We don't prune from
the audit log, and we don't consider it for reachability when we prune
objects (since otherwise you'd never be able to prune anything!). So the
objects sometimes aren't available later to compute, but we still want
to know if the user did a force-push, etc.

I don't think that really applies to regular reflogs, because they do
imply reachability (and they are not great for later analysis, because
we may selectively expire unreachable entries).

-Peff
