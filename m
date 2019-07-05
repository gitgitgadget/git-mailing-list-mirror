Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAC71F461
	for <e@80x24.org>; Fri,  5 Jul 2019 11:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfGELvt (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jul 2019 07:51:49 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:38406 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGELvt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jul 2019 07:51:49 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1hjMki-0004jK-H4; Fri, 05 Jul 2019 20:51:44 +0900
Date:   Fri, 5 Jul 2019 20:51:44 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Surprising use of memory and time when repacking mozilla's gecko
 repository
Message-ID: <20190705115144.7jqvc3qzanrpvpxq@glandium.org>
References: <20190704100530.smn4rpiekwtfylhz@glandium.org>
 <20190705050955.GA25459@sigill.intra.peff.net>
 <20190705054516.mke7aqk2cdsffkpd@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705054516.mke7aqk2cdsffkpd@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 05, 2019 at 02:45:16PM +0900, Mike Hommey wrote:
> On Fri, Jul 05, 2019 at 01:09:55AM -0400, Jeff King wrote:
> > On Thu, Jul 04, 2019 at 07:05:30PM +0900, Mike Hommey wrote:
> > > Finally, with 1 thread, the picture changes greatly. The overall process
> > > takes 2.5h:
> > > - 50 seconds enumerating and counting objects.
> > > - ~2.5h compressing objects.
> > > - 3 minutes and 25 seconds writing objects!
> > 
> > That's weird. I'd expect us to find similar amounts of deltas, but we
> > don't have the writing slow-down. I wonder if there is some bad
> > interaction between the multi-threaded code and the delta cache.
> > 
> > Did you run the second, single-thread run against the exact same
> > original repository you had? Or did you re-run it on the result of the
> > multi-thread run? Another explanation is that the original repository
> > had some poor patterns that made objects expensive to access (say, a ton
> > of really deep delta chains). And so the difference between the two runs
> > was not the threads, but just the on-disk repository state.
> > 
> > Kind of a long shot, but if that is what happened, try running another
> > multi-threaded "repack -f" and see if its writing phase is faster.
> 
> I've run 36-threads, 16-threads and 1-thread in sequence on the same
> repo, so 16-threads was repacking what was repacked by the 36-threads,
> and 1-thread was repacking what was repacked by the 16-threads. I
> assumed it didn't matter, but come to think of it, I guess it can.

I tried:
- fresh clone -> 36-threads
- fresh clone -> 1-thread -> 36-threads

The 36-threads gc in the latter was only marginally faster than in the
former (between 19 and 20 minutes instead of 22 for both "Compressing"
and "Writing").

Mike
