Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0D1DFD8
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720798522; cv=none; b=c7xGiEiyc3uGntLMNF+E5C6J9iyy2C8+QoJYaQu/zNeWP6ebsecfF7GTAedGosa8gbYxQA1ykFOL12mOJSEJrd0Yj+jiwKyIm4qZsoxTzoCfznvsDX8NLcJ6v0G9PnQWg2Nr2PugCzEcsEP4Ash4gd/3iUJetbcZjZNea8Z3G4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720798522; c=relaxed/simple;
	bh=mbhA1wuBYsUsxpAzdEKs+NUKZMFUcH3W4iWsEvmL27s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kmb6dpI2B1HkUQtrk+iyzpY6FOH+XDiPZ4OtfudOkolEMUL8ULaLVu3rrk4H8NQiOSru/VFJYhUoinHmz8NC3xGYteM+jQNisqgR82Tc403W3ldKNAa/2cfEt8Hv8VDaWXCDweRKRzUY2qFFw6bZuFHLgjMvvmFdwJn21DgtYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iuar80wU; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iuar80wU"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A56862F66E;
	Fri, 12 Jul 2024 11:35:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mbhA1wuBYsUsxpAzdEKs+NUKZMFUcH3W4iWsEv
	mL27s=; b=iuar80wUbSPBYKQBbxpD5HPlpNY/FC6c1SB8m6VImkCj61WAqwBZpj
	NtJcRHwdHAOgTGvhp1vOTXm71tTROU94pFgQAki1h65dDXkIPoMi90y6Zzve1Ki2
	MHstixuj/VwIxx1pyJhBZTrPjiUuptCWPXmTpy8sSkqAPSalLXpLw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9E2992F66D;
	Fri, 12 Jul 2024 11:35:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BB3E02F66C;
	Fri, 12 Jul 2024 11:35:16 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] show-index: fix uninitialized hash function
In-Reply-To: <20240712142326.266533-1-abhijeet.nkt@gmail.com> (Abhijeet
	Sonar's message of "Fri, 12 Jul 2024 19:53:26 +0530")
References: <20240712142326.266533-1-abhijeet.nkt@gmail.com>
Date: Fri, 12 Jul 2024 08:35:15 -0700
Message-ID: <xmqqbk32oc7g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 56BB3708-4064-11EF-86A8-C38742FD603B-77302942!pb-smtp20.pobox.com

Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:

> As stated in the docs, show-index should use SHA1 as the default hash algorithm
> when run outsize of a repository.  However, 'the_hash_algo' is currently left
> uninitialized if we are not in a repository and no explicit hash funciton is
> specified, causing a crash.  Fix it by falling back to SHA1 when it is found
> uninitialized.
>
> Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
> ---
>  builtin/show-index.c | 3 +++
>  1 file changed, 3 insertions(+)

Nicely described.

We'd probably want to protect this with a new test, so that
regardless of the choice of GIT_TEST_DEFAULT_HASH, the command
should behave as advertised.

Having said that, I am not sure if --object-format specified on the
command line, or picked up from the repository, makes much sense in
the context of the command, especially for the longer term [*].  The
command is designed to read from its standard input a byte-stream,
which is assumed to be an .idx file of _any_ origin, so ideally it
should be able to tell what hash the incoming data uses and use that
hash algorithm, without being told from the command line?

But that longer-term worry has nothing to do with the validity of
this patch (but the lack of test does).  Thanks.

[Footnote]

 * Perhaps the file format does not make it obvious what hash
   algorithm it uses, so it may be hard to auto-detect without
   additional code.  But if that is the case, it would be something
   we may want to eventually fix.

