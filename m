Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E214147C7F
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 15:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368171; cv=none; b=V/Z7KeY2J8drKjrITnrxgJbULzHobqpNbjvFag476LbMUGY3y9ur1QbHP78CcMmJOCNzpLmBxcgF43H8wjXi+adCkE4H9g/ovDGpbzIYLLgvpSWNI2wXaP9MqbAxiOARz2DTMlThR4np1sbqvJljLQIjZU9gUMYd3A+CK2L0h70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368171; c=relaxed/simple;
	bh=7/PMYm3Ssh4UzoD058Nt/JbQIY0m1wfdup4+NmxHz8E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MotD8tsgVcDoXDp2byYBmjKQ83/tCt3Pp2hOz1QdO71iuVsd5zzVlJw3qw3kJg+VH/OqDFi0+KbqVIyms0v3JXAoWexJ+w9S2DFzRC3ggfBo3e692ZSumlKo0ZJoxKEuYdOHej47487IswQDXkyY0BJu+uxmpW2HzI0YWYjEPWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=YltUXK/E; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YltUXK/E"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DEE65193C8;
	Wed, 17 Apr 2024 11:36:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=7/PMYm3Ssh4UzoD058Nt/JbQIY0m1wfdup4+Nm
	xHz8E=; b=YltUXK/EM74ZUQNnuffyT6VlykJEB4ZL2778iAuzj2rYL9eR9Cn5TG
	gzuqWal3vDC02hTrKltuXb7lnh5M+HgVBIQ/NpgFxd5xqFdFJnIfwGj3QCR0h6vx
	XoD6jgy4yc6PdY8jvt0/ykcXalaPL/Omzp6TvZrbEElf5nrgcTHNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D6C79193C7;
	Wed, 17 Apr 2024 11:36:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3C820193C6;
	Wed, 17 Apr 2024 11:36:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Use a "best effort" strategy in scheduled maintenance
In-Reply-To: <pull.1719.git.1713342535.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 17 Apr 2024 08:28:53
	+0000")
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
Date: Wed, 17 Apr 2024 08:36:03 -0700
Message-ID: <xmqq1q74atng.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 341B1B3C-FCD0-11EE-8A8F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Over in https://github.com/microsoft/git/issues/623, it was pointed out that
> scheduled maintenance will error out when it encounters a missing
> repository. The scheduled maintenance should exit with an error, all right,
> but what about the remaining repositories for which maintenance was
> scheduled, and that may not be missing?

Interesting.

As the order of the maintenance run across repositories is not
controlled by the end-user, I think it is reasonable to keep going
and finish the others, at least by default (if you could control the
ordering, you could make an arrangement where having ran maintenance
on repository A successfully would be necessary to do maintenance on
repository B, but we do not give that power to the end users).

> This patch series addresses this by introducing a new for-each-repo option
> and then using it in the command that is run via scheduled maintenance.

OK.
