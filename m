Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574302D05E
	for <git@vger.kernel.org>; Fri,  3 May 2024 23:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777770; cv=none; b=fBuC71VMROLrQbHVOwLtTNXqfvXjajyMXSIGEzQY0Leyfy7eDRhBzSTu0hQCB3oG8U7DAYXkxOxtGjEM9uDd3NN1FwdMpFd4+TXVp4zXlO0qsFMUWMezuifXxhn15sjdmajnNoTvUcghkeVowTDRl7SY/8Itab7xf2endXUyTaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777770; c=relaxed/simple;
	bh=hc+2SAkiVWrtttoWwrVKGN+bdb4Ln7b6Q7AG352J/rQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hMiRdBAvS67BO5a2T+wH0H+wB8CoQzvq8d3e1SeTchvM4ffjMBFH5laVqc4DSwXsUbdvIRgi79qvnhWjpCK+1uD1TJMCKj+t+FoEexR4FMBj4T/S37FpTInzMKpxgdqKWPv63gwBjiDi2zN5CMYeyJWwEkliH184yEj0GWLTyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=E51/MYIJ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="E51/MYIJ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 03CC02CA62;
	Fri,  3 May 2024 19:09:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hc+2SAkiVWrtttoWwrVKGN+bdb4Ln7b6Q7AG35
	2J/rQ=; b=E51/MYIJcv7TDu0arnNrV7njCnAqXd5t3IhXOjmtRHaYi1QzBT+1g1
	ETaDM0Hck475J9If07474zB63u3Kzgs12ZqR89FWxW8HuvGMne0chgNeyYnEI+r+
	n8PKsYhH+tpv3z57joVkQooimJ+7+/03zTw+7i5cZNIuyg9ESsw0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EFC162CA61;
	Fri,  3 May 2024 19:09:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 612F42CA60;
	Fri,  3 May 2024 19:09:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v6 7/7] refs: remove `create_symref` and associated dead
 code
In-Reply-To: <20240503124115.252413-8-knayak@gitlab.com> (Karthik Nayak's
	message of "Fri, 3 May 2024 14:41:15 +0200")
References: <20240501202229.2695774-1-knayak@gitlab.com>
	<20240503124115.252413-1-knayak@gitlab.com>
	<20240503124115.252413-8-knayak@gitlab.com>
Date: Fri, 03 May 2024 16:09:25 -0700
Message-ID: <xmqqplu24hne.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2FDCF2E6-09A2-11EF-92D4-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> From: Karthik Nayak <karthik.188@gmail.com>
>
> In the previous commits, we converted `refs_create_symref()` to utilize
> transactions to perform symref updates. Earlier `refs_create_symref()`
> used `create_symref()` to do the same.
>
> We can now remove `create_symref()` and any code associated with it
> which is no longer used. We remove `create_symref()` code from all the
> reference backends and also remove it entirely from the `ref_storage_be`
> struct.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---

This has serious semantic conflicts with in-flight topics.  I think
I resolved them all correctly while merging it in 'seen', but please
double check the result after I push it out.

This comment equally applies to the "force all callers to use
get_main_ref_store() on the_repository and remove functions that
implicitly used the main ref store of the_repository" topic by
Patrick, but we really should devise a bit more smoother way to cope
with out of tree and in-flight topics.  For example, as the new
refs_update_symref() function works exactly like the existing
refs_create_symref() function, after renaming all the in-base (i.e.,
in-tree at the point this topic forks from) users to call the new
function, instead of just removing the original one, it would have
been nice to guide authors of other in-flight topics by (1) causing
build failure and at the same time (2) telling them what they need
to do to adjust to the new world order.  This patch does only (1)
but does a poor job for (2).  We may want to establish a better
convention than just outright removing and breaking others' topics.

Thanks.


