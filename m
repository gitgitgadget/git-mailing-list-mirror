Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7AB01F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 23:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754339AbeGGX61 (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 19:58:27 -0400
Received: from mxin.vub.ac.be ([134.184.129.114]:35566 "EHLO mxin.vub.ac.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754060AbeGGX61 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 19:58:27 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EGAQDoUkFb/wsxuIZbGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQrbRIogzOIS1+NXJUygT87CyUGAQKEPgKCTzQYAQIBAQIBAQICAmk?=
 =?us-ascii?q?cDEIOAYITBEs6MAEBAQEBAQEBAQEBAQEBARoCDWQBBTo/EAsYCSUPBSgNARMTG?=
 =?us-ascii?q?4MGgX8PqyiEW4NrgTUFikQ/hB6DGAICgUqDRoIkAplPCYYIiRGIEoVWijiHWIF?=
 =?us-ascii?q?BOYFSTSAYgyQThW2KVD0wegEBh1GFCIJHAQE?=
X-IPAS-Result: =?us-ascii?q?A2EGAQDoUkFb/wsxuIZbGgEBAQEBAgEBAQEIAQEBAYQrbRI?=
 =?us-ascii?q?ogzOIS1+NXJUygT87CyUGAQKEPgKCTzQYAQIBAQIBAQICAmkcDEIOAYITBEs6M?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBARoCDWQBBTo/EAsYCSUPBSgNARMTG4MGgX8PqyiEW4N?=
 =?us-ascii?q?rgTUFikQ/hB6DGAICgUqDRoIkAplPCYYIiRGIEoVWijiHWIFBOYFSTSAYgyQTh?=
 =?us-ascii?q?W2KVD0wegEBh1GFCIJHAQE?=
Received: from igwe11.vub.ac.be (HELO igwe.rave.org) ([134.184.49.11])
  by smtp.vub.ac.be with ESMTP/TLS/AES128-GCM-SHA256; 08 Jul 2018 01:58:25 +0200
Received: from kgybels by igwe.rave.org with local (Exim 4.84_2)
        (envelope-from <kgybels@infogroep.be>)
        id 1fbx5t-0000ct-AL; Sun, 08 Jul 2018 01:58:25 +0200
Date:   Sun, 8 Jul 2018 01:58:25 +0200
From:   Kim Gybels <kgybels@infogroep.be>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Beat Bolli <dev+git@drbeat.li>,
        git@vger.kernel.org
Subject: Re: [PATCH] builtin/config: work around an unsized array forward
 declaration
Message-ID: <20180707235825.GA1546@infogroep.be>
References: <20180705183445.30901-1-dev+git@drbeat.li>
 <20180705193807.GA4826@sigill.intra.peff.net>
 <phlsmp$mot$1@blaine.gmane.org>
 <20180705200205.GA29861@sigill.intra.peff.net>
 <xmqq1scgkw06.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1scgkw06.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On (06/07/18 12:24), Junio C Hamano wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Jul 05, 2018 at 09:50:53PM +0200, Beat Bolli wrote:
> >
> >> > Your patch is obviously correct, but I think here there might be an even
> >> > simpler solution: just bump option_parse_type() below the declaration,
> >> > since it's the only one that needs it. That hunk is bigger, but the
> >> > overall diff is simpler, and we don't need to carry that extra wrapper
> >> > function.
> >> 
> >> That was dscho's first try in the GitHub issue. It doesn't compile
> >> because the OPT_CALLBACK* macros in the builtin_config_options
> >> declaration inserts a pointer to option_parse_type into the array items.
> >> We need at least one forward declaration, and my patch seemed the least
> >> intrusive.
> >
> > Ah, right, so it actually is mutually recursive.  Forward-declaring
> > option_parse_type() would fix it, along with the reordering. I'm
> > ambivalent between the available options, then; we might as well go with
> > what you posted, then, since it's already done. :)
> 
> Among three, forward declaration of the function with reordering
> that nobody has written except for in the brain smells the best, and
> turning an array to a pointer that points at a separate storage looked
> the worst.  I also am OK with what's already posted, too.

I posted the forward declaration of the function on the Git for
Windows issue:
https://github.com/git-for-windows/git/issues/1735#issuecomment-402825623

I would consider it the minimal fix. The already posted solution is
also OK for me.

It's also possible to use "extern" instead of "static" for the array.
It would, however, not be my preferred solution.

-Kim
