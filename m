From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] for-each-ref: fix off by one read.
Date: Tue, 13 Nov 2007 06:15:54 +0100
Message-ID: <200711130615.54196.chriscool@tuxfamily.org>
References: <20071112053725.4f0d1940.chriscool@tuxfamily.org> <7vfxzb1032.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 06:09:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iro1g-000551-Ob
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 06:09:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbXKMFJN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Nov 2007 00:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXKMFJL
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 00:09:11 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:38425 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbXKMFJL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Nov 2007 00:09:11 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id CB8871AB2C2;
	Tue, 13 Nov 2007 06:09:08 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id B477B1AB2C1;
	Tue, 13 Nov 2007 06:09:08 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vfxzb1032.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64753>

Le mardi 13 novembre 2007, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
> > index 598d4e1..89ea37c 100644
> > --- a/builtin-for-each-ref.c
> > +++ b/builtin-for-each-ref.c
> > @@ -306,7 +306,7 @@ static const char *find_wholine(const char *who=
,
> > int wholen, const char *buf, un if (!eol)
> >  			return "";
> >  		eol++;
> > -		if (eol[1] =3D=3D '\n')
> > +		if (*eol =3D=3D '\n')
> >  			return ""; /* end of header */
> >  		buf =3D eol;
> >  	}
>
> Good eyes. =20

Well, Valgrind found it when I did:

$ valgrind git for-each-ref --format=3D'%(refname)' "refs/tags/*"

> This would have broken if

>  (1) we had a header field that consists of a single character
>      and then LF.  We would have mistaken such a line as the end
>      of header; or
>
>  (2) we had a commit or a tag that consists solely of header and
>      no body.  We would have read past the terminating NUL.

I suspect that the end of the header was not properly detected, so that=
 it=20
may have read one byte past a body ending with LF and the terminating N=
UL.

Christian.
