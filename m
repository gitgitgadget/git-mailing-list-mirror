Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8D2C10A4
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745360655; cv=none; b=F48q6utyMJVDnFiZrPtpflkI5YQd4HKyltLOOrf2E5DJ2GWyDdTQGy7ANVl20sxSUISqRFgtgOqw+pGk2+20GbljVwgiTGlQvDiQgYDwznOL3pRC0536q3RuO3J0Et9yNtF9Daah8zaW8RN3m6PM/ynJANPSMoDLha9LPpCgwAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745360655; c=relaxed/simple;
	bh=22+RisyivQHf6tKnqceWWk5xH1g/XeiFOtko2EFRHUE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TqKGg6A5ll5pi9bsJnX0ZyGKndguAOp9Q1nkjDQT+81ALhC+lGBMiLKdtVUzu7X6BHLdz2uWhrvXX5hatqLCsXMBLKtY9fcnbTeqh+PmpuW3sWsNKJdoVT6cOhLi30qfY93Re6sTMXHi5suiLWB5rgFUt0b3YUU/fhiVNiyVRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev; spf=pass smtp.mailfrom=buenzli.dev; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=buenzli.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buenzli.dev
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Zhxbs2Y2pz9tgL;
	Wed, 23 Apr 2025 00:24:09 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Apr 2025 00:24:06 +0200
Message-Id: <D9DIPNY431IJ.23DG6UL5CIQJ@buenzli.dev>
Cc: "Nico Williams" <nico@cryptonector.com>, "Theodore Ts'o"
 <tytso@mit.edu>, "Junio C Hamano" <gitster@pobox.com>, "Martin von
 Zweigbergk" <martinvonz@google.com>, "Git Mailing List"
 <git@vger.kernel.org>, "Edwin Kempin" <ekempin@google.com>, "Scott Chacon"
 <scott@gitbutler.com>, "philipmetzger@bluewin.ch"
 <philipmetzger@bluewin.ch>
Subject: Re: Semantics of change IDs (Re: Gerrit, GitButler, and Jujutsu
 projects collaborating on change-id commit footer)
From: "Remo Senekowitsch" <remo@buenzli.dev>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
References: <CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com> <xmqq4iyzn0vn.fsf@gitster.g> <Z/RFQY433muaCW44@ubby> <20250408125521.GA17892@mit.edu> <Z/VGYrrVZYQ13TLj@ubby> <20250409121924.GA148735@mit.edu> <Z/amMj/eg0RbXdkS@ubby> <CALnO6CC_Gvqhcxp4AknwM+YSsngv_0zngKb2XHXN4u0AvKEMMg@mail.gmail.com> <D9816I5AX1RG.AA4A7H2D8SJ7@buenzli.dev> <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
In-Reply-To: <CALnO6CCjkxv40+5wZ_vwZTKv7Te8Xh--M1fY2wbuOfgJm5LZxw@mail.gmail.com>
X-Rspamd-Queue-Id: 4Zhxbs2Y2pz9tgL

