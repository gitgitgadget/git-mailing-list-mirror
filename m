From: Jeff King <peff@peff.net>
Subject: Re: Bug? file at the same time being deleted and not registered
Date: Sun, 23 May 2010 19:44:59 -0400
Message-ID: <20100523234459.GA8285@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tomas Pospisek <tpo_deb@sourcepole.ch>
X-From: git-owner@vger.kernel.org Mon May 24 01:45:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGKrJ-0002n9-Fs
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 01:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab0EWXpH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 May 2010 19:45:07 -0400
Received: from peff.net ([208.65.91.99]:40365 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab0EWXpG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 19:45:06 -0400
Received: (qmail 29631 invoked by uid 107); 23 May 2010 23:45:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 23 May 2010 19:45:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 23 May 2010 19:44:59 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147597>

On Sun, May 23, 2010 at 11:09:53PM +0200, Tomas Pospisek wrote:

> So we have a file that was committed, that git thinks it's scheduled =
to be
> deleted and at the same time is untracked. Doesn't make any sense,
> does it?
>=20
> This happens only on the mhddfs backed filesystem. The same procedure
> works well in /tmp or on plain ext3.
>=20
> Here's the strace of the commit step (from a identical try):
>=20
>    http://pastebin.com/htUmWYGh
>=20
> Jan 'jast' Kr=C3=BCger from the git IRC channel spotted in that strac=
e the
> fact that the 'link' call is failing.
>=20
> In that case IMHO git should complain and let the user know, that
> something went wrong and it can't proceed meaningfully.

If you mean this (from your strace):

  link(".git/objects/df/tmp_obj_cL0wfQ", ".git/objects/df/2b8fc99e1c1d4=
dbc0a854d9f72157f1d6ea078") =3D -1 ENOSYS (Function not implemented)

Note that it is immediately followed by:

  rename(".git/objects/df/tmp_obj_cL0wfQ", ".git/objects/df/2b8fc99e1c1=
d4dbc0a854d9f72157f1d6ea078") =3D 0

IOW, git tries the hard-link first, then falls back to the rename. If
the rename also fails, git does complain. So I don't think that is your
problem.

I would guess your real problem is that when we traverse the directory
structure and see "a_file", for some reason git is not connecting that
with the index entry for "a_file". In the past, problems like this are
usually due to filesystems which munge the filename behind git's back.
I.e., if you do "touch foo" you get some file whose name _looks_ like
"foo" but is not bit-for-bit compatible. HFS will do this when
normalizing utf8 characters, but I don't think we've ever seen it on
anything as plain as "a_file".

Can you try running the output of "git diff-files --name-only" and "git
ls-files -o" through xxd or something that would show individual bytes?
My suspicion is that the "a_file" shown in each may not be bit-for-bit
identical.

-Peff
