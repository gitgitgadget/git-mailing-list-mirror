Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836639FE3
	for <git@vger.kernel.org>; Sun, 21 Jan 2024 22:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876907; cv=none; b=Fe+lir1Pgdd1WfEy6kbMdbJWEa0/qP8ZKgBM9XTcAC/0F/MwxLz0h4PNqWzEdM8W4A6HsiM99snWOv60BUdWfvTFUYLuZaeZWU+MKF03881yemDRguEgpqZ1e2L0V4gRqoIVOmuLUc6s2bduA7P7LTt1AIp7xfEFJdfTt54hVw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876907; c=relaxed/simple;
	bh=8z6jj1U5oPWVwkHnkF9EwmrXKlgKzdikcBAN0xD1MBY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CZqwZKmHfiSswCNw7OVd4Aq9htUV5TPPbv6h03VdMmi24Lno7DGJ9jlwNdVAQLNnXc7BfNomTN9UZrXiUemBCrmfFPtR6o4EkJBKX59P+UMIT50zaD7Ibo1qbCqc/1ka27Ga2UdimCTw/XOIzcJEUKKFJwf9x5yjBsjQIAu/XuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wc19ljcv; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wc19ljcv"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 078CA1E60B3;
	Sun, 21 Jan 2024 17:41:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8z6jj1U5oPWVwkHnkF9EwmrXKlgKzdikcBAN0x
	D1MBY=; b=Wc19ljcv6GMdffc6A07S5Kq4KjcfftU5LSsT/Cxe04OgPLurE3l+6w
	FNm3qL+XGVmZFKE06pSbIxVBu+x8Hyv9Vpw6z12qNBzdJnc1UaXXXE97RrZg27XL
	G9cjSeb5IBWhrnSdxER5Q4RwlENm/XqeK5ojZdsM7/1tCUIyS8Gm4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F09241E60B2;
	Sun, 21 Jan 2024 17:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 593EF1E60B1;
	Sun, 21 Jan 2024 17:41:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Brian Lyles <brianmlyles@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Taylor Blau
 <me@ttaylorr.com>,  Elijah Newren <newren@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 4/4] cherry-pick: Add `--empty` for more robust
 redundant commit handling
In-Reply-To: <CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
	(Brian Lyles's message of "Sun, 21 Jan 2024 12:28:11 -0600")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240119060721.3734775-5-brianmlyles@gmail.com>
	<06eb93d7-7113-4583-9860-28a6a6d528a2@app.fastmail.com>
	<CAHPHrSddqTEjtfhgVJ=vmRhbtuwXcGEiE1KFZqR1QhKw-HDtSg@mail.gmail.com>
Date: Sun, 21 Jan 2024 14:41:37 -0800
Message-ID: <xmqq8r4ie2ce.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3D173966-B8AE-11EE-8F3E-25B3960A682E-77302942!pb-smtp2.pobox.com

Brian Lyles <brianmlyles@gmail.com> writes:

>> Trailing whitespace on this line.
>
> Thank you -- This will be corrected with v2.
>
> Is the sample pre-commit hook the ideal way to prevent this in the
> future?

The example we ship in templates/hooks--pre-commit.sample in our
source has such a check at the end of it.

