From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase --preserve-merges seems to not work
Date: Thu, 9 Sep 2010 07:51:04 +0200
Message-ID: <20100909055104.GA21004@atjola.homenet>
References: <4C886DF3.8050903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Steinert <hachi@kuiki.net>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Sep 09 07:51:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ota2a-0004a1-6o
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 07:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099Ab0IIFvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Sep 2010 01:51:14 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:57466 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752483Ab0IIFvN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 01:51:13 -0400
Received: (qmail invoked by alias); 09 Sep 2010 05:51:10 -0000
Received: from i59F57FC4.versanet.de (EHLO atjola.homenet) [89.245.127.196]
  by mail.gmx.net (mp046) with SMTP; 09 Sep 2010 07:51:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+YOzxVhbqYf7mDXpTliHKQieeamDBiNdfelrqwPJ
	LeVmWW9uDAWnlL
Content-Disposition: inline
In-Reply-To: <4C886DF3.8050903@workspacewhiz.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155843>

On 2010.09.08 23:17:39 -0600, Joshua Jensen wrote:
> # Commit 'd' is something I would pull --rebase from the server
> before I push.
> $ git lg --all
> *   472fd93 - (HEAD, bc-merge) Merge commit 'c' into HEAD (3 seconds =
ago)
> |\
> | * d132c87 - (c) c (2 minutes ago)
> | * 4a88fd1 - b (2 minutes ago)
> |/
> | * 6abf527 - (d) d (2 minutes ago)
> |/
> * b576660 - (a, master) a (3 minutes ago)
>=20
>=20
> # Here is the rebase with the --preserve-merges option.
> $ git rebase --preserve-merges d
> Rebasing (n/3)
> Successfully rebased and updated detached HEAD.
>=20
> # Of course, bc-merge is an orphaned branch.  Its changes got
> replayed on top of 'd'.

Yup, and the "problem" is, that both sides of the merge got replayed.

> # Note the merge commit with the description "Merge commit 'c' into
> HEAD" is missing.

Because the merge could be resolved as a fast-forward, as it merges the
replayed commits b' and c', not the originals.

> $ git lg --all
> * 2c93a8a - (HEAD) c (11 seconds ago)
> * 2b98bc6 - b (11 seconds ago)
> * 6abf527 - (d) d (3 minutes ago)
> | *   472fd93 - (bc-merge) Merge commit 'c' into HEAD (74 seconds ago=
)
> | |\
> |/ /
> | * d132c87 - (c) c (3 minutes ago)
> | * 4a88fd1 - b (3 minutes ago)
> |/
> * b576660 - (a, master) a (4 minutes ago)

What you actually wanted to replay is just the first-parent history,
redoing the merges with their respective original second parent.
Jonathan (Cc'ed) had the same problem about a month ago.

The "first parent" thing isn't that well defined, criss-cross merges
combined with some unfortunate fast-forwards will easily make the
first-parent history become the one that you didn't mean (ask any
git-svn users that dared to use "git merge" without fully understanding
how git-svn uses the history ;-)), but it works in this special case.
And with that special case in mind (and admittedly probably not thinkin=
g
much further) I came up with this patch a few years ago:

http://marc.info/?l=3Dgit&m=3D119379735525213&w=3D2

It was not my itch to scratch though, so I never got around to get it
included, and of course it doesn't apply cleanly anymore. I tried to
give some hints to Jonathan ("hachi") on #git on how to update the patc=
h
to make it apply again:

http://colabti.de/irclogger/irclogger_log/git?date=3D2010-08-20#l1241

=46eel free to pick up from there...

Bj=F6rn
