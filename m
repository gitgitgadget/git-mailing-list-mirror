From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] Remove --undo flags from stg commands and docs
Date: Mon, 14 Jul 2008 08:27:54 +0200
Message-ID: <20080714062754.GB20751@diana.vm.bytemark.co.uk>
References: <20080704063536.9570.43526.stgit@yoghurt> <b0943d9e0807071354j50dca83aya90317f97f559b19@mail.gmail.com> <20080708042131.GB2247@diana.vm.bytemark.co.uk> <b0943d9e0807120258g26e30c4bn5b7f77f69a0c3db3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 08:29:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIHYY-00011S-Th
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 08:29:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbYGNG2H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 02:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753090AbYGNG2G
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 02:28:06 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2047 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbYGNG2F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 02:28:05 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KIHXO-0005gM-00; Mon, 14 Jul 2008 07:27:54 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0807120258g26e30c4bn5b7f77f69a0c3db3@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88381>

On 2008-07-12 10:58:44 +0100, Catalin Marinas wrote:

> 2008/7/8 Karl Hasselstr=F6m <kha@treskal.com>:
>
> > On 2008-07-07 21:54:01 +0100, Catalin Marinas wrote:
> >
> > > Anyway, have you heard of anyone else using sync apart from me?
> >
> > No, I haven't.
> >
> > I've tried to understand what it does, and as far as I can tell it
> > doesn't do quite what I want. (What I want is the ability to 3-way
> > merge StGit patch stacks, so that I can modify the same patch
> > stack in several places and merge back and forth. From what I
> > recall, the sync command is more like a 2-way merge -- that is, it
> > doesn't take the last common ancestor into account. But it's been
> > a while since I studied it.)
>
> No, the sync command is a 3-way merge between the top of a remote
> patch, the top of the current patch (current HEAD actually) and the
> bottom of the remote patch as ancestor. It also has a mode to
> synchronise with a patch file and it applies the patch onto the
> bottom of the current patch and does the merging between patch tops
> afterwards.
>
> This is not ideal as I have to deal with safe conflicts several time
> (maybe adding git-rerere support would help). If you have better
> ideas for keeping two stacks in sync, I'm happy to accept them (or
> maybe just a different workflow).

Yeah, the actual _tree merging_ is 3-way, but the _patch merging_ is
2-way, since you don't consider the patches' latest common ancestor.
So you run into problems much like what you'd get if you tried to
apply a patch, change it, then apply it again, etc.

When merging two branches with stack logs, you can find the stack log
of the merge base, and use that to 3-way merge the patches.

( To 3-way merge a patch:

    1. You have the common ancestor (A), and the two diverged patches
       (B and C).

    2. Push A, B, and C separately onto the same commit. (If there are
       conflicts at this stage, one probably wants to just ignore them
       automatically, like merge-recursive does.) Now, A_b =3D=3D B_b =3D=
=3D
       C_b. (_b is the patch's bottom; _t is its top.)

    3. 3-way merge A_t, B_t and C_t to get the new patch top.

    4. Commit message etc. can be merged with a standard 3-way merge.

  To merge an entire patch stack, first merge the stack bases (with an
  ordinary 3-way merge, for example), then merge any changes is the
  patch order, and then merge all the patches one by one.

  As I've said before, I haven't actually tried this, so I don't know
  if it'll work as intended. But it sounds right ... and it works out
  OK for trivial cases like when the patch is only modified in one
  branch, or when no patch bottoms are changed by step (2). )

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
