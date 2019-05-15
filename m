Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C65E1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfEPBqV (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:58760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726525AbfEOXxm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 19:53:42 -0400
Received: (qmail 31504 invoked by uid 109); 15 May 2019 23:53:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 May 2019 23:53:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25925 invoked by uid 111); 15 May 2019 23:54:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 15 May 2019 19:54:20 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 May 2019 19:53:40 -0400
Date:   Wed, 15 May 2019 19:53:40 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Closing fds twice when using remote helpers
Message-ID: <20190515235339.GA3579@sigill.intra.peff.net>
References: <20190515105609.sucfjvuumeyyrmjb@glandium.org>
 <87bm04vt81.fsf@evledraar.gmail.com>
 <b6ff2486-a1c2-4e89-4338-9e4e56d528bc@kdbg.org>
 <20190515220834.svurujspjt3bmath@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190515220834.svurujspjt3bmath@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 16, 2019 at 07:08:34AM +0900, Mike Hommey wrote:

> > >> - Except, well, fds being what they are, we in fact just closed a fd
> > >>   from a packed_git->pack_fd. So, when use_pack is later called, and
> > >>   tries to mmap data from that pack, it fails because the file
> > >>   descriptor was closed.
> > 
> > Either dup() the file descriptor, or mmap() before you call the
> > consuming start_command().

If I understand your case correctly, the mmap() is not relevant.  The
issue is that we close a random file descriptor accidentally, and it
just happens to be a pack descriptor later on. Right?

> You seem to imply this is my code doing something. It's not. The process
> that is doing all the things I noted above is an unmodified `git fetch`,
> when using a remote-helper transport. The use_pack happens after the
> transport is disposed because that's at the end of git fetch, when it
> updates refs.

Yes, it's a bug in git.

> Anyway, it would seem the fix is to dup(out) when passing it as in to
> start_command?

Generally, yes. It looks like maybe this spot?

diff --git a/transport-helper.c b/transport-helper.c
index fcd2a58d0e..45cdf891ec 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -433,7 +433,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	struct helper_data *data = transport->data;
 	int cat_blob_fd, code;
 	child_process_init(fastimport);
-	fastimport->in = helper->out;
+	fastimport->in = xdup(helper->out);
 	argv_array_push(&fastimport->args, "fast-import");
 	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
 

One thing I'd wonder, though: what is the contract between the helper
and fast-import here? In the current code, when the helper closes its
stdout, fast-import will see EOF. But not if we are holding on to
another copy of the descriptor.

In that case, the right solution is probably more like:

  fastimport->in = helper->out;
  helper->out = -1; /* hand ownership to fast-import */

-Peff
