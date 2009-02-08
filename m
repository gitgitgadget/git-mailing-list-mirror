From: Jeff King <peff@peff.net>
Subject: Re: Deleting the "current" branch in remote bare repositories
Date: Sun, 8 Feb 2009 03:44:53 -0500
Message-ID: <20090208084453.GA4392@coredump.intra.peff.net>
References: <20090207162754.5fb8b63f@perceptron> <94a0d4530902071405m33a0804er8030e14bea205898@mail.gmail.com> <20090208011802.2b7b9e74@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git ML <git@vger.kernel.org>, obrien654j@gmail.com
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sun Feb 08 09:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW5Mi-0001HS-Fe
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 09:50:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593AbZBHIo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Feb 2009 03:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752549AbZBHIo4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 03:44:56 -0500
Received: from peff.net ([208.65.91.99]:34456 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461AbZBHIo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 03:44:56 -0500
Received: (qmail 25850 invoked by uid 107); 8 Feb 2009 08:45:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 08 Feb 2009 03:45:10 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Feb 2009 03:44:53 -0500
Content-Disposition: inline
In-Reply-To: <20090208011802.2b7b9e74@perceptron>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108929>

On Sun, Feb 08, 2009 at 01:18:02AM +0100, Jan Kr=C3=BCger wrote:

> Okay, somehow I missed that. To reiterate the things from that
> discussion that I think are most reasonable:
>=20
> 1) a local broken symref should generally be ignored unless we actual=
ly
>    need the symref.

I think this is almost as easy as:

diff --git a/refs.c b/refs.c
index 024211d..9601101 100644
--- a/refs.c
+++ b/refs.c
@@ -276,7 +276,6 @@ static struct ref_list *get_ref_dir(const char *bas=
e, struct ref_list *list)
 				continue;
 			}
 			if (!resolve_ref(ref, sha1, 1, &flag)) {
-				error("%s points nowhere!", ref);
 				continue;
 			}
 			list =3D add_ref(ref, sha1, flag, list, NULL);

Since this is just called when enumerating all of the loose refs (via
get_loose_refs(), which is generally called from for_each_ref).

However, there is one other complication. rename_ref uses get_loose_ref=
s
to check whether the destination space is available:

  if (!is_refname_available(newref, oldref, get_loose_refs(), 0))
        return 1;

so you can get funny behavior through:

  git branch -m foo bar

when "bar" is a symref pointing to a non-existent ref. Of course, we ar=
e
not _changing_ that behavior, since we always just ignored that symref.
But we are removing the warning message that might clue the user that
something confusing is about to happen.

> 2) there should be a more convenient (porcelain) way to change a
>    refs/remotes/foo/HEAD symref, e.g. git remote set-default, possibl=
y
>    with an option to re-sync from the remote head (we could even make
>    that an option for git remote update).

Yes, I think that is a good idea (optionally with a switch to just
re-grab the information from the remote).

> Regarding 2): if we managed to add an option to that to change the
> remote HEAD, we could disallow deleting a remote branch that HEAD
> points to, and refer to this command. I think the problem is that we
> would have to add symref updating logic for all types of remote
> protocols.

Yes, the protocol support would make this a much bigger patch (and you
would have to handle the case where the remote side didn't support it).
But bear in mind that deleting the remote HEAD breaks things not just
for you, but for other people who are cloning that remote. Maybe we
should refuse such updates unless "-f" is given (similar to
non-fast-forward updates); I haven't looked to see if we even have the
remote's HEAD information during push, though.

> If people agree with these ideas I think I'll write up a couple of
> patches to implement these changes. So, any protests?

I say go for it.

-Peff
