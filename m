From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Teach merge the '[-e|--edit]' option
Date: Sun, 09 Oct 2011 16:23:52 -0700
Message-ID: <7v8votpx4n.fsf@alter.siamese.dyndns.org>
References: <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <1318023997-54810-1-git-send-email-jaysoffian@gmail.com>
 <7vfwj4tplw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dzrk5x0+JRC8EbrAxjZE+hD+-5mp+H=F=M8Su2WosPfmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 01:24:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD2it-0000S9-TH
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 01:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1JIXXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 19:23:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61982 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab1JIXXy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 19:23:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CA206D61;
	Sun,  9 Oct 2011 19:23:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=QEx/we46xtdGT/FAi/LhOwXYVTk=; b=Iq/TXuTx2EMcvpzrTrMA
	w/lzJvEZ/9o08ovaCCs+w2Q9p5rzd+ASr4ju3MF5Y5kAbNWPGd3YxFebKiJYp+go
	4y5D8WxOYx1bOxkA0rWfXGt8xr56t849ekV56U1Jx5DKhEkwI55fm1BqwPhSxFsC
	fCpod3AE8pGn1PzSz5P6UlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=d8Pyw5uSGjKWqjR8N3Z/MLU36Tg3PWu5qmZKmGUnZAdUpo
	H3B87VUOE0maauMyWlmlaE7ux7vtUmhT+BjXc/UGx1/FUq+czT0KR5sIUDVErgF9
	r63gy9BOQKgMBDchlB6/0jYQwRiV5Lvfx2y3rRT7SZM4bVUUKFsy4M7K4kJaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BB8C6D60;
	Sun,  9 Oct 2011 19:23:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAB156D5F; Sun,  9 Oct 2011
 19:23:53 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C0BF763E-F2CD-11E0-BAA2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183218>

[Adding Ram to the Cc: list as this topic has much to do with resuming a
sequencer-driven workflow, and dropping Todd who does not seem to have
much to say on this topic]

Jay Soffian <jaysoffian@gmail.com> writes:

> I am complaining that git-merge implements commits internally, which
> gives it unique behavior from git-{commit/cherry-pick/revert} (the
> latter two of which just run external git-commit). I'm saying merge is
> fundamentally broken to do it this way. And maybe that's something
> that should be fixed in 2.0 -- that git-merge should just call out to
> git-commit, just like cherry-pick/revert do.

The purpose of the plumbing commands, e.g. commit-tree, is to implement a
unit of logical step at the mechanical level well without enforcing policy
decisions that may not apply to all situations.

On the other hand, the purpose of the Porcelain commands is to support a
concrete workflow element. "git commit" should support what users want to
happen when advancing the history by one commit, "git pull" should support
what users want to happen when integrating work done in another repository
to the history you are currently growing, etc. It is where we should and
do allow users to implement their own policy with hooks and configuration
variables when they want to, and it is even fine if we implemented sane
default policies with ways to override them (e.g. "commit --allow-empty",
"merge --no-ff").

Some Porcelain commands cannot complete their workflow element by
themselves in certain situations without getting help from users, and they
give control back to the user when they need such help. "git rebase", "git
am", "git merge", etc. can and do stop and ask the user to help resolving
conflicts.

The unfortunate historical accident that we may want to correct is that
some of these "we stopped in the middle and asked the user to help before
continuing" situation were presented as if "we stopped and aborted in the
middle, leaving the user to fix up the mess", which is a completely wrong
mental model. "Upon conflicts, 'git merge' stops in the middle, and you
complete it with 'git commit'" is a prime example of this. We even wrongly
label such a situation as "failed merge". It is not failed---it merely is
not auto-completed and waiting to be completed with user's help.

To understand why it is a wrong mental model, you need to imagine a world
where the logic to resolve conflicts in "git merge" is improved so that it
needs less help from the users. rerere.autoupdate is half-way there---the
user allows the merge machinery to take advantage of conflict resolutions
that the user has performed previously. Even though we currently do not
let "git merge" proceed to commit the result, it is entirely plausible to
go one step further and treat the resulting tree from applying the rerere
information as the result of the automerge. When that happens, it is very
natural for the user to expect that the rest of what "git merge" does for
a clean automerge to be carried out. After all, from the end user's point
of view, it _is_ a clean auto-merge. The only difference is how the user
helped the automerge machinery.

The root cause of the inconsistencies you are bringing up (which I agree
are annoying and I further agree that it is a worthy thing to address) is
that even though we tell the users "after helping the 'git merge', you
conclude it with 'git commit'", the concluding 'git commit' does _not_
perform what the user configured 'git merge' to do before a merge is
concluded, unlike a cleanly resolved 'git merge'.

This is merely an unfortunate historical accident. Because "git merge" did
not have any user configurable policy decisions (read: hooks) when this
"conclude with commit" was coded, "conclude with commit" was sufficient to
emulate the case where the merge did not need any help from the user.

But it no longer is true with modern Git.

With more recent changes, e.g. the sequencer work and "git cherry-pick"
that takes multiple commits, "conclude with commit" is becoming less and
less correct thing to say. The workflow elements these commands implement
do have "create a commit" as one essential part, but that is not the only
thing they do. If anything, I think the right way forward is to update the
UI with this rule for consistency:

  Some tools can stop in the middle when they cannot automatically compute
  the outcome, and give control back to the user asking for help. After
  helping these tool, the way to resume what was being done is to invoke
  the tool with the "--continue" option. All user level policy decisions
  implemented by hooks and configurations the tool normally obey when it
  does not need such help from the end user are obeyed when continuing.

I wouldn't mind if that is "invoke 'git continue' command", even though I
suspect that may make the implementation slightly more complex (I haven't
thought things through). "git commit" as a way to conclude a merge that
was stopped in the middle due to a conflict should be deprecated in the
longer term, like say in Git 2.0 someday.


[Footnote]

*1* By the way, "git merge --no-commit" is an oddball. It primarily is
used when the user does _not_ want the resulting commit but wants to
further modify the tree state (e.g. cherry picking a part of what was done
in the side branch). At the philosophical level, the user should be using
merge machinery at the "plumbing" level (e.g. merge-recursive backend),
but the interface to invoke the plumbing level merge machinery is so
arcane (they are after all designed for scripts not for humans) that
nobody does so in practice. And for that purpose, I think it is Ok for the
user to do anything after "git merge --no-commit" finishes (either leaving
conflicts or leaving a cleanly merged state), including "git commit".
Because that "git commit" is very different from the "conclude conflicted
merge with commit" which is a poor substitute for "git merge --continue"
in modern Git, I think it is perfectly fine and even preferable if it does
not obey any "git merge" semantics (i.e. user defined policy that pertains
to "merge" operations).
