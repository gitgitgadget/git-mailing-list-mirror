Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A7C1993A3
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 21:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718658904; cv=none; b=tPDe6eDzcn/g4I5aRO6usIxXP8pMAyZBWec6y1DDXFDKhYfiDgFTSLv7DzEJ75ADVjChNGzrbj7432I48HBDjgKQIJ75koJfzI+vGVFzJBp0LqN9vkShR3iBj/kEJ5UCDfGi6+liBX7hAKtGKTlx3YYk5veCiBBoMi01vdlYx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718658904; c=relaxed/simple;
	bh=8DErNisvHpiQRscp7wTeLYiLK4odwBbbggH4OQiOpLM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vE0oTWGdHdKm3lOsdutIG8TJSubrUbKfhsrSVW+fpuxWMfOWtTzcWg04ZPqQ/4tqdrC9u9fee/6mB18cf9LAg4pMZ5z+IqIYj2Lr9hUAs29W+aZoMxQ8abixKcfYIMnhjTbo1UajfAWDhsqVqtkJmCC7EoFfa+aeegq4mTgaDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JhBc0MNZ; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JhBc0MNZ"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B2D513632B;
	Mon, 17 Jun 2024 17:15:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8DErNisvHpiQRscp7wTeLYiLK4odwBbbggH4OQ
	iOpLM=; b=JhBc0MNZZPJS0pr7J/rKFcsm1UxmE6eMjl0HJQrlqd7tTZuw1sxMze
	lFY3VBvaJ9ytZqeYUjuEX8uwC2Qv+MGIF+66kWfWUUtYjOdOFgl5AnZNHhIJWrEk
	xR+Ew/Nh/FHvui0TwaRP9AhG8D7u+NuLhpE/pDmHoUGvcJeuMn3VI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AB2353632A;
	Mon, 17 Jun 2024 17:15:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4492436326;
	Mon, 17 Jun 2024 17:14:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kyle Lippincott <spectral@google.com>
Subject: Re: [PATCH] attr: fix msan issue in read_attr_from_index
In-Reply-To: <xmqqcyof5n2t.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	17 Jun 2024 13:30:34 -0700")
References: <pull.1747.git.1718654424683.gitgitgadget@gmail.com>
	<xmqqcyof5n2t.fsf@gitster.g>
Date: Mon, 17 Jun 2024 14:14:57 -0700
Message-ID: <xmqqwmmn46ge.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A7546F38-2CEE-11EF-9F62-C38742FD603B-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Having said all that ...
>
>> Make the call to `read_attr_from_buf` conditional on `buf` being
>> non-NULL, ensuring that `size` is not read if it's never set.
>
> ... this makes the logic at the caller crystal clear, so even if
> there are suboptimal checker that bothers us with false positives,
> the change itself justifies itself, I would say.

Well, "even if there were *no* MSAN or other issues wrt usage of size"
was what I wanted to say.  Sorry for a noise.

>>  	} else {
>>  		buf = read_blob_data_from_index(istate, path, &size);
>> -		stack = read_attr_from_buf(buf, size, path, flags);
>> +		if (buf)
>> +			stack = read_attr_from_buf(buf, size, path, flags);
>>  	}
>>  	return stack;
>
> Thanks.
