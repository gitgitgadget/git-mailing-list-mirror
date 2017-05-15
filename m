Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AD5D201A7
	for <e@80x24.org>; Mon, 15 May 2017 23:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbdEOXKN (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 19:10:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:52248 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbdEOXKM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 19:10:12 -0400
Received: (qmail 3131 invoked by uid 109); 15 May 2017 23:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 23:10:12 +0000
Received: (qmail 22762 invoked by uid 111); 15 May 2017 23:10:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 May 2017 19:10:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 May 2017 19:10:10 -0400
Date:   Mon, 15 May 2017 19:10:10 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
Message-ID: <20170515231009.2tvukcbmfywnqlaw@sigill.intra.peff.net>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
 <20170515110557.11913-5-szeder.dev@gmail.com>
 <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 01:29:07PM +0200, SZEDER Gábor wrote:

> On Mon, May 15, 2017 at 1:05 PM, SZEDER Gábor <szeder.dev@gmail.com> wrote:
> > From: Jeff King <peff@peff.net>
> >
> > Using free() on a refspec was always leaky, as its string
> > fields also need freed. But it became more so when ad00f128d
> > (clone: respect configured fetch respecs during initial
> > fetch, 2016-03-30) taught clone to create a list of
> > refspecs, each of which need to be freed.
> >
> > [sg: adjusted the function parameters.]
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> > Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> > ---
> >  builtin/clone.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 4144190da..4bf28d7f5 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -1120,6 +1120,6 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
> >         strbuf_release(&value);
> >         junk_mode = JUNK_LEAVE_ALL;
> >
> > -       free(refspec);
> > +       free_refspec(remote->fetch_refspec_nr + 1, remote->fetch);
> >         return err;
> >  }
> 
> Erm...  I should have given a bit more thought to this last patch,
> shouldn't I?
> 
> First, the unchanged commit message is now (i.e. by using the parsed
> refspecs returned by remote_get()) completely outdated.
> Second, while it properly frees those refspecs, i.e. the array and all
> its string fields, it will now leak the memory pointed by the
> 'refspec' variable.  However, why free just that one field of the
> 'struct *remote'?  Alas, we don't seem to have a free_remote()
> function...

Right, the "struct remote" fields are meant to last the program
lifetime, and just go away when the program does. So they are never
freed. We could just lump this in with them, and remove the free()
entirely.

It's a little funny with your patch as-is, because "struct remote"
doesn't actually know about the refspec we stuck on the end. But since
it doesn't free its refspecs anyway, it's not any more leaky than all
the other entries.

-Peff
