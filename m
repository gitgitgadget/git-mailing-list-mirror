From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] help: show manpage for aliased command on git <alias>
 --help
Date: Tue, 5 Mar 2013 12:38:31 -0500
Message-ID: <20130305173831.GB9379@sigill.intra.peff.net>
References: <1362494681-11419-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 18:38:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCvpL-0003mW-GD
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 18:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757054Ab3CERie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Mar 2013 12:38:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35446 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753594Ab3CERid (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 12:38:33 -0500
Received: (qmail 16421 invoked by uid 107); 5 Mar 2013 17:40:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 05 Mar 2013 12:40:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Mar 2013 12:38:31 -0500
Content-Disposition: inline
In-Reply-To: <1362494681-11419-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217468>

On Tue, Mar 05, 2013 at 02:44:41PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Change the semantics of "git <alias> --help" to show the help for the
> command <alias> is aliased to, instead of just saying:
>=20
>     `git <alias>' is aliased to `<whatever>'
>=20
> E.g. if you have "checkout" aliased to "co" you won't get:
>=20
>     $ git co --help
>     `git co' is aliased to `checkout'
>=20
> But will instead get the manpage for git-checkout. The behavior this
> is replacing was originally added by Jeff King in 2156435. I'm
> changing it because of this off-the-cuff comment on IRC:
>=20
>     14:27:43 <@Tux> git can be very unhelpful, literally:
>     14:27:46 <@Tux> $ git co --help
>     14:27:46 <@Tux> `git co' is aliased to `checkout'
>     14:28:08 <@Tux> I know!, gimme the help for checkout, please
>=20
> And because I also think it makes more sense than showing you what th=
e
> thing is aliased to.

In this simple case, I think it is helpful to show the "checkout"
manpage, because there is no other information to give (and by showing
the checkout manpage, you implicitly indicate that "co" maps to
"checkout").

But like others, I am concerned about the other cases, where there is n=
o
manpage, it is not a git command with a manpage, or it is a git command
with options.  You are losing useful information that is currently give=
n
to the user in all but the single-word case.

In an ideal world, we could say "here is how the alias expands, and by
the way, here is the manpage for the expanded command". And obviously
just omit the latter part when there is no such page. But we are relyin=
g
on external programs to do the presentation and paging. Doing the
C equivalent of:

  echo "'git co' is aliased to 'checkout'" &&
  man checkout

does not quite work, because "man" will start a pager. We can run our
own pager (which should suppress man's invocation), but that is a
regression for anyone who uses MANPAGER.

The user may also be using help.format to use something besides man. If
help.format is set to "html", we will spawn a browser. In that case we
can still output the alias information, but it may or may not be seen
(though come to think of it, that is probably already a problem for "gi=
t
help <alias>" on Windows systems, or anybody invoking git help from a
GUI porcelain).

So I'd only be in favor of this patch if it managed to avoid informatio=
n
loss in the more complicated cases. And I'm not sure how best to do
that. The "only trigger for a single-word alias" suggestion seems like
the least ugly to me.

-Peff
