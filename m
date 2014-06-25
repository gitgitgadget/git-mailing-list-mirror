From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: BUG: git request-pull broken for plain branches
Date: Wed, 25 Jun 2014 15:21:31 +0200
Message-ID: <20140625132131.GO14781@pengutronix.de>
References: <20140625095535.GA27365@pengutronix.de>
 <CA+55aFwZb7tT7xb7y2XJpzcmrxB=Rf--bjz5XbBcxC-7MMm9eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, kernel@pengutronix.de
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 15:21:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzn95-0007se-08
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 15:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755444AbaFYNVq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2014 09:21:46 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46451 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753576AbaFYNVp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 09:21:45 -0400
Received: from ptx.hi.pengutronix.de ([2001:6f8:1178:2:5054:ff:fec0:8e10] ident=Debian-exim)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1Wzn8r-0004Mu-KZ; Wed, 25 Jun 2014 15:21:37 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.80)
	(envelope-from <ukl@pengutronix.de>)
	id 1Wzn8l-00026j-9q; Wed, 25 Jun 2014 15:21:31 +0200
Content-Disposition: inline
In-Reply-To: <CA+55aFwZb7tT7xb7y2XJpzcmrxB=Rf--bjz5XbBcxC-7MMm9eg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:5054:ff:fec0:8e10
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252444>

Hello Linus,

On Wed, Jun 25, 2014 at 05:05:51AM -0700, Linus Torvalds wrote:
> On Wed, Jun 25, 2014 at 2:55 AM, Uwe Kleine-K=F6nig
> <u.kleine-koenig@pengutronix.de> wrote:
> >
> >         $ git rev-parse HEAD
> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3
> >         $ git ls-remote origin | grep 9e065e4a5a58308f1a0da4bb80b83=
0929dfa90b3
> >         9e065e4a5a58308f1a0da4bb80b830929dfa90b3        refs/heads/=
ukl/for-mainline
> >         $ git request-pull origin/master origin HEAD > /dev/null
> >         warn: No match for commit 9e065e4a5a58308f1a0da4bb80b830929=
dfa90b3 found at origin
> >         warn: Are you sure you pushed 'HEAD' there?
>=20
> Notice how "HEAD" does not match.
>=20
> The error message is perhaps misleading. It's not enough to match the
> commit. You need to match the branch name too. git used to guess the
> branch name (from the commit), and it often guessed wrongly. So now
> they need to match.
>=20
> So you should do
>=20
>     git request-pull origin/master origin ukl/for-mainline
>=20
> to let request-pull know that you're requesting a pull for "ukl/for-m=
ainline".
>=20
> If you have another name for that branch locally (ie you did somethin=
g
> like "git push origin local:remote"), then you can say
>=20
>     git request-pull origin/master origin local-name:remote-name
>=20
> to specify what the branch to be pulled is called locally vs remotely=
=2E
>=20
> In other words, what used to be "pick some branch randomly" is now
> "you need to _specify_ the branch".
ah, got it. Still some of my concerns stay valid and I also have some
new ones:

 - if there is a branch and a tag on the remote side that match what I
   specified the outcome depends on the order of git-ls-remote. (minor
   nit.)
 - if I have to specify the remote name now, why do I have to also
   specify my local ref? Isn't the respective $sha1 of the remote side
   enough to do what is needed?
 - Isn't $found =3D $sha1; silly because I cannot pull a rev, only a re=
f?
   (side note:

   	git pull linus d91d66e88ea95b6dd21958834414009614385153

   gives no error message, only returns 1 and does nothing else.)
 - Is the result of

 	git request-pull $somecommit origin

   what is intended? For me it does

   	...
	are available in the git repository at:

	  $repository

	for you to fetch changes ...

   if the remote HEAD matches the local one. I'd prefer to have an
   explicit branch name there, or at least HEAD.

I liked git guessing the branch name, maybe we can teach it to guess a
bit better than it did before 2.0? Something like:

 - if there is a unique match on the remote side, use it.
 - if there are >=3D 1 match on the remote side and exactly one matches
   what I specified as <end>, use it.
 - if there are >=3D 1 match on the remote side and exactly one of them=
 is
   a tag, use the tag
 - if there are two matches on the remote side, and one is "HEAD",
   pick the other one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
