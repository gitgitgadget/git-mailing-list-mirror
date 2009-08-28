From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 20:49:48 +0200
Message-ID: <81b0412b0908281149i2182f95ob51fee82e29e8fdf@mail.gmail.com>
References: <4A97193A.8090502@facebook.com>
	 <20090828060538.GA22416@coredump.intra.peff.net>
	 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
	 <20090828150212.GA6013@coredump.intra.peff.net>
	 <alpine.LFD.2.00.0908281307510.6044@xanadu.home>
	 <20090828180158.GA6940@coredump.intra.peff.net>
	 <81b0412b0908281127h2c444770g411ceaf052952899@mail.gmail.com>
	 <20090828183958.GA11488@coredump.intra.peff.net>
	 <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@cam.org>, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 20:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh6WO-00058V-Op
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 20:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbZH1Str (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 14:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZH1Str
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 14:49:47 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:45093 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZH1Stq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 14:49:46 -0400
Received: by fxm17 with SMTP id 17so1737063fxm.37
        for <git@vger.kernel.org>; Fri, 28 Aug 2009 11:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=DGjesEDhPgRCK3kwSdnQwIg0r65j6W4B4Jf9ioXHkuE=;
        b=DAIOtzmwsXHP46O6uYqevFegsalO5w8upaSNvehDJV+NV2KSEh1hADbo7vFi6CLoEQ
         zwKP5s96Lvo29KXXPZdHXK7BvNaBEzmRPK3SZrN7vbchL1SOD2ALtxJgr1hSVa0X/MMF
         nHhxDYh9KCgkvT1w2FHex/KyIVsXGV+HjNtDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=By6H8+91E3lWyvMSO8TYSTLwgEs4ybUwBfakjB5WaJ4TjGdFq+EqWjeIE4vt1i5rx2
         8M3PUzwqdsiVCbszVjDMhSR5Xok8QwoA39pLwN6B4RP1uEgGp2FrECRTGK5dulk7pgTx
         pOSfQ4YFuywfVCMPHPWa1+ZmfSdiYQDweVoA4=
Received: by 10.204.153.217 with SMTP id l25mr1196306bkw.108.1251485388204; 
	Fri, 28 Aug 2009 11:49:48 -0700 (PDT)
In-Reply-To: <81b0412b0908281142v7e1b73ddvb727abe915dace86@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127326>

On Fri, Aug 28, 2009 at 20:42, Alex Riesen<raa.lkml@gmail.com> wrote:
> On Fri, Aug 28, 2009 at 20:39, Jeff King<peff@peff.net> wrote:
>> On Fri, Aug 28, 2009 at 08:27:06PM +0200, Alex Riesen wrote:
>>
>>> > Thanks, that is a much better solution. And I don't know offhand of any
>>> > portability problems in overriding the library at link time.
>>>

Hm, how about supplying show_date and approxidate with current time?
Like this:

/* exported */
const char *show_date_rel(unsigned long time, int tz, struct timeval *now)
{
... the DATE_RELATIVE path of show_date
}

const char *show_date(unsigned long time, int tz, enum date_mode mode)
{
  struct timeval now;
  if (mode == DATE_RELATIVE) {
    gettimeofday(&now, NULL);
    return show_date_rel(time, tz, &now);
  }
  ... other paths of old show_date
}

Still affects the performance, but much less, and no side effects.
And you can test show_date_rel path in test-date.c
