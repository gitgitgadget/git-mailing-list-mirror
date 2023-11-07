Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D6B2115
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 02:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xIDlCfan"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9C129
	for <git@vger.kernel.org>; Mon,  6 Nov 2023 18:36:59 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5E0731C63E0;
	Mon,  6 Nov 2023 21:36:58 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hlXd+OwxOF4Zeu5ka3Y8JSCM3qFUbHFmnF9DQd
	/NyRU=; b=xIDlCfan7OijiEuRwnhdsbXCviNq2MThoJybdS2GRp0z0squInIhmr
	NPJqEyvIpVEwOHWN5rfGnC8CGaAcQ4DQH79RXRsXcS5lig7iP+1efTrkV4dkt+Ag
	mEdtbYZ6RHnwWEVAmxEOkfm0dNm3qzF694PfbtVHh90Hx/holm+qg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5431C1C63DF;
	Mon,  6 Nov 2023 21:36:58 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9767B1C63DC;
	Mon,  6 Nov 2023 21:36:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 0/9] for-each-ref optimizations & usability improvements
In-Reply-To: <pull.1609.git.1699320361.gitgitgadget@gmail.com> (Victoria Dye
	via GitGitGadget's message of "Tue, 07 Nov 2023 01:25:52 +0000")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
Date: Tue, 07 Nov 2023 11:36:56 +0900
Message-ID: <xmqqo7g69tmf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 856DFDB8-7D16-11EE-8ADF-25B3960A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series is a bit of an informal follow-up to [1], adding some more
> substantial optimizations and usability fixes around ref
> filtering/formatting. Some of the changes here affect user-facing behavior,
> some are internal-only, but they're all interdependent enough to warrant
> putting them together in one series.
>
> [1]
> https://lore.kernel.org/git/pull.1594.v2.git.1696888736.gitgitgadget@gmail.com/
>
> Patch 1 changes the behavior of the '--no-sort' option in 'for-each-ref',
> 'tag', and 'branch'. Currently, it just removes previous sort keys and, if
> no further keys are specified, falls back on ascending refname sort (which,
> IMO, makes the name '--no-sort' somewhat misleading).

We can read it changes the behaviour and what the current behaviour
is, but I presume that the untold new behaviour with --no-sort is to
show the output in an unspecified order of implementation's
convenience?  I think it makes quite a lot of sense if that is what
is done.

> Patch 2 updates the 'for-each-ref' docs to clearly state what happens if you
> use '--omit-empty' and '--count' together. I based the explanation on what
> the current behavior is (i.e., refs omitted with '--omit-empty' do count
> towards the total limited by '--count').

OK.

> Patches 3-7 incrementally refactor various parts of the ref
> filtering/formatting workflows in order to create a
> 'filter_and_format_refs()' function. If certain conditions are met (sorting
> disabled, no reachability filtering or ahead-behind formatting), ref
> filtering & formatting is done within a single 'for_each_fullref_in'
> callback. Especially in large repositories, this makes a huge difference in
> memory usage & runtime for certain usages of 'for-each-ref', since it's no
> longer writing everything to a 'struct ref_array' then repeatedly whittling
> down/updating its contents.

OK.  I was wondering if you are going threaded implementation, until
I read into 6th line ;-)

> Patch 8 introduces a new option to 'for-each-ref' called '--full-deref'.
> When provided, any format fields for the dereferenced value of a tag (e.g.
> "%(*objectname)") will be populated with the fully peeled target of the tag;
> right now, those fields are populated with the immediate target of a tag
> (which can be another tag). This avoids the need to pipe 'for-each-ref'
> results to 'cat-file --batch-check' to get fully-peeled tag information. It
> also benefits from the 'filter_and_format_refs()' single-iteration
> optimization, since 'peel_iterated_oid()' may be able to read the
> pre-computed peeled OID from a packed ref. A couple notes on this one:
>
>  * I went with a command line option for '--full-deref' rather than another
>    format specifier (like ** instead of *) because it seems unlikely that a
>    user is going to want to perform a shallow dereference and a full
>    dereference in the same 'for-each-ref'. There's also a NEEDSWORK going
>    all the way back to the introduction of 'for-each-ref' in 9f613ddd21c
>    (Add git-for-each-ref: helper for language bindings, 2006-09-15) that (to
>    me) implies different dereferencing behavior corresponds to different use
>    cases/user needs.

Makes quite a lot of sense.

>  * I'm not attached to '--full-deref' as a name - if someone has an idea for
>    a more descriptive name, please suggest it!

Another candidate verb may be "to peel", and I have no strong
opinion between it and "to dereference".  But I have a mild aversion
to an abbreviation that is not strongly established.

> Finally, patch 9 adds performance tests for 'for-each-ref', showing the
> effects of optimizations made throughout the series. Here are some sample
> results from my Ubuntu VM (test names shortened for space):

Nice.
