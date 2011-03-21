From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Mon, 21 Mar 2011 16:26:29 +0100
Message-ID: <1300721194.2583.22.camel@bee.lab.cmartin.tk>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
	 <1300371853-8965-1-git-send-email-cmn@elego.de>
	 <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
	 <1300701380.2583.13.camel@bee.lab.cmartin.tk>
	 <20110321111414.GD16334@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:26:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1h0T-0001DH-MB
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 16:26:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989Ab1CUP0n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 11:26:43 -0400
Received: from mx0.elegosoft.com ([88.198.54.133]:44627 "EHLO
	mx0.elegosoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab1CUP0k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 11:26:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id 45AEE1B4BFD;
	Mon, 21 Mar 2011 16:26:39 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mx0.elegosoft.com
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4g08rDedYhtK; Mon, 21 Mar 2011 16:26:33 +0100 (CET)
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 48D871B4BFC;
	Mon, 21 Mar 2011 16:26:33 +0100 (CET)
In-Reply-To: <20110321111414.GD16334@sigill.intra.peff.net>
X-Mailer: Evolution 2.91.92 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169601>

On lun, 2011-03-21 at 07:14 -0400, Jeff King wrote:
> On Mon, Mar 21, 2011 at 10:56:19AM +0100, Carlos Mart=C3=ADn Nieto wr=
ote:
>=20
> > On vie, 2011-03-18 at 00:25 -0700, Junio C Hamano wrote:
> > > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> > >=20
> > > > +	ret =3D snprintf(buf, sizeof(buf), "%s/%s", prefix, path);
> > > > +	if (ret >=3D sizeof(buf))
> > > > +		die("system path too long for %s", path);
> > > > +	else if (ret < 0)
> > > > +		die_errno("encoding error");
> > >=20
> > > POSIX says snprintf() should set errno in this case, and your use=
 of
> > > die_errno() would show that information, but what is "encoding er=
ror"?
> > >=20
> > > Just being curious, as I suspect that "snprintf() returned an err=
or" may
> > > be more appropriate, if the answer is "I don't know what kind of =
error it
> > > is, but snprintf() found something faulty while encoding so I cho=
se to
> > > call it encoding error".
> >=20
> >  My manpage says snprintf returns -1 if there was an output or enco=
ding
> > error. As there couldn't be an output error because it's writing to
> > memory and we can't output what snprintf chocked on because whateve=
r
> > die_errno uses will also choke on it, I just put "encoding error". =
I'd
> > put "error assembling system path" as the actual error message, I g=
uess.
>=20
> FWIW, we don't catch snprintf failures in 99% of the calls in git. Mo=
st
> calls just ignore the return value, and some even directly use the
> return value to add to a length. The one place that actually does che=
ck
> for the error is strbuf_vaddf, which just says "your vsnprintf is
> broken" and dies.

 It's not actually likely we'll ever meet this error if the only one
allowed to set the format string is the programmer (and to do otherwise
is a security risk).

>=20
> So I'm not sure how much we really care about this error code path. I=
f
> anything, we should be replacing all of the calls with something like=
:
>=20
>   static const char buggy_sprintf_msg[] =3D
>   "BUG: vsnprintf returned %d; either we fed it a bogus format string=
\n"
>   "(our bug) or your libc is buggy and returns an error when it shoul=
d\n"
>   "tell us how much space is needed. The format string was:\n"
>   "%s\n";
>   int xsnprintf(char *out, size_t size, const char *fmt, ...)
>   {
>           va_list ap;
>           int r;
>=20
>           va_start(ap, fmt);
>           r =3D vsnprintf(out, size, fmt, ap);
>           va_end(ap);
>=20
>           if (r < 0)
>                   die(buggy_sprintf_msg, r, fmt);
>           return r;
>   }

 Or we could overload (#define) snprintf and replace it with the
paranoid. It'd go nicely with the vsnprintf that tries to work around
the Windows implementation.

 I don't feel that strongly we should have the extra check there, seein=
g
how it's rare and not checked anywhere else.

   cmn
