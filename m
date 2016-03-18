From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC/GSoC 3/3] t0301: test credential-cache support of
 XDG_RUNTIME_DIR
Date: Fri, 18 Mar 2016 01:00:18 -0400
Message-ID: <20160318050017.GA22327@sigill.intra.peff.net>
References: <CAKqreux4aYhXTE9kUHKoKCJ2-4KDWyi58ioCm-CWqXhUYCtEEw@mail.gmail.com>
 <1458122865-29447-1-git-send-email-huiyiqun@gmail.com>
 <1458122865-29447-3-git-send-email-huiyiqun@gmail.com>
 <20160316171535.GC4039@sigill.intra.peff.net>
 <CAKqreuw7Am_wZQjYYjvsxx0Ccr4OOwoF=EnLvMTK9jxeBUFv5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Your friend <pickfire@riseup.net>, git@vger.kernel.org
To: =?utf-8?B?5oOg6L22576k?= <huiyiqun@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agmWd-0005aA-Uc
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 06:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbcCRFAV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 01:00:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33861 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752691AbcCRFAV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:00:21 -0400
Received: (qmail 14012 invoked by uid 102); 18 Mar 2016 05:00:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:00:20 -0400
Received: (qmail 8468 invoked by uid 107); 18 Mar 2016 05:00:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:00:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 01:00:18 -0400
Content-Disposition: inline
In-Reply-To: <CAKqreuw7Am_wZQjYYjvsxx0Ccr4OOwoF=EnLvMTK9jxeBUFv5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289186>

On Fri, Mar 18, 2016 at 12:34:04PM +0800, =E6=83=A0=E8=BD=B6=E7=BE=A4 w=
rote:

> >> +test_expect_success 'set $XDG_RUNTIME_DIR' '
> >> +     XDG_RUNTIME_DIR=3D$HOME/xdg_runtime/
> >> +'
> >
> > Doesn't this need to export the variable so that credential-cache c=
an
> > see it?
>=20
> I'm not sure, but it seems that a little clean up code added before
> send-email
> make the test fail. At that time, I run test without building. I've s=
end
> PATCH v2
> which runs well on my computer. However, $XDG_RUNTIME_DIR is still no=
t
> exported, but that just works.
>=20
> I will try to dig deeper into the bash script to see why.

I suspect it is because you have $XDG_RUNTIME_DIR defined in your
environment, which causes the shell to automatically export it. I don't=
,
so an explicit "export" is required to for the variable to make it to
its children.

I think we should actually be unsetting it in test-lib.sh for all tests=
,
as we do for XDG_CONFIG_HOME. That makes sure the tests are running wit=
h
a known state.

=46or the non-XDG_RUNTIME_DIR tests, does this mean we are creating the
socket in /tmp? I'm not entirely happy with that, as we usually try to
have the test suite avoid touching anything outside of its trash
directories.

> > This runs the full suite of tests twice (once here, and once for th=
e
> > original helper_test invocation you left below). Shouldn't we just =
do it
> > once (making sure that $XDG_RUNTIME_DIR is respected)?
>=20
> I'd like to test the behavior of git-credential-cache when $XDG_RUNTI=
ME_DIR
> is unset.
>=20
> In `t/t0302-credential-store.sh`, helper_test is also run multiple ti=
mes.
> That's why I do so.

OK. My main concern was just that the tests would take too long, but th=
e
slow one is the cache test at the end, which is not repeated. So I thin=
k
this is fine.

> > I wondered if this might be racy. credential-cache tells the daemon
> > "exit", then waits for a response or EOF. The daemon sees "exit" an=
d
> > calls exit(0) immediately. We clean up the socket in an atexit()
> > handler. So I think we are OK (the pipe will get closed when the pr=
ocess
> > exits, and the atexit handler must have run by then).
> >
> > But that definitely was not designed, and is just how it happens to
> > work. I'm not sure if it's worth commenting on that (here, or perha=
ps in
> > the daemon code).
>=20
> I'm still confused.
>=20
> What do you mean by "pipe"? should it be "socket" instead?

Sorry, yes, I used "pipe" and "socket" interchangeably there.

> What is not designed? cleanup being done, my tests passing or the
> synchronization?

The synchronization. If the daemon were implemented as:

  if (!strcmp(action.buf, "exit")) {
	/* acknowledge that we got command */
	fclose(out);
	exit(0);
  }

for example, then the client would exit at the same that the daemon is
cleaning up the socket, and we may or may not call test_path_is_missing
before the cleanup is done.

I think it's OK to rely on that, but we may want to put a comment to
that effect in the daemon code so that it doesn't get changed.

-Peff
