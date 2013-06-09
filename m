From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote-mediawiki: Fix a bug in a regexp
Date: Sat, 8 Jun 2013 22:57:09 -0400
Message-ID: <20130609025708.GB30393@sigill.intra.peff.net>
References: <1370698510-11649-1-git-send-email-celestin.matte@ensimag.fr>
 <vpqmwr0v45b.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Q8OpbGVzdGlu?= Matte <celestin.matte@ensimag.fr>,
	git@vger.kernel.org, benoit.person@ensimag.fr
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 04:57:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlVov-0002do-F8
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 04:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab3FIC5M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Jun 2013 22:57:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:59233 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751383Ab3FIC5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 22:57:11 -0400
Received: (qmail 5631 invoked by uid 102); 9 Jun 2013 02:58:00 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Jun 2013 21:58:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Jun 2013 22:57:09 -0400
Content-Disposition: inline
In-Reply-To: <vpqmwr0v45b.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226873>

On Sat, Jun 08, 2013 at 08:38:56PM +0200, Matthieu Moy wrote:

> C=C3=A9lestin Matte <celestin.matte@ensimag.fr> writes:
>=20
> > In Perl, '\n' is not a newline, but instead a literal backslash fol=
lowed by an
> > "n". As the output of "rev-list --first-parent" is line-oriented, w=
hat we want
> > here is a newline.
>=20
> This is right, but the code actually worked the way it was. I'm not
> sure, but my understanding is that '\n' is the string "backslash
> followed by n", but interpreted as a regexp, it is a newline.

Yes, the relevant doc (from "perldoc -f split") is:

  The pattern "/PATTERN/" may be replaced with an expression to specify
  patterns that vary at runtime.  (To do runtime compilation only once,
  use "/$variable/o".)

So it is treating "\n" as an expression and compiling the regex each
time through (though I think modern perl may be smart enough to realize
it is a constant expression and compile the regex only once). You would
get the same behavior with this:

  split $arg, $data;

if $arg contained '\n'. Of course, you _also_ get the same thing if you
use a literal newline (either "\n" or if $arg contained a literal
newline), because they function the same in a regex. In other words, it
does not matter which you use because perl's interpolation of "\n" and
the regex expansion of "\n" are identical: t hey both mean a newline.

A more subtle example that shows what is going on is this:

  split '.', $data;

If you feed that "foo.bar.baz", it does not split it into three words;
each character is a delimiter, because the dot is compiled to a regex.

> The new code looks better than the old one, but the log message may b=
e
> improved.

Agreed. I think the best explanation is something like:

  Perl's split function takes a regex pattern argument. You can also
  feed it an expression, which is then compiled into a regex at runtime=
=2E
  It therefore works to pass your pattern via single quotes, but it is
  much less obvious to a reader that the argument is meant to be a
  regex, not a static string. Using the traditional slash-delimiters
  makes this easier to read.

-Peff
