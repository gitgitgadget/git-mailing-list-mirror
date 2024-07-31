Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36E1401B
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722454500; cv=none; b=tDpnZWomT8V/kUc56NCzdas8grz5ze9Cyllsg5p+BZqF8/LclZkZRE2OZ5ryBLNDueldWZd/ineyLbWPmitgF16f1o4k6KqU53turwECYJ9gGd0DI4P7Kz79sXVXWA/GmCPXyQXPuhVky6EwOGpIuNZZkH2F6ZBdi1eT4Vm8IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722454500; c=relaxed/simple;
	bh=1yBQ2Jxb/t6/I100bjUxJYXPufk7yXYutoVmzENiLfs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gq+8b3LTUrW2JLTPtj8dBucyiR2kjxIvCloDAzLtYK8QCRqPCzgmin5I0D6s71u4dCFM9kmv1qvnFJGuzGjM8DJy2ghNEK8U6BjdMOFuxTm5MdA/eq2pbdCL0yrDVxpOUmWcBKVzh4pl/hOKl3enGVpI9GarPYkVRw+nUXSpLZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZfjyVsqa; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZfjyVsqa"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A8953B23F;
	Wed, 31 Jul 2024 15:34:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1yBQ2Jxb/t6/I100bjUxJYXPufk7yXYutoVmzE
	NiLfs=; b=ZfjyVsqaLUogNE/1DsxAfsH31uBdtaxDZmlYCRNVQ6UyFkBrktrmQ1
	bK9NBK5tmZHE2jk8Y4wKz0IUn0fCqYcMAff+GqeC73XVSyzaZn87lv1b9q/L6RKx
	dfXn19roRUay5cZHE16jD2PotviwUDSjK7KtdMIHwMHh+qYnNFsVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30E863B23E;
	Wed, 31 Jul 2024 15:34:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 924F03B23D;
	Wed, 31 Jul 2024 15:34:51 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <xmqqikwl2zca.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	31 Jul 2024 11:25:25 -0700")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-4-christian.couder@gmail.com>
	<xmqqikwl2zca.fsf@gitster.g>
Date: Wed, 31 Jul 2024 12:34:50 -0700
Message-ID: <xmqqzfpx1hk5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F4A6763A-4F73-11EF-BD43-BAC1940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Christian Couder <christian.couder@gmail.com> writes:
>
>> When a server repository S borrows some objects from a promisor remote X,
>> then a client repository C which would like to clone or fetch from S might,
>> or might not, want to also borrow objects from X. Also S might, or might
>> not, want to advertise X as a good way for C to directly get objects from,
>> instead of C getting everything through S.
>
> If S is a clone that is keeping up to date with X, even if it does
> not borrow anything from X, as long as X is known to be much better
> connected to the world (e.g., it is in a $LARGEINTERNETCOMPANY
> datacenter with petabit/s backbone connections) than S is (e.g., it
> is my deskside box on a cable modem), it may be beneficial if S can
> omit objects from its "git fetch" response to C, if C is willing to
> fill the gap using X.
>
> So it is of dubious value to limit the feature only to cases where S
> "borrows" from X, is it?

An even better example is if S on my deskside box is the source of
truth, and X in $LARGEINTERNETCOMPANY datacenter that is much better
connected is a publishing repository I use to push from S to X.

Even if you originally cloned from S and use S as your promisor
remote, as the operator of S, I would like you to always consult X
first to reduce the load on S when lazily fetching objects that you
are missing.
