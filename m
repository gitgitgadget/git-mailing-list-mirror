Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B3FC433E0
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF03020842
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 22:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHDWHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 18:07:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:48354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHDWHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 18:07:41 -0400
Received: (qmail 6462 invoked by uid 109); 4 Aug 2020 22:07:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 22:07:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16979 invoked by uid 111); 4 Aug 2020 22:07:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 18:07:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 18:07:40 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200804220740.GA2022650@coredump.intra.peff.net>
References: <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
 <20200803180824.GA2711830@coredump.intra.peff.net>
 <874kpi47xj.fsf@osv.gnss.ru>
 <20200804195830.GA2014743@coredump.intra.peff.net>
 <873652166e.fsf@osv.gnss.ru>
 <20200804212518.GB2020725@coredump.intra.peff.net>
 <87y2muxf5m.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87y2muxf5m.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 05, 2020 at 12:41:25AM +0300, Sergey Organov wrote:

> >> It's 4 lines above, as it's in fact common for all the cases but the
> >> first one.
> >
> > Ah, I missed that. That raises more questions, though. ;)
> >
> > For "-m" we do not need to set revs->diff; why do we need to do so
> > here?
> 
> Good question!
> 
> I believe --diff-merges=all should reset revs->diff back to 0 to
> entirely undo all the effects of '-c' and '--cc', provided those
> appeared before on the command-line, that '-m' fails to do.

Making it counteract "--cc" makes sense, but revs->diff is used for much
more than that. So "--cc" sets revs->diff to 1, but so do many other
unrelated options (e.g., "--full-diff" for one).

I think to do it right you'd need to have this part of the code just set
a single enum variable, like:

  ...
  else if (!strcmp(arg, "--cc")) {
          revs->diff_merges = DIFF_MERGES_DENSE_COMBINED;
  } else if (!strcmp(arg, "-m")) {
          revs->diff_merges = DIFF_MERGES_ALL_PARENTS;
  }
  ...etc...

and then later resolve that into the set of flags we need:

  switch (revs->diff_merges) {
  case DIFF_MERGES_DENSE_COMBINED:
	revs->diff = 1;
	revs->dense_combined_merges = 1;
	revs->combine_merges = 1;
	revs->ignore_merges = 0;
	break;
  case DIFF_MERGES_ALL_PARENTS:
	revs->ignore_merges = 0;
	break;
  ...etc...
  }

it may even be that we can get rid of the separate combine_merges and
dense_combined_merges flag and just have callers look at
rev.diff_merges, which would simplify the code even further. But that
cleanup could also come later on top.

> Admittedly, I didn't yet check what is the outcome of, say,
> "git log -c -m". Is it = "-c", ="-m", or what?

Having looked at the code, I'm pretty sure it behaves like "-c". IMHO
that is a bug and the two should be mutually exclusive (i.e., override
each other). Changing that would not be strictly backwards, but I think
it may be OK under the notion that the current behavior is nonsense.

-Peff
