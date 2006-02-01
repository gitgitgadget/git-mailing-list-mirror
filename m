From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 12:27:17 -0800
Message-ID: <7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:27:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4OZe-0004TN-HG
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWBAU1V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422927AbWBAU1V
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:27:21 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:1437 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422926AbWBAU1U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 15:27:20 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201202507.SHI17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 15:25:07 -0500
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15442>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 31 Jan 2006, Junio C Hamano wrote:
>
>> People who do not like this can set in their config file some
>> flag, say, 'core.index = understood', to get the current
>> behaviour.
>
> I'd avoid hidden config options that magically change behaviors and 
> semantics like that as much as possible....

I agree; it was tongue-in-cheek sort of suggestion ;-)

> It is much more intuitive to expect that, if you specify path arguments 
> to commit, then only those paths are considered, and even if you didn't 
> do a git add on some of them.  If nothing is specified then the current 
> index (the default, including a-new-file) is considered.

Good thinking.  I was not thinking about the case where you
explicitly list an untracked file to be added.

>  - a non-merge commit without any argument would imply -a.
>
>  - a non-merge commit with path arguments implies _only_ those paths, 
>    regardless if they were previously "git add"ed or not.
>
>  - a non-merge commit with, say, --no-auto or --current-index or 
>    whatever would preserve the current behavior, with or without 
>    additional paths.
>
>  - a merge commit ...
>  - a merge commit ...
>
> This might look complicated when presented like that, but I think that 
> the default behavior of each (non-merge vs merge) commit would more 
> closely fit most people's expectations....

If I may correct what I said earlier, I now realize the
"automatic -a is dangerous" argument does not have anything to
do with merges.  If the user usually works with a dirty working
tree, is aware of the index, and takes advantage of the index as
the staging area for the next commit, your --no-auto would be
needed to help her workflow.  I in principle agree with the
first three items in the above summary, except that I think it
would make more sense to do that for all commits.

How about this:

 - "git commit --also fileA..." means: update index at listed
   paths (add/remove if necessary) and then commit the tree
   described in index (the current behaviour with explicit paths).

 - "git commit fileA..." means: create a temporary index from the
   current HEAD commit (or empty index if there is none), update
   it at listed paths (add/remove if necessary) and commit the
   resulting tree.  Also update the real index at the listed
   paths (add/remove if necessary).  In the original index file,
   the paths listed must be either empty or match exactly the
   HEAD commit -- otherwise we error out (Linus' suggestion).

 - "git commit" means: update index with all local changes and
   then commit the tree described in index (current "-a"
   behaviour).

 - In all cases, revert the index to the state before the
   command is run if we end up not making the commit (e.g. index
   unmerged, empty log message, pre-commit hook refusal).

Experienced git users would end up saying "--also" without
explicit paths to defeat the automatic -a behaviour all the
time, and while the flag --also makes perfect sense when used
with one or more paths, using it like this look awkward:

        $ edit some-file
        $ git update-index some-file
        $ git commit --also

It's just a flag name so we could make --no-auto synonym to --also.

A minor twist of the above to make it friendlier to the current
git users is to do this:

 - "git commit fileA...", "git commit -a", and "git commit" keep
   the existing semantics.

 - "git commit --only fileA..." does the new temporary index
   thing.

This has an advantage that existing use is not affected, and
another advantage is that internally it is more consistent ("git
commit" is a natural extension of "git commit fileA..." with
zero path).  But one possible downside is that you need to
explicitly say --only when you want cvs-like "commit".

Since we are discussing that the people find existing
interface to be unintuitive, being consistent with the current
usage may not count as a big advantage after all..
