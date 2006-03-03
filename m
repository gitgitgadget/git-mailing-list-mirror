From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 02 Mar 2006 16:34:20 -0800
Message-ID: <7v1wxk5ptf.fsf@assigned-by-dhcp.cox.net>
References: <20060302164405.GB7292@trixie.casa.cgf.cx>
	<20060302165510.GB18929@spearce.org>
	<20060302220930.GE6183@steel.home>
	<Pine.LNX.4.64.0603021521250.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 01:34:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEyFV-0004hf-G4
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 01:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbWCCAeW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 19:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752094AbWCCAeW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 19:34:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59091 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1752092AbWCCAeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 19:34:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060303003427.USOR25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Mar 2006 19:34:27 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603021521250.22647@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Mar 2006 15:27:24 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17126>

Linus Torvalds <torvalds@osdl.org> writes:

> For example, afaik, when merging multiple branches that had partially been 
> merged already (ie they had overlapping new stuff), if I read the old perl 
> code correctly, it would talk about the new stuff multiple times. This one 
> doesn't.

I think this is not quite right, even though it only matters in
Octopus and not many people do Octopus anyway.  Suppose you are
merging lt/rev-list and fk/blame branches into master, starting
from this state:

    ! [master] GIT-VERSION-GEN: squelch unneed
     ! [lt/rev-list] setup_revisions(): handle
      ! [fk/blame] git-blame, take 2
    ---
     +  [lt/rev-list] setup_revisions(): handl
     +  [lt/rev-list^] git-log (internal): mor
     +  [lt/rev-list~2] git-log (internal): ad
      + [fk/blame] git-blame, take 2
      - [fk/blame^] Merge part of 'lt/rev-list
     ++ [lt/rev-list~3] Rip out merge-order an
     ++ [lt/rev-list~4] Tie it all together: "
     ++ [lt/rev-list~5] Introduce trivial new 
     ++ [lt/rev-list~6] git-rev-list libificat
     ++ [lt/rev-list~7] Splitting rev-list int
     ++ [lt/rev-list~8] rev-list split: minimu
     ++ [lt/rev-list~9] First cut at libifying
      + [fk/blame~2] Add git-blame, a tool for
    --- [lt/rev-list~10] Merge branch 'maint' 

And you had lt/rev-list branch first listed in FETCH_HEAD.  In
this particular example, lt/rev-list has only 3 commits on top
of common things, but if your max were 3 instead of 10, the
first round would actually show the tip 3 without showing any
common stuff, and then the next round to show fk/blame branch
would show only the remaining two, without ever showing the
common stuff, even though it _could_ say the latest of the
common stuff.

> The things it doesn't do:
>  - the old one had a limit of 20, the new one has a limit of 10 commits 
>    reported

Good change I would say, except for the above.

>  - the old one was tested, the new one is written by me.
>  - the old one honored the "merge.summary" git config option. The new one 
>    doesn't.

Easily rectifiable ;-).

>  - the old one did some formatting of the branch message that I don't 
>    follow because I'm not a perl user. The new one just takes the 
>    explanatory message for the branch merging as-is.

FETCH_HEAD has explanatory message in more or less "canonical"
form.  It has noise word "branch", and the current repository is
typically " of .".  These are removed by the code, so that you would
not have to see:

	Merge branch 'jc/delta' of .

Instead you would see:

	Merge 'jc/delta' into 'next'.

The last part, " into 'next'", is also missing from your
version.  I can distinguish a merge into 'master' (which does
not have " into 'master'") and other branches easily that way,
and I find it handy.

Other things the Perl code does are purely for Octopus support:
things like coalescing multiple branches taken from the same
repositories.  You would get something like:

	Merge 'lt/rev-list' and 'fk/blame' into 'next'.

	* lt/rev-list:
	  commit 1
          commit 2

	* fk/blame:
	  commit 3
	  commit 4

instead of (your version):

	Merge branch 'lt/rev-list' of .
	   * commit 1
           * commit 2

	Merge branch 'fk/blame' of .
	   * commit 3
           * commit 4
