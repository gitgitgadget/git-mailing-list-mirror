Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78B919CD00
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923870; cv=none; b=MknnO7FS3th+Yk2oPFOgKnHXLNPvhDiAP1yjrJTy1uh95m2zF2/co5iyPPnhwKmLah+9H3Sok7ljU1YEv6y3I14JbkASryv/8k9T3JZZw2wX+Ewf/oE5/8YMCiX69Ky+EZWn2vZgaSyrJUV3caTS82wJ0K6lR97dTuWrzbsTSOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923870; c=relaxed/simple;
	bh=b9cvILU8Z/Sh7ZGxvS1UTBYMqQtsZ/8hOlxr6HzPntM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sfk2H7FvDK1eGY+VzM7BUU6d8dCOjN4UkC2zSQsm8fsmHR1rz7jlSwjTNqNrltERY6JVLjaA3XJaKSySa2+1ikvyCRpqURb/0wlabcwKwyuSY8sc4V+zrlHdFVOB1bQ5Zr59xFPBBA73sV0Rqqt7UgcZqsfK1WponMeTFBpatK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=apFcipIq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="apFcipIq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 974C035EE6;
	Thu, 25 Jul 2024 12:11:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=b9cvILU8Z/Sh7ZGxvS1UTBYMqQtsZ/8hOlxr6H
	zPntM=; b=apFcipIqnpuyWpSmWZP5LzOx+W5pk/6Q7KIs9FIsHFXaoyIDBzhg6D
	wTfLpEDIGU9fTKj0CDWHgsuC/2drGk7B+jw9p9LyOCcQknr0sGCE4v70AMieSZ+u
	hIAcak4KXi37XJLzCY3ej7jZCSIXsZVbZDsUI/rFErLemGd+VBt5o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 88BE935EE5;
	Thu, 25 Jul 2024 12:11:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A39A35EE2;
	Thu, 25 Jul 2024 12:11:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] safe.directory: normalize the configured path
In-Reply-To: <5332f244-7476-492a-a797-2ef7ba73f490@gmail.com> (Phillip Wood's
	message of "Thu, 25 Jul 2024 10:45:37 +0100")
References: <20240720220915.2933266-1-gitster@pobox.com>
	<20240723021900.388020-1-gitster@pobox.com>
	<20240723021900.388020-3-gitster@pobox.com>
	<5332f244-7476-492a-a797-2ef7ba73f490@gmail.com>
Date: Thu, 25 Jul 2024 09:11:05 -0700
Message-ID: <xmqqbk2ljvty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7F86F154-4AA0-11EF-9596-BAC1940A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think this is sensible if the key is an absolute path, if the key is
> a relative path I think we should ignore it as it is not clear which
> directory the user meant.

The only thing that worries me in that proposal is that doing so
would break a configuration that used to work.  I'd rather leave
the tightening of it to future work with its own justification.

Thanks.

