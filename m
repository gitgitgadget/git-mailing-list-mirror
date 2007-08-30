From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: Buffer overflows
Date: Thu, 30 Aug 2007 23:34:26 +0100
Message-ID: <3f4fd2640708301534k40f07a1cva90a59d12ace6138@mail.gmail.com>
References: <1188502009.29782.874.camel@hurina>
	 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org>
	 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi>
	 <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
	 <6F219888-6F48-4D56-8FA9-BE63EB6E1D95@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Timo Sirainen" <tss@iki.fi>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 31 00:34:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQsb0-0000BT-FU
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:34:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762996AbXH3We3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757775AbXH3We3
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:34:29 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:64614 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762921AbXH3We2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 18:34:28 -0400
Received: by rv-out-0910.google.com with SMTP id k20so263136rvb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 15:34:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=googlemail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F4uwzGq0csYP8zQ/n9o4+3mEFFq50M8CAcHRbF8Z8rYYVMX3ebAOHGO8JWJgm6mu77aKiK6t2H9AjgBeSus7JcVUD6y4XAdoWxIP5M0pF/8eBrG6O1QAbWUEdEVPL8b+rHmyVK6EE/esC2IGna6kjW7GSFrMK5q1xMV4RpK8ZgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tW3icBIyiMEpm1Txhc+HCCXZ5hlktRxp4q11yMBKTAmMgh6upLVSZKlBPEiJcLAhnV/HU0HliMM5D/zel/QGc4p+juLDlPPO0VgQ2vO8Qg0/scuwqLDYSsMKAcjunyqEv+B8joKpuWaKC5Ufe3qlGQngUDFydG6rkDM4hOz3T5c=
Received: by 10.141.161.6 with SMTP id n6mr402698rvo.1188513267010;
        Thu, 30 Aug 2007 15:34:27 -0700 (PDT)
Received: by 10.141.32.14 with HTTP; Thu, 30 Aug 2007 15:34:26 -0700 (PDT)
In-Reply-To: <6F219888-6F48-4D56-8FA9-BE63EB6E1D95@iki.fi>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57082>

On 30/08/2007, Timo Sirainen <tss@iki.fi> wrote:
> On 31.8.2007, at 0.35, Reece Dunn wrote:
>
> >> The problem is that the git code is full of these random cases. It's
> >> simply a huge job to even try to verify the correctness of it. Even
> >> if someone did that and fixed all the problems, tomorrow there would
> >> be new ones because noone bothers to even try to avoid them. So there
> >> really isn't any point in trying to make git secure until the coding
> >> style changes.
> >
> > You don't want a manual check to do these kinds of checks. Not only is
> > it a huge job, you have the human factor: people make mistakes. This
> > is (in part) what the review process is for, but understanding how to
> > identify code that is safe from buffer overruns, integer overflows and
> > the like is a complex task. Also, it may work on 32-bit which has been
> > verified, but not on 64-bit.
> >
> > It would be far better to specify the rules on how to detect these
> > issues into a static analysis tool and have that do the checking for
> > you. Therefore, it is possible to detect when new problems have been
> > added into the codebase. Does sparse support identifying these issues?
>
> Yes, it is a complex task. But if there did exist such a static
> analyzer tool already, it would probably show that half of the strcpy
> () calls (and others) in git are currently unsafe. Wouldn't help all
> that much I think.

Let's see:

symlinks.c(39): In has_symlink_leading_path, the last_symlink input
argument needs to be large enough to hold MAX_PATH characters, as this
is sizeof(path). This is a potential risk, depending on how this
method is used.

sideband.c(17): buf is large enough to copy the "remote:" string
literal into. Also, the buffer is large enough for the input being
read, as packet_read_line specifies the size of the remaining buffer
with an extra character reserved for the null. Therefore, this usage
is safe.

sha1_file.c(550): open_pack_index does a runtime calculation that
essentially results in strcpy( ".pack", ".idx" ). As these are
literals, this usage is safe, provided that strlen(idx_name) >
strlen(".pack") which should be ensured by the caller. Hence, this
usage is safe.

So far, these are looking safe to me. I'd need to check the remaining
uses to be sure and to find the strcpy usage that you have identified
as an issue.

It would also be worth creating a test case that triggers this bug, as
that can then be used to ensure that it does not reappear once fixed.
That is the best way to deal with these, as not all uses of "unsafe"
API are actually unsafe.

> >> The code should be easy to verify to be secure, and with some kind of
> >> a safe string API it's a lot easier than trying to figure out corner
> >> cases where strcpy() calls break.
> >
> > Why is it easier? If you have a fixed-size buffer, why not use
> > strncpy, which is what a safe string API is essentially doing anyway?
>
> Well, strncpy() is a pretty good example actually. A lot of people
> use it wrong, because they don't realize that it doesn't necessarily
> NUL-terminate the strings. So it's another example of a bad API that
> can be easily used wrong. And besides that, it also fills the rest of
> the buffer with NULs, which is almost always pointless waste of CPU.

Ok, I take your point. However, there is nothing preventing these API
from being used correctly. Granted, this is more work and like the
strncpy example, have subtle behaviour, but that does not make it
impossible.

As an example, do your safe API do null pointer checks. This is
because strcpy, strlen and the like don't, which is one of the reasons
why they are considered unsafe. But then, if you guarantee that you
are not passing a null pointer to one of these API, why take the hit
of the additional checks when you know that these are safe. It is also
easier to debug the problem if it happens at the point of call,
instead of silently working.

One of the problems with a safe string API is that there are different
possible things to do when an overrun is detected. The best thing to
do would be to cap the input to the buffer size and return some error
status. For example, you could have:

    STR_STATIC(str, 1);
    sstr_append(str, "/foo/bar");
    // run "rm -rf ${str}"

which would hose your system. This is worse than a buffer overrun.

> And why is safe string API easier to verify? Here's an example:
>
> // see how easily you can use strncpy() to cause a buffer overflow:
> char buf[1024];
> strncpy(buf, input, 2048);

Yes it can, as above. A subtler case would be when the space for a
null terminator is missed. But then I'd write something like:

    char buf[1024];
    strncpy(buf, input, sizeof(buf));

Here, the compiler does the work for me, so if I change 1024 to 512,
it will still be safe.

> // see how impossible it is to cause a buffer overflow with my static
> string API:
> STR_STATIC(str, 1024);
> sstr_append(str, input);

How is str defined? Looking at the code, I can't _see_ that this is
safe. All I see as inputs are `str` and `input`, so how can I verify
that this is correct without looking at how these are defined.

> Of course the above example is a simple one, but often when using
> libc string handling functions for building strings the code gets
> complex and there are all kinds of "is the buffer full already? what
> about now? and now? and now?" and with all of those checks it's easy
> to make mistakes.

But also, those API are well known, along with their associated
problems. By creating a new API, there are new (unknown) ways to
abuse/misuse it.

> The point is that if the APIs are (nearly) impossible to use
> insecurely, it's very easy to verify that the code is safe. The code
> doesn't get safe by lots of checks everywhere, it gets safe by
> placing a minimal amount of checks to small area of the code. The
> correctness of a few checks is a lot easier to verify.

But what about that nearly impossible case?

Also, how do you use the safe string API with other API that don't
have a "safe" equivalent?

- Reece
