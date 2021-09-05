Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B2C433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E943060E93
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 13:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhIENQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 09:16:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:39742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhIENQI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 09:16:08 -0400
Received: (qmail 8733 invoked by uid 109); 5 Sep 2021 13:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 05 Sep 2021 13:15:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22845 invoked by uid 111); 5 Sep 2021 13:15:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 05 Sep 2021 09:15:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 5 Sep 2021 09:15:04 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
Message-ID: <YTTC2IUO1ZmTOEoR@coredump.intra.peff.net>
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net>
 <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 05, 2021 at 04:20:02PM +0800, ZheNing Hu wrote:

> > +       if (ref_cbdata->filter->streaming_format) {
> > +               pretty_print_ref(refname, oid, ref_cbdata->filter->streaming_format);
> 
> So we directly use pretty_print_ref() in streaming mode, OK.
> 
> > +       } else {
> > +               /*
> > +                * We do not open the object yet; sort may only need refname
> > +                * to do its job and the resulting list may yet to be pruned
> > +                * by maxcount logic.
> > +                */
> > +               ref = ref_array_push(ref_cbdata->array, refname, oid);
> > +               ref->commit = commit;
> > +               ref->flag = flag;
> > +               ref->kind = kind;
> > +       }
> >
> >         return 0;
> >  }
> 
> Therefore, in streaming mode, there is no need to push ref to
> ref_array, which can
> reduce the overhead of malloc(), free(), which makes sense.

By the way, one thing I wondered here: how much of the benefit is from
avoiding the ref_array, and how much is from skipping the sort entirely.

It turns out that most of it is from the latter. If I do this:

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 89cb6307d4..037d5db814 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -78,7 +78,11 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	filter.name_patterns = argv;
 	filter.match_as_path = 1;
 	filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
-	ref_array_sort(sorting, &array);
+	/*
+	 * we should skip this only when we are using the default refname
+	 * sorting, but as an experimental hack, we'll just comment it out.
+	 */
+	// ref_array_sort(sorting, &array);
 
 	if (!maxcount || array.nr < maxcount)
 		maxcount = array.nr;

then the timings I get are:

  Benchmark #1: ./git.old for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):     341.4 ms ±   7.4 ms    [User: 299.8 ms, System: 41.6 ms]
    Range (min … max):   333.5 ms … 355.1 ms    10 runs
   
  Benchmark #2: ./git.new for-each-ref --format='%(objectname) %(refname)'
    Time (mean ± σ):     249.1 ms ±   5.7 ms    [User: 211.8 ms, System: 37.2 ms]
    Range (min … max):   245.9 ms … 267.0 ms    12 runs
   
  Summary
    './git.new for-each-ref --format='%(objectname) %(refname)'' ran
      1.37 ± 0.04 times faster than './git.old for-each-ref --format='%(objectname) %(refname)''

So of the 1.5x improvement that the original patch showed, 1.37x is from
skipping the sort of the already-sorted data. I suspect that has less to
do with sorting at all, and more to do with the fact that even just
formatting "%(refname)" for each entry takes a non-trivial amount of
time.

-Peff
