From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a
	strbuf.
Date: Tue, 31 Jul 2007 10:23:05 -0400
Message-ID: <1185891786.11086.40.camel@hinata.boston.redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
	 <11858309311728-git-send-email-krh@redhat.com>
	 <11858309322006-git-send-email-krh@redhat.com>
	 <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 16:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFsiK-0002pF-DH
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 16:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760259AbXGaO2j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 10:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760034AbXGaO2j
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 10:28:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755933AbXGaO2i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 10:28:38 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VENCKr004762;
	Tue, 31 Jul 2007 10:23:12 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VENC62010702;
	Tue, 31 Jul 2007 10:23:12 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VENBH2000462;
	Tue, 31 Jul 2007 10:23:11 -0400
In-Reply-To: <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54354>

On Mon, 2007-07-30 at 21:36 -0700, Junio C Hamano wrote:
> Kristian H=C3=B8gsberg <krh@redhat.com> writes:
>=20
> > +static void inline strbuf_grow(struct strbuf *sb, size_t extra)
> > +{
> > +	while (sb->alloc < sb->len + extra)
> >  		sb->alloc =3D sb->alloc * 3 / 2 + 16;
> > +	sb->buf =3D xrealloc(sb->buf, sb->alloc);
> > +}
>=20
> Somehow this while () loop to compute the growth factor bothers
> me but that is probably a minor detail.

Think of it as a more efficient way of adding one character at a time :=
)
And it's logarithmic in the number of extra bytes.  By the way, I
normally just double the size in these cases, which gives you amortized
linear performance for adding to the buffer.  What's behind the * 3 / 2
idea?

> > +void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
> > +{
> > +	char one_line[2048];
> > +	va_list args;
> > +	int len;
>=20
> Such a nice abstraction so far, and then at the highest level of
> callchain we have this hardcoded limit?

Yeah, I know, it sucks.  I'd like to just run vsnprintf with a 0-sized
buffer to get the length, and then grow the buffer by that much, but
that's not very portable as far as I know.  Another approach is to just
vsnprintf into the one_line buffer and copy it into the strbuf if it
doesn't overflow.  If it does overflow, grow the buffer with that amoun=
t
and vsnprintf into the buffer.  I don't think that's portable either,
since vsnprintf can't be relied upon to return the number of characters
it would have printed.  One thing that would work, but is much more
involved is to lift the vsnprintf implementation from something like
glib.

So, I dunno... given the options, I opted for a simple solution with
some limitations.  Given how many other functions in git work on a fixe=
d
sized static buffer (for example, the fmt_ident case mentioned in
another email), I wouldn't think this is a problem

Kristian
