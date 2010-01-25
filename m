From: Jeff King <peff@peff.net>
Subject: Re: basic question about push
Date: Mon, 25 Jan 2010 06:08:13 -0500
Message-ID: <20100125110813.GB8517@coredump.intra.peff.net>
References: <loom.20100124T074722-510@post.gmane.org>
 <20100124081513.GA10700@coredump.intra.peff.net>
 <76718491001241559u103d2e8j38687b41bd5401a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Russ Paielli <Russ.Paielli@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:08:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZMny-0006cr-Ox
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427Ab0AYLIV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 06:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464Ab0AYLIT
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:08:19 -0500
Received: from peff.net ([208.65.91.99]:59883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753427Ab0AYLIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 06:08:19 -0500
Received: (qmail 6319 invoked by uid 107); 25 Jan 2010 11:13:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 25 Jan 2010 06:13:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Jan 2010 06:08:13 -0500
Content-Disposition: inline
In-Reply-To: <76718491001241559u103d2e8j38687b41bd5401a1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137953>

On Sun, Jan 24, 2010 at 06:59:10PM -0500, Jay Soffian wrote:

> > =C2=A0http://git.wiki.kernel.org/index.php/GitFaq#push-is-reverse-o=
f-fetch
>=20
> Aside, and I think we've discussed this before, but I wonder if it
> would make sense to:
>=20
> a) Add an option to clone such as "-p [<name>] | --push-as[=3D<name>]=
"
> where <name> defaults to $(uname -n | cut -f1 -d.) This would setup
> the cloned repo with a push refspec
> "+refs/heads/*:refs/remotes/<name>/*". e.g.:
>=20
> $ git clone -o host1 -p host2 ssh://host1/~/repo.git
> $ cat repo/.git/config
> ...
> [remote "host1"]
> 	url =3D ssh://host1/~/repo.git
> 	fetch =3D +refs/heads/*:refs/remotes/host1/*
> 	push =3D +refs/heads/*:refs/remotes/host2/*

One problem with this scheme is that it actually does two things:

  1. Tells git to push into the refs/remotes/host2/ hierarchy instead o=
f
     refs/heads/.

  2. Overrides matching behavior to push all heads.

Point (2) is less of a problem than it is without (1) in the sense that
you are pushing to a unique namespace, so you don't have to worry as
much about your crappy half-finished branches filling up the main branc=
h
namespace. But you might not want them publicized at all, either becaus=
e
they are embarrassingly bad or simply because it is cruft that you will
encounter later and wonder "is this branch, which is missing from my
local repositor (presumably from a long-ago deletion) but present
upstream of any value at all?"

I can't think offhand of a way to get the behavior of (1) without (2).
I know we have a shorthand refspec for "matching", but this would not
strictly be matching. It is "convert refs/heads/X into
refs/remotes/blah/X, and _then_ match".

If we had a refspec that worked in that manner, I would think it's a
pretty good idea (even to turn it on by default for non-bare repos).

> b) The controversial part: make this option the default the default
> when cloning from a non-bare repo. There would need to be some way to
> turn it off.

Hmm. Do we reliably know from the client side whether a remote is bare
or not?

> Of course, I'm not sure this would be any less confusing for users.
> Would they wonder why they have to merge to see their pushed changes
> reflected on the pushed-to repo?

Yes, I think we would still have the FAQ of "I pushed my changes, where
did they go?" but at least the answer would be "git merge foo" and not
"what you are doing is confusing to git and you need to figure out what
kind of workflow you want, redo your push, and then git merge foo".
Which seems like an improvement to me. ;)

-Peff
