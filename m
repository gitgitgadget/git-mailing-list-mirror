From: Jeff King <peff@peff.net>
Subject: Re: `.git` symlink makes `git submodule add` fail
Date: Sat, 13 Feb 2016 13:52:52 -0500
Message-ID: <20160213185252.GA10063@sigill.intra.peff.net>
References: <20160212164853.GA6888@witiko>
 <xmqqio1tvlzu.fsf@gitster.mtv.corp.google.com>
 <xmqq60xtvlj9.fsf@gitster.mtv.corp.google.com>
 <20160212182733.GA19973@sigill.intra.peff.net>
 <20160213042008.GA26677@witiko>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?VsOtdCBOb3ZvdG7DvQ==?= <witiko@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 19:53:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUfJT-0007XD-EG
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 19:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbcBMSwz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2016 13:52:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:41617 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750987AbcBMSwy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2016 13:52:54 -0500
Received: (qmail 13491 invoked by uid 102); 13 Feb 2016 18:52:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:52:54 -0500
Received: (qmail 27584 invoked by uid 107); 13 Feb 2016 18:52:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Feb 2016 13:52:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Feb 2016 13:52:52 -0500
Content-Disposition: inline
In-Reply-To: <20160213042008.GA26677@witiko>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286125>

On Sat, Feb 13, 2016 at 05:20:09AM +0100, V=C3=ADt Novotn=C3=BD wrote:

> On Fri, Feb 12, 2016 at 01:27:33PM -0500, Jeff King wrote:
> > On Fri, Feb 12, 2016 at 10:19:38AM -0800, Junio C Hamano wrote:
> >=20
> > > >> Is this a bug, or is the ability to symlink `.git` just a happ=
y coincidence?
> > > >
> > > > It has never been supported.
> > >=20
> > > Oops, hit "send" too early.
> > >=20
> > > We have support for a "gitdir:" facility that would work even on =
a
> > > filesystem that cannot do symlinks (see gitrepository-layout(5)),
> > > and both the higher-level submodule Porcelain and the more recent
> > > "worktree" experimental code do use it.
> >=20
> > And the way to convince git to make the link for you is with clone'=
s
> > "--separate-git-dir" option.
>=20
> What's curious is that this doesn't really work either, so the issue
> doesn't seem to be the lack of symlink support, but rather the lack o=
f
> willingness on the part of Git to resolve a path recursively.

Right. The fundamental problem is that if git needs to construct a
related path, symlinks mean it cannot do so textually. I'm sure there
are spots where we use real_path() to get a canonical path for a
particular $GIT_DIR, but from your results, it's clear we don't do so
consistently.

So you can call that "git doesn't support symlinks", or you can call it
"git supports symlinks, but needs to do so more consistently". :) I am
not sure whether the existing uses of real_path() are there
intentionally to support the kind of path-munging that submodules do or
not. But either way, canonicalizing the paths before creating relative
ones is probably going to be the solution.

I say all of that without having really looked at the code. You asked
earlier if there would be any objects to a patch to implement better
symlink support. That is hard to answer without somebody digging in to
see what the fix would look like, and whether there would be any
tradeoffs.

-Peff
