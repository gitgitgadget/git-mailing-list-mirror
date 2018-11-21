Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B3E1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 16:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeKVDVd (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 22:21:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:47570 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726941AbeKVDVd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 22:21:33 -0500
Received: (qmail 27097 invoked by uid 109); 21 Nov 2018 16:46:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Nov 2018 16:46:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11052 invoked by uid 111); 21 Nov 2018 16:45:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 21 Nov 2018 11:45:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Nov 2018 11:46:20 -0500
Date:   Wed, 21 Nov 2018 11:46:20 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: Re: [PATCH 1/5] eoie: default to not writing EOIE section
Message-ID: <20181121164619.GA13860@sigill.intra.peff.net>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061147.GB144753@google.com>
 <efa1d7fb-1da3-c093-1cb1-873a2e1c445c@gmail.com>
 <20181120132151.GA30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120132151.GA30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 02:21:51PM +0100, SZEDER Gábor wrote:

> On Tue, Nov 20, 2018 at 08:06:16AM -0500, Ben Peart wrote:
> > >diff --git a/read-cache.c b/read-cache.c
> > >index 4ca81286c0..1e9c772603 100644
> > >--- a/read-cache.c
> > >+++ b/read-cache.c
> > >@@ -2689,6 +2689,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
> > >  		rollback_lock_file(lockfile);
> > >  }
> > >+static int record_eoie(void)
> > >+{
> > >+	int val;
> > 
> > I believe you are going to want to initialize val to 0 here as it is on the
> > stack so is not guaranteed to be zero.
> 
> The git_config_get_bool() call below will initialize it anyway.

Yes, there are two ways to write this. With a conditional to initialize
and return or to return the default, as we have here:

> > >+	if (!git_config_get_bool("index.recordendofindexentries", &val))
> > >+		return val;
> > >+	return 0;

Or initialize the default ahead of time, and rely on the function not to
modify it when the entry is missing:

  int val = 0;
  git_config_get_bool("index.whatever", &val);
  return val;

I think either is perfectly fine, but since I also had to look at it
twice to make sure it was doing the right thing, I figured it is worth
mentioning as a possible style/convention thing we may want to decide
on.

-Peff
