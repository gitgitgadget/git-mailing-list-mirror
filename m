From: Jeff King <peff@peff.net>
Subject: Re: t5570 trap use in start/stop_git_daemon
Date: Fri, 13 Feb 2015 02:44:03 -0500
Message-ID: <20150213074403.GB26775@peff.net>
References: <013601d04702$d7e721e0$87b565a0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: 'Git Mailing List' <git@vger.kernel.org>,
	'Joachim Schmitz' <jojo@schmitz-digital.de>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 08:44:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMAvC-0003wL-3V
	for gcvg-git-2@plane.gmane.org; Fri, 13 Feb 2015 08:44:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751806AbbBMHoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Feb 2015 02:44:08 -0500
Received: from cloud.peff.net ([50.56.180.127]:48563 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751592AbbBMHoH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2015 02:44:07 -0500
Received: (qmail 29343 invoked by uid 102); 13 Feb 2015 07:44:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 01:44:06 -0600
Received: (qmail 31907 invoked by uid 107); 13 Feb 2015 07:44:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Feb 2015 02:44:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Feb 2015 02:44:03 -0500
Content-Disposition: inline
In-Reply-To: <013601d04702$d7e721e0$87b565a0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263799>

On Thu, Feb 12, 2015 at 03:31:12PM -0500, Randall S. Becker wrote:

> On the NonStop port, we found that =C2=93trap=C2=94 was causing an is=
sue with test
> success for t5570. When start_git_daemon completes, the shell (ksh,ba=
sh) on
> this platform is sending a signal 0 that is being caught and acted on=
 by the
> trap command within the start_git_daemon and stop_git_daemon function=
s. I am
> taking this up with the operating system group,

Yeah, that seems wrong. If it were a subshell, even, I could see some
argument for it, but it seems odd to trap 0 when a function returns
(bash does have a RETURN trap, which AFAIK is bash-specific, but it
should not trigger a 0-trap).

> but in any case, it may be
> appropriate to include a trap reset at the end of both functions, as =
below.
> I verified this change on SUSE Linux.
>=20
> diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
> index bc4b341..543e98a 100644
> --- a/t/lib-git-daemon.sh
> +++ b/t/lib-git-daemon.sh
> @@ -62,6 +62,7 @@ start_git_daemon() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 test_skip_or_die $GIT_TEST_GIT_DAEMON \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "=
git daemon failed to start"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trap '' EXIT
> }

I don't think this is the right thing to do. That trap is meant to live
beyond the function's return. Without it, there is nothing to clean up
the running git-daemon if we exit the test script prematurely (e.g., by
a test failing in immediate-mode). We pollute the environment with a
running process which would cause subsequent test runs to fail.

> stop_git_daemon() {
> @@ -84,4 +85,6 @@ stop_git_daemon() {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIT_DAEMON_PID=3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -f git_daemon_output
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trap '' EXIT
> }

This one is slightly less bad, in that we are dropping our
daemon-specific cleanup here anyway. But the appropriate trap is still:

  trap 'die' EXIT

which we set earlier in the function. Without it, the test harness's
ability to detect a premature failure is lost.

So I do not know quite what is going on with your shell, but turning of=
f
the traps in these functions is definitely not an acceptable (general)
workaround; it makes things much worse on working platforms.

-Peff
