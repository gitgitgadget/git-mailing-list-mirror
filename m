From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Mon, 15 Aug 2011 11:55:23 -0700
Message-ID: <7v7h6eld2c.fsf@alter.siamese.dyndns.org>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com>
 <20110814160440.GK18466@elie.gateway.2wire.net>
 <7vei0nn1cn.fsf@alter.siamese.dyndns.org>
 <20110814213200.GA6555@elie.gateway.2wire.net>
 <7vippzlj7a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 15 20:55:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt2Jy-0003wU-1N
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 20:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752661Ab1HOSz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 14:55:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36408 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555Ab1HOSz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2011 14:55:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A403F4BC8;
	Mon, 15 Aug 2011 14:55:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0ggOz5p7qFzUZ9DdRSNlJQ+QlHQ=; b=L9RgY4
	szrpvyoYzA9PynfNxzUfTE9rTwTyte5yU1V/klwOYEp8qkW3eO87W+/dEqRVuJlF
	TlKeFWLT6ZtMjNn4h8fO/5qZjZUtqvYQQEcKCWm75RQeIGAHfWmYHMjELJ3vrJFz
	jpfjDr3F6Ra/qyheQqEG5YB/bmlUBLdjqnrpE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e64gcsalO9KjnvYxJx2v9xlCVEbLu+Pt
	rQIJgWm4CCVBqUFYBNQmoHL32BgSOca2E2HFQFr4U1gC5nj9dxhlDGgKQEdu1N47
	Hc0X40aC2jnN95erPbD/vcPjCFoQhfkVFr7kXLUwX3TK58QuiSXSyfeTh52xjCcX
	oD1tn3il9UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 93D774BC6;
	Mon, 15 Aug 2011 14:55:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF2EC4BC2; Mon, 15 Aug 2011
 14:55:24 -0400 (EDT)
In-Reply-To: <7vippzlj7a.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 14 Aug 2011 15:30:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2271C1D6-C770-11E0-B09B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179383>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I believe it is meant to support command sequences such as these:
>>
>> 1.
>> 	git cherry-pick foo; # has conflicts
>> 	... resolve conflicts and "git add" the resolved files ...
>> 	git commit
>> 	git cherry-pick bar
>
> Why does a single commit "cherry-pick foo" leave any sequencer state that
> may interfere with the latter to begin with? Isn't that already a bug?
>
>> 2.
>> 	git cherry-pick foo bar; # has conflicts applying "bar"
>> 	... resolve ...
>> 	git commit
>> 	git cherry-pick baz
>>
>> Those were intuitive things to do before the sequencer existed, and if
>> I understand correctly, d3f4628e was intended to support people and
>> scripts (such as the test suite) that have these commands wired into
>> their fingers.
>
> Given that the latter was broken when "foo" stopped with conficts (it lost
> "bar" altogether anyway), I am not worried about it, and I do not care
> much about anybody who had wired such multi-pick into scripts or fingers,
> either.
>
> IOW, I do not necessarily agree with your "those were intuitive"
> assertion.

After sleeping on this, here are my random thoughts on this topic.

 - The sequencing flow the current "rebase -i" implements when resuming a
   controlled stop (i.e. "edit" or "reword"), even as the last step of the
   insn sheet, feels like the right thing. The actual tweaking of the
   commit done by "commit --amend" is oblivious to the sequencing state,
   and resuming is controlled by "rebase --continue".

 - The case to resume an unexpected stop (i.e. "pick" that causes conflict
   or "rebase" without "-i") also feels right. The user fixes up and marks
   things as "done" with "add/rm", and tell the stopped command that it can
   now continue with "rebase --continue". The same comment applies for
   "am".

 - Even before we started talking about the sequencer, the workflow to deal
   with conflicted "revert" or "cherry-pick" was awkward. From the end
   user's point of view, the operation the end user wanted to perform was
   "revert" (or "cherry-pick"), but we tell the user to fix things up, mark
   them as "done" with "add/rm", and commit the result themselves. We could
   have made the UI more consistent by introducing "revert --continue".

 - In a sense, the last point got worse by a recent change to make
   "commit" notice CHERRY_PICK_HEAD. This was modeled the workflow to
   conclude a conflicted "merge", that noticed "MERGE_HEAD" etc., but from
   the UI point of view, I think it was a mistake. Back when "merge" was
   the only command that needs post-clean-up by the user, saying "when
   merge stops due to conflict, you conclude it with commit, but
   everything else you conclude (or continue) with --continue" was
   reasonable, but now we have to say "after conflicted merge, revert and
   cherry-pick, you conclude it with commit; use --continue for everything
   else".

So I think that questions that affect us longer term are:

 - Does it make sense to keep this two quite different ways to resume an
   interrupted operation? Some saying "The operation you started was Foo
   but you need to conclude it with 'commit'", others saying "When Bar
   stops in the middle, you say 'Bar --continue'"?

 - If so, which camp should the sequencer-based commands fall into?

 - If not, shouldn't we be unifying the user experience to one of them,
   with backward compatibility escape hatches?

I think what d3f4628e tried to do may make sense _if_ we want to make
"commit" the way to conclude or continue sequencer-based commands. If we
really wanted to go that route, however, it would make it easier if
"commit" were the _only_ way to deal with all the "stopped because the
user needs to resolve conflicts or because the user told us to pause"
situations. For example, when "rebase -i" stops (either due to an "edit"
or a conflicted "pick"), after the user tweaks the tree and says "git
commit [--amend]" to reword, "rebase --continue" after that shouldn't be
necessary. If we are making "commit" aware of the sequencer status, it
should already know that the next thing after that invocation of "commit"
is to resume the sequencing.

But I do not think that is the direction we would want to go for two
reasons. There is a (complicated) workflow to split an commit during
"rebase -i" that does _not_ want an auto-resume by a commit. Also not
all conflicted/stopped state can be concluded with "commit" (think:
"rebase/am --skip").

I personally am leaning towards teaching "--continue" to "merge" and
"cherry-pick", while keeping only existing awareness of these two commands
in "commit" as historical mistakes (look for 'unlink(git_path("[A-Z_]*"))'
in builtin/commit.c). That would mean that in the long run, new users need
to learn only one thing: when "git Foo" stops because it needs help from
you resolving conflicts, after you help it by editing the files in your
working tree and making that with add/rm, you say "git Foo --continue" to
signal that you are done helping it.

And we do not have to worry about making "commit" only half-aware of
sequencer states.
