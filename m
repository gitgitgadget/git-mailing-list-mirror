From: Jeff King <peff@peff.net>
Subject: Re: How to create a new commit with the content of some commit?
Date: Tue, 12 May 2009 12:51:03 -0400
Message-ID: <20090512165103.GE29566@coredump.intra.peff.net>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com> <20090512160749.GA29566@coredump.intra.peff.net> <46dff0320905120943j303ef104ve7bad25f1874007f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 18:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vCJ-0006Jn-HO
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 18:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbZELQvI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 12:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756937AbZELQvG
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:51:06 -0400
Received: from peff.net ([208.65.91.99]:36508 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755828AbZELQvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 12:51:04 -0400
Received: (qmail 32269 invoked by uid 107); 12 May 2009 16:51:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 May 2009 12:51:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 May 2009 12:51:03 -0400
Content-Disposition: inline
In-Reply-To: <46dff0320905120943j303ef104ve7bad25f1874007f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118926>

On Wed, May 13, 2009 at 12:43:33AM +0800, Ping Yin wrote:

> > You can just munge the index directly, and skip the working tree
> > entirely:
> >
> > =C2=A0rm .git/index
> > =C2=A0git read-tree b
> > =C2=A0git commit -m 'the copy of b'
>=20
> In a non-conflict status, "git read-tree b" will update the index to
> full match the tree of b, so "rm .git/index" is unnecessary, right?

=46or some reason, I was thinking that entries in the index that were n=
ot
in "b" would remain, but that is not actually the case. So yes, I think
you can do it without removing the index (and you are better off to do
so, since the index also contains the stat cache for your worktree, so
it is more efficient).

You can also add "-u" as Junio suggested to update the working tree
during that step, which should be more efficient.

> > =C2=A0echo 'copy of b' >message
> > =C2=A0tree=3D`git rev-parse b^{tree}`
> > =C2=A0commit=3D`git commit-tree $tree -p c <message`
> > =C2=A0git update-ref c $commit
>=20
> Maybe a -c option can be added to git-commit-tree?

I doubt there is much interest in that, as commit-tree is meant to be a
low-level building block, not a user tool. If you wanted to pull the
message from another commit, you could just do:

  git cat-file commit b | sed '1,/^$/d' | git commit-tree ...

-Peff
