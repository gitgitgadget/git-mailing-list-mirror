Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B418E
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 00:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710115670; cv=none; b=m5Nx2KBEadqu/nXv/Mh+reuyxBoBnt/pkdRKYXd5TXxOGGbOCBJi3HK9GfJtmLvgijCwXso+oIg1zytiP+d1vbb/05x06tgT5Xw65tGwRGE9LkWhfGqqJ3l6jN6i/nVao64l+9w/PI2tG63dDSix+yhG2XMycdVKF1GpIX6KiRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710115670; c=relaxed/simple;
	bh=Ilx7/WYMPcgkIhrIwVWq7tUAQALeTmowfXABXulzhI8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IZBR5DKCnvpSrVqwIG9C3eJzODY2gy5kljN+9mJ33wfFxljgz772MXAK+944q1AIVLk6EGE9KnOTL1yHUfJRuHBOCd2whpaOdVB0VmJzNg5bNgH7hLOXuv6+JZa9HzgXjzKKQIJj+qMY7DmCCe5hPVJjbVJFyEv1jvieU5jNAlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FOaDJHPF; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FOaDJHPF"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EE2351F411;
	Sun, 10 Mar 2024 20:07:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ilx7/WYMPcgkIhrIwVWq7tUAQALeTmowfXABXu
	lzhI8=; b=FOaDJHPFzmMyu8bnraA80NLkToIl53Tek95TsJKk0w/xzLKBdg4RMu
	C4QE23VPZGdyjXNRygnPOa64+CG2r+RGhw0YzglGgQ2ZMLyHmqsAOJYcDHXti+hU
	CHx7mVT/Aw7rFZL8WbGKc6jw7EPuhD4ivC0e0grg+ZOwgwdFq2jCk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D81171F410;
	Sun, 10 Mar 2024 20:07:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C12371F40E;
	Sun, 10 Mar 2024 20:07:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: git@vger.kernel.org,  newren@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/7] sequencer: treat error reading HEAD as unborn
 branch
In-Reply-To: <20240310184602.539656-5-brianmlyles@gmail.com> (Brian Lyles's
	message of "Sun, 10 Mar 2024 13:42:03 -0500")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240310184602.539656-5-brianmlyles@gmail.com>
Date: Sun, 10 Mar 2024 17:07:36 -0700
Message-ID: <xmqq4jddwrzr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E96D2DC-DF3B-11EE-90E0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Brian Lyles <brianmlyles@gmail.com> writes:

> When using git-cherry-pick(1) with `--allow-empty` while on an unborn
> branch, an error is thrown. This is inconsistent with the same
> cherry-pick when `--allow-empty` is not specified.

When cherry-picking on top of an unborn branch without the option,
how does the code figure out that we are on an unborn branch?  We
must be doing the detection, as we'd need to at least know the fact
that we are on an unborn in order to make the resulting commit a
root commit and also in order to apply the cherry-picked changes
against an empty tree.

> Treat a failure reading HEAD as an unborn branch in
> `is_index_unchanged`. This is consistent with other sequencer logic such
> as `do_pick_commit`. When on an unborn branch, use the `empty_tree` as
> the tree to compare against.

It is not a good code hygiene to assume that a failure to read HEAD
always means we are on an unborn branch, even if that is the most
likely cause of the failure.  We may instead want to positively
determine that we are on an unborn state, by seeing if the HEAD is a
symbolic ref that points at a ref in refs/heads/* hierarchy, and
that ref does not exist.

But if the existing sequencer code is littered with such loose logic
everywhere, perhaps imitating the looseness for now with a NEEDSWORK
comment to later clean them all up would be the least we could do
right now.  If we want to be more ambitious, a few clean-up patches
that refactors existing code paths that detect that we are on an
unborn branch into a call to a single helper function, and then
tightens its implementation, before doing this step would be even
better (but I offhand do not know how bad the current code is, so I
would understand it if it may turn out to be a lot more work than
you would want to invest in).
