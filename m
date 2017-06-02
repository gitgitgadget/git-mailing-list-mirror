Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147B32027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdFBWEm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:04:42 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52696 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbdFBWEl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:04:41 -0400
Received: from a1i15.kph.uni-mainz.de (host2092.kph.uni-mainz.de [134.93.134.92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ulm)
        by smtp.gentoo.org (Postfix) with ESMTPSA id E5EA7341743;
        Fri,  2 Jun 2017 22:04:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-ID: <22833.57584.108133.30274@a1i15.kph.uni-mainz.de>
Date:   Sat, 3 Jun 2017 00:04:32 +0200
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Ulrich Mueller <ulm@gentoo.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git-2.13.0: log --date=format:%z not working
In-Reply-To: <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
References: <22824.29946.305300.380299@a1i15.kph.uni-mainz.de>
        <CACBZZX6t0Q9AJ4cpnG298tf5Las-YpmvvJXgLNNYMszikLvtMQ@mail.gmail.com>
        <20170527214611.suohggo226tvmbgt@sigill.intra.peff.net>
        <0a56f99e-aaa4-17ea-245a-12897ba08dbb@web.de>
        <xmqq1sr3161p.fsf@gitster.mtv.corp.google.com>
        <20170602030825.hdpbaisn54d4fi4n@sigill.intra.peff.net>
        <72b001fc-80e7-42b9-bd9d-87621da7978a@web.de>
        <20170602183504.ii7arq2ssxgwgyxr@sigill.intra.peff.net>
X-Mailer: VM 8.2.0b under 24.3.1 (x86_64-pc-linux-gnu)
From:   Ulrich Mueller <ulm@gentoo.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>>>> On Fri, 2 Jun 2017, Jeff King wrote:

> On Fri, Jun 02, 2017 at 07:25:43PM +0200, René Scharfe wrote:
>> On Linux "%z %Z" is expanded to "+0200 CEST" for me, while on Windows I
>> get "Mitteleurop▒ische Sommerzeit Mitteleurop▒ische Sommerzeit".  (That
>> "▒" is probably supposed to be an "ä".)  POSIX requires  +hhmm or -hhmm
>> format for %z, and for %Z is to be "Replaced by the timezone name or
>> abbreviation".

Actually, the POSIX definition for %Z continues: "or by no bytes if no
timezone information exists." So also returning an empty string would
be compliant (but maybe not very helpful).

>> I'd say "GMT+0200" etc. is a nice enough timezone name, i.e. having %Z
>> resolve to the same as %z plus a literal prefix of "GMT" should at least
>> not be wrong.

> I thought that, too, but I think it is wrong based on my understanding
> of how $TZ is parsed. There something like "EDT-4" means "call this EDT,
> and by the way it is 4 hours behind GMT".

> So what you're proposing isn't wrong per se, but your notation means
> something totally different than what similar-looking notation looks
> like on the $TZ end, which is bound to create confusion.

I agree that GMT+0200 could be misleading. But what about resolving %Z
the same as %z in the case of the author's time zone, as was suggested
earlier? It is supposed to be human-readable output, or do we expect
that someone would use the %Z output and e.g. plug it back into their
TZ?

>> Alternatively we could have a lookup table mapping a few typical offsets
>> to timezone names, but e.g. handling daylight saving times would
>> probably be too hard (when did that part of the world switch in the
>> given year?  north or south of the equator?)..

IMHO maintaining such a local table of timezones won't fly.

> Right, I don't think the mapping of zone to offset is reversible,
> because many zones map to the same offset. If I tell you I'm in -0500,
> even just in the US that could mean Eastern Standard Time (winter, no
> DST) or Central Daylight Time (summer, DST). Not to mention that other
> political entities in the same longitude have their own zones which do
> DST at different times (or were even established as zones at different
> times; historical dates need to use the zones as they were at that
> time).

Same here, my +0200 offset could be anything of CAT, CEST, EET, IST,
SAST, or WAST, according to IANA timezone data. It's a one-directional
mapping, and there's no way to get the author's /etc/localtime info
(or whatever its equivalent is on other systems) back from the offset
stored in the commit. A timezone name may not even exist at all for a
given [+-]hhmm offset.

Ulrich
