From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 20:35:54 -0800
Message-ID: <7vzmm0eod1.fsf@assigned-by-dhcp.cox.net>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE>
	<7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP102ED7B30D2B48BEE601F5AE260@CEZ.ICE>
	<7v4q48hizr.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 05:36:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExGfR-0000x9-8K
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 05:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWAMEf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 23:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWAMEf6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 23:35:58 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52643 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751320AbWAMEf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 23:35:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113043600.FCJF25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 Jan 2006 23:36:00 -0500
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP067B249A8110916F036FB3AE260@CEZ.ICE>
	(seanlkml@sympatico.ca's message of "Thu, 12 Jan 2006 23:06:33 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14613>

sean <seanlkml@sympatico.ca> writes:

> I think you're over estimating the downsides of allowing this to be
> set the same was as it is in the git-am case and underestimating the
> number of people who would find it useful, but I personally don't 
> really care if you'd rather have it as a command line option.

You are obviously not talking about the use of "git commit" as a
building block of some script (if you were, it would not make an
iota of difference whether it is a command line option, an extra
"echo From: $name" prepending that to the body of the message,
or setting GIT_AUTHOR_* variables).

So you must be talking about some manual process, at the end of
which the user invokes "git commit" from the command line.

But I would imagine that "git commit" is preceded by a bigger
process of preparing the tree to the committable state out of
what is stored in the foreign SCM, after the user figures out
which commit to pick from (in the original example; the
committable state may come from something other than SCM ---
e.g. set of tarballs or patch application or random monkey
typing).  And the whole process of "preparing the tree" and
"committing" would be done number of times (otherwise we would
not be having this discussion --- just use GIT_AUTHOR_* which is
already available), so having to set them as separate steps
between 'preparing the tree' and 'committing using "git commit"'
is cumbersome.

But you would write 'preparing the tree' (which may include
"figuring out who the author is and what the log has to say" if
the committable state is coming from a foreign SCM) script
anyway, and I simply do not understand why inserting a couple of
setting and exporting of GIT_AUTHOR_* variables at the very end
of that script before calling "git commit" from it, to make it
not just a 'preparing the tree' script but 'prepare the tree and
commit' script is such a big deal for you.

If the committable state does not come from foreign SCM, then
'preparing tree' stage may only be able to prepare a committable
tree, and log and authorship information might need to be
typed/pasted by the user.  But then your script would just do
"read author" or "${VISUAL-vi} .msgfile" before eventually
calling 'GIT_AUTHOR_NAME="$author" git commit -F .msgfile' from
there, so I do not think it is such a big deal either.

I guess the disagreement is primarily coming from that you think
"git commit" is always the uppermost UI layer, while I feel "git
commit" is _one_ possible building block of bigger scripts, but
the true building block is "git commit-tree".
