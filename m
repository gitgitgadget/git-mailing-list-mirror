From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trouble testing out a patch on a branch new scratch git.git 
 repository
Date: Sun, 08 Feb 2009 13:46:02 -0800
Message-ID: <7vy6wgwqjp.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 22:47:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWHV5-0001bU-Bl
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 22:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbZBHVqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 16:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbZBHVqL
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 16:46:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32814 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbZBHVqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 16:46:09 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 398F598A8D;
	Sun,  8 Feb 2009 16:46:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E408E98A8C; Sun,
  8 Feb 2009 16:46:04 -0500 (EST)
In-Reply-To: <e38bce640902081256j3cd84aadn2f0cc863cfca904d@mail.gmail.com>
 (Brent Goodrick's message of "Sun, 8 Feb 2009 12:56:48 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E4B43604-F629-11DD-BB30-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109017>

Brent Goodrick <bgoodr@gmail.com> writes:

> So, here is what I think happened in my repo:
>
> 1. A while ago, I made some changes and began testing them out.
> 2. I committed the change into the first commit (see
> e802880bb89524b1f70132f1ca0716624788db3f below)
> 3. Unfortunately, I then stumbled across the coding guidelines, and
> then discovered that my if statements had too many curly braces, and
> fixed that with another commit (but I doubt that is the problem here)
> 4. I did a git pull origin and found a conflict in a file I had
> changed in the first commit above into cache.h (I had inserted a line
> right where someone else had inserted a line). I probably should have
> stopped right then and there and not gone ahead with the merge, but do
> something different (but if so, then what should I have done instead?)
> :)

Your work is about adding this new feature.  Use a topic branch.

Now what is that topic branch is for?  Yes, it is about adding this new
feature, and nothing else.  Don't pull other people's changes made on my
tree into it.  That will make your topic branch "one new feature and
everything else" and useless as a topic branch.

What would make your life easier would be:

	$ git pull ;# to get up to date with me on your master branch
        $ git checkout -b bg/no-progress origin/master
        ... work on e802880 ...
	... test it ...
        $ git commit ;# record that on bg/no-progress topic

        $ git checkout master
        $ git merge bg/no-progress
        ... test the result of the merge ...

        $ git checkout bg/no-progress
        ... work on style fix ...
        ... test it ...
        $ git commit ;# again record it on bg/no-progress topic
                        
        $ git checkout master
        $ git merge bg/no-progress
        ... test the result of the merge ...

        $ git pull ;# to get up to date with me
        ... resolve conflicts ...

Then after you are convinced that everything on bg/no-progress is worthy
of sending to the list [*A*], but its tip is stale because things have
progressed on my end, you can do this:

	$ git checkout bg/no-progress
        $ git rebase origin/master	;# and rebase to the upstream
        
which may conflict again (but that would be the same conflict you saw with
your "git pull" from me, and rerere may remember it).

Review and test the result and then:

	$ git format-patch origin/master

There can be variants in the last few steps.  For example, your commits on
bg/no-progress may be full of "Oops, this is to fix my own mistake made in
earlier commits since I forked from the upstream".  You would not want to
have them in your submission (instead, you would want to pretend as if you
never made these mistakes in the first place).  For that, you may want to
do, after you feel the tip of bg/no-progress is in a good shape at point
*A* above:

	$ git checkout bg/no-progress
        $ git rebase -i origin/master	;# and rebase to the upstream
        
and reorder, squash, and fix them.

Also you may feel that at point [*A*] what you have is very precious and
you would not want yourself breaking it by the final rebase (which is a
very reasonable thing to feel).  In such a case, the final rewrite could
be:

	$ git checkout bg/no-progress^0
        $ git rebase -i origin/master	;# and rebase to the upstream
	... test and review the result.
        ... convince yourself it is indeed better than
        ... what you earlier thought to be "very precious".
        ... and then finally
	$ git branch -f bg/no-progress
	$ git format-patch origin/master ;# send this

And to finish it off, you may do:

	$ git checkout master
        $ git merge --ours bg/no-progress

The above is a suggestion based on a design to allow you keep sticking to
your merge based workflow as much as possible, but you could instead
choose to keep rebasing.  I have some observations at the end of

    http://gitster.livejournal.com/24080.html

comparing the merge based workflow and the rebase based one.
