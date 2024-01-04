Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD1C2D606
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eDsNjb5n"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C9B5120FE8;
	Thu,  4 Jan 2024 18:59:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=otzxmiPIf441vXVVV+STO+mup9GDBV4g+e+5yY
	GbKIQ=; b=eDsNjb5nu1IfEuxxPNV2jtzoYERKap9htLMx9bJkbkZSLONTidPaHK
	PI9bTCJ4WA9Mjg5EKB9DL68nBLWRW30PdlvUpvoeixZLesjbQROHIWr9J6+mhkOG
	oZlRZ2YtPCtl8BWKCRDiP++vRXWoKyuPpQvDtrNxSRarZEDrbQtbQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C1B4320FE7;
	Thu,  4 Jan 2024 18:59:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 62FBC20FE6;
	Thu,  4 Jan 2024 18:59:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,
  git@vger.kernel.org,  christian.couder@gmail.com
Subject: Re: [PATCH 2/2] ref-filter: support filtering of operational refs
In-Reply-To: <CAOLa=ZStP6F1njTeoQZwN58k+_0r9LT7z-wg2819FWZPq90wQg@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 4 Jan 2024 03:31:10 -0800")
References: <ZZRaOhK869S1Sg1h@nand.local> <ZZUgUUlB8A-rhep5@tanuki>
	<CAOLa=ZS4OOAmyRvf4HH-c_3GvnVkh6zS2kD3hEhRZ7NZT-rvyA@mail.gmail.com>
	<xmqqwmsqbhyt.fsf@gitster.g> <ZZWCXFghtql4i4YE@tanuki>
	<xmqqsf3ebe1l.fsf@gitster.g> <ZZWIlx-9D2r9AfDW@tanuki>
	<xmqqil4a9vue.fsf@gitster.g> <ZZWbMekL2URby0qV@tanuki>
	<xmqqedey9u32.fsf@gitster.g> <ZZWg5JvjQymy2wcn@tanuki>
	<CAOLa=ZStP6F1njTeoQZwN58k+_0r9LT7z-wg2819FWZPq90wQg@mail.gmail.com>
Date: Thu, 04 Jan 2024 15:59:19 -0800
Message-ID: <xmqq1qawr6p4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4774ED08-AB5D-11EE-B3AA-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Thanks all for the discussion, I'll try to summarize the path forward
> as per my understanding.

It has already been clear for the past 5 years or so since 3a3b9d8c
(refs: new ref types to make per-worktree refs visible to all
worktrees, 2018-10-21) that we need to treat "worktrees/foo/HEAD",
"worktrees/bar/refs/bisect/bad", etc. as something end-users can
access via the normal ref mechansim (by a resolve_ref() call that is
eventually made from get_sha1() when these are passed to say "git
log"); I just did not remember that one but that does not mean we
can suddenly change the rules.

So you'd probably need to tweak the end of your bullet point #3, but
other than that it is a great summary.

Thanks.

> 1. We want to introduce a way to output all refs. This includes refs
> under "refs/", pseudo refs, HEAD, and any other ref like objects under
> $GIT_DIR. The reasoning being that users are allowed currently to create
> refs without any directory restrictions. So with the upcoming reftable
> backend, it becomes important to provide a utility to print all the refs
> held in the reftable. Ideally we want to restrict such ref's from being
> created but for the time being, since thats allowed, we should also
> provide the utility to print such refs.
>
> 2. In the files backend, this would involve iterating through the
> $GIT_DIR and finding all ref-like objects and printing them.
>
> 3. To expose this to the user, we could do something like
>
>    $ git for-each-ref ""
>
> Which is a natural extension of the current syntax, where the empty
> string would imply that we do not filter to the "refs/" directory.
> It is still not clear whether we should support "worktrees".
>
> Any corrections here?
