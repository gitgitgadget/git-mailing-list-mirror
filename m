From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 11:21:39 -0700
Message-ID: <7vd4pl713g.fsf@gitster.siamese.dyndns.org>
References: <47E64F71.3020204@jwatt.org> <47E668E1.80804@jwatt.org>
 <alpine.LSU.1.00.0803231534050.4353@racer.site>
 <200803231720.44320.johan@herland.net> <47E6923E.1050904@jwatt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Watt <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 19:22:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdUq6-0005wE-Kt
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 19:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074AbYCWSV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 14:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754027AbYCWSV5
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 14:21:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbYCWSV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 14:21:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 76D8D11CA;
	Sun, 23 Mar 2008 14:21:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5C0F411C9; Sun, 23 Mar 2008 14:21:46 -0400 (EDT)
In-Reply-To: <47E6923E.1050904@jwatt.org> (Jonathan Watt's message of "Sun,
 23 Mar 2008 18:24:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77934>

Jonathan Watt <jwatt@jwatt.org> writes:

> Johan Herland wrote:
>> I'm starting to think it's worth changing the default behaviour of push as follows:
>> 
>> Upon receiving a push into a non-bare repository, if the working copy is on the same branch as is being pushed, then refuse the push with a helpful message describing why the push was refused, and how to resolve this issue (i.e. referring to the tutorials you mention).
>> 
>> This would:
>> - Not clobber the working copy
>> - Tell newbies what happened and why
>> - Hopefully make this issue pop up less frequently
>> - Not affect you if you only push into bare repos
>> - Not affect you if you take care to never push into a checked-out branch
>
> The detach-HEAD idea does all these things, but rather:
>
> - There's no need to tell newbies anything
> - It don't just reduce the frequency of the problem, it eliminates it
>
> :-) Also,
>
> - You eliminate the problem of git thinking the working copy came from a
>   revision it didn't come from, and thus eliminate the "any commit will
>   now overwrite the push" problem
> - You can still write hooks to update the working copy if you like
> - It's completely intuitive to anyone coming from Mercurial (and it's these
>   people who are going to be doing the pushing into non-bare repositories,
>   because that's the workflow they're familiar with)

I am obviously sympathetic to people who are in the detox program from
Mercurial poisoning ;-), but seriously, I have to wonder if the detached
HEAD is the other way around from what merc does?

My understanding is if you push into a non-bare tree in merc, they make
the branch head into "unmerged" state, and as far as the work tree is
concerned you are still on the previous commit, and you merge "the other
commit" that was pushed into from sideways to update the branch tip with
pushed-into commit.

In git, if you detach HEAD when you push into a checked-out 'master', your
work tree won't be associated with 'master' anymore, and to merge the
pushed-into state into the history of 'master', you would need:

	# push into 'master' from elsewhere, which by your magic detaches
        # the HEAD in the pushed-into repository.
	elsewhere$ git push $non_bare_repo master

	# merge pushed-into change into old 'master' where your work tree
        # started from by merging master into detached HEAD.  Somehow you
        # need to know you were on master to be able to do this.  Also
        # because you magically detached HEAD, anything else you do after
        # such a push from sideways in this repository are not protected
        # by reflog for 'master' but only by reflog for 'HEAD'.
	here$ git merge master

	# update the master with the result of the merge
	here$ git push . HEAD:master

        # check out master again to get back to your original state.
        here$ git checkout master

The second point bothers me quite a lot, as you are assuming that the
user at the repository that was pushed into does _not_ know what is going
on, and may keep working on a detached HEAD _without knowing_ what is
going on.

There is an alternative, though.

Git does not use merc style "a single branch can have unmerged multiple
heads" paradigm, but it can be implemented more explicitly (look for
"mothership satellite" in the FAQ you were referred to earlier).

People in the Mercurial detox program may want to use the pattern of
pushing into acceptance branch and then merging from it when it is
convenient, like this:

	# push from sideways go to 'remotes/origin/master', and never to
        # 'master'.  Your 'master' that was checked out is not molested
        # by this push.
	elsewhere$ git push $non_bare_repo master:refs/remotes/origin/master

	# you can keep working on what you were doing without getting
	# molested by the above push.
	here$ hack, hack, commit, commit, all still on 'master'

        # when you are done with the work you were doing in the pushed-into
        # tree, and notice somebody pushed into your acceptance branch,
        # you can _choose to_ merge it in.
	here$ git merge remotes/origin/master
