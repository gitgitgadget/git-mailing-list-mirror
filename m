Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FA61F461
	for <e@80x24.org>; Thu, 16 May 2019 03:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEPD2E (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 23:28:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:58922 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726218AbfEPD2E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 23:28:04 -0400
Received: (qmail 4503 invoked by uid 109); 16 May 2019 03:28:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 16 May 2019 03:28:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26864 invoked by uid 111); 16 May 2019 03:28:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 23:28:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 23:28:02 -0400
Date:   Wed, 15 May 2019 23:28:02 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190516032802.GB4596@sigill.intra.peff.net>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
 <20190515220834.svurujspjt3bmath@glandium.org>
 <20190515235339.GA3579@sigill.intra.peff.net>
 <20190516004802.fmtdz52xxcplkgcf@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190516004802.fmtdz52xxcplkgcf@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 09:48:02AM +0900, Mike Hommey wrote:

> > diff --git a/transport-helper.c b/transport-helper.c
> > index fcd2a58d0e..45cdf891ec 100644
> > --- a/transport-helper.c
> > +++ b/transport-helper.c
> > @@ -433,7 +433,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
> >  	struct helper_data *data = transport->data;
> >  	int cat_blob_fd, code;
> >  	child_process_init(fastimport);
> > -	fastimport->in = helper->out;
> > +	fastimport->in = xdup(helper->out);
> >  	argv_array_push(&fastimport->args, "fast-import");
> >  	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
> >  
> > 
> > One thing I'd wonder, though: what is the contract between the helper
> > and fast-import here? In the current code, when the helper closes its
> > stdout, fast-import will see EOF. But not if we are holding on to
> > another copy of the descriptor.
> 
> The helper is supposed to finish the fast-import stream with "done".
> The documentation doesn't say much, but it also seems like the helper
> could theoretically continue to respond to commands it's sent after
> having done so, but that currently never happens AFAICT.

Hmm. We do not even pass --done to fast-import. If we are really
expecting everybody to say "done", then it seems like we ought to be
doing so. I think that "done" came much later than the concept of
fast-import, so while most reasonable importers would send it, I suspect
antique ones would not.

So I was all ready to say that we need to do it the other way (pass off
ownership) in order for fast-import to exit when the helper closes the
descriptor. But actually, I think I am being silly. The duplicated
descriptor is the _output_ from the helper, not the _input_ to
fast-import. So if we are also holding that output descriptor,
fast-import will not care. It is only the helper which would then not
notice fast-import dying (and continue writing to the descriptor
without EPIPE, since we are still on the other end of it).

I think that's probably OK, as we would see fast-import exit and then
continue ourselves. We'd probably die() immediately assuming fast-import
exits with an error. But if we don't, want happens? The helper would
eventually block if it fills the pipe buffer. We'd eventually end up in
disconnect_helper(). I think it would work out because we
close(data->helper->out) before trying to reap the child, so it would
get SIGPIPE then and exit.

So I think that works. But I have to admit that handing off ownership
seems simpler to reason about. :)

Totally orthogonal, but I think we might also want to introduce a helper
capability so that import helpers can say "I always send 'done' to
fast-import". And then we can pass "--done" to fast-import, which means
it would detect a truncated stream.

-Peff
