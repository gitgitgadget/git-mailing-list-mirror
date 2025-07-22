Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D441B808
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 21:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221336; cv=none; b=UKzdVqeuKrhfibzf2xNRXIFvROdmpDYiIUwvOn/b8WrTV5NelF5gQVkuSJkZlBrA7VPfjCu8qhB+6JubKY4Ypc50qtzL5kQ4JjOebyjqgeOC6dzm/69mp++dBgtfQg36+CGGmLMs55RwTcMUC6DWFOfk3HvfoplvJdrDDkDKDqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221336; c=relaxed/simple;
	bh=BqMPseS67kK6uct2zp3t+Dr1m5A8fVpp7SAAVu1ArW4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDCoed2CdZ0mi5ZHxZIc8w+lR4Ay0vj7Vk+RUsX+UI/+trdmVjeFHwLyrmTyGDBElHxQjKs01RYEJ9znI8VlgReIVfa/sj0tQ+474PkTBg5OqtWSCH2azG+kUhPdqZ6avmCGH4u0vREgwbyI1XqyBtaCF9eW/HYwEYXEbC//CHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4F801335D55;
	Tue, 22 Jul 2025 21:55:33 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Elijah Newren <newren@gmail.com>
Cc: me@ttaylorr.com,  ezekielnewren@gmail.com,  git@vger.kernel.org,
  gitgitgadget@gmail.com,  sandals@crustytoothpaste.net,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <CABPp-BEf2O12jx-wN5ig941SyoL=X2OJkQY26bac=8+v+jx8ZQ@mail.gmail.com>
Organization: Gentoo
References: <aHl4U98BBvpA5eKF@nand.local> <87seiofc0x.fsf@gentoo.org>
	<CABPp-BEf2O12jx-wN5ig941SyoL=X2OJkQY26bac=8+v+jx8ZQ@mail.gmail.com>
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Tue, 22 Jul 2025 22:55:30 +0100
Message-ID: <87o6tbevql.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> Hi,
>
> On Tue, Jul 22, 2025 at 9:03=E2=80=AFAM Sam James <sam@gentoo.org> wrote:
>
> First of all, thanks to all the Gentoo folks for chiming in and
> providing specifics about platforms and their state.

Thanks. I've been trying to be very specific about what the issues
are. I don't deny Rust is the future of many projects, but it still has
rough parts, and I'd like to ensure they're discussed. It is not my
intention to just scream whenever someone considers adopting Rust.

>
>> > I am far from a Rust expert, but I think that a more modern, memory-sa=
fe
>> > language will attract newer contributors who may have a fresher
>> > perspective on the project, and I think that's a good thing.
>>
>> Aren't they likely to contribute to gitoxide? There, they get a clean
>> slate without having to deal with the least-fun part (bidings).
>
> I'm sure some are.  But clearly there are others where the draw is
> improving git itself because of its installed base; in fact, we need
> look no further than this exact series we are commenting on to find
> proof of that -- one such new contributor submitted patches to use
> Rust in git, and found a significant speedup while doing so.

Part of my opinion there is coloured by how generally working on a
polylang codebase often has pain when dealing with bindings and the
edges, so I figure that anyone most-keen on Rust would surely want to
avoid that ;)

