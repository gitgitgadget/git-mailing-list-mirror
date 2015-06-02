From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 7/9] strbuf_getwholeline: use getdelim if it is available
Date: Tue, 2 Jun 2015 14:22:29 -0400
Message-ID: <CAPig+cTctJ0VaKP1GLoWSxsnnq-G=0=fbcgR7tvFY0Daci=1QQ@mail.gmail.com>
References: <20150416084733.GA17811@peff.net>
	<20150416090138.GG17938@peff.net>
	<CAPig+cSKtMPQGxp1Y2GinVRh2y--QyJh_nxhDez2CGFPP6B=xg@mail.gmail.com>
	<20150421230929.GA27773@peff.net>
	<CAPig+cQi7SfJJc4d3DJ2mJ0-5vT7LJDttPPec=UEsmjiqtLcZQ@mail.gmail.com>
	<20150509010952.GA29555@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Rasmus Villemoes <rv@rasmusvillemoes.dk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 02 20:22:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yzqpg-0007ue-8p
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 20:22:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759589AbbFBSWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 14:22:32 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35206 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754556AbbFBSWa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 14:22:30 -0400
Received: by iesa3 with SMTP id a3so139648864ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 11:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nRup4CdbNAlg+NURA9MfAU/JKGMFu28s8gg1Q5xTbsY=;
        b=VVIZEQNuHP8c8JUXS0uQFdJYwJfeXmXZsLz9ulzQxRSz5W9c0M2DK0ASltZdjnvDEE
         ZWhe4SX9aasY9uuVivGqR6ANtQF27A7Zes4YAKLOUuc1klUMFOhA6C+Ym8Eks4YZJrQy
         8lUHcKtPNlJIOgZa+JHgQjITGXxO0HJ8+JaNtbNkFMzsQ2ZQNyZ2Zx53zm38dVOL7VnS
         COgRl3FlyN5w7f9Ecu9R6NxjqLrznwlB4RRgKHo3eM6y7IZigOPkHBxtAivAmm2JcRNB
         siGpeLFxJVcFTrlRFkKrffKe2nvNamuM1/p2pOKVYwjZBvMdVjWUE0n/D0WqtHJGjH/G
         loQQ==
X-Received: by 10.107.31.134 with SMTP id f128mr17372823iof.19.1433269350015;
 Tue, 02 Jun 2015 11:22:30 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 11:22:29 -0700 (PDT)
In-Reply-To: <20150509010952.GA29555@peff.net>
X-Google-Sender-Auth: eCyluh4qlDDArVYrJO-Epk2AIXo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270579>

On Fri, May 8, 2015 at 9:09 PM, Jeff King <peff@peff.net> wrote:
> On Fri, May 08, 2015 at 07:56:28PM -0400, Eric Sunshine wrote:
>> I spent some time downloading old Xcode releases and poking through
>> the packages. Xcode 3.2.x seems to be the last in the Xcode 3 series,
>> and none of the Xcode 3.2.x versions I examined carried getdelim().
>> The first package in which I found getdelim() was Xcode 4.1.
>> (Unfortunately, Apple doesn't seem to make Xcode 4.0 available for
>> download anymore or it's only available to paying developers, so I
>> couldn't check it.) According to Wikipedia[1], Xcode 4.1 was released
>> the same day as Lion (OS X 10.7 [2]), but was also available to paying
>> developers for Snow Leopard (OS X 10.6).
>>
>> Consequently, I think it's safe to say that getdelim() is available
>> for Lion (10.7) and later. If we don't mind being a bit less
>> conservative, then we might assume that it also is available for Snow
>> Leopard (10.6), which it definitely supported, but perhaps that's too
>> risky, since not everyone would have been a paid subscriber.
>
> Thanks for digging. I'd argue for the conservative choice, simply
> because this is a pure optimization. The old code should work just fine,
> and people have been living with it for years.
>
> I doubt it will affect many people either way, though. Lion is 4 years
> old, and most OS X people seem to upgrade fairly regularly. It is not
> like long-term server systems where we are supporting Solaris 7. :)
>
> Want to roll a patch?

After a long, long delay, here it is...[1]

>> Alternately, we could make the test more dynamic and accurate by
>> grepping stdio.h for 'getdelim' or just by trying a test compile,
>> though that's probably too expensive.
>
> The natural place would be in configure.ac, and that is orthogonal to
> the default Darwin setting, I think.

I added that too[1].

[1]: http://thread.gmane.org/gmane.comp.version-control.git/270576
