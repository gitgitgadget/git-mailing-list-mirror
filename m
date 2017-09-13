Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 618D420286
	for <e@80x24.org>; Wed, 13 Sep 2017 14:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751662AbdIMOv5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 10:51:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:36828 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750993AbdIMOv4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 10:51:56 -0400
Received: (qmail 13594 invoked by uid 109); 13 Sep 2017 14:51:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 14:51:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14845 invoked by uid 111); 13 Sep 2017 14:52:31 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Sep 2017 10:52:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Sep 2017 10:51:54 -0400
Date:   Wed, 13 Sep 2017 10:51:54 -0400
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Bug: git branch --unset-upstream command can nuke config when
 disk is full.
Message-ID: <20170913145154.423zqe6antzccclk@sigill.intra.peff.net>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913123420.die3thfcpaweakce@sigill.intra.peff.net>
 <CANgJU+U3Vzmmag9fpFGf7sx4Sq4S9qjLc5bnR4e+U0C3aaQXJA@mail.gmail.com>
 <20170913141739.mkmiaud2eemgnbbh@sigill.intra.peff.net>
 <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+WHr2-FjAUUKQ8pUkniczcxrr11dTo_zBeXdTi_su2oUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 13, 2017 at 04:49:45PM +0200, demerphq wrote:

> On 13 September 2017 at 16:17, Jeff King <peff@peff.net> wrote:
> > You're welcome to read over the function to double-check, but I just
> > looked it over and couldn't find any unchecked writes.
> 
> I can look, but I doubt I would notice something you did not.
> 
> On the other hand the strace output does show that this is a case
> where the writes failed, but we still renamed the empty config.lock
> file into place:
> 
> 
> write(3, "[core]\n\tsharedRepository = true\n"..., 288) = -1 ENOSPC
> (No space left on device)
> write(3, "        merge = refs/heads/yves/"..., 51) = -1 ENOSPC (No
> space left on device)
> munmap(0x7f48d9b8c000, 363)             = 0
> close(3)                                = 0
> rename("/usr/local/git_tree/main/.git/config.lock",
> "/usr/local/git_tree/main/.git/config") = 0

Hmph. That is very disturbing. But with that information I should be
able to track down the culprit. Thanks for digging.

> I freed up space and things worked, so I somehow doubt the filesystem
> is at fault. When I then filled up the disk and retried the error was
> repeatable.

Yeah, agreed. This really does look like a bug.

-Peff
