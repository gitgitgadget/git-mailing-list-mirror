Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4793D5F860
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717525465; cv=none; b=Q93+24nsAejp49Uk55z6i2UsdykPjAaIwkl2zDq5sehOczXclsnNgjL4osMAUD/WAkzPCYs0K0EL5XZAmpOUVoNUG5SIyY574drmXvYWEiBD48tuCFU7NpTX76szHRCy/By8NmKyeXfMHqG5hfCSFQT/SQUeCCN7cUK+Kxi1pkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717525465; c=relaxed/simple;
	bh=CpNXlObG/edq5V0haSBXDMOGHwjWKzmkiA4hmkBEVes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hg9auP3yL9H3A+ZK7GF7jTsN17VtO2VAJi0c+w2UuD2kpU/DMZyTLXjCgKqiFXkzbJD5jeMHl+YbHE5Gmdh1PeFJ/yBtHQf3AbMfjAjUk2Z/ftFrFpkrdjXuPmVSEbOsc2G0MK7M1QwHzNIyGlHLd6ee3ec0PYUnxUfRcTCBozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j+Zwc7kq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j+Zwc7kq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0738D35FE4;
	Tue,  4 Jun 2024 14:24:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CpNXlObG/edq5V0haSBXDMOGHwjWKzmkiA4hmk
	BEVes=; b=j+Zwc7kq0qaA9D+EW/iV+HNWQR3MSBa+8GD/88dVhM5LFg4IWakejd
	w7vd4uBB0PxMQrUC6qZcRj+gNFWV7PpnpbvZXsbWGLMsaya08P/IpW4XPvE9y4mB
	iq7ardbmKCrT222/9o3xP1Z4kPkxr8oSaO9pLqRaahRcxgH+AP1Y8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F37D835FE3;
	Tue,  4 Jun 2024 14:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6424035FE2;
	Tue,  4 Jun 2024 14:24:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Aaron Plattner <aplattner@nvidia.com>
Cc: <git@vger.kernel.org>,  Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH] credential: clear expired c->credential in addition to
 c->password
In-Reply-To: <20240604180224.1484537-1-aplattner@nvidia.com> (Aaron Plattner's
	message of "Tue, 4 Jun 2024 11:02:20 -0700")
References: <20240604180224.1484537-1-aplattner@nvidia.com>
Date: Tue, 04 Jun 2024 11:24:15 -0700
Message-ID: <xmqqed9cva5s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A6BBFB62-229F-11EF-9B4A-6488940A682E-77302942!pb-smtp2.pobox.com

Aaron Plattner <aplattner@nvidia.com> writes:

> When a struct credential expires, credential_fill() clears c->password
> so that clients don't try to use it later. However, a struct cred that
> uses an alternate authtype won't have a password, but might have a
> credential stored in c->credential. Clear that too.

Hmph, piling another thing on top of these selected "discard/reset"
we already have should make us rethink a few things.

 - Is this the only place we discard/reset/clear?

 - Isn't there already a helper function that was DESIGNED to do
   this for us?

 - Are all these places we discard/reset/clear using that helper
   function?

For example, when we rejecting credential, shouldn't we be clearing
the same members of the structure as we notice that the auth material
is stale and has expired?

There is credential_clear() and credential_clear_secrets().  Would
one of these want to be reused in this (and also reject) context?
