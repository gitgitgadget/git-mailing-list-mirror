From: Erick Mattos <erick.mattos@gmail.com>
Subject: Re: [PATCH next v2] log_ref_setup: don't return stack-allocated array
Date: Thu, 10 Jun 2010 20:09:36 -0300
Message-ID: <AANLkTimEwV_bJkd_2csJB0L6T9Lq6F0hpllUO2pJTL8m@mail.gmail.com>
References: <e888313d5a782585f4a5e7ee8914302953c187e2.1276173576.git.trast@student.ethz.ch> 
	<47daf53b6b2cc25cc013c5f2183e309a671dc9d3.1276174233.git.trast@student.ethz.ch> 
	<AANLkTillDOCNQrpaEiFsFdq6HpU_LlwWI2ELIrEcrWHc@mail.gmail.com> 
	<201006101929.11034.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jun 11 01:10:06 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMqsv-0002Ml-HA
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 01:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754374Ab0FJXJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 19:09:59 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52442 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab0FJXJ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 19:09:58 -0400
Received: by gye5 with SMTP id 5so353845gye.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=wMY+Q9yBdrJkNuUDAQYHtF6wgEOEqF6J9WX7CnCpy8s=;
        b=pvTU8h3qAezBw9bivqkiGPI12rQK7AUX1RklPKChtTwWCJh6HYSdZMMpLKgUqh01GB
         Eq/mr0hRWzq6srmOkD4rsW8L8/7Xig2Yccr+7RkUN4TNivvMAqKzJqWfBDhcxDXIUUgT
         ISBIdqVbh/M2PMgJHTvVsZijMvXvcvni/7ZnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=oR1dOeGXAhqTacgzIzn4Tkc00AXZXFPzXs+ZKqP1XbDLZ96yNknTSCEaBUupoptcNU
         ajUsApj6VLYIVj1xE90j4FGef9Odp+JWIgcDZaoLhR/XC6XKCIik7UdNe2kDZMPFKXnY
         0D3oFMqx1wHdLL2raPOgInHMbGSEduo4cZ8FY=
Received: by 10.150.118.3 with SMTP id q3mr2294901ybc.211.1276211397522; Thu, 
	10 Jun 2010 16:09:57 -0700 (PDT)
Received: by 10.151.15.7 with HTTP; Thu, 10 Jun 2010 16:09:36 -0700 (PDT)
In-Reply-To: <201006101929.11034.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148920>

Hi,

We are becoming a little theoretical here so people please be
condescending to us if the chat gets a little boring.  ;-)

2010/6/10 Thomas Rast <trast@student.ethz.ch>:
> What the - side of the hunk above does is returning a local (stack
> allocated) variable, in the form of a pointer to logfile. =C2=A0Once =
those
> go out of scope, you have zero guarantees on what happens with them.

Not really.

What the actual log_ref_setup() does when is instantiated is to create
a pointer in the stack, called log_file, to a pointer to a char array.
 This pointer receives the address of a char array of the calling
function because that is why passing by reference is made to.  See
that the calling functions is using the "&" when making the call (If I
was using C++ I would pass by reference the array itself but in C I
can only pass pointer variables by reference that is why the pointer
to a pointer).

Then git_snpath() creates a char array in the heap with the right
content and changes the stack pointer logfile to it.  Then when we do
*log_file =3D logfile what is happening is that the content of the
pointer in the stack, log_file, which its content is the calling
function char array pointer, is being set to the address of the buffer
created in the heap by git_snpath().  After it, what you have is just
the natural cleanup of the stack variables of the called function but
the calling variable keeps the address of the char array in the heap
created by git_snpath().

> Try the following snippet, it should cause a similar problem:
>
> =C2=A0#include <stdio.h>
>
> =C2=A0int* f()
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0i =3D 42;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return &i;
> =C2=A0}
>
> =C2=A0int main()
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int *p =3D f();
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (1) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0char buf[1024]=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memset(buf, 0,=
 sizeof(buf));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printf("I got: %d\n", *p);
> =C2=A0}
>
> Only in this case the issue is so obvious that the compiler will warn
> (at least mine does).

That is another thing.

>> I haven't ever seen this happening so I think you have found some
>> particularity of valgrind which could route a patch to it.
>
> Admittedly my experience is somewhat limited since I don't do C codin=
g
> outside of git and some teaching. =C2=A0But so far I have not had a s=
ingle
> false alarm with valgrind (when compiled without optimizations;
> otherwise the compiler may do some magic).

I don't think I am good enough too.  I have always things to learn.
And I hopefully will be always learning new things!  I am addicted to
it.  :-S

Everybody is here to help each other and NOBODY does not commit
mistakes so your help is very welcome but don't deposit all your
beliefs in any piece of software because all of them could contain
mistakes too, even if the best ever existent programmers had made them
in whole.

Programming is teaching a limited dumb equipment to be clever.  So it
is in itself a contradiction.

Best regards
