Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2460B665
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 22:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744066308; cv=none; b=AVbnlM3G3GvdZBXGIEyyDI9M33aVUJTFcAWgd6MrXqvLqF0H1g7YtxBzXapFjXDE+p9yIpulW/PlkX2VdUvHjnaa4+dyaxMNAvgeCiv0hmOnNEa/e5sifedPsCDdVLXNYjfxa3b2WswV5PSu28SLNomsq/69z1KpXAhAly3r0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744066308; c=relaxed/simple;
	bh=de9deFVKAbcEmmPj4InZYUH1N4+RvULEWw1hsDhUdIM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JxPc9x/EKeUcgLmkhOjUf0ou81yWmFrUfy46lmQMcyFWwLAjAgMtIa7N219wa78eM/ewEsYGjMnID2L6gQtW+DI0RPSd8R9j5N+OAXzW92YWFcaR05zUp4qbxtTqKXXmimXLMcZx6Nq9rz2phw0XIaR7UfgJLa2Ol38TXSgV4vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4ZWkwY6WKzz9sdW;
	Tue,  8 Apr 2025 00:51:41 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Apr 2025 00:51:39 +0200
Message-Id: <D90RWL4FEBQA.1UNOR59T3U98R@buenzli.dev>
Subject: Re: Gerrit, GitButler, and Jujutsu projects collaborating on
 change-id commit footer
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "Junio C Hamano" <gitster@pobox.com>, "Martin von Zweigbergk"
 <martinvonz@google.com>
Cc: "Git Mailing List" <git@vger.kernel.org>, "Edwin Kempin"
 <ekempin@google.com>, "Scott Chacon" <scott@gitbutler.com>,
 "philipmetzger@bluewin.ch" <philipmetzger@bluewin.ch>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <xmqq4iyzn0vn.fsf@gitster.g>
In-Reply-To: <xmqq4iyzn0vn.fsf@gitster.g>
X-Rspamd-Queue-Id: 4ZWkwY6WKzz9sdW

On Mon Apr 7, 2025 at 10:59 PM CEST, Junio C Hamano wrote:
> Martin von Zweigbergk <martinvonz@google.com> writes:
>
>> For example, it enables
>> `git rebase main <change ID>; git switch <change ID>` without
>> requiring the user to look up the hash of the rewritten commit.
>
> I do not quite see why this can be listed even as an advantage,
> unless you are going to allow end users to name the changes, instead
> of using auto-generated impossible-to-remember hexadecimal string
> (perhaps prefixed with a single "I" or something).

Since the change-id will use a "reverse-hex" alphabet (z-k instead of
0-f), prefixing an "I" won't be necessary for disambiguation.

In the case of Jujutsu, there is a configurable "immutable revset",
which represents the idea that people usually don't want to force-push
over the master branch. If the user specifies a change-id prefix that's
ambiguous, but only one of the commits it could refer to is "mutable",
that one takes precedence. So in practice, the commits one is currently
working on can be identified with 1-3 characters, which fit comfortably
into short-term memory.

While that feature isn't implemented in Git (yet), it shows how such a
usage pattern can be very ergonomic.

>> If the change id also transferred between repos and preserved by
>> a forge (such as Gerrit), it enables the change id to be used to
>> identify a code review.
>
> People often talk about rebasing and rewriting in the context of
> discussing "change IDs", and for 80% of the use cases where a simple
> single-commit topic is involved, it would perfectly work fine.
> After making a new commit C0 on top of 'main', updating 'main' with
> others' changes, and then rebasing that C0 on top of updated 'main'
> to produce C1, you would expect that C0 and C1 are moral equivalents
> so it is natural that you wish there is a name to give to these
> moral equivalents.
>
> But stepping back a bit, if they are not just moral equivalents but
> record identical changes that are so same that an earlier review of
> C0 makes it unnecessary to review C1, why are you even rebasing in
> the first place?  Just merging C0 to the updated 'main' would retain
> the earlier review made on C0 and things should merge just fine.

