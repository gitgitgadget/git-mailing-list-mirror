From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 10:58:32 -0800
Message-ID: <7vwt4jzrjb.fsf@assigned-by-dhcp.cox.net>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net>
	<86k60jsvh8.fsf@blue.stonehenge.com>
	<86fyb7sv9f.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 19:58:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxpbK-0004iK-DV
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 19:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbWLVS6f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 13:58:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbWLVS6e
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 13:58:34 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:61792 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbWLVS6e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 13:58:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222185833.QFTG15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 13:58:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1uxq1W00R1kojtg0000000; Fri, 22 Dec 2006 13:57:51 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86fyb7sv9f.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "22 Dec 2006 09:19:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35195>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Randal" == Randal L Schwartz <merlyn@stonehenge.com> writes:
>>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> Junio> git-pull: refuse default merge without branch.*.merge
>
> Randal> Argh.  How do I get back the old behavior?
> Randal> "git-pull origin" doesn't seem to be enough.
>
> Randal> You just broke a bunch of automated scripts for me.
>
> Ahh, it's "git-pull . origin".
>
> Maybe a bit more warning for non-upward-compatible changes though, please.
>
> Or maybe we should presume everything is non-upward compatible?  I didn't
> think a naked "git-pull" was that out of the ordinary.

Things are supposed to be upward compatible, but this round
until v1.5.0 some things may not be when it is justifiably an
improvement.  For example, we've already made 'separate remote'
not only the default but the only layout 'git clone' produces.
I cannot think of others offhand, but I am reasonably certain
there are others.  We need a "incompatible changes" list.

The tradtional "pull always merges the first set of branches"
rule, although I was actually very much in favor of it, was
something that was hated by everybody.

It was said that people had lot of trouble after doing "git pull
origin" without any refspecs ("git pull" without any argument
defaults to 'origin' which is backward compatible, if you do not
have branch.*.remote, so that form has the same issues), when on
a branch other than the 'master' branch.  "merges the same first
set of branches no matter which branch you are on" was the rule,
but people did not want to merge the ones they usually merge to
their 'master' but wanted some other branch merged.
"branch.*.merge" can be used to specify this, but if you do not
have need for this "merge different branches depending on which
branch I am on", you do not have to use it.  Without
"branch.*.merge" for the current branch, we are still backward
compatible and follow the "first set of branches" rule.

The real trouble is that some people further argued that pulling
without 'branch.*.merge' when you might not want to follow the
"first set of branches" rule might be a newbie mistake and
should be warned and forbidden.  The commit that broke you was
an attempt for that behaviour.  I think that newbie protection
intent is good, but the execution was obviously not.

What I have on 'master' has a little fixup to use 'first set of
branches' rule when the fetch gets only one branch without
complaining.  I am still not happy with that either, and at this
point I am not sure if there is a good compromise that does not
break existing setup while offering the newbie protection.

Possibilities:

 (1) Forget about that "protection" business.  If you do not
     want mistakes, use 'branch.*.merge' but otherwise we will
     continue to follow the good old "first set of branches"
     rule.

 (2) A slight variant of the above; do the "protection" only
     when 'branch.*.merge' is defined for _any_ of the branches,
     not just the current branch.

 (3) A further variant; do not do the above "protection" if the
     current branch is 'master' (this further makes 'master'
     special, which some people may hate).
