From: Timo Sirainen <tss@iki.fi>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 00:51:24 +0300
Message-ID: <6F219888-6F48-4D56-8FA9-BE63EB6E1D95@iki.fi>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--249912982"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Reece Dunn" <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQrvE-0008Iy-Vq
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760847AbXH3VvY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 17:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760679AbXH3VvY
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 17:51:24 -0400
Received: from dovecot.org ([82.118.211.50]:36775 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760562AbXH3VvX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 17:51:23 -0400
Received: from [192.168.10.217] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 69C2C16471E6;
	Fri, 31 Aug 2007 00:51:22 +0300 (EEST)
In-Reply-To: <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57077>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--249912982
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On 31.8.2007, at 0.35, Reece Dunn wrote:

>> The problem is that the git code is full of these random cases. It's
>> simply a huge job to even try to verify the correctness of it. Even
>> if someone did that and fixed all the problems, tomorrow there would
>> be new ones because noone bothers to even try to avoid them. So there
>> really isn't any point in trying to make git secure until the coding
>> style changes.
>
> You don't want a manual check to do these kinds of checks. Not only is
> it a huge job, you have the human factor: people make mistakes. This
> is (in part) what the review process is for, but understanding how to
> identify code that is safe from buffer overruns, integer overflows and
> the like is a complex task. Also, it may work on 32-bit which has been
> verified, but not on 64-bit.
>
> It would be far better to specify the rules on how to detect these
> issues into a static analysis tool and have that do the checking for
> you. Therefore, it is possible to detect when new problems have been
> added into the codebase. Does sparse support identifying these issues?

Yes, it is a complex task. But if there did exist such a static  
analyzer tool already, it would probably show that half of the strcpy 
() calls (and others) in git are currently unsafe. Wouldn't help all  
that much I think.

>> The code should be easy to verify to be secure, and with some kind of
>> a safe string API it's a lot easier than trying to figure out corner
>> cases where strcpy() calls break.
>
> Why is it easier? If you have a fixed-size buffer, why not use
> strncpy, which is what a safe string API is essentially doing anyway?

Well, strncpy() is a pretty good example actually. A lot of people  
use it wrong, because they don't realize that it doesn't necessarily  
NUL-terminate the strings. So it's another example of a bad API that  
can be easily used wrong. And besides that, it also fills the rest of  
the buffer with NULs, which is almost always pointless waste of CPU.

And why is safe string API easier to verify? Here's an example:

// see how easily you can use strncpy() to cause a buffer overflow:
char buf[1024];
strncpy(buf, input, 2048);

// see how impossible it is to cause a buffer overflow with my static  
string API:
STR_STATIC(str, 1024);
sstr_append(str, input);

Of course the above example is a simple one, but often when using  
libc string handling functions for building strings the code gets  
complex and there are all kinds of "is the buffer full already? what  
about now? and now? and now?" and with all of those checks it's easy  
to make mistakes.

The point is that if the APIs are (nearly) impossible to use  
insecurely, it's very easy to verify that the code is safe. The code  
doesn't get safe by lots of checks everywhere, it gets safe by  
placing a minimal amount of checks to small area of the code. The  
correctness of a few checks is a lot easier to verify.

--Apple-Mail-4--249912982
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (Darwin)

iD8DBQFG1zvcyUhSUUBViskRAvO/AKCi6X9TSfN63vYpX0py91iDPYwBWACfSYRK
mMxTxu72oT9sZgTIqwenaro=
=589l
-----END PGP SIGNATURE-----

--Apple-Mail-4--249912982--
