From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More Beginning Git Questions
Date: Fri, 23 Sep 2011 11:47:39 -0700
Message-ID: <7vipojumd0.fsf@alter.siamese.dyndns.org>
References: <4E7C9AAD.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 20:47:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7Amq-0006p0-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 20:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102Ab1IWSrp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 14:47:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39708 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736Ab1IWSro (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 14:47:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26CE26CD5;
	Fri, 23 Sep 2011 14:47:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oHNsOUibHnFmeAAqr4nVXsiGX4M=; b=t1fleI
	xcJ+FONfucZh686lHfg/B9HZkRKA3Z0LsN0HVDTEsJ4gFg3B9uWxpigy6PD5TfLN
	5cnIxpX8CzTS7ddhfBkVMP5frajomfM+kcRM4W30aked+joN1jJIzwvbTVWRmZuz
	5LiVQqG4bdg9/+2BQYw6mUIkczmvDnehRtNu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R7E58VfQhPCEc1cSlacqc1X3YYjuaJPI
	ALlLkATsSu8FAImPIr47REXdGkL6eCcMA7hjWchakb5GY8PKlJ4wCPivnQ2RZJup
	MYPEp8/EapE5csXmZBec15cljq+2ZrJHSK9bzZ9kBdyhQj7DR7F+fSYTPV+2Hfvz
	PoUM4DP35+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA976CD3;
	Fri, 23 Sep 2011 14:47:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 529726CD0; Fri, 23 Sep 2011
 14:47:41 -0400 (EDT)
In-Reply-To: <4E7C9AAD.7060209@gmail.com> (Jon Forrest's message of "Fri, 23
 Sep 2011 07:41:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 843DC2DA-E614-11E0-AD0E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181988>

Jon Forrest <nobozo@gmail.com> writes:

> "Note that in general, Alice would want her local changes committed
> before initiating this "pull"."
>
> This is an interesting statement. I'll come back to it shortly.
>
> "If Bob’s work conflicts with what Alice did since their histories forked,"
>
> Does this include both changes that Alice has checked in to her
> repository and uncommitted changes in her working tree?

We do not consider uncommitted changes part of _any_ history. You can
think of them as floating on top of the history of the branch that is
currently checked out [*1*].

> "Alice will use her working tree and the index to resolve conflicts,"
>
> How does Alice use her working tree and index? Does this mean
> she makes changes to her working tree so that the conflicts
> no longer exist? How does the index play a part in this?
>
> I thought that the index gets populated only when a
> "git add" is done. Does Alice need to do "git add" as part
> of the conflict resolution process?

If you start from a clean working tree (i.e. no local changes), then after
any "mergy" operation (not just "git pull" and "git merge" but things like
"cherry-pick", "checkout -m", "rebase" and "am -3" that can stop due to
conflicts), one of the three things will happen to each of the paths in
the project:

 1. If the result of the operation can be mechanically known, and if that
    is the same as your current state (i.e. HEAD or "ours"), nothing
    happens.

 2. If the result of the operation can be mechanically known, and if that
    is different from your current state (i.e. HEAD or "ours"), the index
    entry for that path records the result, and the path in the working
    tree is updated to match that result.

 3. If the result of the operation cannot be mechanically known
    (i.e. merge conflict), the index entry for that path will record up to
    3 "stages", stage #1 representing the contents the conflicting sides
    diverged from (i.e. common ancestor), stage #2 representing the
    contents of your current state (i.e. HEAD or "ours") and stage #3
    representing the contents of the other branch (i.e. MERGE_HEAD or
    "theirs"), and the path in the working tree is updated to represent it
    with conflict markers.

You conclude the "mergy" operation by resolving conflicts in the working
tree for paths in the category 3, tell Git that you are done with these
paths using "git add $path" (but paths in no other categories!!!).
Because cleanly merged paths are already updated in the index (see
2. above), that is all needed to bring the index to the state that
represents the desired result of the "mergy" operation.

Even if you have local changes in your working tree, as long as your index
exactly matches HEAD when you start your "mergy" operation, thanks to the
rule for "result matches the current HEAD" case (see 1. above), the result
of your "mergy" operation recorded by the procedure in the previous
paragraph will not be contaminated with your local changes.

The precondition for all of the above to work is that you start from a
clean index, and that is why "git merge" refuses to start if your index
already has changes relative to HEAD.

Also, for cases 2. and 3., updating the files in the working tree to match
the auto-merge result (case 2.) or to show the conflicted state (case 3.)
requires Git to overwrite the file, which is bad if you have local changes
to the files in the working tree. To prevent lossage, "mergy" operations
will notice if paths in categories 2. and 3. have local changes in the
working tree, and refuses to work if that is the case.


[Footnote]

*1* This incidentally is important to have in your mental model to
understand how to use "git checkout $branch" to switch branches.
