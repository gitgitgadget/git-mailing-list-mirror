Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1CC3CF5E
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723608631; cv=none; b=ec8opzg2xMLqGHwrcyZtPpNsw062VJdj0WyXulzC9A83KYC8jzofflWRE3/S84PcPqcw7P6Am7HTI1BjmdigWoMdAp8KVPjGAwp3dgxs/iTBpKnc/ZXbIlbTh4XOgHy3ZgVnIs5PJL12BDDqbq8n9JuK7Keq47hkBMxDqODtq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723608631; c=relaxed/simple;
	bh=rYzOs4feEw9NEGcKhoFi37lvLKaM1khREWm+W6279OU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lE6tUA/lfzsgnlr3oc9dmTddaNySzujen4//11spLy9feZ48/7b42VysR/703Og51VxA7cov/Oiws0tTUeumlEL2OCciB2XUjgJN0vowt5trsb4J4EOvzR0GL5mM1R+srfeaBdd5wmsfT7Msaf2AhIHxe0hyWFf5JOhXN0OYSQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=UTHIrjcs; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UTHIrjcs"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CAE023F86;
	Wed, 14 Aug 2024 00:10:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rYzOs4feEw9NEGcKhoFi37lvLKaM1khREWm+W6
	279OU=; b=UTHIrjcsX1RC5K7ihdJX4ZIKt+KHeqaY/fBenBmlb0Fbkk8cvknEML
	JZqC28mw13s9yJs2MZNwNXJ0WKcsZ87oKuMA/hlqvPAbfYB9LlLDN7IXUd7mUvZK
	Q8EQjx12qh5IOIEPKYY/2/mADFdkk4uwAhW0Q0F2Is+oCWqTR5kqM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 04AEB23F85;
	Wed, 14 Aug 2024 00:10:29 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 698FA23F30;
	Wed, 14 Aug 2024 00:10:25 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,
  xingxin.xx@bytedance.com,  jeffhostetler@github.com
Subject: Re: [PATCH 0/1] revision: fix reachable objects being gc'ed in no
 blob clone repo
In-Reply-To: <20240813171808.504427-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Tue, 13 Aug 2024 10:18:08 -0700")
References: <20240813171808.504427-1-jonathantanmy@google.com>
Date: Tue, 13 Aug 2024 21:10:23 -0700
Message-ID: <xmqqsev73ftc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2204E420-59F3-11EF-A1E1-E92ED1CD468F-77302942!pb-smtp21.pobox.com

Jonathan Tan <jonathantanmy@google.com> writes:

> Jonathan Tan <jonathantanmy@google.com> writes:
>> Solutions I can think of:
>
> One more thing that I just thought of regarding the solution in this
> patch. It seems to be to have a different separation of packs: all
> objects currently in promisor packs and all objects currently not
> in promisor packs. And the way it is done is to only exclude (in
> this patch, mark UNINTERESTING, although it might be better to have
> a separate flag for it) objects in promisor packs, but not their
> ancestors.

You're right to mention two separate bits, especially because you do
not want the "I am in a promisor pack" bit to propagate down to the
ancestry chain like UNINTERESTING bit does.  But isn't the approach
to enumerate all objects in promisor packs in an oidset and give a
quick way for is_promisor_object() to answer if an object is or is
not in promisor pack sufficient to replace the need to use _any_
object flag bits to manage objects in promisor packs?

> There are two ways we can go from here:
>
>  - Do not iterate past this object, just like for UNINTERESTING. This
>    would end up not packing objects that we need to pack (e.g. {C,T,B}2
>    below, if we only have a ref pointing to C3).
>
>   commit  tree  blob
>    C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
>    |
>    C2 ---- T2 -- B2 (created locally, in non-promisor pack)
>    |
>    C1 ---- T1 -- B1 (fetched from remote, in promisor pack)
>
>  - Iterate past this object (I think this is the path this patch took,
>    but I didn't look at it closely). This works, but seems to be very
>    slow. We would need to walk through all reachable objects (promisor
>    object or not), unlike currently in which we stop once we have
>    reached a promisor object.

Thanks for helping Han & Xinxin.
