Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC6179B2
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714511112; cv=none; b=sXv7sapcqExOL1d03gJkR3jOQ2+ADBfColcN/UEGLBh4oiVXUiDJxF/P6jAtIu04c8YZFVM7zXmL00CmBnsyRnv+JddtXGT2ruCn2LEJCOtmCQOdoTIimG40XSsqQW5G5xuc2sjrOmHRHDiqq9q/chaSdi19xxq30ujLOOunvMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714511112; c=relaxed/simple;
	bh=69PlvG7KIdje+L1fHWnUiXZTx3lV8LBQthCM8cJYhAE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hdb1JIdhVrtJHW8MUhMMdGd2ZDsC31IjPQDaoQTc+IBfA945Y+VQ0Xei8UvoMXdBS9dXEqCEp6KQZlI3ZcaPgSK5F4N+VwDZyzWr3UsS17RP9+vuLGVLk7iRCMYW8+FfqGa/vfcYhB7obiyjebJeDa5rY3NTHXof2TjSAj2X0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LlsnbLmv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LlsnbLmv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C1AF52219B;
	Tue, 30 Apr 2024 17:05:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=69PlvG7KIdje+L1fHWnUiXZTx3lV8LBQthCM8c
	JYhAE=; b=LlsnbLmvnI27XpFgNCmX8HmQ41IRQL7oIsrCr8W8OZ2sryPr1AVOHg
	TZKMmuDJTwRSgsW3Lef63qbz23xKxkpApdm4v4qugzKq6lRPT+PflGQIXKMQrVxR
	n92bOWpHyYloRWkwL99ugH/wBeAIUefDgvbzHQsMTa1LpiJB4QWuc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BAF9E2219A;
	Tue, 30 Apr 2024 17:05:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 92DD722198;
	Tue, 30 Apr 2024 17:05:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v5 6/7] t/Makefile: run unit tests alongside shell tests
In-Reply-To: <c6606446c47a7f49007e058e9ba84025919d86c4.1714506612.git.steadmon@google.com>
	(Josh Steadmon's message of "Tue, 30 Apr 2024 12:55:56 -0700")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1714506612.git.steadmon@google.com>
	<c6606446c47a7f49007e058e9ba84025919d86c4.1714506612.git.steadmon@google.com>
Date: Tue, 30 Apr 2024 14:05:03 -0700
Message-ID: <xmqqle4uy328.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 51A472F6-0735-11EF-BE79-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> +# A simple wrapper to run shell tests via TEST_SHELL_PATH,
> +# or exec unit tests directly.
> +
> +case "$1" in
> +*.sh)
> +	if test -z "${TEST_SHELL_PATH+set}"
> +	then
> +		echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
> +		exit 1
> +	fi
> +	exec ${TEST_SHELL_PATH} "$@"

You want to be prepared for a path like "//C/My Programs/bash".

	exec "$TEST_SHELL_PATH" "$@"

> +	;;
> +*)
> +	exec "$@"
> +	;;
> +esac
