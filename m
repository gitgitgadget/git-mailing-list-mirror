Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DA512C53A
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708040757; cv=none; b=K/TF+Eqa9vx77gziUALi8yN4c2U6NvyDPl612JmJbzxOU8ekvhcTTh5Ez6B+Nz5x1U+FEkL+9o29PFiLjHidsmobq7ZFqfl1jAtCdzbGath6ndPtvuyIHRJSEv/wkJeAIP1HOa28ic6A4FnaQJUQDTnK0n6MFGuLD/F2BHWp1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708040757; c=relaxed/simple;
	bh=0f6erRtdgmLLTJq0AMGdhuLtsGXOBZ+6Ma1Ss6YBXSA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gO1cLrnEjOdTzO4NxTlwfi2Q1r8EYlDTGijWYbd4syJxO6f6kMVIITu5nCtvQ3+H2zMit0lpHoKl9gkUdLaBmLbn1igd1NpPz7Bt9zKGQEpw/5qSFAEc9OKddkmOyc4gQIxQPOFq3WVQa3abPEP5SzVaiAqhxchDhoJ1rGQVlPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kQzRdqWk; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kQzRdqWk"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7CC6E2A9AE;
	Thu, 15 Feb 2024 18:45:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0f6erRtdgmLLTJq0AMGdhuLtsGXOBZ+6Ma1Ss6
	YBXSA=; b=kQzRdqWkQ88rtjjc3/gngt+2T6ylGmZURu3RiaumJBIaLdYjZGG94R
	plQ2zhYVPX2/mYvpUmjr8x/4nRD3EkxugHENqP2J3DVYUZZMjau5YoikJM3XR64p
	46gkIys6AVGsLpX+YHK2NuUOY7BuQv90/d2/kAFpu5Yo/01i/JOC4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 753462A9AD;
	Thu, 15 Feb 2024 18:45:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AF9A2A9AA;
	Thu, 15 Feb 2024 18:45:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Josh Steadmon <steadmon@google.com>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: let `test-tool` run the unit tests, too
In-Reply-To: <pull.1666.git.1708038924522.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Thu, 15 Feb 2024 23:15:24
	+0000")
References: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 15:45:50 -0800
Message-ID: <xmqq5xypmgup.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5A6DD936-CC5C-11EE-AA97-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The `test-tool` recently learned to run the unit tests. To this end, it
> needs to link with `test-lib.c`, which was done in the `Makefile`, and
> this patch does it in the CMake definition, too.

Nice.  Will queue.  Thanks.

> +add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
>  
>  list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
>  add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
> -target_link_libraries(test-tool common-main)
> +target_link_libraries(test-tool test-lib common-main)
