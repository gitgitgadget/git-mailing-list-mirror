Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEE715B558
	for <git@vger.kernel.org>; Wed, 29 May 2024 17:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004634; cv=none; b=krUkLJS8oyLSQ0WqxoAIPAcoxXMI8x1HV01CQ6yOUskUOt5GY642GKgJA34jSqWGF0no2yfw4fTeEadVAkOH6iWLNXQkRoS5xuY4HubMwXI/LQwrmzwydtNQNDCwPx8Xx8o3bR92CM1kbWszplA9pG0S5PkoO6ePD0bWXqhNzMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004634; c=relaxed/simple;
	bh=so8+yKeMoBKF7wBx0QXSUk0+GVC999b7SVUBT2qrfq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jzE/fCVGc8zox2XsfTzLZEtCCIxx5I5AWZDTmdg3+CzvBCsU1D/+Ir/CHSAHOjSNfj1Ot8sZ0sZT1NUlij2dXt334JYUsa3eh8SxOxPFdNNQKN2QNAPqFOMcCJd1KCuFujNicCgI4ianRaylF7sU3SIGFavwXw1zb/W93CqTm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oJg2ZrO4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oJg2ZrO4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 46FAD2AD7E;
	Wed, 29 May 2024 13:43:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=so8+yKeMoBKF7wBx0QXSUk0+GVC999b7SVUBT2
	qrfq8=; b=oJg2ZrO4dPM/hGvzIOwIszF08FbUCKTwElPFpetBOhKNZEf7OLsOTe
	w+hMYIHvXNI7jVliL5Ca6aI2wURrkfHewh+B0aoWZWW583QggXsXLVuspNWwlYp+
	C1d99h9b8NwGJ2YeZYk17DvrnhF3Fkgfu/XO00GItAlwfjingLayQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F08C2AD7D;
	Wed, 29 May 2024 13:43:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 496302AD7C;
	Wed, 29 May 2024 13:43:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/19] reftable: improve const correctness when
 assigning string constants
In-Reply-To: <dc5d85257eef747f2331638ed718b0f7a5bb1da2.1716983704.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 29 May 2024 14:44:25 +0200")
References: <cover.1716983704.git.ps@pks.im>
	<dc5d85257eef747f2331638ed718b0f7a5bb1da2.1716983704.git.ps@pks.im>
Date: Wed, 29 May 2024 10:43:47 -0700
Message-ID: <xmqqed9ky0mk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0195A5B8-1DE3-11EF-9BBA-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> diff --git a/reftable/basics_test.c b/reftable/basics_test.c
> index 997c4d9e01..af9209d535 100644
> --- a/reftable/basics_test.c
> +++ b/reftable/basics_test.c
> @@ -58,8 +58,8 @@ static void test_binsearch(void)
>  
>  static void test_names_length(void)
>  {
> -	char *a[] = { "a", "b", NULL };
> -	EXPECT(names_length(a) == 2);
> +	char *names[] = { (char *)"a", (char *)"b", NULL };
> +	EXPECT(names_length(names) == 2);
>  }

I would have preferred to see this kind of rewrite more than
separate and clearly writable variables that are initialied with the
constant contents e.g. branches[] = "refs/heads/*", we saw in
earlier steps.  Wouldn't that approach, combined with making the
literal constants stored in read-only segment to trigger runtime
failure when a bug causes the "unfortunately non-const" variables
to be written, give us a better result?
