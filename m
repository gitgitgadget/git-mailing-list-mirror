From: sean <seanlkml@sympatico.ca>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 23:51:03 -0500
Message-ID: <BAYC1-PASMTP01A07DAA61F181E9D9679EAE260@CEZ.ICE>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	<7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:55:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGyN-0004fT-66
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964879AbWAMEzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:55:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964878AbWAMEzb
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:55:31 -0500
Received: from bayc1-pasmtp01.bayc1.hotmail.com ([65.54.191.161]:13359 "EHLO
	BAYC1-PASMTP01.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S964879AbWAMEza (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:55:30 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP01.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 12 Jan 2006 20:55:25 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 7E20E644C23;
	Thu, 12 Jan 2006 23:55:24 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Message-Id: <20060112235103.42665813.seanlkml@sympatico.ca>
In-Reply-To: <7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 13 Jan 2006 04:55:25.0853 (UTC) FILETIME=[914CC4D0:01C617FD]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 12 Jan 2006 20:35:54 -0800
Junio C Hamano <junkio@cox.net> wrote:

> You are obviously not talking about the use of "git commit" as a
> building block of some script (if you were, it would not make an
> iota of difference whether it is a command line option, an extra
> "echo From: $name" prepending that to the body of the message,
> or setting GIT_AUTHOR_* variables).

Correct.  Although, even as a building block script this might
be a nice little touch; as you mentioned it might be able to 
simplify the git-am script.
 
> So you must be talking about some manual process, at the end of
> which the user invokes "git commit" from the command line.

Yes, and in truth I only have a vague notion of his process.
 
> But I would imagine that "git commit" is preceded by a bigger
> process of preparing the tree to the committable state out of
> what is stored in the foreign SCM, after the user figures out
> which commit to pick from (in the original example; the
> committable state may come from something other than SCM ---
> e.g. set of tarballs or patch application or random monkey
> typing).  And the whole process of "preparing the tree" and
> "committing" would be done number of times (otherwise we would
> not be having this discussion --- just use GIT_AUTHOR_* which is
> already available), so having to set them as separate steps
> between 'preparing the tree' and 'committing using "git commit"'
> is cumbersome.

Agreed, except even in the one-off case I think being able to set
the author info on the command line would be better.   The GIT_AUTHOR_*
variables only really make sense for defaults, and even that is better
handled with .git/config nowadays.

> 
> But you would write 'preparing the tree' (which may include
> "figuring out who the author is and what the log has to say" if
> the committable state is coming from a foreign SCM) script
> anyway, and I simply do not understand why inserting a couple of
> setting and exporting of GIT_AUTHOR_* variables at the very end
> of that script before calling "git commit" from it, to make it
> not just a 'preparing the tree' script but 'prepare the tree and
> commit' script is such a big deal for you.

Hmmm.. we've already agreed that if there is a script to prepare
the tree then this is a non-issue.   We're only talking when
everything is done from the command line.   In fact, i'm suggesting
that if you offer this on the command line (or From: line) that fewer
scripts would need to be hacked together by git users for some simple
cases.

> If the committable state does not come from foreign SCM, then
> 'preparing tree' stage may only be able to prepare a committable
> tree, and log and authorship information might need to be
> typed/pasted by the user.  But then your script would just do
> "read author" or "${VISUAL-vi} .msgfile" before eventually
> calling 'GIT_AUTHOR_NAME="$author" git commit -F .msgfile' from
> there, so I do not think it is such a big deal either.

Yes, this is almost what I emailed to the gentleman in the first place,
but as you noted there is more than just one variable to set so you can't
do it that way.. you end up having to:

$ export GIT_AUTHOR_NAME="$author"
$ GIT_AUTHOR_EMAIL="$email" git commit -F .msgfile

Which is cumbersome and also ends up destroying your defaults if you happen
to use that method, so afterward you have to unset them or reset them back
to your own author info.   If git handled a GIT_AUTHOR_COMBINED or some such
where you could give the name and email together in one variable which 
would be parsed, then that suggestion would be slightly more palatable
but still seems more obtuse than either just accepting it on the command
line or via a From: line.
 
> I guess the disagreement is primarily coming from that you think
> "git commit" is always the uppermost UI layer, while I feel "git
> commit" is _one_ possible building block of bigger scripts, but
> the true building block is "git commit-tree".
> 

Yes, I think you nailed it here.   I do see git-commit as a end-user script
rather than just a building block.

Sean
