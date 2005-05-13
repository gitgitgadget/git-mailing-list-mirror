From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Fri, 13 May 2005 16:59:36 -0700
Message-ID: <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org>
	<20050513224529.GF32232@pasky.ji.cz>
	<7vhdh691gs.fsf@assigned-by-dhcp.cox.net>
	<20050513233354.GK32232@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 02:01:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWk5O-0001vB-Kd
	for gcvg-git@gmane.org; Sat, 14 May 2005 02:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbVENAAb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 20:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262625AbVENAAb
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 20:00:31 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:8096 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262621AbVEMX76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2005 19:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050513235938.HCXS7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 May 2005 19:59:38 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050513233354.GK32232@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 14 May 2005 01:33:54 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Sat, May 14, 2005 at 12:59:31AM CEST, I got a letter
PB> where Junio C Hamano <junkio@cox.net> told me that...
>> Created: t/t2000-diff.sh (mode:100755)
>> +Mode changed: path0 (100644->100755)

PB> Great, so it's even worse than before. :/

Depends on the definition of "before".  At the beginning, we did
not do anything special and always said l/foo k/foo even when
create/delete was involved.  Then we did a misguided attempt to
minimally be cg-diff compatible, which Linus complained that it
was too distracting for human consumption.  The current one is
something in between, a lot more human side.

Yes, it is off course worse than the minimally cg-diff
compatible one, from cg-patch'es point of view.

You have seen what the current "something in between" does.
What I think is that in order not to distract human (read:
Linus) who reads patches, they should not share the same special
characters like "@".  Which unfortunately completely contradicts
what you are attempting to do.  Another thing we did while you
were looking other way ;-) was that we say mode changed only
when things change, so in that sense it is "inconsistent" from
the scripting point of view.  These were all done to make the
output more readable by and less distracting for humans, per
request from Linus.

I do not think nobody uses that current textual "comment"
information in automated tools (I do not), so changing them
should not be a problem.  How about we do something like this:

  1. Invent an environment variable you can define.  Let's say
     GIT_DIFF_SHOW_MODES.  It could alternatively a flag you
     pass from git-diff-{files,cache,tree,tree-helper} to the
     internal diff engine but then you need to add the necessary
     command line parameter for all these commands.  I can be
     persuaded in either way.

  2. When it is defined, we are not interested in pleasing Linus
     by trying not to be distracting.  We are more interested in
     producing patch that is easily script processible.

  3. Keep the current behaviour for human comsumption when we
     are operating without the option we define in 1.

  4. Change the mode stuff when GIT_DIFF_SHOW_MODES is defined.
     It would produce one of the following for _all_ entries;

     @. (100644->100755) path/to/a/file/that/changed/mode
     @. (100644->120000) path/to/a/file/that/changed/to/symlink
     @. (100644->100644) path/to/a/file/with/no/mode/change
     @. (.->100644) path/to/a/new/file
     @. (100644->.) path/to/a/deleted/file

     I have to stress that these would come immediately before
     the patch for each file.  Not upfront, not grouped together
     at the beginning.

BTW, what do you think about renaming git-diff-tree-helper to
just git-diff-helper?  It used to be for grokking diff-tree's
output but now the family have the same raw output format it
does not make much sense to keep "tree" in its name.

