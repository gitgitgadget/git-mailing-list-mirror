From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 17:06:36 -0400
Message-ID: <20110713210636.GF31965@sigill.intra.peff.net>
References: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
 <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 23:06:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh6do-0007AM-BE
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 23:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935Ab1GMVGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 17:06:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751812Ab1GMVGi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 17:06:38 -0400
Received: (qmail 29239 invoked by uid 107); 13 Jul 2011 21:07:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 17:07:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 17:06:36 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177082>

On Wed, Jul 13, 2011 at 11:23:33AM +0200, Erik Faye-Lund wrote:

> > =C2=A0static int git_tcp_connect_sock(char *host, int flags)
> > =C2=A0{
> > + =C2=A0 =C2=A0 =C2=A0 struct strbuf error_message =3D STRBUF_INIT;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int sockfd =3D -1, saved_errno =3D 0;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *port =3D STR(DEFAULT_GIT_POR=
T);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct addrinfo hints, *ai0, *ai;
> > @@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host, in=
t flags)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (connect(=
sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0saved_errno =3D errno;
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 fprintf(stderr, "%s[%d: %s]: errno=3D%s\n",
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt,
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ai_name(ai),
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(saved_errno));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 strbuf_addf(&error_message, "%s[%d: %s]: errno=3D%s\n",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host, cnt, ai_name(ai), strerror=
(saved_errno));
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0close(sockfd);
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0sockfd =3D -1;
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0continue;
> > @@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host, i=
nt flags)
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0freeaddrinfo(ai0);
> >
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sockfd < 0)
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("unable to c=
onnect a socket (%s)", strerror(saved_errno));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("unable to c=
onnect to %s:\n%s", host, error_message.buf);
> >
>=20
> This kills the output from the case where "sockfd < 0" evaluates to
> true for the last entry in ai, no (just above your second hunk), no?
> In that case errno gets copied to saved_errno, and the old output
> would do strerror(old_errno), but now you just print the log you've
> gathered, and don't even look at saved_errno.

But that's OK, because the value of that saved_errno is in the gathered
log, isn't it? So the output is not identical, but IMHO it's much
better. It's gone from:

  $ git fetch git://example.com/foo
  example.com[0: 192.0.32.10]: errno=3DConnection timed out
  example.com[0: 2620:0:2d0:200::10]: errno=3DNetwork is unreachable
  fatal: unable to connect a socket (Network is unreachable)

to:

  $ git fetch git://example.com/foo
  fatal: unable to connect to example.com:
  example.com[0: 192.0.32.10]: errno=3DConnection timed out
  example.com[0: 2620:0:2d0:200::10]: errno=3DNetwork is unreachable

IMHO, the "Network is unreachable" at the end of the first one is just
noise; it's a duplicate of what was already printed, and it may not be
the errno value that is most interesting to you.

> If this is intentional then you should probably kill the saved_errno
> variable also, it's rendered pointless by this patch.

That is sensible, though, I think.

-Peff