>
> Further, there's considerable interest from existing git developers to
> use Rust in git as well; last year at the Git contributor summit,
> usage of Rust in git was not only one of the topics of discussion, it
> was the top voted topic (meaning, the topic that the greatest number
> of git contributors wanted to discuss).
>
>> > It is also not the Git project's responsibility to ensure that every
>> > platform is Rust-friendly.
>>
>> That's true, of course. And nobody is entitled to indefinie updates, but
>> on the other hand, there's still some implicit contract with users. I
>> really don't think git would have the adoption it does today if it had
>> adopted a Rust-like language in the same state Rust is now from the
>> start.
>>
>> (In exactly the same way, git doesn't gratuitously break compatibility
>> every release either. Can it? Yes, and git can change the platforms it
>> runs on, but it's something to be taken seriously.)
>
> This feels kind of close to a false dichotomy between breaking
> compatibility every release and indefinite update entitlements.  There
> is certainly some middle ground: discussing reducing the breadth of
> platform support in order to gain other benefits, then gathering
> feedback, making a plan, and announcing the upcoming change, etc.
>

Of course. I'm just making the point that it is indeed a compatibility
change, and perhaps that perspective is useful.

> And we're already pretty deep into it.  Concerns about losing out on
> some platforms have repeatedly slowed us down from adopting Rust years
> ago.  Yet, the desire for Rust adoption keeps coming up anyway; see
> the threads starting at
>
>   * https://lore.kernel.org/git/ZZ77NQkSuiRxRDwt@nand.local/
>   * https://lore.kernel.org/git/Zu2D%2Fb1ZJbTlC1ml@nand.local/
>   * https://lore.kernel.org/git/20241128-pks-meson-v10-22-79a3fb0cb3a6@pk=
s.im/
> (search for "Rust")
>   * https://lore.kernel.org/git/cover.1723242556.git.steadmon@google.com/
>
> The discussion has also been picked up and reported outside the Git
> mailing list, e.g. https://lwn.net/Articles/998115/.
>
> And so, in addition to the optional contrib/libgit-rs and
> contrib/libgit-sys Rust components that have already been merged into
> git, and a new build system added in part to make it easier to adopt
> Rust, we now have the first patch series that proposes a hard
> dependency on Rust.

Yes, that's why it's of concern. I have no issue with the optional parts.

>
> Further, I'd like to comment a bit on the support of our users from
> another angle.  We're also responsible for security for our users

Supply-chain issues become more of a problem with Rust if we end up
making heavy use of crates. A policy moderating their use is something
we should talk about.

> and
> feel Rust would help (see e.g.
> https://litchipi.github.io/infosec/2023/01/24/git-code-audit-viewed-as-ru=
st-programmer.html
> and https://github.com/bk2204/git/commit/fbeb1180c7473635a964daed2da642c5=
3487782d).
> We're responsible for performance of Git for our users, and feel Rust
> would help (see the email that started this thread,
> https://lore.kernel.org/git/CABPp-BFOmwV-xBtjvtenb6RFz9wx2VWVpTeho0k=3DD8=
wsCCVwqQ@mail.gmail.com/,
> and brian's notes about [CPU multi-]threading elsewhere in this email
> thread we are in).  And there are other benefits from using Rust that
> we believe would benefit our users.  Thus, it's not just a question of
> responsibility to our users, because such a responsibility pulls us in
> different directions regarding usage of Rust.  So we need to figure
> out how to weigh the needs of our different users.  For many of us,
> and forgive the geeky comparison, we'll probably weigh those needs
> with something more akin to an L2 norm (most good for the most users)
> rather than an L-infinity norm (maximal difference in usability for a
> single user), which probably isn't to your liking.
>

:)

> Anyway, there's been lots of discussion already.  We can certainly
> still discuss more about exactly how to announce, when to adopt Rust,
> whether we'll support an existing C-only version of git for a longer
> period of time than normal, and even whether to continue to delay
> adopting Rust for a little longer.  But my personal guess is that
> attempting to stop adoption of Rust is unlikely to win at this point.

I wouldn't characterise my position as attempting to flat-out stop
adoption of Rust (see beginning of this email).

>
>> > Hopefully the platforms that we currently support but won't after this
>> > patch series have niche enough workloads that they do not need the
>> > absolute latest-and-greatest Git release at all times.
>>
>> I mention this in my other email, but it's not just about ancient
>> platforms. It's also about new ones, or ones where Rust supports them
>> poorly despite them being relevant.
>
> This feels like you're trying to push the decision for a given
> platform to be a dichotomy between latest-and-greatest-Git or
> no-version-of-Git-at-all, despite the fact that Taylor suggested an
> alternative and you even quoted him.  Can you comment on that
> alternative?  Why would using the last C-only version of Git[1] until
> gccrs bridges the gap be a problem for these platforms?

What I was saying there was: it matters for platforms where they may not
have a git at all (because they're new, and we have a bit of a
bootstrapping problem), not just old ones where they're stuck on an old git.

Part of what I had in mind here is that sticking on old versions even
temporarily isn't necessarily a great option, see the recent issues w/
backports done (https://lore.kernel.org/git/xmqqldov4rpt.fsf@gitster.g/,
and https://lore.kernel.org/git/20250708210529.1214574-1-tmz@pobox.com/).

---

As a final note: I am genuinely not trying to be a member of the peanut
gallery wishing to prevent git's progress if the project wants to adopt
Rust, just there's some real practical obstacles for us right now.

I hope it didn't come across that way, but "dichotomy" appearing a few
times in your reply made me fear it did.

>
> Thanks,
> Elijah

thanks,
sam

>
> [1] Well, C-only other than optional Rust components like
> contrib/libgit-rs and contrib/libgit-sys that have already been
> released.
