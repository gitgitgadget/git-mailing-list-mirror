Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993B8470
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XFf0iCyw"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1903F1D8551;
	Mon, 18 Dec 2023 13:43:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4OcxVtUbtxGwe83S5TyWn5KLfsshF2Dq+1l2gI
	Ry7V0=; b=XFf0iCywD++rNbe9tfDgjIgkehKrmd+Aqb7PHw9Zp2WrTn5inqeyUD
	Si+XeX+mWS6LXzS8bB8b2i+CxcOPQ0kCwPs6Cr2u746R+MLlVi3K7G9/iz3mYpA3
	ylZwTFIZbx38jHm9FzWF4qnocLf8WKx+Cv3lkkDyQovQVlqYN1d4E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FD8A1D8550;
	Mon, 18 Dec 2023 13:43:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 73D2B1D854F;
	Mon, 18 Dec 2023 13:43:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mial.lohmann@gmail.com>
Cc: phillip.wood123@gmail.com,  Johannes.Schindelin@gmx.de,
  git@vger.kernel.org,  mi.al.lohmann@gmail.com,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase-interactive: show revert option and add single
 letter shortcut
In-Reply-To: <20231218170912.73535-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Mon, 18 Dec 2023 18:09:12 +0100")
References: <c2489476-f23b-4c03-8651-d6a8799ff67c@gmail.com>
	<20231218170912.73535-1-mi.al.lohmann@gmail.com>
Date: Mon, 18 Dec 2023 10:43:14 -0800
Message-ID: <xmqqmsu7e4hp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DDBA53C-9DD5-11EE-9ABE-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Michael Lohmann <mial.lohmann@gmail.com> writes:

> A `revert` in an interactive rebase can be useful, e.g. if a faulty
> commit was pushed to the main branch already, so you can't just drop it.

But wouldn't that be typically done simply by running "git revert",
totally outside the context of "git rebase -i"?

Interactive rebase is more geared toward rearranging an already
built history *after* such a "git revert" is made and possibly other
commits are made either before or after that commit that was created
by "git revert".

And when "git rebase -i" sees such a series of commits, e.g.,

	git checkout -b side-branch master
	git commit -m "some work"
	git commit -m "some more work"
	git revert -m "revert a bad one for now" master~4
	git commit -m "tentative alternative for what master~4 did"
	git rebase -i master

The "revert a bad one for now" commit looks to the machinery just
like any other commit in the todo list.

> When you are already working in a feature branch you might just want to
> revert said commit right where you branched off from main, so you can
> continue working on the feature you intend while still being up-to-date
> otherwise.

Yes, I can see why sometimes you want to work on a history with
effects from certain commits removed.  But that does not explain why
you want to _insert_ a revert that you do not even have in the
history anywhere before you start your interactive rebase.

> Another reason why you might not want to drop a commit is if it is a
> work in progress one and you want to properly fix it later, but for now
> need to revert the changes. That way it is a lot cleaner to structure
> your branch like this:
>
>     A---B---C       (B is WIP commit you cannot use as is)
> =>
>     A---B---~B---C  (temporarily revert B (called "~B") directly after
>                      it is created, until you find the time to fix it -
>                      at which point in time you will naturally drop the
>                      revert commit)
>
> This way you still have the WIP patch, but "your history is not broken
> the whole time".

A much cleaner way to structure your branch is not to muck with such
tentative changes *on* the branch you eventually want to store the
final result on.  Fork another branch and rebase B away:

    $ git checkout -b topic-ng topic [*]
    $ git rebase -i A

to obtain

	A---B---C    topic
	 \
	  C          topic-ng

and then you'd build on top a better version of B eventually

	A---B---C
	 \
	  C---D---E---...---B*---X

And after that you may "rebase -i" to refine the result, and then
get rid of the tentative work:

    $ work work work (still on topic-ng)
    ...
    $ git commit -m "X"
    $ git rebase -i A
    $ git branch -M topic 

Nowhere in the above two flow, there is no need to manually insert a
new "make a revert here of that other commit" in the todo list.
So I am not sure if I buy the above, especially this part:

> +To revert a commit, add a line starting with "revert" followed by the commit
> +name.

It really smells like a confusing odd man out, among all other
existing instructions that are naturally created by the
rebase/sequencer machinery and all the user needs to do is to
shuffle them, never creating a new thing.



[Footnote]

 * I do this too frequently that I often do without a separate -ng
   branch; once you get used to the flow, you learn to do this kind
   of thing on detached HEAD instead, so this step would look more
   like

   $ git checkout --detach topic

   and the remainder of the above procedure will not change.  The
   last step would become

   $ git checkout -B topic

   to bring me back to the target branch in a completed form.

   One beauty about this "detached HEAD" approach is that output
   from "git reflog topic" will show the refinement of the topic as
   a single atomic event.

