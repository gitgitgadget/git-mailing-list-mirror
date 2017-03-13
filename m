Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC92E20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbdCMVPu (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:15:50 -0400
Received: from fester.cwi.nl ([192.16.191.27]:38396 "EHLO fester.cwi.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750902AbdCMVPt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:15:49 -0400
Received: from mail.cwi.nl (zwebmail.cwi.nl [194.187.76.178])
        by fester.cwi.nl (8.14.4/8.12.3) with ESMTP id v2DLFTA0028685;
        Mon, 13 Mar 2017 22:15:29 +0100
Received: from mail.cwi.nl (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTPS id 423463C041E;
        Mon, 13 Mar 2017 22:15:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.cwi.nl (Postfix) with ESMTP id 33BA73C041C;
        Mon, 13 Mar 2017 22:15:24 +0100 (CET)
Received: from mail.cwi.nl ([127.0.0.1])
        by localhost (mail.cwi.nl [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lUgXVByUgMBP; Mon, 13 Mar 2017 22:15:24 +0100 (CET)
Received: from mail.cwi.nl (mail.cwi.nl [194.187.76.178])
        by mail.cwi.nl (Postfix) with ESMTP id 0716C3C03B5;
        Mon, 13 Mar 2017 22:15:24 +0100 (CET)
Date:   Mon, 13 Mar 2017 22:15:23 +0100 (CET)
From:   Marc Stevens <Marc.Stevens@cwi.nl>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <1392458356.3351662.1489439723458.JavaMail.zimbra@cwi.nl>
In-Reply-To: <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net>
References: <20170301195302.3pybakmjqztosohj@sigill.intra.peff.net> <CY1PR0301MB2107B3C5131D5DC7F91A0147C4250@CY1PR0301MB2107.namprd03.prod.outlook.com> <CY1PR0301MB2107876B6E47FBCF03AB1EA1C4250@CY1PR0301MB2107.namprd03.prod.outlook.com> <20170313194848.2z2dlgpomu6e3dkh@sigill.intra.peff.net> <1e6a592f-7da1-8043-0b29-0bb7c8cda3f3@cwi.nl> <CA+55aFyNi2uHwd9nzjy3dOu2L1A0jPN6AD43WKj-05km1GNtRQ@mail.gmail.com> <161775901.3349663.1489438074825.JavaMail.zimbra@cwi.nl> <20170313210023.bumtp6wyw6blmymp@sigill.intra.peff.net>
Subject: Re: [PATCH] Put sha1dc on a diet
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [84.31.180.140]
X-Mailer: Zimbra 8.6.0_GA_1162 (ZimbraWebClient - GC57 (Win)/8.6.0_GA_1162)
Thread-Topic: Put sha1dc on a diet
Thread-Index: zcqlgFnpFzsgEDuuKkGZcaxVksZ+/w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I now understand.
The Makefile indeed seems to fail to correctly rebuild when a header has changed.

As the performance branch has removed the 'int bigendian' from SHA1_CTX in lib/sha1.h,
the perf-branch and master-branch are binary incompatible.
So the command-line utility does not get fully recompiled 
and instead of the value of found_collision will read a different value of SHA1_CTX.

So be careful to always do a 'make clean' for now.

-- Marc

----- Original Message -----
From: "Jeff King" <peff@peff.net>
To: "Marc Stevens" <Marc.Stevens@cwi.nl>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>, "Dan Shumow" <danshu@microsoft.com>, "Junio C Hamano" <gitster@pobox.com>, "Git Mailing List" <git@vger.kernel.org>
Sent: Monday, March 13, 2017 10:00:23 PM
Subject: Re: [PATCH] Put sha1dc on a diet

On Mon, Mar 13, 2017 at 09:47:54PM +0100, Marc Stevens wrote:

> Linus:
> I would be surprised, the dependencies should be automatically determined.
> 
> BTW Did you make local changes to this perf branch?

I can reproduce it with:

  cd sha1collisiondetection
  git clean -dqfx ;# make sure we are starting from scratch

  git checkout 9c8e73cadb35776d3310e3f8ceda7183fa75a39f
  make
  bin/sha1dcsum $file

  git checkout 55d1db0980501e582f6cd103a04f493995b1df78
  make
  bin/sha1dcsum $file

The final call to sha1dcsum will report a collision, even though the
first one did not.

It also reproduces with the original snippet I posted. I didn't notice
because I was just collecting the timings then (and I originally noticed
the problem on the versions I had pulled into Git, where it works as
expected; but then I am just pulling in the two source files, without
all of the libtool magic).

-Peff
