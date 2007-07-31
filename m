From: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
Subject: Re: [PATCH 3/5] Add strbuf_printf() to do formatted printing to a
	strbuf.
Date: Tue, 31 Jul 2007 11:28:53 -0400
Message-ID: <1185895733.11086.54.camel@hinata.boston.redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
	 <11858309311728-git-send-email-krh@redhat.com>
	 <11858309322006-git-send-email-krh@redhat.com>
	 <7vhcnlgpeo.fsf@assigned-by-dhcp.cox.net>
	 <1185891786.11086.40.camel@hinata.boston.redhat.com>
	 <Pine.LNX.4.64.0707311556150.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 31 17:31:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFtgY-00050F-Gw
	for gcvg-git@gmane.org; Tue, 31 Jul 2007 17:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbXGaPay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 11:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbXGaPay
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 11:30:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:45452 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750810AbXGaPax (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2007 11:30:53 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFT1Gp011575;
	Tue, 31 Jul 2007 11:29:01 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFT0td022202;
	Tue, 31 Jul 2007 11:29:00 -0400
Received: from [192.168.1.102] (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6VFSxso029839;
	Tue, 31 Jul 2007 11:28:59 -0400
In-Reply-To: <Pine.LNX.4.64.0707311556150.14781@racer.site>
X-Mailer: Evolution 2.11.4 (2.11.4-1.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54359>

On Tue, 2007-07-31 at 15:57 +0100, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 31 Jul 2007, Kristian H?gsberg wrote:
>=20
> > On Mon, 2007-07-30 at 21:36 -0700, Junio C Hamano wrote:
> > > Kristian H=C3=B8gsberg <krh@redhat.com> writes:
> > >=20
> > > > +void strbuf_printf(struct strbuf *sb, const char *fmt, ...)
> > > > +{
> > > > +	char one_line[2048];
> > > > +	va_list args;
> > > > +	int len;
> > >=20
> > > Such a nice abstraction so far, and then at the highest level of
> > > callchain we have this hardcoded limit?
> >=20
> > Yeah, I know, it sucks.  I'd like to just run vsnprintf with a 0-si=
zed
> > buffer to get the length, and then grow the buffer by that much, bu=
t
> > that's not very portable as far as I know.
>=20
> We do have nfvasprintf()...

Ah, ok... it looks like it's using the second approach I described:
printing into a temp buffer, and realloc'ing and printing again if it
didn't fit.  But it dies with 'out of memory' if vsnprintf returns < 0,
is that reasonable?  I'm not familiar with what will make vsnprintf
return a negative value...  Also, that implementation potentially uses
the va_list twice, which isn't universally supported.  C99 introduces
va_copy for this case, but that's also not available everywhere.

However, if the nfvasprintf implementation in trace.c is fine, I'll jus=
t
use that approach in strbuf_printf too.  I'd just like to know that the
above issues aren't a problem on win32, since part of my motivation for
doing this is to make git available on windows so it will be easier for
people to choose git.

Kristian
