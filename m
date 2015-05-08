From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Fri, 8 May 2015 19:56:28 -0400
Message-ID: <CAPig+cQi7SfJJc4d3DJ2mJ0-5vT7LJDttPPec=UEsmjiqtLcZQ@mail.gmail.com>
References: <20150416084733.GA17811@peff.net>
	<20150416090138.GG17938@peff.net>
	<CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
	<20150421230929.GA27773@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 09 01:56:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqs8B-0006qV-64
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 01:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752797AbbEHX43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 19:56:29 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:34209 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540AbbEHX42 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 19:56:28 -0400
Received: by iget9 with SMTP id t9so40161214ige.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 16:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=dMBT6nqmeUrpY9HkHn0Z+SqWgwadNqC9252y3vrAPzQ=;
        b=O7kfRyGf1iQT2w47SYW7U3MVcuT+jm3faEIQ0mjw7mnl8rtd823f5s3XbLF+lx//Iy
         6dZ29l7SuqTs2k7tZrDapLN3Sp2QvtpdPraF9ZHCbzOSi9GgdTOqMwGnSO+yFQAPpdyb
         cp5HWyAWoleF+QQvLZdoy+IiBM+i/OZtngyMuA7GX2dAb2kqw8KdtuYHbsnRtDcYI2Ec
         OG1mJO1VMTFm9sWWhtxr3iIr5Z5WD63DEA6N0DMMLDrzov6TTW9WObMyrZUhyumlseA2
         f61urOTJ27BvXo8UNB/911W2dyJywv7DmMyL7v4cxo5ZpcknhQrKrl3jCg0LeF4e+D7X
         0HBQ==
X-Received: by 10.42.250.70 with SMTP id mn6mr648338icb.78.1431129388300; Fri,
 08 May 2015 16:56:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 8 May 2015 16:56:28 -0700 (PDT)
In-Reply-To: <20150421230929.GA27773@peff.net>
X-Google-Sender-Auth: Q95Vj2v_gh8gCFTIKjIn3hYS7u8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268688>

On Tue, Apr 21, 2015 at 7:09 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 17, 2015 at 06:16:48AM -0400, Eric Sunshine wrote:
>> > If somebody has a FreeBSD or OS X system to test on, I'd
>> > love to see what is needed to compile with HAVE_GETDELIM
>> > there.
>>
>> Modern Mac OS X, 10.10.x Yosemite, has getdelim() and git builds fine
>> with HAVE_GETDELIM. I also tested on old Snow Leopard 10.5.8 from
>> 2009. It does not have getdelim(). Unfortunately, I haven't been able
>> to determine when getdelim() was introduced on the Mac OS X, thus have
>> been unable to craft a simple rule for config.mak.uname.
>
> Thanks for looking into it. Since there haven't been any other takers in
> the meantime, do you want to prepare a patch that checks $(uname_R) for
> 10.10.x?  That's likely more conservative than is necessary, but we can
> loosen it later if somebody on 10.9.x shows up with test results.

I spent some time downloading old Xcode releases and poking through
the packages. Xcode 3.2.x seems to be the last in the Xcode 3 series,
and none of the Xcode 3.2.x versions I examined carried getdelim().
The first package in which I found getdelim() was Xcode 4.1.
(Unfortunately, Apple doesn't seem to make Xcode 4.0 available for
download anymore or it's only available to paying developers, so I
couldn't check it.) According to Wikipedia[1], Xcode 4.1 was released
the same day as Lion (OS X 10.7 [2]), but was also available to paying
developers for Snow Leopard (OS X 10.6).

Consequently, I think it's safe to say that getdelim() is available
for Lion (10.7) and later. If we don't mind being a bit less
conservative, then we might assume that it also is available for Snow
Leopard (10.6), which it definitely supported, but perhaps that's too
risky, since not everyone would have been a paid subscriber.

Alternately, we could make the test more dynamic and accurate by
grepping stdio.h for 'getdelim' or just by trying a test compile,
though that's probably too expensive.

[1]: http://en.wikipedia.org/wiki/Xcode
[2]: http://en.wikipedia.org/wiki/OS_X
