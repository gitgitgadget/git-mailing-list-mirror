From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 07/11] branch: move 'current' check down to the
 presentation layer
Date: Sat, 1 Aug 2015 12:18:50 +0530
Message-ID: <CAOLa=ZRq7zowwse7OGeU_AwJe_Z0WDn1qoYaH_A6AD5g92e_GQ@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-7-git-send-email-Karthik.188@gmail.com>
 <vpqbnewxwcx.fsf@anie.imag.fr> <CAOLa=ZTy+KX4K_inpDoMy+thzFdF2RF93yMEHJUExzT4OvjPww@mail.gmail.com>
 <vpqk2tjmgeg.fsf@anie.imag.fr> <CAOLa=ZRUnF12gO=AKg3E373XETqoykqOXSkPvr7DHCVrOeggAA@mail.gmail.com>
 <vpq4mkmejsh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Aug 01 08:49:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLQbk-0006Bm-VP
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 08:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbbHAGtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2015 02:49:21 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33441 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751029AbbHAGtU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2015 02:49:20 -0400
Received: by oig1 with SMTP id 1so14893631oig.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 23:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ReCeDncosSRmygBxzoG6gPahPM80uXNiXMq0PsK+lY4=;
        b=nbKjoH0BQ9wpCv6XVLte3tVwxdoJTi1UVARUzEx/y1Y6R47P2WAuAdEOks7h2UrJRd
         5SM4ov84k0a8KYcNP9kyP3lz2b5a0lPvksWaMu6H/KCrOmaJz7GFH8xnu9J5l5GU7iLu
         ISsDNwLZDzz//Yds8g+f/+D5aXIRq30iZC0iJZ2TYBeX+eYxz/IC3B5PiaLtnidgAMC6
         2cs+VC6W5kOMZYnbIUvsJVK5P9hdwXxzlvE6gaS1eekIXbXaeEo68qaFsLlF5nLzT2u7
         Maxf5MoUBLY95SM1XsJZ/O61oLwXQL3DEwn+bBG2oFed38gNhr4kF0zeCZtPu+K1uQxZ
         xWCQ==
X-Received: by 10.202.92.6 with SMTP id q6mr6921817oib.11.1438411759837; Fri,
 31 Jul 2015 23:49:19 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 31 Jul 2015 23:48:50 -0700 (PDT)
In-Reply-To: <vpq4mkmejsh.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275111>

On Thu, Jul 30, 2015 at 2:57 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> What I was thinking of was something like this :
>>
>> struct strbuf format = STRBUF_INIT;
>> char c = ' ';
>> if (current)
>>     c = '*';
>> strbuf_addf(&format, "%c....", c, other format options...);
>> show_ref_array_item(item, format.buf, quote_style, 0);
>> strbuf_release(&format);
>
> I think that would interact badly with verify_ref_format(). Usually, you
> have just one format string and call verify_ref_format() on it, not a
> different format string for each ref_array_item. That would probably be
> solvable.
>

Good point! I just was wondering if we need another atom just to print a star.
But your points certainly are valid. I'll implement this. Thanks :)

>> This would remove the need of making the printing of the "*" to be
>> needed by ref-filter. As this is only needed in branch.c
>>
>> If going on what you're saying we could have a "%(starifcurrent)" atom or
>> something, but I don't see a general use for this.
>
> To have a really customizeable format, you would want to allow e.g.
>
>   git branch --format '%(starifcurrent) %(objectname) %(refname)'
>
> if the user wants to get the sha1 before the refname, and still have the
> star in front. It's a bit frustrating to have a hardcoded format that
> the user can't reproduce with the --format option, since it means you
> can't easily make a small variation on it.
>

Agreed. will have a "starifcurrent" atom :)

-- 
Regards,
Karthik Nayak
