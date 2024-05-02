Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8626F16FF23
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714668694; cv=none; b=gYNJk8gopY656udqL6Aiks0MgcToyB3pOUD/REBSne+TQElBbIqCu7240egEWMK8yTMj7zxQd326M3OT8IexoVPDgF5GZbqu6eE6DmhxRlTMhDesh0ge2VpCY3amdJ7avkAGfBIMmI+Ty0R1UGYgTemQ9JYJ06gcfC1CR07QgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714668694; c=relaxed/simple;
	bh=NVwevJ8rZzRcMWD5J4YWdrxlHL1+LaaJ7ZWFgC7zBhc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PGLL4id81MQhpYvY54TDDlDK9dDrNrG+56WUbdoZ5yNYlh0X8gNLHLHGlj211WkP3NabZ06l6A5H1sHtk2XBd0DXSdO/GqN8/xumYU4wineYohgjGfOgjGWe70Ubn6AZIDvrgiVRChGmS146MIkxnkZHdiPRjsxqOpAd3DDqt5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LfNg9hbF; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LfNg9hbF"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EEE1F31FEB;
	Thu,  2 May 2024 12:51:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NVwevJ8rZzRcMWD5J4YWdrxlHL1+LaaJ7ZWFgC
	7zBhc=; b=LfNg9hbF8aWkZeEhG5spBjcxlimDK74Fu9PAiWeQgW3kSzwY27cAHu
	VdxzZf2VwxqkGlU23pNwmMvXx1524dR1tH+17P8o0a8Rn0S6GN9+I3tc3jYIm5Pu
	KlL11Ox9JoVR4+bS2Xv/XhhJYgVsTJmLqxhNvA/cK+2sSYtm+LbNM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E832431FEA;
	Thu,  2 May 2024 12:51:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 73C5431FE9;
	Thu,  2 May 2024 12:51:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org
Subject: Re: [PATCH v5 4/7] refs: add support for transactional symref updates
In-Reply-To: <ZjNFC6A5j5hMQ5VA@tanuki> (Patrick Steinhardt's message of "Thu,
	2 May 2024 09:47:23 +0200")
References: <20240426152449.228860-1-knayak@gitlab.com>
	<20240501202229.2695774-1-knayak@gitlab.com>
	<20240501202229.2695774-5-knayak@gitlab.com>
	<xmqqbk5pgke0.fsf@gitster.g>
	<CAOLa=ZQkTM26wmGgj3=Pz9p7-nFAWQdxCA=RjaJVSm2m8zn7jQ@mail.gmail.com>
	<ZjNFC6A5j5hMQ5VA@tanuki>
Date: Thu, 02 May 2024 09:51:27 -0700
Message-ID: <xmqq4jbgf980.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 38F3833A-08A4-11EF-BB0C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I wouldn't say we can't do that. We already do log when symrefs become
> dangling when updating references via HEAD by logging a zero OID as new
> OID. That is, if we have "HEAD -> refs/heads/foo" and you delete the
> latter, then we create a new reflog message for "HEAD" with zero OID as
> new OID.
>
> I would claim that the current behaviour where we don't create a reflog
> entry when updating a ref to become dangling is a mere bug. I think it's
> fair to declare this a #leftoverbit and handle it in a follow-up patch
> series. But it would be nice to say so in an in-code comment.

I like that.  Thanks.
