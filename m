From: Jeff King <peff@peff.net>
Subject: Re: feature request - telling git bisect to skip, from inside a
 commit
Date: Tue, 29 Mar 2011 14:23:00 -0400
Message-ID: <20110329182300.GB20784@sigill.intra.peff.net>
References: <AANLkTinCiM9uqK8Yr=pKaeKytWXqpWF898AeTwvHKg4-@mail.gmail.com>
 <20110328163153.GA18774@sigill.intra.peff.net>
 <7vipv31943.fsf@alter.siamese.dyndns.org>
 <AANLkTin+0yScj2ejVgPSMmY6Q+Qk0MM+W+EqqLGphCrz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jim Cromie <jim.cromie@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 20:23:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4dZM-0004ui-Gt
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 20:23:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753911Ab1C2SXD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 14:23:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57739
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab1C2SXB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 14:23:01 -0400
Received: (qmail 31276 invoked by uid 107); 29 Mar 2011 18:23:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 14:23:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 14:23:00 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin+0yScj2ejVgPSMmY6Q+Qk0MM+W+EqqLGphCrz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170298>

On Tue, Mar 29, 2011 at 11:00:00AM -0600, Jim Cromie wrote:

> If the pseudo-header can be added into the commit message,
> it is trivial to use.
>=20
> I see the merit of a skip-cache as working after-the-fact
> on already published/shared patch-sets, but Im unsure how the
> skip-cache can be shared currently.

If you use git-notes as I did in the example of my first response, then
you will end up with a ref "refs/notes/skip". You can push it to
wherever:

  git push origin refs/notes/skip

and then everybody else can configure their repos to fetch it:

  git config --add remote.origin.fetch \
    +refs/notes/skip:refs/notes/origin/skip

I think they would still have to manually merge it into their own skip
cache with "git notes merge". I'm not sure. The notes-merging code is
very new (v1.7.4, I believe), and I think we are still figuring out wha=
t
workflows make sense around it (which is why it is still manual).

> > I think that is a saner approach, and further say it would be much =
saner
> > to make that token something like
> >
> > =C2=A0 =C2=A0Broken: does not build
>=20
> My only concern here is the negative connotation of Broken.
> At least in my 1/2 change scenario, thats known to be incomplete,
> its kinda pejorative.  But it certainly gets the job done.
>=20
> Skip: make rc 125
> Skip: 125
> Skip: gcc error: no such field: foo
> Skip: api change only, users must follow
>=20
> Skip: has less pejorative, and closer name-association linkage
> to the bisect skip command that it

Yeah, I think a more neutral name makes sense, since there are many
reasons to skip (and in fact, broken builds are among the least
interesting to mark, since those are easy to detect at bisection time).

> > And then teach the script you give to "bisect run" to grep for that
> > "^Broken: " pattern to answer with exit 125 (cannot test), and you =
are
> > done.
> >
>=20
> With this, nothing needs to be added.
> The only advantage to bisect looking for the pseudo-header is that
> a convention is supported, such that it might get used.

If you do use this, I would love to hear a report on how it works 6
months in. If it's useful, then it might make more sense to clean up
rough edges with better tool support. Or maybe it works perfectly
without tool support, or maybe it turns out to be a flawed idea. :)

-Peff
