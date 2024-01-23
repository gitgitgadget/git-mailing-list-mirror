Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808603B2A6
	for <git@vger.kernel.org>; Tue, 23 Jan 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046618; cv=none; b=mXl64Vhu/o0BqO51UmHjpd1SgLifAS59L+YYcS1XJU60a5iFuqXjQC0RbXbB6tyeK85QeoLB5Mp1VfSuAyW3se8Ss4Yld7Dtkfk/E9RYbPQOK1X70jL0ZNf01VQJHgCcdZeSMmwdfn5SDnm6bWk8Pl/6Ze+0EseIZH8HRaxEIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046618; c=relaxed/simple;
	bh=S0u614hIlWRsMml5UfZWt+TapIlnqWfyxaPzNT9ku58=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzzKDZ6cmqR3Cy9RMJgeC1nBikTwhKVRu+Eaytx4qLpY/OBH0Vk+mnBxVFEffR+5cENU0D0wgY2P+vrwwXPAxlTr7G54PMgsdweFY6Knf0gs4n00nkXSNbroYuR1eD7GLAGDYfdwL7GdNtVuZMaF4wjHTlSgiZ4ItvInJ/qQ28E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=asw7ciK4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="asw7ciK4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D31D41CE8B;
	Tue, 23 Jan 2024 16:50:11 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=S0u614hIlWRsMml5UfZWt+TapIlnqWfyxaPzNT
	9ku58=; b=asw7ciK4wU766qxgeBbdZDb2gdxSRoMfFaZqIeCNzcKU5s58zMYw6x
	qDwOFViQP4zq3R1HUukrA5dZn4V5Crrq3TDMS+0lZGkFUKR+H89auCNFHOvvR6ja
	lTRN0YYoVZQ2gGvQ+YwfL6ct8jcRgid4QQsTnEaHMbHALoE47W5Bg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CB20D1CE8A;
	Tue, 23 Jan 2024 16:50:11 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 47B231CE89;
	Tue, 23 Jan 2024 16:50:07 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] reftable: honor core.fsync
In-Reply-To: <xmqq34unn8x4.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	23 Jan 2024 11:31:35 -0800")
References: <pull.1654.git.git.1706035870956.gitgitgadget@gmail.com>
	<xmqq34unn8x4.fsf@gitster.g>
Date: Tue, 23 Jan 2024 13:50:04 -0800
Message-ID: <xmqqsf2nlnxv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F7E21EA-BA39-11EE-AAB8-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> A comment and a half.
>
>  * Can't the new "how to flush" go to the write-option structure?
>    If you represent "no flush" as a NULL pointer in the flush member,
>    most of the changes to the _test files can go, no?

Nah, that was a stupid comment.  These are used to populate the
members of the reftable_writer instance being created, and it does
make sense to have flush_func immediately next to writer_func.

The part about using NULL as the value to say "do not use any flusher"
still stands, though.  You do not have to expose noop_flush into the
global namespace that way.

Thanks.
