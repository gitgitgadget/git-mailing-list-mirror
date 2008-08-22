From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: some questions
Date: Fri, 22 Aug 2008 07:15:48 -0700
Message-ID: <20080822141548.GD3483@spearce.org>
References: <48AE6B41.1070005@jentro.com> <m3bpzls8ld.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>,
	Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 16:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWXSN-0004TR-Q0
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 16:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbYHVOPt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Aug 2008 10:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751677AbYHVOPt
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 10:15:49 -0400
Received: from george.spearce.org ([209.20.77.23]:56952 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbYHVOPs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 10:15:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 25B1038376; Fri, 22 Aug 2008 14:15:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <m3bpzls8ld.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93303>

Jakub Narebski <jnareb@gmail.com> wrote:
> Thomas Pasch <thomas.pasch@jentro.com> writes:
>=20
> > I try to migrate our old cvs repo to git.
> > However, I still have to following questions
> > that I found difficult to answer with
> > the documentation.
> >=20
> > - Is there a way to convert a indexVersion 1
> >   repo to indexVersion 2? (And vice versa?)
>=20
> I think the only solution is to simply remove index,
> ensure configuration (pack.indexVersion), and recreate
> it using git-index-pack(1).

Just change pack.indexVersion in .git/config to have the version
you want and run `git gc` to repack the repository.  If you created
this repository by cloning another you may need to first delete
any .keep files:

	rm -f .git/objects/pack/*.keep
 =20
> > - Is there a way to find out if a repository
> >   is indexVersion 1 or indexVersion 2 (from
> >   the pack/index files)?
>=20
> There is some magic number used to distinguish between
> pack index version 1 and version 2.
>=20
> See Documentation/technical/pack-format.txt for details.

  for i in .git/objects/pack/pack-*.idx; do
  dd if=3D$i bs=3D12 count=3D1 | od -c
  done

A line like:

0000000   =EF=BF=BD   t   O   c  \0  \0  \0 002  \0  \0  \0 002

indicates index version 2, as it has the magic byte sequence in
front of '\xFFt0c'.  Most version 1 indexes will have 2 zeros
in the first two bytes:

0000000  \0  \0  \0  \0  \0  \0  \0 001  \0  \0  \0 003

> > - http for git seems to be read-only/fetch.
> >   Would it be (theoretically) possible to
> >   support write/push (with WebDAV or so)?
>=20
> It *is* supported (via https).
>=20
> There was even attempt to create 'smart' http
> push via web server module or CGI script, but
> IIRC it hit feature freeze and discussion petered
> out, so only parts of it are in 'pu'.
>=20
> Search for "Add Git-aware CGI for Git-aware smart
> HTTP transport", "More on git over HTTP POST"
>=20
>   http://thread.gmane.org/gmane.comp.version-control.git/91104

I'm picking this up again and working on it more.  Its not dead.
 =20
> > - What would be the implication to mount the
> >   git repo with nts (or another remote fs).
> >   Is it save to use such a mounted repo from
> >   more than one computer?

I've found that accessing a Git pack file over a network file
system like NFS or SMB is kinda slow.  The issue is we do many
reads scattered throughout the file.  Its hard for the client
to batch up reads and hide the network latency.

You may get better performance by building Git without mmap
support:

	make NO_MMAP=3D1

but that is going to hurt access to local files.

--=20
Shawn.
