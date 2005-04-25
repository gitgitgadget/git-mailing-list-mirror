From: David Roundy <droundy@abridgegame.org>
Subject: Re: A darcs that can pull from git
Date: Mon, 25 Apr 2005 09:31:20 -0400
Message-ID: <20050425133116.GG11667@abridgegame.org>
References: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:33:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ3h4-0004cj-LB
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 15:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVDYNgs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 09:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVDYNgn
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 09:36:43 -0400
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:36647 "EHLO
	localhost") by vger.kernel.org with ESMTP id S262610AbVDYNgY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 09:36:24 -0400
Received: from droundy by localhost with local (Exim 4.50)
	id 1DQ3gH-0004E6-1J; Mon, 25 Apr 2005 09:31:21 -0400
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Mail-Followup-To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7ipswjbybx.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 25, 2005 at 12:32:18AM +0200, Juliusz Chroboczek wrote:
> I've just finished putting together a hack for darcs to allow it to
> pull from Git repositories.  You'll find the patch (Darcs patch, not
> diff patch) on

Very cool! :)

>   http://www.pps.jussieu.fr/~jch/software/files/darcs-git-20050424.darcs

First off, you need to include a license header in the git files indicating
that unlike the rest of darcs, they may only be distributed under GPL v2.
Something like the following would probably be fine (but it's Linus'
copyright that's involved, not mine)

/*
 * GIT - The information manager from hell
 *
 * Copyright (C) Linus Torvalds, 2005

  This program is free software; you can redistribute it and/or modify
  it under the terms of version 2 of the GNU General Public License as
  published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

Without this header, it's either illegal to distribute these files, or
they're assumed to be under GPLv2 or later along with the rest of darcs,
which also isn't legal...

> I've just finished putting together a hack for darcs to allow it to
> pull from Git repositories.  You'll find the patch (Darcs patch, not
> diff patch) on
>   http://www.pps.jussieu.fr/~jch/software/files/darcs-git-20050424.darcs

Any chance you can host a gettable repository? If not, I'd be happy to give
you an account on darcs.net on which you could host darcs-git.

> If you get merge conflicts, try using a version of the darcs-unstable
> tree from 18.04.2005, which is what I started with.

There is a conflict in GNUMakefile, which is moderately easy to resolve.
It would be nice to keep files in alphabetical order (as is mostly
currently the case, which has some small chance of reducing the likelihood
of conflicts.

> A minor problem: there's something broken with the build procedure;
> you'll probably need to manually do a ``make Context.hs'' followed
> with ``make darcs'' when the build breaks.

Or alternatively run "autoconf; ./configure; make"

> After you build darcs-git, you should be able to do something like
> 
>   $ cd ..
>   $ mkdir a
>   $ cd a
>   $ darcs initialize
>   $ ../darcs-git/darcs pull /usr/local/src/git-pasky-0.4
>   $ darcs changes

Do you have any plans/ideas for allowing pulls directly from a remote git
repository? Obviously it'll be less efficient, since you'll have to
download at least one file in its entirety.  Perhaps we could store a git
mirror in _darcs and use rsync?  :(

> David, could you please have a look at the patches
> 
>   Sun Apr 24 16:50:02 CEST 2005  Juliusz Chroboczek <jch@pps.jussieu.fr>
>     * First cut at remodularising repo access.
> 
>   Sun Apr 24 16:01:32 CEST 2005  Juliusz Chroboczek <jch@pps.jussieu.fr>
>     * Change Repository to DarcsRepo.
> 
> and tell me whether this sort of restructuring is okay with you.

Those two look fine to me.  I'm increasingly liking (as I get to understand
it better) your ideas regarding modularizing repository access.

> (David, I'm not claiming that this scheme is better than the ``tagging
> like crazy'' scheme that you outlined; I'm only trying to prove that
> my scheme is workable.)

Okay, it does look like most of your code will be equally useful for the
"tagging like crazy" scheme.

> Right now, I'm taking a Git commit and manually generating a Darcs
> patch id from that, which is a bad idea.  A better way would be to get
> Darcs to deal with arbitrarily shaped patch ids; a patch that
> originates with git would get the git patch id, while a patch that
> comes from Darcs would retain its patch id even when pushed to git.
> David, you had some objections to that; any chance we could discuss
> the issue?

We certainly can discuss it, and I still object.  I think it'd be much
better to map from git commits to darcs patch ids.  Your scheme and mine
both have uglinesses.

My "tag like crazy" scheme gives a unique mapping of a git commit to one
darcs patch and one darcs tag, but has the ugliness that a darcs patch
can't be mapped to a git commit without adding an additional darcs tag.  I
tend to see this as a plus.  It reflects the fact semantic difference
between a darcs patch and a git commit--the git commit is actually
equivalent not to a darcs patch but rather a darcs tag.

Your idea has the niceness that it could provide a one-to-one (as opposed
to two-to-one) mapping between darcs patches and git commits, but the catch
is that we don't know the git commit ID until after the patch has been
moved into git-land.  This is directly analagous to the wart in my scheme
that darcs patches would acquire a tag when moved into git-land.  I prefer
my scheme, since extra tags are relatively harmless, and reflect the
dependencies in the git repository.

> This is slow.  There are a few obvious improvements to make to the
> performance, but I'd rather first implement whatsnew, diff and apply,
> and fix the problem with patch dependencies.  (Whatsnew is where git's
> performance is actually likely to be better than Darcs, but it will
> require some abstracting of ``Slurpy'' in order to make that
> effective.)  Unfortunately, I don't expect to have hacking time before
> next week-end.

All right.  I'll look forward to another installment after next weekend
then!  :)

I had a few minor comments on your code, which I've forgotten.  One was
that either you're compiling with ghc 6.2, or you've disabled
-Werror... It'd be nice to be sure that your code is -Werror-clean with ghc
6.4 as well.
-- 
David Roundy
http://www.darcs.net
