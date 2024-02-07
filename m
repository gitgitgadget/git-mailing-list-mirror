Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAACC149E14
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707344165; cv=none; b=QC/F+unOKe+xkFSf/OqNDfSWSxeyYIDEUMBhdaes12vBRU1UpyWpn5kgWs6gMBJPFUnwpek1UvMnAwnupeXfywtmodIIwcOOAQCD/zw6xJ9Akx5jIbTbtsNLDp6zkw0g4CvIhDFINkpT71vjtfWhkeRVduel3/uHjKOk7EPOu44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707344165; c=relaxed/simple;
	bh=V88NlKM7B2dTJjlwwWf47hxYjbhL2fGl3Y1YFuRZFAc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eYB0jW2jJ5ZM6iJto+CaaH8J1YVFn0X3boXOSfJtEyr+aI1IhbC4ic1vC5lMQHjWR6zm9db86LNzVPi1SrGUebMB9hWXbWID3p5JrGlAHKsIuM2gGkL/RbydGk9M1WcKxr6y84gP/Pukaepp48WQvy5KkNqrCF/7NLK7gXoYp0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y3P3xfQx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y3P3xfQx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4233B2C0C9;
	Wed,  7 Feb 2024 17:16:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=V88NlKM7B2dTJjlwwWf47hxYjbhL2fGl3Y1YFu
	RZFAc=; b=Y3P3xfQxp5daKvLecXsZfL0cswdctK2umuW1ge8zLIUnojRAaTYCRb
	ppw4QrtNIwWAbFXP/qMOQcTTMIaNZHXLhtqc/IBeoMIRA5+4nwXKhUF6RaUV53iH
	AQQp+d5IwhN4eH0oG5Z9knbxswj92e0SJkxCvBMiNdzdFzqy/xMv0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 3C01F2C0C8;
	Wed,  7 Feb 2024 17:16:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5E8C2C0C2;
	Wed,  7 Feb 2024 17:15:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] apply with core.filemode=false
In-Reply-To: <20231226233218.472054-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Tue, 26 Dec 2023 15:32:15 -0800")
References: <pull.1620.v3.git.1703066893657.gitgitgadget@gmail.com>
	<20231226233218.472054-1-gitster@pobox.com>
Date: Wed, 07 Feb 2024 14:15:58 -0800
Message-ID: <xmqqzfwb53a9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7919D972-C606-11EE-B61D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Chandra Pratap noticed that "git apply" on a filesystem without
> executable bit support gives a warning when applying a patch that
> expects the preimage file to have executable bit on.  Dscho noticed
> that the initial fix by Chandra did not work well when applying a
> patch in reverse.  It turns out that apply.c:reverse_patches()
> invalidates the "a patch that does not change mode bits have the
> mode bits in .old_mode member and not in .new_mode member" invariant
> we rely on.
>
> Here is the result of concerted effort.
>
> Chandra Pratap (1):
>   apply: ignore working tree filemode when !core.filemode
>
> Junio C Hamano (2):
>   apply: correctly reverse patch's pre- and post-image mode bits
>   apply: code simplification
>
>  apply.c                   | 16 +++++++++++++---
>  t/t4129-apply-samemode.sh | 27 +++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 3 deletions(-)

Anybody wants to offer a review on this?  I actually am fairly
confortable with these without any additional review, but since I am
sweeping the "Needs review" topics in the What's cooking report, I
thought I would ask for this one, too.

