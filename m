Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FC04D5BD
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723065689; cv=none; b=WWi0arM+QrmTRrz1W08e1t7QLd6hL+ddiNUkIRRv6BUC8bXqSEgYqnZTWFgQQdRZZY/87cj48sUszKiflinS3pjFk+k3L5EAuUZoZYlvpERsmKMA6osaWZJiGtNCyUOyCGmFx4HqDwayPKPMs0SpF5doWH0zbNH6XVYTkeklLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723065689; c=relaxed/simple;
	bh=/7o5nkNZehCSTFu7iPGh+SKPUaILLrmaaIGsjPdVR6U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X3O2v7akmYcZtiJuHz0K31UqsVBNSIRu0+uPX1vziYZ3ZuYC28nZyqI6mo3s7vy/Bme/yQ3M8kybxpIXfq/cEfqmhXASLYOWYlDwku0BI+asIk/qnsYNIp9v4Fc+G2/+M2E7nEehUU9Ffg4wAWsa9eK4VEt5nQnBkf9aVU0Dj+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Yyg0rvGP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yyg0rvGP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9346D1AD35;
	Wed,  7 Aug 2024 17:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=/7o5nkNZehCSTFu7iPGh+SKPUaILLrmaaIGsjP
	dVR6U=; b=Yyg0rvGPsqBEkVeHW2EKV96qwjvTs2FURVb9l8NR5cQdlAjzGUdAX1
	InX6qF6e9hqOgw6vEWLHpOEt0ZUfLS8FmzxPmvaEZt0Dn7DWfuW1VXyHlh/S+ymq
	anME3QzbcqJUKwxsCmSndqqikH8sEeYsPNO73FniS4ZSLwwamE0bM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AA351AD34;
	Wed,  7 Aug 2024 17:21:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F00351AD30;
	Wed,  7 Aug 2024 17:21:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 1/6] common-main: split common_exit() into a new file
In-Reply-To: <78c2aa2ef9351d977f31dbbb16b148baf254ad59.1723054623.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 7 Aug 2024 11:21:26 -0700")
References: <cover.1723054623.git.steadmon@google.com>
	<78c2aa2ef9351d977f31dbbb16b148baf254ad59.1723054623.git.steadmon@google.com>
Date: Wed, 07 Aug 2024 14:21:24 -0700
Message-ID: <xmqqr0b0ni5n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00E43240-5503-11EF-B310-9B0F950A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/common-exit.c b/common-exit.c
> new file mode 100644
> index 0000000000..1aaa538be3
> --- /dev/null
> +++ b/common-exit.c
> @@ -0,0 +1,26 @@
> +#include "git-compat-util.h"
> +#include "trace2.h"
> +
> +static void check_bug_if_BUG(void)
> +{
> +	if (!bug_called_must_BUG)
> +		return;
> +	BUG("on exit(): had bug() call(s) in this process without explicit BUG_if_bug()");
> +}

Nice that this can stay file-scope static.

> +/* We wrap exit() to call common_exit() in git-compat-util.h */
> +int common_exit(const char *file, int line, int code)
> +{
> +	/*
> +	 * For non-POSIX systems: Take the lowest 8 bits of the "code"
> +	 * to e.g. turn -1 into 255. On a POSIX system this is
> +	 * redundant, see exit(3) and wait(2), but as it doesn't harm
> +	 * anything there we don't need to guard this with an "ifdef".
> +	 */
> +	code &= 0xff;
> +
> +	check_bug_if_BUG();
> +	trace2_cmd_exit_fl(file, line, code);
> +
> +	return code;
> +}

I wonder if at least the part that primes the trace2 system needs to
also be split out of the file that defines our own main(), though.

Are libgit.a users now responsible for calling things like
trace2_initialize_clock(), trace2_initialize(), etc., themselves?  I
am wondering if these calls are encapsulated into a simple helper
function, say common_startup(), then the story we need to tell the
libgit.a users may become simpler, i.e. you call common_startup, do
your things, and then you somehow cause common_exit() to be called.

