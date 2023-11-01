Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327F10EE
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 01:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H0oxGZID"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A1E8
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 18:42:58 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 19A901FAD7;
	Tue, 31 Oct 2023 21:42:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=YgowQgDcT7ws
	FhDPN0wlOUVK25ScNE1o4Zpw3oJRV3s=; b=H0oxGZIDDj/B4UzdbZKfT1l341CY
	W0SaACHgjLVD7eTjfcd5GBRUQxrkDQ0ohlruu5snE9FxQZPJSbn87PT2GEhgBN2f
	2ZH5MpsGa/YFC2WubABBqAI80drqobxocNjygmPN6eGwe3y3yh9QsafxvvR2P9Cc
	Ju+AiO8OT9JKgpg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 122AD1FAD6;
	Tue, 31 Oct 2023 21:42:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A747F1FAD5;
	Tue, 31 Oct 2023 21:42:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
Cc: "Josh Soref" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Ruslan
 Yakauleu" <ruslan.yakauleu@gmail.com>,  "Taylor Blau" <me@ttaylorr.com>
Subject: Re: [PATCH] merge: --ff-one-only to apply FF if commit is one
In-Reply-To: <cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Tue, 31 Oct 2023 09:32:55 +0100")
References: <pull.1599.git.git.1698224280816.gitgitgadget@gmail.com>
	<ZUALkdSJZ70+KBYq@nand.local> <xmqq1qdb8wzk.fsf@gitster.g>
	<cb166ed4-b8b5-4120-b546-e878445573b6@app.fastmail.com>
Date: Wed, 01 Nov 2023 10:42:53 +0900
Message-ID: <xmqqa5ryxn8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 FA0290EE-7857-11EE-96F8-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:

> I think it=E2=80=99s about the `--first-parent` view. Then you get a on=
e-commit
> view of each pull request that was merged. For a merge commit it serves=
 as
> a summary of multiple commits. And a merge commit of one commit would
> serve as a summary of one commit. So in that case you remove that extra
> level of indirection.

Yeah, I understand that position very well. After all, I was heavily
involved in the introduction of the first-parent view to the system
at around 0053e902 (git-log --first-parent: show only the first
parent log, 2007-03-13).  Soon after that, d66424c4 (git-merge: add
--ff and --no-ff options, 2007-09-24) added --no-ff to make it easier
to maintain the first-parent worldview.

Strictly speaking, the log message on a merge commit serves two
purposes, one is to summarize commit(s) on the side branch that gets
merged with the merge, and as you said above, it is not needed when
merging a topic with just one commit.  But the other is to justify
why the topic suits the objective of the line of history (which is
needed even when merging a single commit topic---imagine a commit
that is not incorrect per-se.  It may or may not be suitable for the
maintenance track, and a merge commit of such a commit into the
track can explain if/how the commit being merged is maint-worthy).

A project that does not need the latter can do without a "--no-ff"
merge of a single commit topic.

> But the pull request is already given: it either has one commit or
> several. And you can for sure look at it and either argue that it shoul=
d
> be reduced (squashed) to one commit or maybe expanded (split out) into
> several commits.
>
> The point at which you use such a merge feature is when you are already
> happy with the pull request (or patch series or whatever else). And the=
n
> you (according to this strategy) prefer to avoid merge commits for
> single-commit pull requests.

But that argues against the "--ff-one-only" option, doesn't it?

If you looked at the side branch before you decide to merge it, you
know if the topic has only one commit (in which case you decide not
to use "--no-ff"), or if the topic consists of multiple commits (in
which case you decide to use "--no-ff").  And the only effect to
have the "--ff-one-only" option is to allow you *not* to look at
what is on the side branch.

Thanks.

