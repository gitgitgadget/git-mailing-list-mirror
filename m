From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [RFH] eol=lf on existing mixed line-ending files
Date: Sun, 10 Apr 2011 00:09:38 +0400
Message-ID: <BANLkTi=qBeT=09YFng1gyt+SuN2v0g+kDg@mail.gmail.com>
References: <20110407231556.GA10868@sigill.intra.peff.net>
	<BANLkTimBewshVRYBibXJ7nDNoX0S0iDaUQ@mail.gmail.com>
	<20110409192941.GB31579@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Mislav Marohnic <mislav@github.com>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 22:09:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8eTa-0004g2-UJ
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 22:09:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471Ab1DIUJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 16:09:39 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52487 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755437Ab1DIUJj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 16:09:39 -0400
Received: by qyk7 with SMTP id 7so519603qyk.19
        for <git@vger.kernel.org>; Sat, 09 Apr 2011 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iOTzZCgc6b1OD8TObG/fdmS03vbgv8JGJGeOe8TLl7E=;
        b=PwUH0XtdCZo1xsYe1DNXFWtLBwpBPJRKpwoRMU9VJuqQQynV9/2WPFrswCzYTTcn4v
         ppJ/R3cL7Vph/od15csarCyWoUlv6ws0pbVC9GknD42rTRTFK+4yIVCwBjTOSRiFkvHM
         uSlXhBDja4Z87eXmZ9A4lFvN7LThZ4zYIRz44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p9CdkdDPucrQcnze25cOM2uD1bDZcC+lst80tz15KKFod34dRuA+griQLKeoBryeJp
         YUk7tsLR17a1tuWN9bfbALFrgq9CO2hCv8SgRDQ1WL4fw/xBV7EINzNgO7w0tJN6mqr8
         +jQFmX+76fY/6pcbfgNiO0hKLuzSDOl41UPBQ=
Received: by 10.229.66.151 with SMTP id n23mr2761814qci.268.1302379778388;
 Sat, 09 Apr 2011 13:09:38 -0700 (PDT)
Received: by 10.229.241.201 with HTTP; Sat, 9 Apr 2011 13:09:38 -0700 (PDT)
In-Reply-To: <20110409192941.GB31579@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171206>

On Sat, Apr 9, 2011 at 11:32 PM, Jeff King <peff@github.com> wrote:
>
> I just wonder if git can do better. But the only options I could thin=
k
> of are:
>
> =A01. Set the working tree file to have just LF's. But that doesn't h=
elp,
> =A0 =A0 since it is the conversion _to_ linefeeds that make it look l=
ike
> =A0 =A0 the file is changed. So we'd still see unstaged changes.

Well, eol=3Dcrlf _does_ set the working tree file to have only CRLF, bu=
t
you still have the same race as before. Just because git converts file,
it does not think about it as "dirty". It becomes "dirty" when git
tries to convert it back and gets a different result, and whether it
tries or not depend on timestamp. So, you still have the same race.

>> > So we get two different outcomes, depending on the index raciness.=
 Which
>> > one is right, or is it right for it to be non-deterministic?
>>
>> I like everything being deterministic, but in this case I do not see
>> how it is possible without making the normal case much slower.
>
> I think if you took my (1) suggestion above, it would be deterministi=
c.

Replace "eol=3Dlf" with "eol=3Dcrlf" in your script, and you will see t=
hat
it does not help with the race.

>
> I absolutely agree, and my first advice upon seeing this jquery repo =
was
> to fix those line endings. But they went for over a year with the bro=
ken
> setup, so clearly it wasn't bothering them. I wonder what git could d=
o
> better to provoke them to fix it sooner.

I believe git should consider all files as "dirty" if .gitattributes is
changed. So, you cannot accidentally commit changes to .gitattributes
without fixing line endings. Currently, you can provoke git to consider
all files as dirty by doing:

  touch -d 2000-1-1 .git/index

but we should not expect users to do that after editing .gitattributes.


Dmitry
