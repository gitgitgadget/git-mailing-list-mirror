Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059842D603
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705602300; cv=none; b=a1DlPmdYLWJVEm/+bzT9MYIpCjNHrx4EYyAood3bb5IybwDxF6mLdWaP4orhrDqJk6grzyziEdTckzuLH0Iqjr4s5O1QjENKFqyzEaoVcZ4tYngkVH3D75p2rhxN9UnpyAwborfA/7zzCo5HjzTSK6+eujsh6hcQ2FBh/hrO1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705602300; c=relaxed/simple;
	bh=jlVreeOG2RyHPpN7tmidghigySkXwu0U/xnP8J4awKw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EH9R3UJLvdLe9uaJfdy6f4/ApQcCaZXBMkWoC6/Gkw3K1xhurzkWv81bFS3u556cvdLMr3nwPGtRE1qvoROHwmvWfgNct6/fK5RNnePslX30h4biWJEOTfRz1UfBWM/rHNo/oTpmZJeIlRuavM8lk2uYXD5t4cZ8X2tqUdlsbyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=oW/amP7s; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="oW/amP7s"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5516E373CA;
	Thu, 18 Jan 2024 13:24:56 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jlVreeOG2RyHPpN7tmidghigySkXwu0U/xnP8J
	4awKw=; b=oW/amP7sLUIXGrdJR4Ryr9KPYmL8Kwuf+tyDPM8HSMUTWthpvS/U0i
	7toUurE1xbH8LGldZu97TrVLpgjX5/uCBsfUFUmYuH6VvakuWh5u5fZKIadE+lyn
	Lm1FkutTSqjkDdF/KSniwSIjE1JKzAY9wK5gZgvRRVaGl3mhUhzx4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C811373C9;
	Thu, 18 Jan 2024 13:24:56 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DB87D373C7;
	Thu, 18 Jan 2024 13:24:52 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 0/4] Strengthen fsck checks for submodule URLs
In-Reply-To: <pull.1635.v2.git.1705542918.gitgitgadget@gmail.com> (Victoria
	Dye via GitGitGadget's message of "Thu, 18 Jan 2024 01:55:14 +0000")
References: <pull.1635.git.1704822817.gitgitgadget@gmail.com>
	<pull.1635.v2.git.1705542918.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 10:24:51 -0800
Message-ID: <xmqqmst2sdn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DF7A66F6-B62E-11EE-ABBF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> While testing 'git fsck' checks on .gitmodules URLs, I noticed that some
> invalid URLs were passing the checks. Digging into it a bit more, the issue
> turned out to be that 'credential_from_url_gently()' parses certain URLs
> (like "http://example.com:something/deeper/path") incorrectly, in a way that
> appeared to return a valid result.
>
> Fortunately, these URLs are rejected in fetches/clones/pushes anyway because
> 'url_normalize()' (called in 'validate_remote_url()') correctly identifies
> them as invalid. So, to bring 'git fsck' in line with other (stronger)
> validation done on remote URLs, this series replaces the
> 'credential_from_url_gently()' check with one that uses 'url_normalize()'.
>
>  * Patch 1 moves 'check_submodule_url()' to a public location so that it can
>    be used outside of 'fsck.c'.
>  * Patch 2 removes the obsolete/never-used code in 'test-tool submodule
>    check-name' handling names provided on the command line.
>  * Patch 3 adds a 'check-url' mode to 'test-tool submodule', calling the
>    now-public 'check_submodule_url()' method on a given URL, and adds new
>    tests checking valid and invalid submodule URLs.
>  * Patch 4 replaces the 'credential_from_url_gently()' check with
>    'url_normalize()' followed by 'url_decode()' and an explicit check for
>    newlines (to preserve the newline handling added in 07259e74ec1 (fsck:
>    detect gitmodules URLs with embedded newlines, 2020-03-11)).

Nicely done.  I'll wait for a few days to see if anybody else has
reaction but after reading the patches myself, my inclination is to
suggest merging it to 'next'.

Thanks.
