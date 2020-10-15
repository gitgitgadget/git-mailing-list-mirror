Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B9DC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82DC206B5
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbgJOT2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:28:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:33356 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391541AbgJOT2r (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:28:47 -0400
Received: (qmail 24148 invoked by uid 109); 15 Oct 2020 19:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:28:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32158 invoked by uid 111); 15 Oct 2020 19:28:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:28:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:28:45 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [RFC] CodingGuidelines: mark external declarations with "extern"
Message-ID: <20201015192845.GD1108210@coredump.intra.peff.net>
References: <xmqq8scgzqis.fsf@gitster.c.googlers.com>
 <20201009015505.GB1314@generichostname>
 <xmqqtuv4uncn.fsf@gitster.c.googlers.com>
 <xmqqy2kfryiu.fsf@gitster.c.googlers.com>
 <xmqqtuv3ryhr.fsf_-_@gitster.c.googlers.com>
 <20201009195701.GA967869@coredump.intra.peff.net>
 <xmqqpn5rrvfg.fsf@gitster.c.googlers.com>
 <20201015013607.GA388244@coredump.intra.peff.net>
 <xmqq8sc7h0ld.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8sc7h0ld.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 15, 2020 at 10:15:42AM -0700, Junio C Hamano wrote:

> > As others noted, gcc 10 actually does complain about this. And we can
> > easily stick -fno-common into the DEVELOPER knobs, if it's something we
> > want to catch (I had actually forgotten it wasn't the default).
> 
> Yup, that is a good thing to do regardless.  I am mostly interested
> in seeing "extern" in front of all extern decls (not defns) from
> human readers' point of view, though.

OK, patch incoming.

> > I see you picked up my patch as jk/report-fn-typedef, but applied it
> > directly on v2.28, and not on top of your "drop these extra externs"
> > patch. That makes sense if we're not going to remove them, but then your
> > conflict resolution shows my patch as removing them. :)
> 
> I think the patch rearranged that way shows why the new typedef
> shines.
> 
> It makes it immediately recognisable that set_die_routine() and
> friends are functions, not pointers to functions, and because the
> reason why "extern" was in front of them was because the last person
> who "cleaned up" the header failed to recoginise that they are
> functions without the help from this new typedef.
> 
> All of that depends on the fact that everybody understands that the
> current rule is not to write "extern" in front of external
> declaration of functions, so perhaps we may want to update the log
> message to mention why "extern" were removed from these two.

I added:

  Note that this also removes the "extern" from these declarations to
  match the surrounding functions. They were missed in 554544276a
  (*.[ch]: remove extern from function declarations using spatch,
  2019-04-29) presumably because of the unusual syntax.

which I think clarifies it.

Here's that patch re-rolled, plus the DEVELOPER one.

  [1/2]: usage: define a type for a reporting function
  [2/2]: config.mak.dev: build with -fno-common

 config.mak.dev    |  1 +
 git-compat-util.h | 12 +++++++-----
 usage.c           | 18 +++++++++---------
 3 files changed, 17 insertions(+), 14 deletions(-)

-Peff
