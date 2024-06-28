Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02AB77F10
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 22:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719613122; cv=none; b=WPB/611Bd9EOQNy26sg+q7wpQbjLPDIuIj98c9sfIbw/K6HnIGekwL+FS+ZfD74jWoPTrfj4HmJBlWF/nSFZ0F3jl204FhqEnwSlaGZHGtNZmpSBe27hhwinYMLrr72Am9MwdrvSyMnv9bVUtiAHk229OULkJulUrB80IXc9Z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719613122; c=relaxed/simple;
	bh=xD/NVjfJP8ZQqXHX9tg7FPVO0Njan/pYeFcEg39CZMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=C2luJdwl9Us9TbABXlbd+W/yqEB3/AyjQdJ7amMgd8H8iMXPZrxB8d6KC+VosxJBMtB4Ai69b+Q7Ea/HTAHgCkfPQ60OE578KRXvQbRU5cBxzDhN+U8xTk5BWyV7zM20i08qS+27PDWqiB9O2vanoPJl1qIqfgR3xohbuXeadB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xzV0lpeb; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xzV0lpeb"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6725C234A9;
	Fri, 28 Jun 2024 18:18:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xD/NVjfJP8ZQqXHX9tg7FPVO0Njan/pYeFcEg3
	9CZMM=; b=xzV0lpebz9lNcf4rlyWxPNHV7cNWc8qeA4CMELL2o/8pEsigDj6do0
	jvyXA6sYCmrS+8te7+w9zb72PPIsaqY+9G5U9YK1msVS2ggtStD1ISd+BpDY4S35
	s1I9uq50Mqrzs3+16Onv7VukWm1v+yRNIyqF/C8bxBIeakQTardro=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DE34234A8;
	Fri, 28 Jun 2024 18:18:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C377C234A7;
	Fri, 28 Jun 2024 18:18:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] http: allow authenticating proactively
In-Reply-To: <Zn8yhdN6henrIqgD@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 28 Jun 2024 22:00:37 +0000")
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
	<20240628002742.3421311-2-sandals@crustytoothpaste.net>
	<xmqqa5j53pbo.fsf@gitster.g>
	<Zn8yhdN6henrIqgD@tapette.crustytoothpaste.net>
Date: Fri, 28 Jun 2024 15:18:37 -0700
Message-ID: <xmqqh6dc1zk2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5E7C4784-359C-11EF-8B0F-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > +* `basic` - Request Basic authentication from the helper.
>> > +* `auto` - Don't request any scheme from the helper.
>> > +--
>> 
>> What does "don't request" exactly mean?  It is not like we are
>> telling the helper "Don't give us anything", right?  Are we telling
>> the helper "Give us any username/password for the URL in any
>> authentication scheme you know about?"
>
> It means we don't send a `wwwauth[]` entry in the request.  We are
> giving the helper carte blanche to decide what scheme is best (maybe it
> knows we want Bearer, for example).

Well, at least I couldn't read the proposed document update and read
that much out of it, and I suspect there may be other readers who
will share my confusion.  I think the source of the confusion is
that "don't request" does not automatically imply "allow the helper
to pick any scheme as it sees fit" if you do not know how helper is
designed to behave when it is not requested "any scheme".

    `basic` - Request Basic authentication from the helper.
    `auto`  - Ask the helper to pick an appropriate scheme.
    `none`  - Disable proactive authentication.

or something, perhaps?

Thanks.

