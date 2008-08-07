From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Thu, 7 Aug 2008 09:13:55 +0200
Message-ID: <200808070913.55212.J.Wielemaker@uva.nl>
References: <200808061539.50268.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 09:15:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQzi8-0007xk-Tk
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754279AbYHGHN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 03:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754312AbYHGHN6
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:13:58 -0400
Received: from smtp-vbr7.xs4all.nl ([194.109.24.27]:2712 "EHLO
	smtp-vbr7.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260AbYHGHN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:13:57 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr7.xs4all.nl (8.13.8/8.13.8) with ESMTP id m777Dub9061894
	for <git@vger.kernel.org>; Thu, 7 Aug 2008 09:13:56 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <200808061539.50268.J.Wielemaker@uva.nl>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91561>

On Wednesday 06 August 2008 15:39:50 you wrote:
> Hi,
>
> I've been puzzling most of today to do something that must be simple.
> I've got a big repo which contains a project with several nicely related
> subprojects in directories. Only now, we want to share some of these
> subprojects with another project. I.e. they must start to live there own
> life. Of course, I would like to keep the history. So, I did (git
> --version: 1.5.6.GIT):
>
>       % git clone /home/git/pl.git
>       % cd pl
>       % git filter-branch --subdirectory-filter packages/chr HEAD
>
> This indeed creates a nice directory holding only the contents of
> packages/chr.  But, starting qgit I see that all commits, also those
> that had absolutely nothing to do with this dir are still there.  Also,
> all tags are still there with exactly the same SHA1 as the original.
> I'd expect the tags to be rewritten such that their SHA1 refers to the
> state of this single directory and its contents!?  Of course, these
> tags give me access to everything, so the repository doesn't shrink
> much too.
>
> I must be missing something important ...  I found similar complaints,
> but few decent answers and the few answer I did find appeared outdated.
> The one at http://use.perl.org/~rjbs/journal/34411 comes closest, although
> the reset --hard is no longer needed and the copying and gc-ing doesn't
> help much anymore.
>
> Should I write a tree-filter that removes all but the directory I want
> to keep?  I.e. something like this?  Feels like and overkill and I fear
> I'll have a lot of empty commits left.
>
>       'mv packages/chr .. && rm -r * && mv ../chr/* . && rmdir ../chr'
>
> I'll be grateful for a clue!

Weirdness goes on.  I tried this:

    git filter-branch --tree-filter '/home/jan/nobackup/tmp2/keep 
packages/chr'

where `keep' is a shell-script:

----------------------------------------------------------------
tmp=/home/jan/nobackup/tmp2
dir="$1"

if [ -d "$dir" ]; then
  b=`basename $dir`
  mv "$dir" $tmp/$b
  rm -rf *
  mv $tmp/$b/* .
  mv $tmp/$b/.??* .
  rmdir $tmp/$b
else
  rm -rf *
fi
----------------------------------------------------------------

This kind of works. I.e. I end up (after 3 hours) with a tree that only
contains files from packages/chr. Using qgit it no longer shows the
other files in the `tree' view. Only, it has *all* commits of the
original project, most of which of course do not change this directory,
but now at least their diff is empty. I'd assume there is a command to
remove these (which?)

Space wise this isn't ok.  The original project GIT is 140M, after this
action and a git gc, it is 63M: *much* too big.

Whats more weird: all tags still have the same sha1. I copied using git
clone --no-hardlinks pl chr, deleted all refs/tags from packed-refs and
gave a "git gc --prune", to end up with 1.1 GIGABYTE repository!?

I'm starting to feel a bit stupid that I can't get this done ...

        Clues?  --- Jan
