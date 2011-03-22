From: Jeff King <peff@peff.net>
Subject: Re: Weird behavior of shell variables in git aliases
Date: Tue, 22 Mar 2011 07:28:32 -0400
Message-ID: <20110322112832.GB32446@sigill.intra.peff.net>
References: <d9c38309-c433-476c-bba3-f2c5b7e94a89@k15g2000prk.googlegroups.com>
 <20110321215310.GA2122@sigill.intra.peff.net>
 <7v8vw8nmh2.fsf@alter.siamese.dyndns.org>
 <7v4o6wnlxm.fsf@alter.siamese.dyndns.org>
 <AANLkTimH+eVUh6D5qK-PbNJGg46XJwaCii5zMg7xyZ_6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Lasse Makholm <lasse.makholm@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 12:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1zlS-0007zX-92
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 12:28:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754435Ab1CVL2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2011 07:28:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:42103
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab1CVL2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 07:28:34 -0400
Received: (qmail 23614 invoked by uid 107); 22 Mar 2011 11:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 Mar 2011 07:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Mar 2011 07:28:32 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimH+eVUh6D5qK-PbNJGg46XJwaCii5zMg7xyZ_6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169723>

On Tue, Mar 22, 2011 at 11:38:06AM +0100, Lasse Makholm wrote:

> > The attached quick hack gives
> >
> > =C2=A0$ git config alias.silly
> > =C2=A0!echo hello $1; echo $# args, bye!
> > =C2=A0$ GIT_TRACE=3D1 ./git silly world funny
> > =C2=A0trace: exec: 'git-silly' 'world' 'funny'
> > =C2=A0trace: run_command: 'git-silly' 'world' 'funny'
> > =C2=A0trace: run_command: 'sh' '-c' 'echo hello $1; echo $# args, b=
ye'\!'' '-' 'world' 'funny'
> > =C2=A0trace: exec: 'sh' '-c' 'echo hello $1; echo $# args, bye'\!''
> > =C2=A0'-' 'world' 'funny'
> > =C2=A0hello world
> > =C2=A02 args, bye!
>=20
> That would IMHO be The Right Way to do it. Since the documentation fo=
r
> aliases promises to to pass my alias to a shell if I prefix it with
> "!", I shouldn't have to add the "sh -c ... -" myself...

It does pass it to the shell. You can do:

  $ git config alias.autolog --oneline
  !repo=3D`find-git-repo-for $PWD` && git --git-dir=3D"$repo" log

for an example of a shell-based alias. It just doesn't handle positiona=
l
parameters the way you want. The typical solution is to invoke another
shell, but you can also do:

  $ grep -B1 silly .git/config
  [alias]
          silly =3D "!foo() { echo hello $1; echo $# args, bye!\n}\nfoo=
"

which unsurprisingly looks like exactly the same solution one would use
in the shell to avoid the fact that shell aliases suck for handling
positional parameters.

> > but it would penalize a properly written alias that uses "sh -c <it=
> -"
> > trick itself by double forking, which is not very nice and I am unh=
appy
> > about.
>=20
> A properly written alias that uses a trick? I guess that sums up the
> problem... :-)

Yeah. Though it also penalizes non-tricky aliases. See my other mail in
this thread.

> Anyway, doesn't the existing way potentially break when passing funky
> arguments containing spaces/quotes/something? We currently pass the
> arguments to the alias command as a single quoted string. Passing the=
m
> as seperate elements on argv seems a lot more robust...

No, the arguments in the current scheme are properly shell-quoted befor=
e
they are appended to the shell snippet. So they are equally robust.

-Peff
