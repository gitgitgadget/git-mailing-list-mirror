Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CF9196D94
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717686832; cv=none; b=PehwlZDy4vUatFpCYPdo9bF987toHkjL38+41/mJNNecM0QtZw85l6iCfmPHZ9Sn3Fu2aoDIDCh7vukwWGc8ZprBbBWc7Kd4Fw8hZ4JLGuvhhNw2bZunau5hbzNqKLqT+dPzzSrVne/Lb8Lg9V0YSPTr6fHwfW/YIvS4WQAFN9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717686832; c=relaxed/simple;
	bh=sjvg3QbAieJHftK8mgT60n5twD9/G+uAHqTAlafx7o0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gAkfIZmKkgOxVALexlvMwJWA5fbMOjAV7xpbiqzvidgZCH/iaO0lYcgiD/z60Gl9cBA2ZsgoAK+8ojKcDhUKOT8Q7+AKQXUWjdLj0jY0ozMfQmnXnj55vKOP9mxQv2wGXjjb+fdGiY8Bv+9deW9szeHLgrp+sCroFdxBNjEsmW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Cxr0Q0uz; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Cxr0Q0uz"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 97A2B23660;
	Thu,  6 Jun 2024 11:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=sjvg3QbAieJHftK8mgT60n5twD9/G+uAHqTAla
	fx7o0=; b=Cxr0Q0uzDSZ1vMormsA0lTBuLEw9kLyV4m6luIl6C4rW2K77DsZZ88
	mzxbw+gg9AHWdw3iSGV8Zoj5uhLXq//TXYGKZubJ08YV0Hj96jzkCdlvMRtZ5dVp
	icvGtvrs47fC9JPsOD/iSLmCkUHxFRquhfldrCq2tIx2iGifo8+HQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F6932365E;
	Thu,  6 Jun 2024 11:13:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB8872365A;
	Thu,  6 Jun 2024 11:13:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Aaron Plattner <aplattner@nvidia.com>,  git@vger.kernel.org,  Rahul
 Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify
 secret clearing
In-Reply-To: <20240606081054.GC658959@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 6 Jun 2024 04:10:54 -0400")
References: <20240604192929.3252626-1-aplattner@nvidia.com>
	<20240605085733.GE2345232@coredump.intra.peff.net>
	<xmqqtti7tj32.fsf@gitster.g>
	<20240606081054.GC658959@coredump.intra.peff.net>
Date: Thu, 06 Jun 2024 08:13:46 -0700
Message-ID: <xmqqed9ap0id.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F8520A6-2417-11EF-AEA6-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> items that reject() is clearing is the best one. So I'd just as soon
> leave it as a weird internal detail for now, rather than codifying it in
> a function.
>
> I dunno. I guess it is the same lines of code in either spot, but
> somehow sticking it in a clear_response() helper seems like an
> endorsement that the author knew what they were doing. ;)

True.  It probably belongs to too premature abstraction.  Thanks.

