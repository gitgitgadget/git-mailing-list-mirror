Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F232500C5
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743698433; cv=none; b=R3ndf+/fFqvNg2O3Mz21i8MrRxdXegL1V03ks4T+9hvK39muzgVOdpIHUeu9dx1a8WtJlFn1R5QmFG1oExiVJNWS0N5ri0obhV1Lw5W3kZEYF+8XosiyqiqyF6J54AN/BF2bvgY3BEDToWd+/M4+PJGJQqe11BDnpZ/V4cIAuyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743698433; c=relaxed/simple;
	bh=dkSS0Suwl9vBvvl7MDmS+lFA9/7PPCDJCUn7oB5BP/E=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=CfevvF+G3TRyTVIHSEfrH2jz6r08OMZAz40Up3FexB66UQWgI0p4vL3sBU/hhaiRc2QqKuBdZhVBmXbtYQ/inZzM4dP2Lq8iUkn5/18w5whyMmKtTGbc3DSl0yIuzOtmsiaotTCMq2aXA5NYUxXCxwpG+2Lge0HiyRK6hINIAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4ZT6sy2DDSz9sl4;
	Thu,  3 Apr 2025 18:40:22 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Apr 2025 18:40:20 +0200
Message-Id: <D8X5I3W7K1DI.2JYHGNY9L7ZD3@buenzli.dev>
To: "Elijah Newren" <newren@gmail.com>, "Martin von Zweigbergk"
 <martinvonz@google.com>
Cc: "Git Mailing List" <git@vger.kernel.org>, "Edwin Kempin"
 <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
In-Reply-To: <CABPp-BFRz-yjnti4W17AEBozb0v52kmNsgTLUZW6-MF34R-xdw@mail.gmail.com>
X-Rspamd-Queue-Id: 4ZT6sy2DDSz9sl4

On Thu Apr 3, 2025 at 5:39 PM CEST, Elijah Newren wrote:
> On Wed, Apr 2, 2025 at 11:48=E2=80=AFAM Martin von Zweigbergk
> <martinvonz@google.com> wrote:
>>
>> There are many benefits to having a change id even if it's just
>> local. I mentioned some in my email to this mailing list in [1].
>> For example, it enables
>> `git rebase main <change ID>; git switch <change ID>` without
>> requiring the user to look up the hash of the rewritten commit.
>
> But <change ID> isn't unique, right?  The whole point of having the
> change ID is to preserve it despite edits (e.g. rebase, commit
> --amend, cherry-pick), meaning that you end up with multiple commits
> with the same <change ID>.
>
> Why would this work?
>
> And if it does work, isn't it expensive since you'd need to walk
> history to find it?  Or do you keep an extra lookup table on the side
> somewhere?

For rebase and commit --amend, the way Jujutsu deals with those is that
all descendants are immediately rebased on top of the new commit, and
refs to those descendants are updated as well. That means, the old
version of the patch with the same change-id becomes unreachable. So,
at least most of the time, the change-id is indeed unique.

This doesn't work for cherry-pick, more on that below.

Some of these features are not in Git yet, at least not to my knowledge.
That means getting the full benefit of change-ids with Git itself
would indeed require some more work. I know of rebase.updateRefs
and rebase.rebaseMerges, which move the Git experience closer to
Jujutsu, but don't go all the way. AFAIK it's not possible with Git to
automatically rebase --update-refs all descendants of a commit that is
amended or rebased.

Jujutsu does keep a separate index of change-ids, yes.

>> There is a design doc [2] about the impact on Gerrit and how to
>> handle various cases where the client doesn't understand the
>> `change-id` header. That also includes some discussion about
>> whether cherry-picking should preserve the change id or create a
>> new one. I think there is a lot of value in having a
>> standardized header regardless of what we decide about
>> cherry-picks.
>
> cherry-pick & rebase preserve author name, email & time, while
> creating a new committer name, email, & time.  To me, the change-id is
> about the authorship, and since these commands already preserve
> authorship, it'd seem weird to me to have cherry-pick not preserve the
> change-id by default.

I'd say Jujutsu, Gerrit and GitButler think of a change-id as associated
with a unit of review. (Although it will naturally support reviewing
sets of patches as well.) Usually only one person will push commits with
the same change-id, just like people don't usually force-push over each
others branches. But that's mostly about avoiding logistical problems.
When an employee leaves a company or is on vacation, it can be perfectly
reasonable for someone else to take over their work. In that case, it
would be appropriate to preserve the change-id, even though authorship
has changed, because the history of code review on that patch should
stay associated with the new version.

Cherry-picking on the other hand often represents a separate unit of
review. That review may revolve around whether it makes sense to
backport a bugfix at all or any additional changes that may have been
necessary to make the bugfix work in the different, older codebase.

As mentioned above, there's also the issue that preserving the change-id
on cherry-pick likely results in duplicates. For Jujutsu, it would be
nice it this was avoided. But it's not infeasible to deal with that
either.

For Gerrit, it would be important to be able to track a change across
cherry-picks somehow, since that is a feature they already have. If Git
decides to preserve the change-id on cherry-pick, there's no problem
for Gerrit. Alternatives include storing a separate cherry-picked-from
header or enabling the -x flag on cherry-pick by default.

Remo
