From: Jeff King <peff@peff.net>
Subject: Re: Poor performance of git describe in big repos
Date: Mon, 3 Jun 2013 10:49:08 -0400
Message-ID: <20130603144907.GA5938@sigill.intra.peff.net>
References: <CAJ-05NOjVhb+3Cab7uQE8K3VE0Q2GhqR3FE=WzJZvSn8Djt6tw@mail.gmail.com>
 <87ip20bfq4.fsf@linux-k42r.v.cablecom.net>
 <20130530193046.GG17475@serenity.lan>
 <CAJ-05NOEuxOVy7LFp_XRa_08G-Mj0x7q+RiR=u71-iyfOXpHow@mail.gmail.com>
 <87obbr5zg3.fsf@linux-k42r.v.cablecom.net>
 <CAJ-05NOdg5TvjzEMrXaPgogU5z5W6kywZhD-82eTUmvE9Hp=Lw@mail.gmail.com>
 <87y5av4jvj.fsf@linux-k42r.v.cablecom.net>
 <87txlj30n4.fsf@linux-k42r.v.cablecom.net>
 <20130531161710.GB1365@sigill.intra.peff.net>
 <CAJ-05NO2reGkboet1c2kYy0Y7xzkb9K45mTdCLq_AU7dp1OTNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>, John Keeping <john@keeping.me.uk>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Mon Jun 03 16:49:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjW4R-0005P9-Mp
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 16:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072Ab3FCOtM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Jun 2013 10:49:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:60315 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755177Ab3FCOtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 10:49:10 -0400
Received: (qmail 17934 invoked by uid 102); 3 Jun 2013 14:49:54 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 03 Jun 2013 09:49:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Jun 2013 10:49:08 -0400
Content-Disposition: inline
In-Reply-To: <CAJ-05NO2reGkboet1c2kYy0Y7xzkb9K45mTdCLq_AU7dp1OTNw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226218>

On Mon, Jun 03, 2013 at 09:39:21AM +0100, Alex Benn=C3=A9e wrote:

> > in the target repository. You can check that it's working because "=
git
> > rev-list --all --count" should be an order of magnitude faster. You=
 may
> > need to add "save_commit_buffer =3D 0" in any commands you are chec=
king,
> > though, as the optimization can only kick in if parse_commit does n=
ot
> > want to save the buffer as a side effect.
>=20
> Is this a command line argument? The tools don't seem to think so.

If you mean the "save_commit_buffer =3D 0", no; I mean you would have t=
o
insert it somewhere in builtin/$CMD.c, and then recompile. However,
git-describe already has it, so it should work.

> Anyway it seems to make a marginal difference to my case:

I get much better results:

  $ cd linux-2.6
  $ time git --no-pager describe --long --tags HEAD~800
  v3.5-6956-gaa0b3b2

  real    0m0.261s
  user    0m0.248s
  sys     0m0.012s

  $ git metapack --commits --all
  $ time git --no-pager describe --long --tags HEAD~800
  v3.5-6956-gaa0b3b2

  real    0m0.057s
  user    0m0.032s
  sys     0m0.024s

which implies that your time is being spent elsewhere. That topic
wouldn't avoid inflating tag objects from disk. Do you have really big
tag objects (or unannotated tags pointing to blobs)? What does:

  git for-each-ref --format=3D'%(object)' refs/tags |
  git cat-file --batch-check |
  sort -k 3nr |
  head

say?

-Peff
