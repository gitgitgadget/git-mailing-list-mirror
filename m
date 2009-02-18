From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there a way to exclude user-specified files or directories
 from  participating in merges?
Date: Tue, 17 Feb 2009 17:36:17 -0800
Message-ID: <7vmyck1q7i.fsf@gitster.siamese.dyndns.org>
References: <e38bce640902171649g765275a4n4e86d1d4f4aaf394@mail.gmail.com>
 <7v1vtw367w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 02:37:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbNq-0002zg-1a
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 02:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbZBRBgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752652AbZBRBgY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:36:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63620 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560AbZBRBgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:36:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B2712B5CC;
	Tue, 17 Feb 2009 20:36:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1D7132B5C9; Tue,
 17 Feb 2009 20:36:18 -0500 (EST)
In-Reply-To: <7v1vtw367w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 17 Feb 2009 17:05:07 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8C2DAEE0-FD5C-11DD-B4D6-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110491>

Junio C Hamano <gitster@pobox.com> writes:

> Brent Goodrick <bgoodr@gmail.com> writes:
>
>> Suppose I create a git repo called central.git on a machine I will
>> call "central". In that central.git repo, I put these files:
>>
>>   work.sh
>>   home.sh
>>   generic.sh
>>
>> When I clone the central.git repo on to a different machine I will
>> call "work", I want this fileset to be pulled:
>>
>>   work.sh
>>   generic.sh
>>
>> But not the home.sh file.
>
> You would have one common branch and one branch per deployment.
>
> A common branch would host only common files (e.g. generic.sh file from
> your example).  Per deployment branch, e.g. home, would branch from the
> common branch (so it starts with some version of generic.sh) and may add
> its own private files (e.g. home.sh).
>
> And stick to the following two rules:
>
>  - You make edits to common files only on the common branch.
>  - You merge from common to deployment, never the other way.
>
> So at work, you would have a checkout of your work "deployment branch",
> and find needs to change things.  It is Ok to edit both work.sh and
> generic.sh (without being able to edit both, it would be hard to verify if
> the changes would work together) at this time, but don't commit the result
> in the work branch.
>
> Save the changes to work.sh away (e.g. "git diff work.sh >P.diff" and then
> "git checkout HEAD work.sh"), switch to the common branch, and commit the
> changes to the generic file.  Switch back to the deployment branch, merge
> the common branch (to pick up the changes to home.sh), reapply the changes
> specific to the deployment you saved earlier (e.g. "git apply P.diff"),
> tne commit the result.

By the way, earlier in a different thread, somebody wondered if being able
to make a commit on detached HEAD is a good thing, and this is a good
example of why it is convenient.  When I use the above "one-way merge,
never merging back" workflow in real life [*1*], I do not use a simple
"git diff work.sh >P.diff && git checkout HEAD work.sh" to save away the
tentative changes I made and verified on the deployment branch.  The above
is an oversimplified example.

For one, in real life projects, there are many files that are specific to
individual deployments, and for another, distinction between generic vs
deployment specific changes does not cleanly appear at file boundaries.

Instead, I would make a real commit, with full intention of discarding it
later.

                  T work
                 /
         ...o---o
               / 
       ...o---o common

I would go back to common branch ("git checkout common"), cherry-pick the
commit from the deployment branch ("git cherry-pick --no-commit work").
This would conflict heavily because the common branch does not have any
changes specific to the deployment branch (i.e. files that were modified
since the deployment forked from the generic, and files the deployment
added).  That is Ok.  I would use "git add -i" and editor to sift out the
deployment specific parts to discard, and commit only the parts of the
change T made that are truly generic:

                  T work
                 /
         ...o---o
               / 
       ...o---o---A common

Then I would go back to the deployment, and detach the head at commit
before the tentative commit T.  From here, I can merge the common branch
in.

                  T work
                 /
         ...o---o HEAD
               / 
       ...o---o---A common

"git merge common" would make something like this:

                  T work
                 /
         ...o---o---B HEAD
               /   /
       ...o---o---A common

I know that the remainder of the change (i.e. difference between B and T)
should be the parts that are specific to the deployment.  After reading
through the output of "git diff HEAD work" to make sure that it has all
deployment specific changes I made (and nothing that should have been in
the commit A on common), I would:

	git read-tree -m -u work && git commit

to grow the history of detached HEAD.

                  T work
                 /
         ...o---o---B---C HEAD
               /   /
       ...o---o---A common

After this step, just wrap it up with:

	git branch -f work && git checkout work

to reach the final state:

                  T
                 /
         ...o---o---B---C work
               /   /
       ...o---o---A common

The tentative commit T becomes dangling but we know "diff T C" are empty
and records the good state we verified when we made T.

This is one case I still use the plumbing "read-tree -m -u".


[Footnote]

*1* http://gitster.livejournal.com/26540.html
