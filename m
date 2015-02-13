From: Jeff King <peff@peff.net>
Subject: Re: t5570 trap use in start/stop_git_daemon
Date: Fri, 13 Feb 2015 03:03:59 -0500
Message-ID: <20150213080359.GC26775@peff.net>
References: <013601d04702$d7e721e0$87b565a0$@nexbridge.com>
 <20150213074403.GB26775@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Git Mailing List' <git@vger.kernel.org>,
	'Joachim Schmitz' <jojo@schmitz-digital.de>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 09:04:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMBEN-0004gj-Sp
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 09:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbbBMIED convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 03:04:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:48579 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751477AbbBMIEC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 03:04:02 -0500
Received: (qmail 30183 invoked by uid 102); 13 Feb 2015 08:04:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 02:04:02 -0600
Received: (qmail 32092 invoked by uid 107); 13 Feb 2015 08:04:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 03:04:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2015 03:03:59 -0500
Content-Disposition: inline
In-Reply-To: <20150213074403.GB26775@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263800>

On Fri, Feb 13, 2015 at 02:44:03AM -0500, Jeff King wrote:

> On Thu, Feb 12, 2015 at 03:31:12PM -0500, Randall S. Becker wrote:
>=20
> > On the NonStop port, we found that =C2=93trap=C2=94 was causing an =
issue with test
> > success for t5570. When start_git_daemon completes, the shell (ksh,=
bash) on
> > this platform is sending a signal 0 that is being caught and acted =
on by the
> > trap command within the start_git_daemon and stop_git_daemon functi=
ons. I am
> > taking this up with the operating system group,
>=20
> Yeah, that seems wrong. If it were a subshell, even, I could see some
> argument for it, but it seems odd to trap 0 when a function returns
> (bash does have a RETURN trap, which AFAIK is bash-specific, but it
> should not trigger a 0-trap).

Hmm, today I learned something new about ksh. Apparently when you use
the "function" keyword to define a function like:

  function foo {
    trap 'echo trapped' EXIT
  }
  echo before
  foo
  echo after

then the trap runs when the function exits! If you declare the same
function as:

  foo() {
    trap 'echo trapped' EXIT
  }

it behaves differently. POSIX shell does not have the function keyword,
of course, and we are not using it here. Bash _does_ have the function
keyword, but seems to behave POSIX-y even when it is present. I.e.,
running the first script:

  $ ksh foo.sh
  before
  trapped
  after

  $ bash foo.sh
  before
  after
  trapped

  $ dash foo.sh
  foo.sh: 3: foo.sh: function: not found
  foo.sh: 5: foo.sh: Syntax error: "}" unexpected

Switching to the second form, all three produce:

  before
  after
  trapped

I don't know if that is all helpful to your bug-tracking or analysis,
but for whatever reason it looks like your ksh is using localized traps
for both forms of function. But as far as I know, bash has never behave=
d
that way (I just grepped its CHANGES file for mentions of trap and foun=
d
nothing likely).

-Peff
