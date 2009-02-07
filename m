From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Fri, 06 Feb 2009 16:21:56 -0800
Message-ID: <7veiyb14gr.fsf@gitster.siamese.dyndns.org>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
 <57518fd10902060641pa789ffbjceccbf013864e0a5@mail.gmail.com>
 <7vocxf5ufu.fsf@gitster.siamese.dyndns.org>
 <57518fd10902061108k6a7691c5r13b2782baf3bfde3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 01:23:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVayr-0003by-Mb
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 01:23:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715AbZBGAWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 19:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZBGAWH
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 19:22:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbZBGAWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 19:22:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0CBAD2A977;
	Fri,  6 Feb 2009 19:22:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CB9F02A976; Fri, 
 6 Feb 2009 19:21:57 -0500 (EST)
In-Reply-To: <57518fd10902061108k6a7691c5r13b2782baf3bfde3@mail.gmail.com>
 (Jonathan del Strother's message of "Fri, 6 Feb 2009 19:08:47 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56984572-F4AD-11DD-AAC3-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108801>

Jonathan del Strother <maillist@steelskies.com> writes:

> On Fri, Feb 6, 2009 at 5:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan del Strother <maillist@steelskies.com> writes:
>>
>>> On Fri, Feb 6, 2009 at 2:32 PM, Jonathan del Strother
>>> <jon.delStrother@bestbefore.tv> wrote:
>>>> Add a "Show changes" option to each prompt in mergetool. This prints the conflicted changes on the current file, using 'git log -p --merge <file>'
>>>
>>> Just discovered that this doesn't work so well when resolving merges
>>> resulting from "git stash apply" - it produces "fatal: --merge without
>>> MERGE_HEAD".  Should git-stash be setting MERGE_HEAD in this case,
>>
>> No no no, please absolutely don't.  MERGE_HEAD is an instruction to the
>> eventual commit to create a merge commit and use the commits recorded
>> there as other parents when it does so.  You do *NOT* want to end up with
>> a merge with random state after unstashing.  None among cherry-pick,
>> rebase, checkout -m (branch switching), nor am -3 should.
>>
>> I'd suggest making the new action conditionally available, by using the
>> presense of MERGE_HEAD as a cue.
>>
>> The thing is, these commands that can potentially end in conflict operate
>> only at the tree level, and not at the level of commit ancestry graph.
>> "log --merge" is all about following the commit ancestry graph, and for
>> conflicts left by these commands it is not a useful way to review.
>
> Maybe I'm misunderstanding the issue,...

There actually are two independent issues.  Sorry for being unclear.

My objection is about the issue (1) below.  I am pointing out (2) merely
as an issue you need to address if you were to invent a solution that does
not have the issue (1); it is not an objection.

(1) Writing MERGE_HEAD from "git stash apply" (or "git stash pop") is
    absolutely a wrong thing to do.

    Typically you use stash this way.

	... work work work, oops, got interrupted.
        $ git stash save
        ... do some unrelated work.
        ... perhaps switch branches, perhaps not, it does not matter.
        ... the important thing is you conclude this and result in
        ... a clean work tree state.
        $ git stash pop
        ... inspect and resolve issues, perhaps using git log or
        ... git diff or git mergetool
        ... continue to work refining what you were doing
        $ git commit

    Imagine what the last "git commit" does, IF your "stash pop" wrote
    any commit object name in MERGE_HEAD.  It will record the tree created
    from the index in a commit that is a merge between the current HEAD
    and whatever commit you wrote in MERGE_HEAD.  But you obviously did
    not want any merge --- you wanted a straight and honest single parent
    commit.

    It is Ok if your design is to come up with a marker that is different
    from MERGE_HEAD for "git stash pop" to tell "git log --merge" where
    the potential conflicts may be coming from, but using MERGE_HEAD as
    that marker is unacceptable for this reason.

(2) The set of commits on the left and right side of "git log --merge"
    is tied very closely to the topology over the three commits:

        $(git merge-base HEAD MERGE_HEAD), which is the base,
        HEAD, which is the right-hand side, and
        MERGE_HEAD, which is the left-hand side.

    During a normal merge resolution, "git log --merge $paths..." looks at
    the topology of this graph:

          x---x---MERGE_HEAD--??? merge result?
         /                   /
	MB---o---o---o---HEAD

    and it simply runs

	git log MERGE_HEAD...HEAD -- $paths

    Hence, x would appear on the left hand side and o on the right hand
    side in the resulting traversal (this makes difference especially if
    you did "git log --left-right --merge").

But "stash pop" and "cherry-pick" (they are the same thing) work on a
quite different topology.

If you stashed while on 'master' (whose tip is A), "git stash save" will
create commit S without moving the tip of 'master' (S is saved at the tip
of refs/stash):

      x---x---B topic
     /
    o---o---o---A master
                 .
                  ...S

When you unstash it on B, "git stash pop" does a three way merge between A
and S and B, but it does *not* use the usual ancestry topology.

It merges S on top of B as if A is the common ancestor (i.e. merge base).
If you actually commited S on the master and cherry-picked it on B,
exactly the same thing happens.

Because of the way the cherry-picking 3-way merge has to happen, the
"virtual ancestory chain" becomes like this:

                  *---*---*---x---x---B
                 /                     \
                A master                \ 
                 .                       \
                  ...S..................??? merge result?

where * are "anti-commits" that reverse the effects of the commits o in
the original history that lead to A [*2*].

First of all, "git log A...B -- $path" won't show the virtual topology
depicted above.  It will only show commits x and would ignore o, hence it
does not explain the conflicts at all [*1*].  You somehow need to devise a
way to pretend that the topology is like the above one to achieve an
output equivalent to "git log --merge" for a true merge situation.

It is not just the matter of "echo A >.git/MERGE_HEAD" (which is an
absolute no-no for totally unrelated reason, which is (1) above) to tell
"git log --merge" to pretend the topology is like the above when it does
its traversal.

"git log -p A...B -- $path" won't show them without such a change either,
but even if you somehow convinced the revision traversal to pretend the
three commits o before A should be shown, you also would need to teach it
to show them in reverse because they are now anti-commits.

As I said, the longer explanation of issue (2) in this message is not
meant as an objection.  I am explaining why "git log --merge [-p]" cannot
be used as-is for what you are trying to do.

My primary objection is "don't mess with MERGE_HEAD", which is the issue
(1) above.


[Footnote]

*1* you handwaved this issue away in your message saying that what you did
is not interesting, but I think that is a cop-out.  Why are we showing our
side when inspecting the history in a true merge situation if it is really
uninteresting?

*2* In addition, there is this little problem that you can cherry-pick
(and unstash) between disjoint histories, in which case there won't even
be such a virtual ancestry chain that I obtained by rotating the history a
bit in the above example.
