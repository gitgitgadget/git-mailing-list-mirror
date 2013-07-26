From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] branch: make sure the upstream remote is configured
Date: Fri, 26 Jul 2013 19:12:11 -0400
Message-ID: <20130726231211.GB12968@sigill.intra.peff.net>
References: <1374860377-17652-1-git-send-email-cmn@elego.de>
 <20130726184311.GA29799@sigill.intra.peff.net>
 <1374877787.2670.6.camel@centaur.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Sat Jul 27 01:12:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2rBJ-0003Q2-Ci
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 01:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349Ab3GZXMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jul 2013 19:12:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:33274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757607Ab3GZXMN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 19:12:13 -0400
Received: (qmail 14354 invoked by uid 102); 26 Jul 2013 23:12:13 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 26 Jul 2013 18:12:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jul 2013 19:12:11 -0400
Content-Disposition: inline
In-Reply-To: <1374877787.2670.6.camel@centaur.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231216>

On Sat, Jul 27, 2013 at 12:29:47AM +0200, Carlos Mart=C3=ADn Nieto wrot=
e:

> > Is it nonsensical? It does not make sense for the @{upstream} magic
> > token, because we will not have a branch in tracking branch refs/re=
motes
>=20
> This was the main point, yes; the only time I've seen it used is by
> mistake/misunderstanding, and thinking that you wouldn't want to do
> something like what's below.

If that is what you want to prevent, I do not think checking for a name=
d
remote is sufficient. You can also be pushing to a branch on a named
remote that is not part of your fetch refspec, in which case you do not
have a tracking branch. I.e.:

  git clone $URL repo.git
  cd repo.git
  git push --set-upstream HEAD:refs/foo/whatever

=46or that matter, I wonder what "--set-upstream" would do if used with
"refs/tags/foo". You would not do that in general, but what about:

  git push --set-upstream master:master master:v1.0

I didn't test.

> > to point to. But the configuration would still affect how "git pull=
"
> > chooses a branch to fetch and merge.
> >=20
> > I.e., you can currently do:
> >=20
> >   git push --set-upstream /tmp/t master
> >   git pull ;# pulls from /tmp/t master
>=20
> Interestingly, this actually fetches the right branch from the remote=
=2E I
> wasn't expecting something like this to work at all.
>=20
> Somewhat doubtful that this usage is something you'd really want to d=
o,
> I see that it does behave properly.

I do not claim to have used it myself. Tightening the "--set-upstream"
behavior would not hurt people who want to configure such a thing
manually, and it might catch errors from people doing it accidentally.

So even though the config it generates is not nonsensical, there is a
reasonable chance it was an error, and tightening may make sense. But I
think you would not want the condition to be "this is a named remote",
but rather "the generated configuration actually has an @{upstream}".

-Peff
