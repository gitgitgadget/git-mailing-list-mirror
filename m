From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] git_remote_helpers: push all refs during a non-local
 export
Date: Tue, 7 Jun 2011 13:42:03 -0400
Message-ID: <20110607174203.GD23224@sigill.intra.peff.net>
References: <20110607171838.GA21685@sigill.intra.peff.net>
 <20110607172129.GG22111@sigill.intra.peff.net>
 <BANLkTimQ9ORrhLm7SAETYa+f8ov81wzUaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:42:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU0IA-0002fX-5Z
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756797Ab1FGRmJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 13:42:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43475
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab1FGRmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:42:08 -0400
Received: (qmail 17938 invoked by uid 107); 7 Jun 2011 17:42:13 -0000
Received: from c-76-21-13-32.hsd1.ca.comcast.net (HELO sigill.intra.peff.net) (76.21.13.32)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Jun 2011 13:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2011 13:42:03 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTimQ9ORrhLm7SAETYa+f8ov81wzUaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175236>

On Tue, Jun 07, 2011 at 07:32:22PM +0200, Sverre Rabbelier wrote:

> On Tue, Jun 7, 2011 at 19:21, Jeff King <peff@peff.net> wrote:
> > When a remote helper exports to a non-local git repo, the
> > steps are roughly:
> >
> > =C2=A01. fast-export into a local staging area; the set of
> > =C2=A0 =C2=A0 interesting refs is defined by what is in the fast-ex=
port
> > =C2=A0 =C2=A0 stream
> >
> > =C2=A02. git push from the staging area to the non-local repo
> >
> > In the second step, we should explicitly push all refs, not
> > just matching ones. This will let us push refs that do not
> > yet exist in the remote repo.
>=20
> That repo is re-used though. Wouldn't this break for:
>=20
> $ git push branch-a
> $ # make commits on branch-a that shouldn't be pushed yet
> $ git push branch-b

No, because our fast-export from git will not include branch-a, and thi=
s
is about pushing from the exported staging area.

If the remote rewound their branch-a, we would actually fast-forward it
back again. This is no different than the current behavior, though,
which uses matching[1]. It would also update branch-a because it exists
upstream.

A related problem is branch deletion. I don't know that I can delete vi=
a
a fast-export stream. So once a branch exists in the staging area, it
will never go away.

So I think the right solution is really that the "export" command needs
to communicate the ref pairs to the remote helper so that it can do the
right thing (which would include renaming or deleting).

-Peff

[1] Actually, isn't the default push behavior due to change soon? That
would further break the existing code.
