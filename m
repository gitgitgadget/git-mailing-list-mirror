From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Sun, 13 Sep 2015 13:11:46 -0400
Message-ID: <CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
	<20150913101727.GB26562@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeffrey Walton <noloader@gmail.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 19:11:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbAoi-0001qV-LS
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 19:11:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824AbbIMRLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 13:11:48 -0400
Received: from mail-yk0-f181.google.com ([209.85.160.181]:36132 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbIMRLr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 13:11:47 -0400
Received: by ykdt18 with SMTP id t18so113458993ykd.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 10:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=obtW1ERY52rIG6dsjsU9dvmirJlFa51iEZv0EIL5WBU=;
        b=p2BuXPPAaWOYAwzR0VdjDaVAB4xYNYQVcKvXO9CTV+80nMEGUB6xBUVZycod6MSaof
         piJCPbOKyxZjsGwymitSqZiIeWFkryDQG2CP9iFRPKu739JeL0l+3jiHVpbWuT/u/geX
         fcS+lK1/JuZFEvRhYnBRONBVCoaGRXbGxzJmP19WkXyg3c5fkl3Uc0uItk9z1beI1ZgI
         Um3jEVFohkcLFfVWS8lwDkCnDHSEmhmuHmoVXuKMosd4GoCGXRxJb1HWzYbBtBzNiRvV
         zhwhezjBGR3z/hdcAnz8PDJWN2+xnl6jVmfaBHas8cbuV25Xl9JjReZeWv560qfHhIKu
         LyRw==
X-Received: by 10.129.70.195 with SMTP id t186mr9760111ywa.4.1442164307015;
 Sun, 13 Sep 2015 10:11:47 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 13 Sep 2015 10:11:46 -0700 (PDT)
In-Reply-To: <20150913101727.GB26562@sigill.intra.peff.net>
X-Google-Sender-Auth: HT37dWM9p9an6t8FI9vuuKh0AMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277787>

On Sun, Sep 13, 2015 at 6:17 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Aug 30, 2015 at 05:34:59PM -0400, Jeffrey Walton wrote:
>> I'm working on an old OS X machine. I needed to perform:
>>
>>   AR=libtool
>>   ARFLAGS="-static -o"
>>   ...
>>   make configure
>>   ./configure ...
>>   make
>
> Hrm. Your "$(AR)" is not really "ar" then, is it? It has been a long
> time since I played with libtool, but what is the reason that you are
> calling libtool and not "ar" in the first place. Is it that you do not
> have "ar" at all, and libtool performs some other procedure? If so, is
> there a more ar-compatible wrapper that can be used?

This isn't GNU's libtool. It's Apple's libtool, an entirely different
beast, which is an 'ar' replacement and is needed when linking
Universal binaries containing code for more than one architecture,
such as 'ppc' and 'i386', so the same executable can run on multiple
architectures. This tool dates all the way back to at least NextStep
3.1 when NeXT ported NextStep to Intel hardware (i486) from NeXT
computers (m68k). The name "Universal" is an Apple invention, but back
in the NeXT days, they were called Multi-Architecture Binaries (MAB)
or, colloquially, just FAT (for "fat"); there was a corresponding
"lipo" command (short for "liposuction") to "thin" out "fat" binaries.
NeXT's libtool predates GNU's libtool by a few years: May 1993 vs.
July 1997, respectively. When an attempt is made to use 'ar' on
Universal object files, it errors out saying that it can't be used
with such files and recommends 'libtool' instead.

>> The Makefile might benefit from the following for users who need to
>> tweak things:
>>
>>     ARFLAGS ?= rcs
>>     ...
>>
>>     $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
>>     ...
>
> Yeah, that does sound reasonable (even if one does not set $(AR) to
> something completely different, they might need slightly different
> flags).
