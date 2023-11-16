Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FvddmLZ0"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8A619B
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 16:07:05 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A8AA1CF23E;
	Wed, 15 Nov 2023 19:07:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7aUg/2xClR5pqrLj3LiH2rbzDvudKQ/KDeIAb8
	rNFFo=; b=FvddmLZ0KGKQtEbO2IzZ86XcFSi7hinC9fFLnm4T578qIHMNGbiRpE
	DgihTllHGUK+TbPjm2BfCnpkjIx2BaxqE60P7xz9/qmwlYIPfi/6MXesxi6q+S86
	uK0zOwflCgACTJau5ciXLMLli3de5x757nIsGHfEOGIqRRvODEKYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 19F111CF23D;
	Wed, 15 Nov 2023 19:07:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13B151CF23C;
	Wed, 15 Nov 2023 19:07:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by default
In-Reply-To: <ZVTJFOSnVonoPgZk@tanuki> (Patrick Steinhardt's message of "Wed,
	15 Nov 2023 14:35:16 +0100")
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
	<ZVNNXNRfrwc_0Sj3@tanuki> <xmqq7cmkz3fi.fsf@gitster.g>
	<xmqqzfzgxops.fsf@gitster.g>
	<20231114194310.GC2092538@coredump.intra.peff.net>
	<ZVTJFOSnVonoPgZk@tanuki>
Date: Thu, 16 Nov 2023 09:07:01 +0900
Message-ID: <xmqqh6lmwogq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11FCD804-8414-11EE-BFE6-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Yeah. Just like we auto-enabled GIT_REF_PARANOIA for git-gc, etc, I
>> think we should do the same here.
>
> I'm honestly still torn on this one. There are two cases that I can
> think of where missing objects would be benign and where one wants to
> use `git rev-list --missing`:
>
>     - Repositories with promisor remotes, to find the boundary of where
>       we need to fetch new objects.
>
>     - Quarantine directories where you only intend to list new objects
>       or find the boundary.
>
> And in neither of those cases I can see a path for how the commit-graph
> would contain such missing commits when using regular tooling to perform
> repository maintenance.

I can buy the promisor remotes use case---we may expect boundary
objects missing without any repository corruption.  I do not know
about the other one---where does our "rev-list --missing" start
traversing in a quarantine directory is unclear.  Objects that are
still in quarantine are not (yet) made reachable from any refs, so
even "rev-list --missing --all" would not make a useful traversal,
no?

In any case, it sounds like you are not torn but are convinced that
we should leave this loose by default ;-) and after thinking it over
again, I tend to agree that it would be a better choice, as long as
the feature "rev-list --missing" has any good use case other than
corruption in repository.

So,... thanks for pushing back.
