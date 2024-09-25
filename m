Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7203482EB
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282939; cv=none; b=tc2xcSrEu+QA5xQvEecVC4cEbwLX5UfcNsnkVUbk6DAhjcPF51ILoT6jc7rUTHVP2OlCaCClhAw3ABedL3gyBxqHjaPpFyuklSUXWX/xwjA255ZdfnrP0gqUnU28ZnNS1mB+cCtumQusqRVqJ1ptVrkBBXY7ftas6cgnVZPN8ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282939; c=relaxed/simple;
	bh=e7lZ7H6h34RSUVAVToc17ZJuqBWQWCqEKVTNnlIvFCg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAMyQq9TMjYuCItkRh9LU7IqoiHYycFY2xN0+yRIdg7xK+Ku6DW2FMSZBlnW86cc+Ri+22u73IsfNEw2O/SQe8M1QxxWRWaslbd2c4rJk06vrkZpN5UkIzEmu7Gtu5na7U5+ErlZ063TE8/W/gF1Oli8svwrGdT5sdeEG0kslw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=fwK06u1q; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fwK06u1q"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99E632CDB8;
	Wed, 25 Sep 2024 12:48:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=e7lZ7H6h34RSUVAVToc17ZJuqBWQWCqEKVTNnl
	IvFCg=; b=fwK06u1qSjYE1s889lxajt633L8EGJMTC7Q2n6Hb/nITrpHCK1LtdD
	f6Mdi9FAnMQP26B00krF1m49C6dBXTILcUvfoPoxlGxPPn5FavnTJgKs07grkss0
	xZZP+U/1EUnK8824g0TxrzYBRhfP1qZprXu0gfmeFEDKkCdmOAqpY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F9BE2CDB7;
	Wed, 25 Sep 2024 12:48:56 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E34A92CDB6;
	Wed, 25 Sep 2024 12:48:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Han Young <hanyang.tony@bytedance.com>,  git@vger.kernel.org,
  calvinwan@google.com,  jonathantanmy@google.com,  sokcevic@google.com
Subject: Re: [PATCH 0/2] repack: pack everything into promisor packfile in
 partial repos
In-Reply-To: <a5e3322d-4e63-4b8c-84af-6578fe257cad@gmail.com> (Phillip Wood's
	message of "Wed, 25 Sep 2024 16:20:55 +0100")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240925072021.77078-1-hanyang.tony@bytedance.com>
	<a5e3322d-4e63-4b8c-84af-6578fe257cad@gmail.com>
Date: Wed, 25 Sep 2024 09:48:54 -0700
Message-ID: <xmqqfrpnptl5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0DBDFF56-7B5E-11EF-889F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I was wondering if it would be possible to cache the tip commits in
> promisor packs when repacking so that a subsequent repack only has to
> walk the commits added since the last repack when it is trying to
> figure out if a local object should be moved into a promisor pack.

I was wondering the same thing.  If packfiles (and bundles) record
the entry points and the exit points of the DAG, it would help quite
a bit.

> It would be helpful if the cover letter or commit messages discussed
> the tradeoffs of these changes and updated that document accordingly.

I like the suggestion very much.

Thanks for a review.
