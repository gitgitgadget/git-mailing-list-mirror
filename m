Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CFA56770
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710352326; cv=none; b=Yx74a60SMuoo/akaXHe14X3i9iMUvEfOQv0FY8INjtCvvQHeIrsWOklFnDxdkuvRclZoKdZ/7vatagEiD7gZXQKFT++EMvnxibCKIGDQZf21BCzVaxTnhEBLp+/W3yOL3YnlzHVxZ0k2ql7gBCOSkMVBe35WzDn05Zu71TADKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710352326; c=relaxed/simple;
	bh=9+2qrKszzQvRqjRXAA4gIlFu61HT4buH2AOxF9tyYVI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TH+V/zyU9dg+vF49d8k5aptAcZt66oh5uQ2HGNFEMvbXfOrXybX+IwoNT2Tjnabf+0eMdwKJXh9IlzFfOmMZ5E3jUDZM0BaQiLHSYRYHwZHf7gc5Sj1KbfHRLhSB35JJEx5d6VWEvfzLZvq6+Egb3b6C0zfySwxQRHAscJotH1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HWy41xOy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HWy41xOy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A41E2084C;
	Wed, 13 Mar 2024 13:52:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9+2qrKszzQvRqjRXAA4gIlFu61HT4buH2AOxF9
	tyYVI=; b=HWy41xOyLl88b6O1BqJWbcbxCYSxE0RM9RAindTDDWojuCTbVJyQtJ
	7uUzhl7eHoEL83i27hR9wAcmCRlWtXULRjFF6HpzVmDSf3LpN3RxFdp7l1aAnruz
	tKXOr1tWdAeh3RcXCslWtCaC5D1Jx4l8PqwDSsmY/mMFxWg6pgUtg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5341C2084B;
	Wed, 13 Mar 2024 13:52:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 009C820849;
	Wed, 13 Mar 2024 13:52:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Atneya Nair <atneya@google.com>
Cc: git@vger.kernel.org,  jeffhost@microsoft.com,  me@ttaylorr.com,
  nasamuffin@google.com,  Tanay Abhra <tanayabh@gmail.com>,  Glen Choo
 <glencbz@gmail.com>
Subject: Re: [RFC PATCH 2/3] Make ce_compare_gitlink thread-safe
In-Reply-To: <CA+D9mTHD6iwXuSdgAg1JZHYu1s0G6y8Kgv07V_JUkKU2Kcm_vA@mail.gmail.com>
	(Atneya Nair's message of "Tue, 12 Mar 2024 15:15:29 -0700")
References: <20240305012112.1598053-2-atneya@google.com>
	<20240305012112.1598053-4-atneya@google.com>
	<xmqqwmqg38u2.fsf@gitster.g>
	<CA+D9mTHD6iwXuSdgAg1JZHYu1s0G6y8Kgv07V_JUkKU2Kcm_vA@mail.gmail.com>
Date: Wed, 13 Mar 2024 10:51:59 -0700
Message-ID: <xmqqedcec94w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 64DB168E-E162-11EE-9A90-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Atneya Nair <atneya@google.com> writes:

> What is the appropriate way to split an intermediate patch into two? Simply
> adding the additional commit as 3 of 4 would cause a mismatch between patch-set
> versions? Would that cause any issues?

If you have three patch series originally and the second one is too
big, then you'd end up with four patch series whose second and third
corresponds to the second patch of the original series, and the last
patch of the updated series that is numbered 4 will correspond to
the third one from the original.  That is perfectly normal and you
can see the correspondence with help from tools like range-diff.
