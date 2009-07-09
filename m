From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] quickfetch(): Prevent overflow of the rev-list command 
	line
Date: Thu, 9 Jul 2009 10:43:38 +0200
Message-ID: <81b0412b0907090143r7c894c6fh15db309b53b9c446@mail.gmail.com>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se>
	 <200907081801.36901.johan@herland.net>
	 <81b0412b0907090101x7c8aa182o36687d67be3c5fb0@mail.gmail.com>
	 <200907091037.41329.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 10:44:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOpEg-0002Ya-5p
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 10:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756026AbZGIInm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Jul 2009 04:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbZGIInk
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 04:43:40 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:62660 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586AbZGIInk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 04:43:40 -0400
Received: by bwz25 with SMTP id 25so3377138bwz.37
        for <git@vger.kernel.org>; Thu, 09 Jul 2009 01:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QtTTo8g0FHPu8Mx61+Sv9BCUyQxjMd0KG4pT12Y9Hno=;
        b=iyKfIxCDK5o4XDGA0V56+X53fqKF5hJCOmFqA3pTXGGzuk4xXcntt3UJ5VOO8cIHq1
         r8z5ahmSvMY0TUsPp0EVrvNzPiJC/4ERcuCiplZATeYSPmQM0QXO2gPRhQV5CiHqr/8W
         3KA8UYBSqaPmdi70dOCKCN/YTxFmWmldpUCYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tyWJFpyjSatlsZqQNrMB+wpH1n2Q3vLkF2E5TczOIDxCTeg2DMfrtW1JEKNnAFdU5/
         O3ZJN98coc0sRepRV552VksRAce9Dv58rxKBtAzlY2E0KgVm3PFFm57W9asTicWeA6G7
         QEZSOoP2uxpI1IagLXczvNQOmb7vDegyHm8V8=
Received: by 10.204.113.12 with SMTP id y12mr455179bkp.214.1247129018348; Thu, 
	09 Jul 2009 01:43:38 -0700 (PDT)
In-Reply-To: <200907091037.41329.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122947>

On Thu, Jul 9, 2009 at 10:37, Johan Herland<johan@herland.net> wrote:
> On Thursday 09 July 2009, Alex Riesen wrote:
>> On Wed, Jul 8, 2009 at 18:01, Johan Herland<johan@herland.net> wrote=
:
>> > On Wednesday 08 July 2009, Johannes Sixt wrote:
>> >> ... don't you get this error message with errno set to EPIPE?
>> >> Previously, there was no error message.
>> >
>> > Indeed, you are correct. I guess the following should be added to =
the
>> > patch:
>> >
>> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (write_in_full(revlist.in, sha1_to_h=
ex(ref->old_sha1), 40) <
>> > 0 || write_in_full(revlist.in, "\n", 1) < 0) {
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("failed w=
rite to rev-list");
>> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D errno;
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D =
EPIPE) {
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 error("failed write to rev-list");
>> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 err =3D errno;
>>
>> You'll loose errno this way: error() does not save it.
>
> Not sure what you mean here. Should I move "err =3D errno;" outside t=
he
> innermost "if"?

put it before error("failed write to rev-list"); or even before the
"if (err !=3D EPIPE)".
Otherwise it is 0 after fprintf to stderr (which is the error() call).

> From my POV, if errno !=3D EPIPE, we save it into err, and return tha=
t
> (overridden by finish_command()'s return value, if non-zero). If errn=
o =3D=3D
> EPIPE, we're not interested in saving it, because we expect finish_co=
mmand()
> to return non-zero in any case.

And you think this expectation makes the code simpler to understand?
