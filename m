From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Do not log unless all connect() attempts fail
Date: Wed, 13 Jul 2011 19:43:57 -0400
Message-ID: <20110713234357.GB18273@sigill.intra.peff.net>
References: <1EC2718A-A993-443C-8D7C-DEBD7C424EB9@apple.com>
 <CABPQNSaPXmHE1qECUbG9oWU43HbAXxAY42T1P=MNHgkkWM936w@mail.gmail.com>
 <20110713210636.GF31965@sigill.intra.peff.net>
 <CABPQNSazGsgqcZZ=q9VJ+2u=O32ePeRAjqo4+FuyVwCkX4y4nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dave Zarzycki <zarzycki@apple.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 01:44:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh966-0002TB-Bl
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 01:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1GMXn7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 19:43:59 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47600
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab1GMXn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 19:43:59 -0400
Received: (qmail 31574 invoked by uid 107); 13 Jul 2011 23:44:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 19:44:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 19:43:57 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSazGsgqcZZ=q9VJ+2u=O32ePeRAjqo4+FuyVwCkX4y4nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177094>

On Thu, Jul 14, 2011 at 12:29:11AM +0200, Erik Faye-Lund wrote:

> On Wed, Jul 13, 2011 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> > On Wed, Jul 13, 2011 at 11:23:33AM +0200, Erik Faye-Lund wrote:
> >
> >> > =C2=A0static int git_tcp_connect_sock(char *host, int flags)
> >> > =C2=A0{
> >> > + =C2=A0 =C2=A0 =C2=A0 struct strbuf error_message =3D STRBUF_IN=
IT;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0int sockfd =3D -1, saved_errno =3D 0;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *port =3D STR(DEFAULT_GIT_=
PORT);
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0struct addrinfo hints, *ai0, *ai;
> >> > @@ -225,11 +226,8 @@ static int git_tcp_connect_sock(char *host,=
 int flags)
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (conne=
ct(sockfd, ai->ai_addr, ai->ai_addrlen) < 0) {
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0saved_errno =3D errno;
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 fprintf(stderr, "%s[%d: %s]: errno=3D%s\n",
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host,
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt,
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ai_name(ai),
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 strerror(saved_errno));
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 strbuf_addf(&error_message, "%s[%d: %s]: errno=3D%s\n",
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 host, cnt, ai_name(ai), stre=
rror(saved_errno));
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0close(sockfd);
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0sockfd =3D -1;
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;
> >> > @@ -242,11 +240,13 @@ static int git_tcp_connect_sock(char *host=
, int flags)
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0freeaddrinfo(ai0);
> >> >
> >> > =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sockfd < 0)
> >> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("unable t=
o connect a socket (%s)", strerror(saved_errno));
> >> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die("unable t=
o connect to %s:\n%s", host, error_message.buf);
> >> >
> >>
> >> This kills the output from the case where "sockfd < 0" evaluates t=
o
> >> true for the last entry in ai, no (just above your second hunk), n=
o?
> >> In that case errno gets copied to saved_errno, and the old output
> >> would do strerror(old_errno), but now you just print the log you'v=
e
> >> gathered, and don't even look at saved_errno.
> >
> > But that's OK, because the value of that saved_errno is in the gath=
ered
> > log, isn't it?
>=20
> No, it's not. In the case where socket fails, we assign errno to
> saved_errno and _continue_. So nothing gets logged about the error. I=
f
> there's only one entry in the address list, we don't end up reporting
> anything; the strbuf is empty. We used to at least report
> strerror(errno) in that case.

Ah, sorry. I was reading the patch, not the actual function, and the bi=
t
you are talking about was not in the context. Yes, you are right. Sorry
for the noise.

-Peff
