Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B60E203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 08:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbcGXINj (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 04:13:39 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37699 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845AbcGXINg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 04:13:36 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3rxxwY09DXz3hkBk;
	Sun, 24 Jul 2016 10:13:32 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3rxxwX5kZpzvkSJ;
	Sun, 24 Jul 2016 10:13:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id LcwqM7esJJRu; Sun, 24 Jul 2016 10:13:31 +0200 (CEST)
X-Auth-Info: N7xXjYj9lhY2/W8iMfutmo44WXF1Nmf5hSkYrowi0GcUuLKt/ZPlGSiKQPtBV2XP
Received: from linux.local (ppp-88-217-24-98.dynamic.mnet-online.de [88.217.24.98])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 24 Jul 2016 10:13:31 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 4EC6F1E53F9; Sun, 24 Jul 2016 10:13:31 +0200 (CEST)
From:	Andreas Schwab <schwab@linux-m68k.org>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] mailinfo: extract is_from_line from mailsplit
References: <20160722224739.GA22961@whir>
	<alpine.DEB.2.20.1607231056150.14111@virtualbox>
	<20160724031409.GA32480@starla> <20160724031518.GB32480@starla>
	<m2poq3zdu3.fsf@linux-m68k.org>
	<alpine.DEB.2.20.1607241003480.14111@virtualbox>
X-Yow:	LOU GRANT froze my ASSETS!!
Date:	Sun, 24 Jul 2016 10:13:31 +0200
In-Reply-To: <alpine.DEB.2.20.1607241003480.14111@virtualbox> (Johannes
	Schindelin's message of "Sun, 24 Jul 2016 10:05:16 +0200 (CEST)")
Message-ID: <m2lh0rzc5w.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.95 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Andreas,
>
> On Sun, 24 Jul 2016, Andreas Schwab wrote:
>
>> Eric Wong <e@80x24.org> writes:
>> 
>> > diff --git a/mailinfo.c b/mailinfo.c
>> > index 9f19ca1..0ebd953 100644
>> > --- a/mailinfo.c
>> > +++ b/mailinfo.c
>> > @@ -1035,3 +1035,34 @@ void clear_mailinfo(struct mailinfo *mi)
>> >  
>> >  	strbuf_release(&mi->log_message);
>> >  }
>> > +
>> > +int is_from_line(const char *line, int len)
>> > +{
>> > +	const char *colon;
>> > +
>> > +	if (len < 20 || memcmp("From ", line, 5))
>> > +		return 0;
>> > +
>> > +	colon = line + len - 2;
>> > +	line += 5;
>> > +	for (;;) {
>> > +		if (colon < line)
>> > +			return 0;
>> > +		if (*--colon == ':')
>> > +			break;
>> > +	}
>> > +
>> > +	if (!isdigit(colon[-4]) ||
>> > +	    !isdigit(colon[-2]) ||
>> > +	    !isdigit(colon[-1]) ||
>> > +	    !isdigit(colon[ 1]) ||
>> > +	    !isdigit(colon[ 2]))
>> > +		return 0;
>> > +
>> > +	/* year */
>> > +	if (strtol(colon+3, NULL, 10) <= 90)
>> > +		return 0;
>> > +
>> > +	/* Ok, close enough */
>> > +	return 1;
>> > +}
>> 
>> Should this be made more strict, like by checking for a space before the
>> year?
>
> This patch only moves the function, so it would be inappropriate to change
> it.
>
> If you want to make it stricter, you will have to submit a separate patch.

You didn't answer my question.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
