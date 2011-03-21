From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] system_path: use a static buffer
Date: Mon, 21 Mar 2011 07:14:14 -0400
Message-ID: <20110321111414.GD16334@sigill.intra.peff.net>
References: <1300359664-6230-1-git-send-email-cmn@elego.de>
 <1300371853-8965-1-git-send-email-cmn@elego.de>
 <7vpqpoyjo3.fsf@alter.siamese.dyndns.org>
 <1300701380.2583.13.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 21 12:14:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1d46-0007u6-JB
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 12:14:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007Ab1CULOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 07:14:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38372
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752964Ab1CULOU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 07:14:20 -0400
Received: (qmail 12178 invoked by uid 107); 21 Mar 2011 11:14:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Mar 2011 07:14:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2011 07:14:14 -0400
Content-Disposition: inline
In-Reply-To: <1300701380.2583.13.camel@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169582>

On Mon, Mar 21, 2011 at 10:56:19AM +0100, Carlos Mart=C3=ADn Nieto wrot=
e:

> On vie, 2011-03-18 at 00:25 -0700, Junio C Hamano wrote:
> > Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
> >=20
> > > +	ret =3D snprintf(buf, sizeof(buf), "%s/%s", prefix, path);
> > > +	if (ret >=3D sizeof(buf))
> > > +		die("system path too long for %s", path);
> > > +	else if (ret < 0)
> > > +		die_errno("encoding error");
> >=20
> > POSIX says snprintf() should set errno in this case, and your use o=
f
> > die_errno() would show that information, but what is "encoding erro=
r"?
> >=20
> > Just being curious, as I suspect that "snprintf() returned an error=
" may
> > be more appropriate, if the answer is "I don't know what kind of er=
ror it
> > is, but snprintf() found something faulty while encoding so I chose=
 to
> > call it encoding error".
>=20
>  My manpage says snprintf returns -1 if there was an output or encodi=
ng
> error. As there couldn't be an output error because it's writing to
> memory and we can't output what snprintf chocked on because whatever
> die_errno uses will also choke on it, I just put "encoding error". I'=
d
> put "error assembling system path" as the actual error message, I gue=
ss.

=46WIW, we don't catch snprintf failures in 99% of the calls in git. Mo=
st
calls just ignore the return value, and some even directly use the
return value to add to a length. The one place that actually does check
for the error is strbuf_vaddf, which just says "your vsnprintf is
broken" and dies.

So I'm not sure how much we really care about this error code path. If
anything, we should be replacing all of the calls with something like:

  static const char buggy_sprintf_msg[] =3D
  "BUG: vsnprintf returned %d; either we fed it a bogus format string\n=
"
  "(our bug) or your libc is buggy and returns an error when it should\=
n"
  "tell us how much space is needed. The format string was:\n"
  "%s\n";
  int xsnprintf(char *out, size_t size, const char *fmt, ...)
  {
          va_list ap;
          int r;

          va_start(ap, fmt);
          r =3D vsnprintf(out, size, fmt, ap);
          va_end(ap);

          if (r < 0)
                  die(buggy_sprintf_msg, r, fmt);
          return r;
  }

-Peff
