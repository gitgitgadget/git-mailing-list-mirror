From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 01:55:45 -0800
Message-ID: <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
	<43EB05B5.20307@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sean <seanlkml@sympatico.ca>, Ryan Anderson <ryan@michonline.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 10:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F78Wm-0002LN-6m
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 10:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWBIJzt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 04:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030541AbWBIJzt
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 04:55:49 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:47018 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030523AbWBIJzt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 04:55:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209095552.UVHU25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 04:55:52 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43EB05B5.20307@op5.se> (Andreas Ericsson's message of "Thu, 09
	Feb 2006 10:04:53 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15798>

Andreas Ericsson <ae@op5.se> writes:

> sean wrote:
>> I've always followed it okay by just using "git branch -d pu" each
>> time before pulling from you.   Your "next" branch does sound like
>> an improvement though.
>
> I thought
>
> 	Pull: +pu:pu
>
> was supposed to handle such things automatically. It has always pulled
> properly for me anyways.

Yes, fetching to look at is no problem, but what I wanted to
solve is that you cannot easily _touch_ it.  The point of this
is to make improving on top of what is still _not_ in master
easier for the contributors.

If you want to improve upon what is in the current "pu", the
natural thing for you to do would be:

	$ git fetch git://git.kernel.org/pub/scm/git/git +pu:pu
	$ git checkout -b my-pu pu ;# initial
        $ hack on it and git commit many times
        $ git format-patch --stdout pu..my-pu |
          git send-email --to junkio@cox.net --cc git@vger.kernel.org

(Side note: I do not know git-send-email would work like the
above, but if it did that might be handy.  Ryan?)

But sometimes you may take more time than how my "pu"
progresses, and you would want to sync your work to my updated
"pu".  A natural thing you would want to do is this:

        $ git pull git://git.kernel.org/pub/scm/git/git +pu:pu

Unfortunately, this would _not_ work very well, because by the
time you pull from my "pu" again, it would have rewound and
rebased.  You would end up seeing unnecessary merge conflicts.

Another possibility would be:

        $ git fetch git://git.kernel.org/pub/scm/git/git +pu:pu
        $ git rebase pu

This helps somewhat because "git rebase" uses "git cherry" to
detect the same patch with different commit ID in "pu" that you
already have in "my-pu".  But my topic branches have been
sometimes rewound and even rewritten to fix minor points (using
"reset --soft HEAD^" followed by "commit -a -c ORIG_HEAD"), and
when that happens "git rebase" would not be of much help.

The updated workflow on my part is trying to reduce these
problems by (1) not rewinding nor rebasing "next" and (2) not
rewinding nor rebasing the topic branches merged into "next".

Strictly speaking, the latter is not necessary (I would need to
resolve conflicts when merging the rewound/rebased topic
branches into "next", but after that is done, contributors who
pulled "next" do not have to deal with that, as long as "next"
itself is not rewound/rebased), but that way you could disect
component topic branches more easily out of "next".

For example, as of this writhing, my "master" and "next" look
like this:

    $ git show-branch --topo-order master next
    * [master] .gitignore git-rerere and config.mak
     ! [next] Merge branch 'jc/nostat'
    --
     - [next] Merge branch 'jc/nostat'
     + [next^2] "Assume unchanged" git: --really-refresh fix.
     - [next^] Merge branch 'jc/ls-files-o'
     + [next^^2] ls-files: honour per-directory ignore file ...
     - [next~2] Merge branches 'jc/nostat' and 'jc/empty-commit'
     + [next~2^3] t6000: fix a careless test library add-on.
     + [next~2^3^] Do not allow empty name or email.
     + [next^2^] ls-files: debugging aid for CE_VALID changes.
     + [next^2~2] "Assume unchanged" git: do not set CE_VALID...
     + [next^2~3] "Assume unchanged" git
    *+ [master] .gitignore git-rerere and config.mak

If you want to help fixing my thinko in jc/nostat branch, you
could:

	$ git checkout -b jc/nostat next^2
        $ fix fix fix; git commit

By convention, merge records what was the tip of the branch as
the first parent, and the second parent (and subsequent ones if
it is an Octopus) is the tip of the branch that was merged in,
so you can tell "next^2" is what was merged into the branch to
advance "next"; in other words, that is the tip of the jc/nostat
branch.  Similarly, you can tell the tip of jc/empty-commit was
merged to next~2 in an Octopus as the second merged-in branch,
so you can tell that its tip is next~2^3.

You could even publish your jc/nostat branch after you built on
it and tell me to pull from it to fix my stupidity.
