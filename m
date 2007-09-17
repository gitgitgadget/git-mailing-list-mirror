From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 6/9] Rewrite launch_editor, create_tag and stripspace
	to use strbufs.
Date: Mon, 17 Sep 2007 18:59:41 -0400
Message-ID: <1190069981.10112.12.camel@hinata.boston.redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
	 <11890382242333-git-send-email-krh@redhat.com>
	 <11890382243290-git-send-email-krh@redhat.com>
	 <11890382253220-git-send-email-krh@redhat.com>
	 <11890382252522-git-send-email-krh@redhat.com>
	 <1189038225525-git-send-email-krh@redhat.com>
	 <Pine.LNX.4.64.0709061732480.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXPZK-0002R1-KJ
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 00:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756360AbXIQW7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 18:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756375AbXIQW7u
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 18:59:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756309AbXIQW7t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 18:59:49 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMxlGU017093
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Sep 2007 18:59:47 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMxliK004087;
	Mon, 17 Sep 2007 18:59:47 -0400
Received: from [192.168.1.101] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8HMxlqA008674;
	Mon, 17 Sep 2007 18:59:47 -0400
In-Reply-To: <Pine.LNX.4.64.0709061732480.28586@racer.site>
X-Mailer: Evolution 2.11.90 (2.11.90-4.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58493>

On Thu, 2007-09-06 at 17:38 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Wed, 5 Sep 2007, Kristian H=C3=B8gsberg wrote:
>=20
> > diff --git a/strbuf.c b/strbuf.c
> > index fcfc05e..ed2afea 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -73,43 +74,15 @@ void strbuf_printf(struct strbuf *sb, const cha=
r *fmt, ...)
> >  {
> >  	char buffer[2048];
> >  	va_list args;
> > -	int len, size =3D 2 * sizeof buffer;
> > +	int len;
> > =20
> >  	va_start(args, fmt);
> >  	len =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
> >  	va_end(args);
> > =20
> > -	if (len > sizeof(buffer)) {
> > -		/*
> > -		 * Didn't fit in the buffer, but this vsnprintf at
> > -		 * least gives us the required length back.  Grow the
> > -		 * buffer acccordingly and try again.
> > -		 */
> > -		strbuf_grow(sb, len);
> > -		va_start(args, fmt);
> > -		len =3D vsnprintf(sb->buf + sb->len,
> > -				sb->alloc - sb->len, fmt, args);
> > -		va_end(args);
> > -	} else if (len >=3D 0) {
> > -		/*
> > -		 * The initial vsnprintf fit in the temp buffer, just
> > -		 * copy it to the strbuf.
> > -		 */
> > -		strbuf_add(sb, buffer, len);
> > -	} else {
> > -		/*
> > -		 * This vnsprintf sucks and just returns -1 when the
> > -		 * buffer is too small.  Keep doubling the size until
> > -		 * it fits.
> > -		 */
> > -		while (len < 0) {
> > -			strbuf_grow(sb, size);
> > -			va_start(args, fmt);
> > -			len =3D vsnprintf(sb->buf + sb->len,
> > -					sb->alloc - sb->len, fmt, args);
> > -			va_end(args);
> > -			size *=3D 2;
> > -		}
> > -	}
> > +	if (len > sizeof(buffer) || len < 0)
> > +		die("out of buffer space\n");
> > +
> > +	strbuf_add(sb, buffer, len);
> >  }
>=20
> Really?
>=20
> (If you find the time, it would be really nice to rebase that patch s=
eries=20
> on top of Pierre's strbuf work...)

Argh, this was a screwup when I edited the patch series.  The next
series is based on Pierres changes.

Kristian
