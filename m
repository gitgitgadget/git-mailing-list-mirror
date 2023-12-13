Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qi9PwbOg"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6428B0
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 16:36:29 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D03A301BA;
	Tue, 12 Dec 2023 19:36:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=G4ifb5fRWm3MfqhyBbodaEt8lJwxvnPy2kpO0+
	mTgoY=; b=Qi9PwbOgbkqww7RPElhMpCtw3TPNWst3fgSWhNuOWFH4BAu4Mze0YN
	yv0dmrZ6e4Mv8sodfYdHe6nP/lD41COEyV/YJOD4Q7JEQZmX/hVSl8YQ+qSKuXoj
	5RHjxE5xxaTt+Wpk9GwAYeMOCT3GfqM6lW63i/kxi+E8MJVUyRwbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 26547301B9;
	Tue, 12 Dec 2023 19:36:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C3213301B7;
	Tue, 12 Dec 2023 19:36:25 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 1/4] wt-status: read HEAD and ORIG_HEAD via the refdb
In-Reply-To: <ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
	(Ramsay Jones's message of "Tue, 12 Dec 2023 23:32:37 +0000")
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
	<1db3eb3945432964aabe1c559db4c3ac251e83fd.1702365291.git.ps@pks.im>
	<xmqqle9zqidj.fsf@gitster.g>
	<ac84b1b9-2381-406a-b459-6728bf9f8704@ramsayjones.plus.com>
Date: Tue, 12 Dec 2023 16:36:24 -0800
Message-ID: <xmqq34w7os53.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A5CC37A0-994F-11EE-9A1E-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> "via the refdb" -> "via the refs API" or something here and on the
>> title, and possibly elsewhere in the proposed log messages and
>> in-code comments in patches in this series, as I've never seen a
>> word "refdb" used in the context of this project.
>> 
>> I agree it is bad manners to be intimate with the implementation
>> details of the how files-backend stores HEAD and ORIG_HEAD.
>
> Hmm, I have never thought of the 'pseudo-refs' as being a part of
> the 'reference database' at all. ;)

Me neither, but once you start thinking about getting rid of the
need to use one-file-per-ref filesystem, being able to maintain all
refs, including the pseudo refs, in one r/w store backend, becomes a
very tempting goal.  From that point of view, I do not have problem
with the idea to move _all_ pseudorefs to reftable.

But I do have reservations on what Patrick, and the code he
inherited from Han-Wen, calls "special refs" (which is not defined
in the glossary at all), namely, refs.c:is_special_ref() and its
callers.  Neither am I very much sympathetic to the hardcoded list
of "known" pseudorefs, refs.c:pseudorefs[].  I cannot quite see why
we need anything more than

    any string that passes refs.c:is_pseudoref_syntax() is a
    pseudoref, is per worktree, and ref backends can store them like
    any other refs.  Many of them have specific meaning and uses
    (e.g. HEAD is "the current branch").

Enumerating existing pseudorefs in files backend may need to
opendir(".git") + readdir() filtered with is_pseudoref_syntax(),
and a corresponding implementation for reftable backend may be much
simpler (because there won't be "other cruft" stored there, unlike
files backend that needs to worry about files that are not refs,
like ".git/config" file.

> We seem to have pseudo-refs, special pseudo-refs and (recently)
> ex-pseudo-refs!
>
> This patch (well series) changes the 'status' of some, *but not all*,
> pseudo-refs; some graduate to full-blown refs stored as part of *a*
> reference database (ie reftable).

Yeah, that leaves bad taste in my mouth, too.
