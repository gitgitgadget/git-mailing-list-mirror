From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 13:59:32 -0800
Message-ID: <7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
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
	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 23:01:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4Q0o-0004oM-0n
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 22:59:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422968AbWBAV7f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 16:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWBAV7f
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 16:59:35 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:15855 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422968AbWBAV7e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 16:59:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201215720.CMDO17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 16:57:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602011307250.21884@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 1 Feb 2006 13:09:19 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15454>

Linus Torvalds <torvalds@osdl.org> writes:

>>  - "git commit" means: update index with all local changes and
>>    then commit the tree described in index (current "-a"
>>    behaviour).
>
> No. Please no. "git commit" should continue to do what it does now. 
> Otherwise you can't do the two-stage thing in any sane way.
> Requiring "--incremental"/"--also" is very confusing.

I myself did not like it but...

> If somebody doesn't know about the index, he normally will never have 
> index changes _anyway_, except for the "git add" case. In which case "git 
> commit" does the right thing for him: it will either commit the added 
> files, or it will say "nothing to commit".

... the original complaint was that "git commit" without
explicit paths does not quack like "cvs/svn commit" -- commit
all my changes in the working tree.

And actually the one you are responding to was my cunning move
to pull this exact reaction from you: "No commit without
parameter should not imply -a".  I prefer the "minor twist"
version in the same messge myself.

To recap:

 - "git commit fileA..." means: update index at listed paths
   (add/remove if necessary) and then commit the tree described
   in index (the same as the current behaviour with explicit
   paths).

 - "git commit -a" means: update index with all local changes and
   then commit the tree described in index (the same as the
   current behaviour).

 - "git commit" means: write out the current index and commit
   (the same as the current behaviour).

 - "git commit --only fileA..." means: create a temporary index
   from the current HEAD commit (or empty index if there is
   none), update it at listed paths (add/remove if necessary)
   and commit the resulting tree.  Also update the real index at
   the listed paths (add/remove if necessary).  In the original
   index file, the paths listed must be either empty or match
   exactly the HEAD commit -- otherwise we error out (Linus'
   suggestion).

 - In all cases, revert the index to the state before the
   command is run if we end up not making the commit (e.g. index
   unmerged, empty log message, pre-commit hook refusal).  With
   this, "git diff-files fileA" would show the differences as it
   showed beforean aborted "git commit -a" or "git commit fileA"
   and removes one common gripe.
