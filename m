Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBD53D0A9
	for <git@vger.kernel.org>; Wed, 25 Sep 2024 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283805; cv=none; b=b7prs5A1qEDyDsg+DUJicynTTjvdFHmMTdRjNlwRfVzkYv9wb8vYLg3+CMdc+buYasDCJ3FNhGHDPYJqxZLekhFp+NkhQMtDzkuRgpYMrCjHZ0Bb3kBkFsm3/yE8iTNj9fVjQwbek5UrFdfisGROWosLhNjYuGKEW0GSCOwSNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283805; c=relaxed/simple;
	bh=4c8+1Dc5gJJSB62l1c8REbaJtp2D11gnjY1WVBkWIOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QfzUDVX4309V1N+Ci/bQNkuv48OupwapQIAMXh/UNnEyPxvdG37WqJRsgMwUiLqrXBIWfKYlMo/BCnmBraLiYnMiORLk9oe1q0M0cZqTsz+baHO5zoAqazRbeB0ggoUjqioLVdbaFDG4NOZszCdruNQsxy+n6jnUumMH8P4PmVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=R0DJ0CTb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="R0DJ0CTb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 184F82D197;
	Wed, 25 Sep 2024 13:03:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4c8+1Dc5gJJSB62l1c8REbaJtp2D11gnjY1WVB
	kWIOM=; b=R0DJ0CTbZFJR6sac5EgRKnjRpbLzwLa4F/Dei1bo0h8eNUMqQkAR3L
	3egv2zEfXh3g2oXZV8W8uxvwhxKXQJWOMK2IjZ9ltX9tgweENQZKkKW27/l8874j
	AN5wuEaJVysw6cjWuGtu7YLqUdUU3V/nNqJicEwabvEkg+xrL++eY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0D0D82D196;
	Wed, 25 Sep 2024 13:03:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 518742D195;
	Wed, 25 Sep 2024 13:03:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  jonathantanmy@google.com,
  sokcevic@google.com
Subject: Re: [PATCH 0/2] repack: pack everything into promisor packfile in
 partial repos
In-Reply-To: <20240925072021.77078-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Wed, 25 Sep 2024 15:20:19 +0800")
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
	<20240925072021.77078-1-hanyang.tony@bytedance.com>
Date: Wed, 25 Sep 2024 10:03:19 -0700
Message-ID: <xmqqwmizoeco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 12294648-7B60-11EF-9F4E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Han Young <hanyang.tony@bytedance.com> writes:

> By using 'repack everything', repacking requires less work and we are not
> using more bandwidth. The only downside is normal objects packing does not
> benefiting from the history and path based delta calculation. Majority of
> objects in a partial repo is promisor objects, so the impact of worse normal
> objects repacking is negligible.

There is an important assumption that any objects in promisor packs
*and* any objects that are (directly or indirectly) referenced by
these objects in promisor packs can safely be expunged from the
local object store because they can be later fetched again from the
promisor remote.  In that (in)famous failure case topology of the
history:

    commit  tree  blob
     C3 ---- T3 -- B3 (fetched from remote, in promisor pack)
     |
     C2 ---- T2 -- B2 (created locally, in non-promisor pack)
     |
     C1 ---- T1 -- B1 (fetched from remote, in promisor pack)

even though the objects associated with the commit C2 are created
locally, the fact that C3 in promisor pack references it alone is
sufficient for us to also assume that these "locally created" are
now refetchable from the promisor remote that gave us C3, hence it
is safe to repack the history leading to C3 and all objects involved
in the history and mark the resulting pack(s) promisor packs.

OK. That sounds workable, but aren't there downsides?

Thanks for working on this topic.

