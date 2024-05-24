Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74612C485
	for <git@vger.kernel.org>; Fri, 24 May 2024 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716567129; cv=none; b=bMb9VFmDOFQgBef3QiswbS8LxdCa3mthVbzWgULKJhDlZ8ZHE2WVhhV81cFudHZLiA+zqIADoTZq9acDwf4VN4sptST6rbM74h7tEchUJiVHmi6A95wq0RC5Rkg+/QsMPN3mDF6hUZNJu2yTr55voRYSrQ13o4gOUXEOAWhQPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716567129; c=relaxed/simple;
	bh=S3eOKNKRXKd9vJAvDLY9QF/KqyBLvniWcfbeiUyCNfU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WYLLJWRYbhZoej9wK2BeQg5/qlCluM/Kul+DLUIViZfXAX23fNNE6oimYNT/pja+fH/aV+uNVhzXt4u7b23bmbW3kQKl6p9+MQAQgpuikkrTjnqqI1FkVoEsp7P4pe3lnWCoqM0B1yxAOfPYE24tLT7hEp9Qp5IA7s/7TDqB1yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hHDJVw+q; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hHDJVw+q"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9CCF229BBF;
	Fri, 24 May 2024 12:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S3eOKNKRXKd9vJAvDLY9QF/KqyBLvniWcfbeiU
	yCNfU=; b=hHDJVw+qC1pnO9RUHUSEOA5/5701TCH+kpUoyUQQAPf/DPd5O3B9QA
	7Gxvf6U/LiUtwIZH0NW2tJESNzU9hGbLrtqfC9LoCymU+7kUvHE8ZUPMbQpnFWoD
	aPmKM9p79Abyuo6j7PXE71DVNns5B/S0eODW+OLFq4guHiKqvuCYk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9568629BBE;
	Fri, 24 May 2024 12:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B4CBF29BBD;
	Fri, 24 May 2024 12:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/20] config: plug various memory leaks
In-Reply-To: <ZlBV-QtqoNX-7m8a@tanuki> (Patrick Steinhardt's message of "Fri,
	24 May 2024 10:55:21 +0200")
References: <cover.1716465556.git.ps@pks.im>
	<b2f8878b55564c4bf4848642e419c44c1a9d9005.1716465556.git.ps@pks.im>
	<xmqq7cfkv4cr.fsf@gitster.g> <ZlA6jZmKomOu1p_S@tanuki>
	<ZlBV-QtqoNX-7m8a@tanuki>
Date: Fri, 24 May 2024 09:12:03 -0700
Message-ID: <xmqq8qzznq98.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5C8C1ADC-19E8-11EF-BD7B-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> I've changed my mutt configuration to prefer UTF-8 over ISO-8859-1, so
> the next iteration should hopefully work alright. But as you say, this
> is probably something that needs to be fixed in the git-am(1) machinery.

Yup, you can probably keep the preference to annoy me into looking
into the issue ;-)

Thanks.
