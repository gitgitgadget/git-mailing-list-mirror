From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Some ideas for StGIT
Date: Sat, 4 Aug 2007 22:31:30 -0400
Message-ID: <20070805023130.GV20052@spearce.org>
References: <1186163410.26110.55.camel@dv> <200708031914.04344.andyparkins@gmail.com> <1186206085.28481.33.camel@dv> <20070804055110.GP20052@spearce.org> <f934ve$3oi$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 04:31:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHVu5-0000t0-Lh
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765445AbXHECbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 4 Aug 2007 22:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbXHECbf
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 22:31:35 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43463 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360AbXHECbe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Aug 2007 22:31:34 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IHVtn-0001ti-Lw; Sat, 04 Aug 2007 22:31:19 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A12DE20FBAE; Sat,  4 Aug 2007 22:31:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <f934ve$3oi$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54924>

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn O. Pearce wrote:
>=20
> > (Regarding the performance, cherry-picking 55 patches is
> > slow, especially when many of them would apply trivially with
> > git-diff|git-apply --index. =A0Be nice to improve that in 1.5.4.)
>=20
> Perhaps in the future you would be able to use -i/--interactive mode
> in merge driven git-rebase (git rebase --merge -i <base>), which I th=
ink
> should be faster.

Heh.  You're talking to someone who actually knows what he is talking
about here, and was actually involved in some of these tools...
Let me fill the reader in on what's really happening...

`git-rebase` (non -i, non -m) uses `format-patch|am` to apply the
changes of each commit it is rebasing.  This is insanely fast as
builtin diff and apply routines are quite efficient.  It sometimes
fails due to patches not applying cleanly.  In those cases you
have to either hand edit the patch, apply and continue the rebase,
or abort the rebase and restart with the -m flag so it uses a full
three-way file merge.

`git-rebase -m` (aka --merge) uses git-merge-recursive to apply the
changes of each commit it is rebasing.  (That's the merge part!)
However merge-recursive usually takes longer to run then the above
`format-patch|am` pipeline, and that is why -m is not the default.
But it does handle cases `format-patch|am` cannot do automatically.

=46or quite a long time now both `git-revert` and `git-cherry-pick`
(which are actually the same program!) have also been using
git-merge-recursive as their implementation to revert or apply the
commit's change.  This allows them to perform changes that also
involve renames, as well as to apply some changes that might fail
as a patch but succeed when done as a three-way file merge.

So really `revert`, `cherry-pick`, `rebase -m` (and also `am -3`
as it also uses merge-recursive) are all the same underlying
implementation.  The major differences between them is what they
do *after* the changes have been applied, and which direction the
change goes (e.g. revert undoes the change).

Now the new `git-rebase -i` is really just a complicated loop around
`cherry-pick`.  Really.  Go look at the code, it never calls anything
except cherry-pick.  So `rebase -i` is actually `rebase --merge -i`.
That's why its sluggish.

Why is merge-recursive sluggish?  It does rename detection.
It does full three-way file merges, rather than just applying
a patch.  It also tries to do a three-way read-tree before doing
file level merges.  git-apply does none of these things, and is
faster because of it.

So that future you speak of above is today.  Its also not faster,
its slower.  Faster would be to do something like `format-patch|am -3`
so that merge-recursive is only invoked if git-apply was unable to
apply the patch automatically.  Except we'd want to save the original
tree data so we can do proper rename detection when merge-recursive
is fired up.

--=20
Shawn.
