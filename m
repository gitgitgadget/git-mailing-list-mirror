Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00C1171E75
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713475010; cv=none; b=dbYQxehD/eXY/abBBeG9M0IgbPVjihxczNnUOvpFvXOs0LNzQB8PZGuqjDzfMrX69t0JwqCFwbrNWGkbC+8BsoQWyrwDzTjCd2MvqmsV3PNXwIycpTRyNQN3Ep7jwfs/eS3SYGjrA6950qDRHN5znlygf/q4hjaCrIbNKy3uUM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713475010; c=relaxed/simple;
	bh=cyYdS0XPcDUd20bhcmSUEMTmv0IfucZw6/GTkv638lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTDIiW5OEtB0Pk0SNnl3HI+R3I3JQ3hZ+cDNaxpwwIeaP7OnChxzD62AxIRBSEkD/pMZyon+c1BkTMarnCu+J7Uinn6Ro9jZjAo5KBOoNQWSfZoJhA63UbQTWiJQ1kn2GXjUhVQoV+nuUvI3FxHPAbL7WjvnO5lMOOcma65bBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tVaziSKP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tVaziSKP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B00C824774;
	Thu, 18 Apr 2024 17:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cyYdS0XPcDUd20bhcmSUEMTmv0IfucZw6/GTkv
	638lc=; b=tVaziSKP4/HShZOisXDfIyzC8haBz3qBsbfk+xstD4FlbAW/ooKCuj
	0xN8r8h39kd4TBMGDJJ3PY5pgGYKJny/E3MAujlF+vZAmfVg56QYpx9v4w4FZ8N9
	sU7vYZgN6vOnz2XogQ3YaeR9roE6NL3ESM3XYJcpW6Fw4WcnbmYCg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A827A24773;
	Thu, 18 Apr 2024 17:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1D4B424772;
	Thu, 18 Apr 2024 17:16:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  David Bimmler <david.bimmler@isovalent.com>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/5] rebase -m: fix --signoff with conflicts
In-Reply-To: <4c8f8843780f3ac23262f1e45a5000d183adca6b.1713445918.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Thu, 18 Apr 2024 14:14:09 +0100")
References: <cover.1713445918.git.phillip.wood@dunelm.org.uk>
	<4c8f8843780f3ac23262f1e45a5000d183adca6b.1713445918.git.phillip.wood@dunelm.org.uk>
Date: Thu, 18 Apr 2024 14:16:36 -0700
Message-ID: <xmqq7cguqsln.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F1751734-FDC8-11EE-96D8-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> +	struct replay_ctx *ctx = opts->ctx;
> +
> +	/*
> +	 * Write the commit message to be used by "git rebase
> +	 * --continue". If a "fixup" or "squash" command has conflicts
> +	 * then we will have already written rebase_path_message() in
> +	 * error_failed_squash(). If an "edit" command was
> +	 * fast-forwarded then we don't have a message in ctx->message
> +	 * and rely on make_patch() to write rebase_path_message()
> +	 * instead.
> +	 */
> +	if (ctx->have_message && !file_exists(rebase_path_message()) &&
> +	    write_message(ctx->message.buf, ctx->message.len,
> +			  rebase_path_message(), 0))
> +		return error(_("could not write commit message file"));

Makes the readers wonder if there are cases where we have written to
disc, but .have_message is true and the on-disc contents and in-core
contents are different.  If a codepath that writes to the file had
the message in-core, and it needs to tweak the message (e.g., add a
sign-off trailer) before writing it out to the file but forgot to do
so, then later we have tweaked the message in-core, such a bug would
result in the necessary "tweak" we have done not appear on disc.
Optionally keeping an in-core copy of what we have on disc does not
directly reduces the possibility of introducing such a bug, and I am
wondering if we can do anything clever about it.

Thanks.
