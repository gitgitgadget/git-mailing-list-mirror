Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363E71F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751083AbdHZSxl (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 14:53:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:50036 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750849AbdHZSxk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 14:53:40 -0400
Received: (qmail 25093 invoked by uid 109); 26 Aug 2017 18:53:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Aug 2017 18:53:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24710 invoked by uid 111); 26 Aug 2017 18:54:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 26 Aug 2017 14:54:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Aug 2017 11:53:37 -0700
Date:   Sat, 26 Aug 2017 11:53:37 -0700
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cat-file timing window on Cygwin
Message-ID: <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 01:57:18AM +0100, Ramsay Jones wrote:

> > diff --git a/run-command.c b/run-command.c
> > index 98621faca8..064ebd1995 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -641,7 +641,6 @@ int start_command(struct child_process *cmd)
> >  	}
> >  
> >  	trace_argv_printf(cmd->argv, "trace: run_command:");
> > -	fflush(NULL);
> >  
> >  #ifndef GIT_WINDOWS_NATIVE
> >  {
> 
> I suspect not, but I can give it a try ...
> 
> ... oh, wow, that works! Ahem. (Hmm, so it's flushing stdin?!)

Interesting. I find it a little hard to believe there's so obvious a bug
as "fflush(NULL) flushes stdin", but well...that's what it seems like.

If that's truly what it is, this is the minimal reproduction I came up
with:

-- >8 --
#include <stdio.h>

int main(void)
{
	char buf[256];
	while (fgets(buf, sizeof(buf), stdin)) {
		fprintf(stdout, "got: %s", buf);
		fflush(NULL);
	}
	return 0;
}
-- 8< --

If this really is the bug, then doing something like "seq 10 | ./a.out"
would drop some of the input lines.

-Peff
