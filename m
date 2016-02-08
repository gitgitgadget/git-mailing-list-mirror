From: Jeff King <peff@peff.net>
Subject: Re: git show doesn't work on file names with square brackets
Date: Mon, 8 Feb 2016 09:15:53 -0500
Message-ID: <20160208141552.GC27054@sigill.intra.peff.net>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com>
 <alpine.DEB.2.20.1602061518220.2964@virtualbox>
 <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com>
 <alpine.DEB.2.20.1602061708220.2964@virtualbox>
 <CACsJy8ChZzYWXePSwF6D8vPZMuz3dQe1=jtw6rSG7M1oC+RiNw@mail.gmail.com>
 <32B9BD70-F06C-49C4-B672-24173E69B99F@jetbrains.com>
 <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 15:16:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSmbf-0000Gb-U1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 15:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbcBHOP4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 09:15:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:39190 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750922AbcBHOPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 09:15:55 -0500
Received: (qmail 30852 invoked by uid 102); 8 Feb 2016 14:15:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 09:15:54 -0500
Received: (qmail 5230 invoked by uid 107); 8 Feb 2016 14:15:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 08 Feb 2016 09:15:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 08 Feb 2016 09:15:53 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8AMEgk8UXF==VmvLXsL4R67u0+U4MiUGPtO6HX0Y30oXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285768>

On Mon, Feb 08, 2016 at 12:06:44PM +0700, Duy Nguyen wrote:

> On Sun, Feb 7, 2016 at 10:11 PM, Kirill Likhodedov
> <kirill.likhodedov@jetbrains.com> wrote:
> > Hi Duy,
> >
> >> It's from 28fcc0b (pathspec: avoid the need of "--" when wildcard =
is
> >> used - 2015-05-02)
> >
> > v2.5.0 is the first release which contains 28fcc0b.
> > I can confirm that older versions of Git work correctly without =E2=
=80=9C--=E2=80=9C:
> >
> > # /opt/local/bin/git version
> > git version 1.7.1.1
> > # /opt/local/bin/git show HEAD:bra[ckets].txt
> > asd
> >
> > Looks like a regression?
>=20
> No it's a deliberate trade-off. With that change, you can use
> wildcards in pathspec without "--" (e.g. "git log 'a*'" instead of
> "git log -- 'a*'"). And I still believe that happens a lot more often
> than this case. Putting "--" is _the_ way to avoid ambiguation when
> git fails to do it properly. Though in future we may make git smarter
> at solving ambiguation (e.g. it could do glob() to test if a wildcard
> pattern matches any path).

It's still sort-of a regression; we changed the rule and now things tha=
t
used to work don't. Using "--" is a good protection, but people who
didn't have to use "--" in some cases now do.

I wonder if we could fix this pretty simply, though, by skipping the
"does it have a wildcard" check when we see a colon in the path. That i=
s
a good indication that we are using one of git's special rev syntaxes
(either "tree:path", or ":path", or ":/search string". That breaks
anybody who really wanted to look for "path:with:colons.*", but that
seems a lot less likely to me.

It doesn't cover:

  git log 'HEAD^{/Merge.*}'

which is similarly affected by 28fcc0b. Perhaps "^{" should be such a
magic string, as well. We can be liberal with such strings as they are
really just limiting the impact of 28fcc0b; we would fall back in those
cases to the usual "can it be resolved, or is it a path?" rule.

-Peff
