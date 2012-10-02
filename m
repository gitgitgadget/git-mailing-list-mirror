From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] run-command: don't try to execute directories
Date: Tue, 2 Oct 2012 17:26:45 -0400
Message-ID: <20121002212645.GA26789@sigill.intra.peff.net>
References: <1349189193-25497-1-git-send-email-cmn@elego.de>
 <7vvces93qj.fsf@alter.siamese.dyndns.org>
 <87bogkisas.fsf@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:27:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJA01-0000ub-IP
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 23:27:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416Ab2JBV0y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2012 17:26:54 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38497 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932402Ab2JBV0x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 17:26:53 -0400
Received: (qmail 32141 invoked by uid 107); 2 Oct 2012 21:27:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 02 Oct 2012 17:27:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Oct 2012 17:26:45 -0400
Content-Disposition: inline
In-Reply-To: <87bogkisas.fsf@centaur.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206847>

On Tue, Oct 02, 2012 at 09:32:11PM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> >> @@ -101,8 +102,9 @@ static char *locate_in_PATH(const char *file)
> >>  		}
> >>  		strbuf_addstr(&buf, file);
> >> =20
> >> -		if (!access(buf.buf, F_OK))
> >> +		if (!stat(buf.buf, &st) && !S_ISDIR(st.st_mode)) {
> >>  			return strbuf_detach(&buf, NULL);
> >> +		}
> >
> > So we used to say "if it exists and accessible, return that".  Now
> > we say "if it exists and is not a directory, return that".
> >
> > I have to wonder what would happen if it exists as a non-directory
> > but we cannot access it.  Is that a regression?
>=20
> I guess it would be, yeah. Would this be related to tha situation whe=
re
> the user isn't allowed to access something in their PATH?

This code path is related to correcting EACCES errors into ENOENT. But
it does not bother checking permissions itself.  We know there is some
permission problem, because execvp told us EACCES, so we are only
checking whether such a file actually exists at all in the PATH. And
that is why we are using F_OK with access, and not X_OK.

So any reason for which stat() would fail would presumably cause
access(F_OK) to fail, too (mostly things like leading directories not
being readable), and I think converting the access into a stat is OK.

Adding the !ISDIR on top of it makes sense if you want to consider the
directory in your PATH to be a harmless thing to be ignored. However, I
am not sure that is a good idea. The intent of ignoring the original
EACCES is that it could be caused by totally uninteresting crap, like a=
n
inaccessible directory in your PATH.

Whereas in this case, the error really is that we found "git-foo", but
it is somehow broken. And it almost certainly is a configuration error
on the part of the user (why would they put a git-foo directory in thei=
r
PATH? Presumably they meant to put its contents into the PATH).

So I think your implementation is fine, but I'm a little dubious of the
value of ignoring such an error.

-Peff