Some people (including me) like to / are used to rebasing often and
keeping a linear history on master as possible. I'm not aware that
there's anything wrong with that.

In practice, I don't think this will cause any problems. The change-id
will help the code review tool to identify the commits as morally
equivalent. After checking that the other review-relevant data (patch,
message, author...) is identical, the review tool may choose to mark
the commit C1 as "already reviewed" without any user intervention.

And if the data has somehow changed, only the interdiff of that can be
shown for review, which is precisely the kind of benefit we're aiming
for with this header. It has been pointed out that git-range-diff can do
this in a limited fashion already, which we can hopefully expand upon.

> I have more problems with the remaining 20% use case, where you need
> to deal with multiple commits.
>
> Perhaps your initial changeset is a single commit C0 that is so
> large and does too many things at once, and reviewers would
> naturally advise you to split things up.  You'll come up with a
> series of commits, C1_0 and C1_1.  The net effect of applying these
> two patches may be the same as applying the original C0, but each of
> them is more cleanly separated to address one issue at a time, and
> the explanation given in the proposed log message more clearly
> describes the issue each of them addresses.  Now you gave a change ID
> to C0, and want to somehow relate C1_0 and C1_1 to the original C0.
> Which one gets the same change ID?  Earlier one?  The last one?
> Both gets the same change ID?
>
> Or your initial changeset is a two-commit series, C0_0 and C0_1, but
> reviewers find that each one of them alone is not complete, and
> because the issue addressed by these two is small and isolated
> enough, you are advised to make them into a single commit C1.  Did
> you start with two change IDs for these two original commits?  If
> so, whose change ID the updated commit C1 inherit?  Or does C1 have
> two change IDs now?  Or did you start with a single change ID
> assigned to both of these two original commits?

These are good descriptions of realistic scenarios. At a high level, I'd
say change-ids don't help much with these problems. But that's OK, they
don't need to solve all problems to be worthwhile.

A commit only ever has one change-id. (Other headers may be useful, but
they should have another name and should be disussed separately IMO.)

In both of the described scenarios, it doesn't matter which one
inherits the previous one. When a commit is split into two, the one that
inherits the change-id will show up in review tools with half of its
patch deleted, the other commit will show up as new. When two commits
are combined into one, any one of the change-ids is inherited. Review
tools will show the patch from the commit the ID was inherited from as
preserved (maybe even hidden) while the patches from the other commits
will show up as added. If they were previously reviewed, those reviews
will be "lost".

So, while these scenarios are not ideal and somehow ambiguous, the
ambiguity doesn't present any real problems in practice.

More importantly, I disagree with the 80%-20% split between these
scenarios. There is another one that comes up a lot, and that scenario
is the one that benefits the most from change-ids. Namely, when multiple
commits are carried together as a patchset. These commits can split
out into little subtrees that are constantly rebased to keep up with
upstream, while the commits are amended, reworded and so on. They can
sometimes be reviewed as a whole, where people are generally looking at
all commits at once. But they can also represent dependencies between
entirely different features. For example, bugfixes will often be at the
base of this tree / patchset, while features that depend on it fan out
from there. Here is where the change-id shines: As commits are amended,
reordered, rebased and reworded, their evolution can be trivially
tracked. There are discussions around the topic of "stacked PRs", which
is basically this exact scenario, just managed in a specific way.

I find myself working this way a lot.

> Quite frankly, I think the concept of "change ID" is nice but it is
> not mechanically trustable.  Recording them in the trailers is fine,
> but I somehow feel that they have a clear-cut semantics everybody
> can agree on to deserve to be in the header part of commit objects.

I think the concrete examples above show that while change-ids don't
solve all version control problems, these remaining problems don't
diminish the value of change-ids either. I also don't see any potential
for different tools in the ecosystem to disagree about the semantics so
profoundly that interoperability would be hampered.

Remo
