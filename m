Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A66631F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756293AbcIFONc (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 10:13:32 -0400
Received: from mout.gmx.net ([212.227.17.21]:58938 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756034AbcIFONb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 10:13:31 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVvDo-1baeNs2vJA-00X3EG; Tue, 06 Sep 2016 16:13:20
 +0200
Date:   Tue, 6 Sep 2016 16:13:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fix a segfault caused by regexec() being called on
 mmap()ed data
In-Reply-To: <20160906065821.bxwitnk72rpn3xhl@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1609061606411.129229@virtualbox>
References: <cover.1473090278.git.johannes.schindelin@gmx.de> <20160906065821.bxwitnk72rpn3xhl@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5JMQ8/F0TejuDmP43Hs1xd9fbHpm0sNex7ZAK9RR5N/+Q4Pv8jq
 PjzNDxMJbU0uI2SonajpXpJomNmoO0pm2NZyIVUs77h/1NcBs4JHqJ2N8TIwEj+ZzGPPKuI
 viX/FOlzuHJcR/ZRFk+ySV5M3yzHDo6yqBDw43cKxS0uLH9ByjM1GWXWNvmP//PMJU/swye
 Q9HWjjoSbeiupcLJiIDHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1IyBO69tIIA=:Qe8q6FREIMF9wyURcCUBpB
 ZoJVnwRXNJoSl+MtEQbI4+HcNnKCQO4XEUb8n3S1lr7vYbWZSz0yTROiIBNhrXMKBxfw7/+l8
 fS5Ddb2RnyjMba1zCFyR7rfxrfUPuAtkZyghXPGCI7P+g4ESjIAwN9tu8qyWtTlbzh0eP9j4T
 G6f6bcvjNlAPytaqEe1C1OTmROcJv/GxustReTVv0pXHhyi3BtnkBZO1M0YF5pIwCi3cfA/VV
 REI/s/fQuRaGjXTsb7RVKHHNkgxFhgf+HzahLT1P8qwmwNq5IvC70euLHxc72trtHV+un6tTl
 IsH+OhqAEeJvQtu+IUsEtr/Ycuqbg+mp8HoT/7tMFU/EI2x+oTrot0B2/8HaAvHMbS3+76Egs
 aOdxJX0hlJtU1CseD3duICau67IBo4W6QMxdzVYUxrIjesGW28sOqF1/AHXZGdBBu/IjMzv+R
 Qu+atzVfr7nN4XIzSBZWYxjXYassE6jUlx2sWcw1HAYUxeov99qKSYUC/s9z795DFt3/ZaVgs
 OAHh4YL6yX54QtsXAWdBaeS1PlyJDDv0nHo1BQL3xoz40Cv89UAnxLJYXV+goTGI4NdinZeZt
 8SbwmHI460eFSfPM/UH51+EF4a8j/suIRGtzHdLqjgIoJxsgKHbwcTbG1imSWgL1mNTf+BjPD
 VtRcw53U91AkjZoywElwhypHjXMjpp1MCRO2IV2OArLzgvFy82m7geCNCd/+9JtQHLQ63uri9
 8oknplvY7jNSR0/9C1+wQsBZvjJQ66emnTDO0FUYs3p7TQMGuNspdAnKJBj/5A+GcIWbElUYn
 iahvl0/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 6 Sep 2016, Jeff King wrote:

> On Mon, Sep 05, 2016 at 05:44:57PM +0200, Johannes Schindelin wrote:
> 
> > The problem with that: mmap()ed memory is *not* NUL-terminated, yet
> > the pickaxe code calls regexec() on it just the same.
> > 
> > This problem has been reported by my colleague Chris Sidi.
> > 
> > Please note that this patch series is a hot fix I applied to Git for
> > Windows (the bug does not trigger a segmentation fault for me on
> > Linux, strangely enough, but it is really a problem on Windows).
> 
> This has come up before, and I think somebody mentioned that on Linux,
> you are OK unless the buffer ends right at a page boundary (i.e., the
> buffer size is a multiple of the page size). I don't know if that's true
> or not.

In my tests on Linux, even when the buffer ended right at the page
boundary, the memory after that was still legal to access, and typically
had a NUL *somewhere*.

That's happenstance, of course, and could very well result in false
positives (however unlikely that is).

> > So at least I have a workaround in place. Ideally, though, we would
> > NUL-terminate the buffers only when needed, or somehow call regexec() on
> > ptr/size parameters instead of passing a supposedly NUL-terminated
> > string to it?
> 
> There's some discussion in:
> 
>   http://public-inbox.org/git/20121030121747.GA4231@sigill.intra.peff.net/#r
> 
> and the thread below it. The quickest way to fix regexec() would be to
> have everybody use the built-in GNU regex in compat/. People seemed
> somewhat positive on that direction, but we never followed up.

I had a brief look, and it is not pretty. You would have to pay me good
money to dive in and try to implement a regexecn() based on what we have
in compat/regex/. And then people would still complain, I guess, for not
using the native regex support, where available.

Ciao,
Dscho
