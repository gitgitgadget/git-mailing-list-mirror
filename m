Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4327ED
	for <git@vger.kernel.org>; Wed,  8 Nov 2023 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QosIXZs6"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951D510C0
	for <git@vger.kernel.org>; Tue,  7 Nov 2023 17:26:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B92B31C5A93;
	Tue,  7 Nov 2023 20:26:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=C17CS7E3kJV5iuMGHgC5chQdIZHbc8tkUugNYe
	oRFQI=; b=QosIXZs6zMFudhS/EEy/VZG4phtZxLdxCwzuBYMGOQVk9Mi8eY5HSh
	USxnB/kZHO/cCi+0CKHpSn/znl598dFHMPG/SL5pBNiLQZnTO12m73FHev3OC6pE
	7UsTpx+h4YshZcZm9hX/qUoXhm5GP2/dyXtYkN+TBPP7uB5laIM88=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A97D31C5A92;
	Tue,  7 Nov 2023 20:26:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A1821C5A86;
	Tue,  7 Nov 2023 20:26:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Sam James via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Sam James <sam@gentoo.org>
Subject: Re: [PATCH] diff: implement config.diff.renames=copies-harder
In-Reply-To: <CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
	(Elijah Newren's message of "Tue, 7 Nov 2023 09:19:48 -0800")
References: <pull.1606.git.1699010701704.gitgitgadget@gmail.com>
	<CABPp-BEuvjduS4JiORJybKtoPWvJd+BbbR_JAvZdj4Px_v8H4A@mail.gmail.com>
	<xmqq7cmu9s29.fsf@gitster.g>
	<CABPp-BF9iUkF+g_w7wLATFTmjfJ3f1hsBr+zXxNZEcq-XiNOWg@mail.gmail.com>
Date: Wed, 08 Nov 2023 10:26:05 +0900
Message-ID: <xmqqttpx828i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB49D18A-7DD5-11EE-885A-25B3960A682E-77302942!pb-smtp2.pobox.com

Elijah Newren <newren@gmail.com> writes:

>> True.  "often copies of a previous version" means that it is a
>> directory that has a collection of subdirectories, one for each
>> version?  In a source tree managed in a version control system,
>> files are often rewritten in place from the previous version,
>> so I am puzzled by that justification.
>>
>> It is, in the proposed log message of our commits, a bit unusual to
>> see "This patch does X" and "I do Y", by the way, which made my
>> reading hiccup a bit, but perhaps it is just me?
>
> I think I read Sam's description a bit differently than you.  My
> assumption was they'd have files with names like the following in the
> same directory:
>    gcc-13.x.build.recipe
>    gcc-12.x.build.recipe
>    gcc-11.x.build.recipe
>    gcc-10.x.build.recipe
>
> And that gcc-13.x.build.recipe was started as a copy of
> gcc-12.x.build.recipe (which was started as a copy of
> gcc-11.x.build.recipe, etc.).  They keep all versions because they
> want users to be able to build and install multiple gcc versions.

OK, "previous version" is within the context of "variants of gcc",
and to us, there is no distinction among them (we do not care which
ones are older than the others---we need to keep track of them all).

Which makes sense.  OK.

> I find that marginally better; but I still don't think it answers the
> user's question of why they should pick one option or the other.  The
> wording for the `--find-copies-harder` does explain when it's useful:
>
>         For performance reasons, by default, `-C` option finds copies only
>         if the original file of the copy was modified in the same
>         changeset.  This flag makes the command
>         inspect unmodified files as candidates for the source of
>         copy.  This is a very expensive operation for large
>         projects, so use it with caution.
>
> We probably don't want to copy all three of those sentences here, but
> I think we need to make sure users can find them, thus my suggestion
> to reference the `--find-copies-harder` option to git-diff so that
> affected users can get the info they need to choose.

"in addition to paths that are different, will look for more copies
even in unmodified paths" then?
