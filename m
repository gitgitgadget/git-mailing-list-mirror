From: Junio C Hamano <gitster@pobox.com>
Subject: Re: keeping track of where a patch begins
Date: Wed, 21 Oct 2009 13:03:55 -0700
Message-ID: <7veiow4iqc.fsf@alter.siamese.dyndns.org>
References: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
 <alpine.LFD.2.00.0910211402490.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: E R <pc88mxer@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 22:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0hPt-0005CP-8i
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 22:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbZJUUEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 16:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753047AbZJUUEG
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 16:04:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbZJUUEF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 16:04:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C98FC80433;
	Wed, 21 Oct 2009 16:04:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sL1eSJNM6pE28FOpOYInwQf7nX4=; b=CL+LkQ
	8TDnVXih9wZBcJvvyPUj0j9THhFAsK/IWS63x9MBsSqr+hYaWnwlgKw4xv22O05u
	kd69miqpjhbn6bacuV8cVC/X9xwzdtvK0v/OiTWfRN+ZddxNym+JH8derdXQHRWF
	klfI7rdhq3WDYQ89k2bFlrog7IWI5C8Q/ZLgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y6VEkrYLlzieyZ8HT5OyeOPF5UYHLxKw
	RCrf63M7pvBskxujySdzAlVzkQUp3JsePd2+/vvMLuvWnWq59X7vJBaJ9x5VpLLk
	DY+VLejeLl5Mo+X3afs40N43f6vjtuzt+FVPVXJMq1LDWKBqIp7oU70xEoCGYK74
	6seWSunVT58=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93CEF80431;
	Wed, 21 Oct 2009 16:04:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8029B8042B; Wed, 21 Oct 2009
 16:03:57 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910211402490.21460@xanadu.home> (Nicolas
 Pitre's message of "Wed\, 21 Oct 2009 14\:14\:37 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E176D5E8-BE7C-11DE-AFB9-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130956>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Wed, 21 Oct 2009, E R wrote:
>
>> What solutions have you come up with to either to catch or prevent
>> this from happening? It is possible to determine what node a branch
>> started from?
>
> This can be determined by looking at the gitk output.
>
> Also 'git merge-base' can give you that node, given the main branch and 
> the topic branch.  See documentation about git-merge-base.
>
> Then if you need to move a branch to another starting node, then 'git 
> rebase' is what you need (again the git-rebase documentation is pretty 
> detailed).

That is a correct way to diagnose the mistake and recover from it, but
unfortunately it is a rather weak tool to identify the mistake in the
first place.

A branch in git, as Randal often used to say on #git, is an illusion---it
points only at the top and does not identify the bottom.

But it does _not_ have to stay that way at the Porcelain level.

Here is a rough sketch of one possible solution.  It is not fully thought
out; the basic idea is probably sound but I did not try to exhaustively
cover changes to various tools that are necessary to maintain the
invariants this scheme requires.

 (0) Define a way to identify the bottom of a branch.  One way to do this
     is by an extra ref (e.g. refs/branchpoints/frotz).  Then the commits
     between refs/branchpoints/frotz..refs/heads/frotz identifies the
     commits on the branch.  None of the additional restrictions below
     applies when the branch does not have such bottom defined (i.e.
     created by the current git without this extension).

 (1) At branch creation, the branchpoint is noted.  E.g.

     $ git branch frotz master~4

     would internally become

     $ git update-ref refs/heads/frotz master~4
     $ git update-ref refs/branchpoints/frotz master~4

     You would also need to cover "checkout -b".

 (2) You can grow the branch naturally with "commit", "am" and "merge".
     The bottom of the branch does not have to move with these operations.

 (3) Operations that alter histories, e.g. "commit --amend", "rebase",
     "reset", while on a branch that records its bottom need to be taught
     to pay attention to not break its bottom.  Paying attention needs to
     take different forms depending on the operation; some probably will
     forbid the operation while others would automatically adjust the
     bottom.

     Examples (not exhaustive):

 (3-a) "branch -f frotz $commit"

     This moves the tip of the branch.  Unless $commit is already some
     part of the existing frotz branch, we should probably forbid it for
     simplicity, when a bottom is defined for the branch.

     We could later loosen the rule so that $commit is only required to be
     a descendant of existing bottom of the branch to support a workflow
     like this:

     $ git checkout -b frotz master~4 ;# records branchpoint
     $ edit; git add; git commit; ... ;# builds history
     $ git checkout HEAD^             ;# go back somewhere on frotz
     $ edit; git add; git commit; ... ;# builds an alternate history
     $ git show-branch HEAD frotz     ;# check progress
     $ git diff frotz HEAD            ;# is this one better?
     $ git branch -f frotz            ;# I prefer this new one better

 (3-b) "reset $commit" (with or without --hard/--soft/--mixed)

     This is similar to (3-a) above; $commit has to be a descendant of
     existing bottom.

 (3-c) "commit --amend"

     $ git checkout -b frotz master~4 ;# records branchpoint
     $ git commit --amend             ;# rewrite the bottom???

     would probably be a mistake, as the end result would make the frotz
     branch forked from master~5 with the first commit on the branch a
     fix-up to what is already in the master branch.

     However, this is a valid way to work:

     $ git checkout -b frotz master~4 ;# records branchpoint
     $ edit; git add; git commit      ;# builds history
     $ git commit --amend             ;# fix the tip

     and it does not have to do anything to the bottom.

 (3-d) "rebase"

     $ git checkout -b frotz master~4 ;# records branchpoint
     $ edit; git add; git commit; ... ;# builds history
     $ git rebase --onto master       ;# transplants the branch

     would make the "onto" commit the new bottom.  Another interesting
     thing to note is that we do not have to compute which commits to
     transplant with merge-base with the "onto" commit, because we know
     the bottom commit of the branch.

 (4) Operations that browse histories, e.g. "log", "show-branch", while on
     a branch that records its bottom can be taught to pay attention to
     the bottom.  For example, it is conceivable that

     $ git log
     $ git log -- Documentation/

     without an explicit branch name that fell back to the default HEAD
     while on branch "frotz" might be better run with an implicit bottom
     ^refs/branchpoint/frotz.

We probably could kill the other bird in the nearby thread that wants to
add a description to a branch, if this scheme is fully implemented (no, I
am not going to start coding right away, as this message is just a sketch
of what we _could_ do), As we will fully know in what operations we need
to update the branchpoint ref, we could make the refs/branchpoints/frotz
an annotated tag, and store the description for the branch in that tag.
Whenever we need to adjust the branchpoint, we update it while carrying
the branch description message over to the new tag object.
