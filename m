From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two newbie question: "dead" branches and merging after cherry-pick.
Date: Fri, 27 Jan 2006 12:59:46 -0800
Message-ID: <7vlkx11j5p.fsf@assigned-by-dhcp.cox.net>
References: <20060127173619.GA26199@pern.dea.icai.upcomillas.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 21:59:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2ahJ-0006Nr-MX
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 21:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932498AbWA0U7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 15:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWA0U7t
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 15:59:49 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25799 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932498AbWA0U7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2006 15:59:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060127205850.GSEP3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 27 Jan 2006 15:58:50 -0500
To: Romano Giannetti <romano@dea.icai.upcomillas.es>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15187>

Romano Giannetti <romano@dea.icai.upcomillas.es> writes:

>         - I use to work on a topic branch to make test, try solutions for
>         bugs, etc. Say I am done with the branch "test-bill-idea". I decide
>         it's a dead branch, so that I do not want to see it in day-by-day
>         work (git branch, basically), but I do not want to loose it. ...

First let me make sure if I understand you correctly.

You are done with what you did in the branch for now, but you
have not merged the work to your day-to-day development "master"
for some reason.  In the meantime you would want to switch to
other topic branches to work on other topics, and while working
on them you do not want to "git branch" and "git show-branch" to
show the topic you are done with but not merged yet.  Later you
would want to come back to it to do some interesting stuff with
it (maybe finally merge into "master", or format-patch to send
upstream).  Is that what is happening here?

If so, I would have chosen "postponed" not "dead" to describe
the situation but you said "dead" and that is why I am wondering
if I am getting you correctly.

>         ... If I
>         delete the branch I will loose all its commit at the next prune,
>         correct? ...

Yes.  If you do not have anything under .git/refs pointing at
the tip of a development trail, that trail will be lost by the
next prune.  Even if you do not prune, it would be cumbersome to
find it.  "git lost-found" would find it for you but it still is
cumbersome.

>         ... There is a way to maintain it as a dead or hidden branch,
>         shown for example just by gitk --all? If I tag the tip of the
>         branch, and then delete .git/refs/head/test-bill-idea, will the
>         "dead branch commits" be preserved by next prune(s)? 

Yes.  You have the tag under .git/refs which points at the tip
of that postponed branch head, so the development trail will not
be lost.  When you are done with other topics and would want to
come back to that topic again, you could do this:

	$ git checkout -b test-bill-idea tag-bill-idea-postponed

Until recently I used to have "jc/link" topic branch to play
with "gitlink"-style subproject support suggested by Linus.  It
is not finished yet, and in the meantime I have suggested
another way to do subproject support, which I've been spending
more time on, in "jc/bind" topic branch.  I have not abandoned
"jc/link" topic completely, so I am not ready to do throw away
that branch with "git branch -D jc/link" yet, but at the same
time it clutters output from "git branch".  So I did exactly
what you outlined [*1*]:

	$ git tag hold/jc/gitlink jc/link ;# copy it to tags/
        $ git branch -D jc/link		  ;# delete it from heads/

Now "git branch" would not show it, but "gitk --all" still would.

>         - Easier: suppose I cheery-picked "abababab" from branch "testing"
>         to master branch. What will happen if later I decide to merge
>         all "testing" to master branch? I will have a merge conflict (trying
>         to apply two times the same fix) or not? 

This is easy to experiment so I'd suggest you to try it and tell
us what you see, like this:

	$ git checkout -b test-merge-throwaway master
        $ git cherry-pick abababab
        $ ... play with it, maybe making a couple of commits
        $ git pull . testing

I would not be surprised if this resolves cleanly. If abababab
is the only thing that touches the set of paths it touches,
other than what are in "testing" and what you did since
"testing" forked from "master", it is likely that the merge
would resolve cleanly.

Otherwise you would likely to see conflicts --- in which case
you may want to suggest if/how we can reduce it.  "cherry-pick"
without -r drops a hint of which commit was picked in the commit
log so it _might_ be a good idea to teach git to optionally take
that information into account while doing the merge.  I dunno.

Once you are done experimenting, you can come back to master and
delete the test-merge-throwaway branch:

	$ git checkout master
        $ git branch -D test-merge-throwaway


[Footnote]

*1* As my personal convention, each of my topic branches is
named with two-letter name, '/', and a short topic word, and
postponed tags have names starting with "hold/".  Sticking to a
convention makes it easy for me to do things like this:

	$ git show-branch --topo-order master "heads/??/*"
