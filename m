From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Mon, 15 Apr 2013 08:16:26 -0700
Message-ID: <7vsj2rzuwl.fsf@alter.siamese.dyndns.org>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
 <1365887729-9630-4-git-send-email-artagnon@gmail.com>
 <7v8v4k2vm0.fsf@alter.siamese.dyndns.org>
 <CALkWK0mmrvYSjvUCvvjbnav4JmbkVKho2K6c7QAM2AuqWFkEFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 17:16:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URl91-0001Wc-Hl
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 17:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab3DOPQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 11:16:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47984 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752506Ab3DOPQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 11:16:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADDE11559F;
	Mon, 15 Apr 2013 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=js6ct2/PwkPOMWo+G54+BGa46xA=; b=CACfFG
	gHRB3O3io3ITh/iugLgDrD+hjekIURv12171+ZvBlb19AnwnqC8m2yPcAM6LgVs3
	TTnx4YzVNYVvPRK2eyUS0auW1MlwROsOdx5acMrocTS47WQobEQn6hh8erDRvl+A
	U0bjx5z2vBOrCMkh3IgBBU6q67ZxZ8dUITmoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PeWchMayEX9B0P+TYKddFgvOAJjM/N5G
	qCWXFZmCXODsuPOXa5ckvkE3r4m4ITfuHv6DRXiS0NTzgl49BEEMOR3A3xZcI/cy
	8VHcNcsaTTQlCvdwmvPDJ89MLu6au+YZE4sC3h9gaa7w6SQOtrvcGViKmBbPkuGQ
	bjo380a1pWw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A192B1559B;
	Mon, 15 Apr 2013 15:16:29 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA12F1559A; Mon, 15 Apr
 2013 15:16:28 +0000 (UTC)
In-Reply-To: <CALkWK0mmrvYSjvUCvvjbnav4JmbkVKho2K6c7QAM2AuqWFkEFw@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Mon, 15 Apr 2013 18:01:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 724B612C-A5DF-11E2-9CE4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221237>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> In the end, simple cases (the canonical example being Linus keeping
>> a local change to "Name = Unicycling Gorilla" in his Makefile while
>> running dozens of "git pull" every day) would not be helped with
>> this feature very much because there is rarely overlap, while in a
>> complex case the user really needs help to save away his WIP, the
>> user is forced to resolve the conflict immediately upon the failed
>> "stash pop" at the end of "git pull".  If the conflict turns out to
>> be something the user would not want to resolve at that moment, the
>> user needs to know the way out, something like:
>>
>>         git reset --hard                ;# go back to the result of pull
>>         git checkout -b wip ORIG_HEAD   ;# start from before the pull
>>         git stash pop                   ;# recover his wip
>>         ... perhaps work a bit more ...
>>         git commit -a -m wip            ;# save it away for safety
>>         git checkout -                  ;# result of pull
>>
>> so that he can come back tomorrow, check out "wip" branch, and
>> decide what to do.
>
> What does this have to do with pull at all?

Exactly.

By tempting the user to use autostash first, you are forcing the
user to say "reset --hard" (the first one), "ORIG_HEAD" (to start
from the pre-pull state), "stash pop" (to recover the autostashed
WIP), to a user who got conflict during "stash pop" after the pull
integrated the committed work with the remote side.

If the user did this instead:

        ... Let's save my large WIP away in a more permanent place first
	git checkout -b wip
        ... perhaps work a bit more ...
        git commit -a -m wip
        git checkout -
	... and then ...
	git pull

the user wouldn't have had to do those extra steps.

Another thing to consider is that even with the current system, many
users do not have a clear idea on what the state of the working tree
is when a "pull" fails (there are largely two classes). Either the
merge failed without damaging the WIP before the pull at all, or
there wasn't any interaction between the WIP and the change pull
wanted to bring in and only the paths with conflicts need to be
resolved and added (i.e. "commit -a" is a no-no). This "auto-pop"
adds a third failure mode to "pull". It is a non-issue for Git-heads
like us (we do read the messages from the programs), but not all
users are like us.

>> The "--autosquash" option (or not adding either the configuration or
>> the option) would encourage the user to think about the nature of
>> WIP he has in the working tree before running "git pull".
>
> I'm lost.  What does git rebase --autosquash (or rebase.autosquash)
> have anything to do with git pull --autostash?

Sorry, the typo meant --autostash.

>> Is it a
>> too complex beast that may interfere with what others are doing, or
>> is it a trivial change that he can stash away and pop it back?  If
>> the former, he will be far better off doing "checkout -b", keep
>> working until the local change gets into somewhat a better shape and
>> "commit", before pulling into the original branch.
>
> A pull-merge person having complex worktree changes should not execute
> git pull blindly in the first place.   That's what git fetch is for:

Huh?  You are not making sense.

I would understand it if it were "That's what git commit is for",
though.

> But I'm a pull-rebase guy, and I always want pull.autostash.

That is why I said the equation is different for pull-rebase, where
"rebase" insists that you start from a squeaky clean working tree,
so you can check the condition early before "git pull" even starts.
While --autostash will not improve the life for pull-merge people
(and pull.autostash will actively hurt them), pull.autostash does
help pull-rebase people work around the limitation of "rebase".
