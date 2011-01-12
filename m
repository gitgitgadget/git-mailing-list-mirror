From: Thomas Rast <trast@student.ethz.ch>
Subject: diff -U0 occasionally misses a chance to make empty lines context [was: Re: [BUG] difference of info from diff and blame]
Date: Wed, 12 Jan 2011 11:20:26 +0100
Message-ID: <201101121120.26724.trast@student.ethz.ch>
References: <4D2C333A.3010401@gmail.com> <201101111440.08619.trast@student.ethz.ch> <4D2D5E08.9040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Davide Libenzi <davidel@xmailserver.org>
To: Semyon Kirnosenko <semyon.kirnosenko@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 11:20:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pcxoh-0004lB-R5
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 11:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752356Ab1ALKUa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jan 2011 05:20:30 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26505 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752244Ab1ALKU3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jan 2011 05:20:29 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 12 Jan
 2011 11:20:22 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.218.12; Wed, 12 Jan
 2011 11:20:27 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <4D2D5E08.9040804@gmail.com>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165012>

Ok, so to summarize for late joiners and the new Ccs:

git diff -U0 occasionally gives suboptimal results in hunks like

Semyon Kirnosenko wrote:
> 11.01.2011 16:40, Thomas Rast =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > @@ -108,11 +123,8 @@ jQuery.event =3D {
> > -			var handler =3D element["on" + type ], val,
> > -				fn =3D jQuery.isFunction( element[ type ] );
> > -
> > -			if ( handler ) {
> > -				// Pass along a fake event
> > -				data.unshift( this.fix({ type: type, target: element }) );
> > -=09
> > -				// Trigger the event
> > -				if ( (val =3D handler.apply( element, data )) !=3D=3D false )
> > -					this.triggered =3D true;
> > -			}
> > +			var val, ret, fn =3D jQuery.isFunction( element[ type ] );
> > +		=09
> > +			// Pass along a fake event
> > +			data.unshift( this.fix({ type: type, target: element }) );
> > +
> > +			// Trigger the event
> > +			if ( (val =3D this.handle.apply( element, data )) !=3D=3D false=
 )
> > +				this.triggered =3D true;

where two of the whitespace lines are the same and thus could have
been made context.  Oddly enough, this specific line *is* made context
for the default -U3.  This occasionally causes git-blame (which uses
the equivalent of 'git diff -U0' internally) to misattribute blank
lines.  This does *not* affect correctness of the diff, it is just
suboptimal.

My own guess at the problem is

> > I wouldn't be too surprised if it had heuristics that put lines
> > consisting only of whitespace at a lower importance than "actual"
> > lines.

i.e. that it's whitespace-related, and indeed Semyon says

> All cases I have seen were about whitespace lines.

I don't really care, since I haven't seen a single use-case where the
attribution of empty lines matters.  Still, let's at least bring it to
the attention of the people who have worked on libxdiff.

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
