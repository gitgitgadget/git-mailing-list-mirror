From: Timo Sirainen <tss@iki.fi>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 01:41:03 +0300
Message-ID: <16CA3709-5E04-4CEA-B154-2339C5E4D23C@iki.fi>
References: <1188502009.29782.874.camel@hurina> <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> <3f4fd2640708301435s7067137cp5db6334af844158a@mail.gmail.com> <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-5--246933607"
Content-Transfer-Encoding: 7bit
Cc: "Reece Dunn" <msclrhd@googlemail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 00:41:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQshK-0001fy-Px
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 00:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757940AbXH3WlG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 18:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757230AbXH3WlG
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 18:41:06 -0400
Received: from dovecot.org ([82.118.211.50]:54079 "EHLO dovecot.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756030AbXH3WlE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 18:41:04 -0400
Received: from [192.168.10.217] (82-203-162-146.dsl.gohome.fi [82.203.162.146])
	by dovecot.org (Postfix) with ESMTP id 948CA16471E1;
	Fri, 31 Aug 2007 01:41:01 +0300 (EEST)
In-Reply-To: <7vtzqg7jrn.fsf@gitster.siamese.dyndns.org>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57084>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-5--246933607
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On 31.8.2007, at 1.14, Junio C Hamano wrote:

> "Reece Dunn" <msclrhd@googlemail.com> writes:
>
>> Why is it easier? If you have a fixed-size buffer, why not use
>> strncpy, which is what a safe string API is essentially doing anyway?
>
> I would not claim unchecked strcpy is good -- we obviously would
> want to fix them.
>
> But at the same time use of strncpy, strlcpy and friends solves
> only half of the problem.  Often people say "use strncpy or
> strlcpy then you would not overstep the buffer", but that does
> not really solve anything, without additional logic to deal with
> resulting truncation (barfing with "insanely long string" error
> message and dying is the least impact).  Continuing the work on
> data that the user did not intend to give you is just as wrong
> as using corrupt data that overflowed your static buffer.

Sure, I agree with that. In my own code I avoid static buffer sizes  
as much as I can. But since git's code is far from even trying to do  
that, I thought it would be easier to start with a simpler plan: Try  
not to have remote code execution holes that can be found with 2  
minutes of looking at the code.

> Does Timo's nonstandard API solve that issue?  Perhaps it does,
> perhaps not.

That would require moving to dynamically growing strings, which in  
turn requires freeing the strings afterwards so it's not such a  
simple job. Simply replacing the current char[] buffers with my  
static_string would be quick and easy and although it wouldn't fix  
all potential problems, it would fix most of the buffer overflows.

> Does it make easier to maintain our code?  I highly doubt it in the  
> current shape.

Depends on what you mean by "maintain". I find the resulting code a  
lot easier to understand, and a lot easier to verify for correctness  
and safety. Here's an example: http://marc.info/? 
l=git&m=117962988914013&w=2

But then again you and Alex didn't seem to think so.

> It is well and widely understood idiom to use strlcpy to a
> fixed-sized buffer and checking the resulting length to make
> sure the result would not have overflowed (and if it would have,
> issue an error and die).  I would not have anything against a
> set of patches to follow such a pattern.

I don't like strlcpy()/strlcat() all that much either, because  
checking the overflow is more difficult than it needs to be. For  
example:

if (strlcpy(dest, src, sizeof(dest)) <= sizeof(dest)) overflow();
// compared to a function that simply returns if it overflowed or not:
if (strocpy(dest, src, sizeof(dest)) < 0) overflow();

Actually I'm not even sure if the above strlcpy() check is right. Is  
it <= or <?

> The API needs to justify itself to convince the people who needs
> to learn and adjust to that the benefit far outweighes deviation
> from better known patterns, and I do not see that happening in
> Timo's patch.

The better known patterns are being used insecurely all the time now,  
so I can't really see how this would be anything worse.

Anyway my point wasn't to get my code into git. I just wanted that  
*something* would be done about this. Currently I just can't see  
myself wanting to use git, because it limits what I can do with it.  
Any kind of automated processing is completely out of the question  
because then attackers could easily take over my machine if they  
wanted to.

--Apple-Mail-5--246933607
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (Darwin)

iD8DBQFG10eAyUhSUUBViskRAvv/AJ48s7g8PyD9pJMnXQ/q0DMNuvdXBACeJt7y
ytVIDKJi8UZomMQoUh92AKo=
=lTJU
-----END PGP SIGNATURE-----

--Apple-Mail-5--246933607--
