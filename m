Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24D451F462
	for <e@80x24.org>; Tue, 28 May 2019 06:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfE1G2I (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 02:28:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:39440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726657AbfE1G2I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 02:28:08 -0400
Received: (qmail 27449 invoked by uid 109); 28 May 2019 06:28:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 06:28:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10427 invoked by uid 111); 28 May 2019 06:28:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 02:28:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 02:28:05 -0400
Date:   Tue, 28 May 2019 02:28:05 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/1] trace2: fix tracing when NO_PTHREADS is defined
Message-ID: <20190528062804.GE7946@sigill.intra.peff.net>
References: <pull.222.git.gitgitgadget@gmail.com>
 <20190521212744.GC14807@sigill.intra.peff.net>
 <97796007-db6e-f2ea-91ae-3113b74e4ae9@jeffhostetler.com>
 <20190523055108.GA20871@sigill.intra.peff.net>
 <CACsJy8D7w4sC_tchx-Q80PCiu+2hYfkZo22_Vb3vgJ+xvgUAAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8D7w4sC_tchx-Q80PCiu+2hYfkZo22_Vb3vgJ+xvgUAAA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 25, 2019 at 05:43:55PM +0700, Duy Nguyen wrote:

> > +typedef struct {
> > +       void *data;
> > +       /* extra indirection because setspecific is passed key by value */
> > +       void **vdata;
> 
> Ha! I was thinking a separate key->value mapping which is complicated
> in C. But this works pretty well for a single thread, and it even
> supports multiple keys.

I really wish that all of the functions passed the pthread_key_t by
reference. That would make it possible to define the key as a single
pointer.

I'm not sure if pthread_key_t's are meant to be shallow-copyable. I.e.,
should this work:

  void foo(pthread_key_t *out)
  {
	pthread_key_t tmp;
	pthread_key_create(&tmp, NULL);
	*out = tmp;
  }
  ...
  pthread_key_t k;
  foo(&k);
  pthread_setspecific(k, some_ptr);

It does not with my proposed plan, because the pointer in tmp.data went
out of scope, leaving tmp.vdata (and thus k.vdata) as a dangling
pointer.

The code above seems like a vaguely crazy thing to do. But if we want to
be absolutely paranoid, we'd have to malloc() an extra pointer in the
create() function, instead of carrying it inside the key. Or just make a
global "void *thread_specific_data[PTHREAD_KEYS_MAX]" and make each key
an integer index into it.

It's pretty clear that they expect one of those two implementations,
given that POSIX says key creation can report either ENOMEM, or EAGAIN
if we exceed PTHREAD_KEYS_MAX. :)

-Peff
