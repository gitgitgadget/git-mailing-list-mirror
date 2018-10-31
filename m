Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB8791F453
	for <e@80x24.org>; Wed, 31 Oct 2018 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeJaXgH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 19:36:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:34386 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729494AbeJaXgH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 19:36:07 -0400
Received: (qmail 3281 invoked by uid 109); 31 Oct 2018 14:37:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Oct 2018 14:37:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10822 invoked by uid 111); 31 Oct 2018 14:37:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 31 Oct 2018 10:37:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2018 10:37:47 -0400
Date:   Wed, 31 Oct 2018 10:37:47 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/3] cat-file: handle streaming failures consistently
Message-ID: <20181031143747.GA9994@sigill.intra.peff.net>
References: <20181030231232.GA6141@sigill.intra.peff.net>
 <20181030232337.GC32038@sigill.intra.peff.net>
 <20181031133341.GA5070@tor.lan>
 <xmqqva5iurd7.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqva5iurd7.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 11:23:48PM +0900, Junio C Hamano wrote:

> Torsten Bögershausen <tboegi@web.de> writes:
> 
> >> +static int stream_blob(const struct object_id *oid)
> >
> > Sorry for nit-picking:
> > could this be renamed into stream_blob_to_stdout() ?
> 
> I think that name makes sense, even though stream_blob() is just
> fine for a fuction that takes a single parameter oid, as there is no
> other sane choice than streaming to the standard output stream the
> blob data.

I was trying to keep the name small since it is a static-local
convenience helper. I'd rather write it as:

  stream_blob(1, oid);

than change the name. ;)

> >> +{
> >> +	if (stream_blob_to_fd(1, oid, NULL, 0))
> >
> > And I wonder if we could make things clearer:
> >  s/1/STDOUT_FILENO/
> 
> What would benefit from symbolic constant more in that function call
> may be CAN_SEEK thing, but s/1/STDOUT_FILENO/ adds negative value to
> that line, I would think.  The name of the function already makes it
> clear this is sending the output to a file descriptor, and an
> integer 1 that specifies a file descriptor cannot mean anything
> other than the standard output stream.

Yes, I'd agree (there are very few cases where I think STDOUT_FILENO
actually increases the readability, since it is usually pretty clear
from the context when something is a descriptor).

-Peff