On Tue Apr 22, 2025 at 10:17 PM CEST, D. Ben Knoble wrote:
> On Wed, Apr 16, 2025 at 7:36=E2=80=AFAM Remo Senekowitsch <remo@buenzli.d=
ev> wrote:
>>
>> On Mon Apr 14, 2025 at 9:54 PM CEST, D. Ben Knoble wrote:
>> > On Wed, Apr 9, 2025 at 12:56=E2=80=AFPM Nico Williams <nico@cryptonect=
or.com> wrote:
>> >> Let's nail down the semantics of these change ID headers.  Here is a
>> >> proposal to bang on:
>> >>
>> >>  - change IDs get preserved on cherry-pick and on `pick`s in rebases
>> >>
>> >>  - users can manually remove or change these change IDs, naturally,
>> >>    though generall they would not
>> >>
>> >>  - the actual change IDs are either free-form or they are URIs -- pic=
k
>> >>    one, but if they are URIs they should be URIs to CRs, and approved
>> >>    CRs should perhaps have links to integration reports etc.
>> >
>> > Using URIs [to code reviews] looks to me like it makes some
>> > assumptions about what creates or consumes these headers, right?
>> > Especially since the URI should point to a code review=E2=80=A6 Is the=
re a way
>> > to do that which is downstream-agnostic?
>> >
>> > Further, and maybe this is my ignorance of Gerrit showing: how would
>> > you attach a URI to a local commit when authoring it? You don't have
>> > the review URI when running `git commit`, do you? (Maybe I
>> > misunderstood; I'm seeing an odd chicken-egg problem here.)
>> >
>> > Which begs another question: what/who applies the initial change ID to
>> > a commit and when?
>>
>> These are all great questions, which the originally proposed format
>> (fixed-width reverse-hex) has answers to. I think a URI would be
>> strictly worse.
>
> Well, I think we still missed "what/who applies the initial change ID
> to a commit and when."

The tool that creates the commit, when it creates the commit. In the
context of this discussion, that's Git or Jujutsu. If the commit is
brand new, generate the change-id randomly. If it's the "spiritual
successor" of another commit, use that commit's change-id.

Btw. since the thread was started, the implementation in Jujutsu has
been completed and I've been pushing commits with the change-id header
to various remotes for a while now. It works well. Forges can start
taking advantage of it. (I hope I find time to help work on that.)

> But the treatment below is something I agree with and failed to
> convey, I think: namely, URIs seem to encode too much
> "unportable"/"specific" information in Git. I feel like the current
> design is not really "tool-agnostic" as much as "built on a universal
> core." That seems valuable and prone to more longevity.
>
>>
>> * Using a reverse-hex ID makes no assumptions about what consumes these
>>   headers. There can be multiple different consumers which treat the ID
>>   differently with different URI schemes.
>>
>> * Attaching a reverse-hex ID to a local commit when authoring it is
>>   trivial: you generate it randomly.
>>
>> This is one of those cases where being maximally restrictive about the
>> format will enable maximal flexibility downstream.
>>
>> One example: GitHub has a URL scheme that looks like this:
>> github.com/org/repo/compare/<ref1>..<ref2>
>>
>> This doesn't work if the refs contain slashes, as branches sometimes do
>> (e.g. feat/foo, username/bar). If the change-id is a URI, this type of
>> URL scheme doesn't work reliably.
>>
>> That is not to say we should design the change-id around GitHub, it's
>> just an example how making the format more free-form (URI is more
>> free-form than fixed-width reverse-hex) makes it more difficult to get
>> stuff working downstream.
>>
>> And lastly, laser-etching the URI scheme of one particular tool into
>> your commit history means the history is at great risk of degrading
>> over time. URI schemes change, domains change, tools become outdated
>> and are replaced.
>>
>> Adding some ephemeral configuration to a tool that constructs a URI out
>> of a reverse-hex ID on the other hand is trivial.
>
> Yep.
>
>> > PS This discussion feels somewhat related to the classic GitHub
>> > problem of not presenting interdiffs/range-diffs: GitHub shows a
>> > too-flat source diff on force-pushes. Perhaps better web UI tooling
>> > about interdiff review (which I think is one of the things Gerrit
>> > does/wants to do?) makes change IDs less necessary, since interdiffs
>> > help connect evolutions of commits?
>>
>> I think it's the other way around: Building a code review UI built on
>> git and centered around interdiffs today is _hard_, that's why we don't
>> have it yet. Adding change-ids to commits will make it much easier,
>> paving the way for these tools to be implemented.
>
> Fair point, although GitHub's detection of force-pushes makes me think
> it could split a PR into versions at that point, cross-link backwards
> and forwards by one version (from the force-push detection), show
> range-diffs between versions based on the target branch of the merge,
> and even follow the cross-links to show an overall sequence of
> versions.
>
> But I don't work there, so presumably it's harder than that :)

I agree that forges still have a lot of potential to improve their code
review UIs even without change-ids. But tracking individual patches
across force-pushes is not as easy as calling git range-diff. Its
manpage says the output is not stable for machines to read and the
algorithm it uses has cubic runtime complexity. Not something I'd want
to use on my backend if the user controls the input. So the next best
thing is to reimplement it using cheaper (but worse) heuristics. The
author timestamp would probably be a good start. But at that point,
you're looking at a lot of work for what users will perceive as an
unreliable and inconsistent experience.

> I sincerely hope to make it easier if it's really that hard! And,
> though my opinion matters little, I'm having a hard time piercing the
> conversation to see a "universal core" that solves the desired
> problem. Maybe I'm not reading carefully enough, and maybe a summary
> would help. I greatly appreciated the work of previous folks to
> summarize the current thread status.

--
Best regards,
Remo
