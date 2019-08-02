Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,SUSPICIOUS_RECIPS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A39891F731
	for <e@80x24.org>; Fri,  2 Aug 2019 22:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbfHBW07 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 18:26:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:32806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729919AbfHBW07 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 18:26:59 -0400
Received: (qmail 12497 invoked by uid 109); 2 Aug 2019 22:27:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Aug 2019 22:27:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10788 invoked by uid 111); 2 Aug 2019 22:28:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Aug 2019 18:28:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 2 Aug 2019 18:26:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 11/11] built-in add -i: implement the `help` command
Message-ID: <20190802222657.GA526@sigill.intra.peff.net>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
 <pull.170.v3.git.gitgitgadget@gmail.com>
 <db70c6475d85dd77385d773274fa390fa7ed08c0.1563289115.git.gitgitgadget@gmail.com>
 <xmqqpnlnjn3q.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnlnjn3q.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 02, 2019 at 02:04:09PM -0700, Junio C Hamano wrote:

> > +static int run_help(struct add_i_state *s, const struct pathspec *ps,
> > +		    struct file_list *files, struct list_options *opts)
> [...]
> 
> As we do not allow the command names to get translated, this makes
> sense.
> 
> Have we adopted the convention to name callback parameters that have
> to stay unused (because the callback function must have a function
> signature that accepts the union of what everybody needs to take)
> differently from the parameters that actually get used?  It may make
> sense to use it in a function like this, to prevent readers from
> wasting time by wondering how pathspec is used in this function, for
> example.

I haven't yet[1] polished up the remainder of my patches to make us
-Wunused-parameter clean, but the pattern there would look like:

  void some_function(const char *foo, void *UNUSED(bar))
  {
     ... use foo but not bar ...
  }

which both tells the compiler that "bar" may be unused, and renames it
behind the scenes to unused_bar so that it cannot be accidentally used
(or more importantly, so that we can drop the annotation when it does
get used).

All of which is to say that I'm fine if you call it "unused_bar"
manually for now, but I'd switch it to the above in my series. So it may
not matter all that much in the meantime.

-Peff

[1] The sticking point is a few more cases I found where it's unclear to
    me whether they should be marked, or if it's a latent bug.
