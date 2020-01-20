Return-Path: <SRS0=cmu9=3J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D6CC32771
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FA02217F4
	for <git@archiver.kernel.org>; Mon, 20 Jan 2020 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgATUX4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:23:56 -0500
Received: from elephants.elehost.com ([216.66.27.132]:65175 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgATUX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jan 2020 15:23:56 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.179.249])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 00KKNpjn055037
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 20 Jan 2020 15:23:51 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>
References: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001201555220.46@tvgsbejvaqbjf.bet>
Subject: RE: Y2038 vs struct cache_time/time_t
Date:   Mon, 20 Jan 2020 15:23:46 -0500
Message-ID: <017401d5cfcf$8791d900$96b58b00$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE/8h2/Etm33bphKzxATo2qQV1OV6kftBHA
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 19, 2038 (no really January 20, 2020 2:39 PM), Johannes
Schindelin wrote:
> today, in quite an entertaining thread on Twitter
> (https://twitter.com/jxxf/status/1219009308438024200) I read about yet
> another account how the Year 2038 problem already bites people. And costs
> real amounts of money.
> 
> And after I stopped shaking my head in disbelief, I had a quick look, and
it
> seems that we're safe at least until February 7th, 2106. That's not great,
but I
> plan on not being around at that date anymore, so there. That date is when
> the unsigned 32-bit Unix epoch will roll over and play dead^W^Wwreak
> havoc (iff the human species manages to actually turn around and reverse
> the climate catastrophe it caused, and that's a big iff):
> https://en.wikipedia.org/wiki/Time_formatting_and_storage_bugs#Year_21
> 06
> 
> Concretely, it looks as if we store our own timestamps on disk (in the
index
> file) as uint32_t:
> 
> 	/*
> 	 * The "cache_time" is just the low 32 bits of the
> 	 * time. It doesn't matter if it overflows - we only
> 	 * check it for equality in the 32 bits we save.
> 	 */
> 	struct cache_time {
> 		uint32_t sec;
> 		uint32_t nsec;
> 	};
> 
> The comment seems to indicate that we are still safe even if 2106 comes
> around, but I am not _quite_ that sure, as I expect us to have "greater
than"
> checks, not only equality checks.
> 
> But wait, we're still not quite safe. If I remember correctly, 32-bit
Linux still
> uses _signed_ 32-bit integers as `time_t`, so when we render dates, for
> example, and use system-provided functions, on 32-bit Linux we will at
least
> show the wrong dates starting 2038.
> 
> This got me thinking, and I put on my QA hat. Kids, try this at home:
> 
> 	$ git log --until=1.january.1960
> 
> 	$ git log --since=1.january.2200
> 
> Git does not really do what you expected, eh?
> 
> Maybe we want to do something about that, and while at it also fix the
> overflow problems, probably requiring a new index format?

The preferred way of fixing this is traditionally - for those of us who have
been through it (4-ish times), to convert to time64_t where available (big
legacy machines, like z/OS and NonStop), or in gcc, time_t is 64 bit on 64
bit systems. It has been 64 bit on Windows since VS 2005. I have a
relatively some relatively old Linux distros on 64 bit processors that also
have time_t set as 64 bit in gcc. Those seem to be the standard approaches.
To cover it, I suggest we move to a gittime_t which is always 64 bit (or 128
bit if you don't want to be resurrected after the sun turns into a red giant
or later when we are left with evaporating black holes), no matter what the
platform, and build the selection of what gittime_t is (time_t or time64_t)
into our config and/or compat.h. That way, hopefully, people will rebuild
their git before 2038 or before someone decides to stick a fake date into a
Github repo just to mess with us.

Cheers,
Randall

