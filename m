Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F680058
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708970606; cv=none; b=GFcr/tizQo0Wg3EMuLfAV0xhiqKwiwHpdJSqjlOVunng/tjUqy5Grgwx3+h7J9FlePlKWDCUUueUapNhHy6NSs7gjRXpmFOyyK8Zgdan0kzmPsDqiXFKLlNQxvT4UlMLmfEZiOtYlN07VBUuoRu5zgu5w7D/kZO42p1yOSHF1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708970606; c=relaxed/simple;
	bh=6Gm3PfgETsWGmAbhkPcwUNwMRFpTH7pZ1pPSBXHEk+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nVg/7/P12p+pUuqzVreywIQfrw17y1I6z4VJ/gKk4gb/doTXSl1MZNonPSZMrlZ5oOZiCKWoLJGxBULkcWj9sbHV+0wjxfh392FQ7rzBKPpCx3wbuYFpXBct1X3J0SDEdNBjASPCM6HFpYdPPyW9OQI7Xj1wN4iki9Pc4jJi/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GOeZ0VkH; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GOeZ0VkH"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 201C31D2C1A;
	Mon, 26 Feb 2024 13:03:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6Gm3PfgETsWGmAbhkPcwUNwMRFpTH7pZ1pPSBX
	HEk+Q=; b=GOeZ0VkHJU46rjobY/UZ8OgwR41t+9yFGaRUwhFGumika56gxMzNK5
	SI+ksEDmLYtlVUW6M009VTXkdyWUzEXU2RjBcQAZB4bRtauqDiaTt91rI00f5CQp
	gZfcgAn6Xn2ZqQTcmgeUDskwDnAvkG44V7p5t5ciyu0a3qCg7GSFE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 193CC1D2C19;
	Mon, 26 Feb 2024 13:03:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 785501D2C18;
	Mon, 26 Feb 2024 13:03:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Triplett <josh@joshtriplett.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] commit: Avoid redundant scissor line with
 --cleanup=scissors -v
In-Reply-To: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
	(Josh Triplett's message of "Sun, 25 Feb 2024 20:23:16 -0800")
References: <9c09cea2679e14258720ee63e932e3b9459dbd8c.1708921369.git.josh@joshtriplett.org>
Date: Mon, 26 Feb 2024 10:03:22 -0800
Message-ID: <xmqqbk83nlw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 550A8EDA-D4D1-11EE-BCB2-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Josh Triplett <josh@joshtriplett.org> writes:

> `git commit --cleanup=scissors -v` currently prints two scissors lines:
> one at the start of the comment lines, and the other right before the
> diff. This is redundant, and pushes the diff further down in the user's
> editor than it needs to be.

Interesting discovery.

> diff --git a/wt-status.c b/wt-status.c
> index b5a29083df..459d399baa 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1143,11 +1143,13 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
>  	 * file (and even the "auto" setting won't work, since it
>  	 * will have checked isatty on stdout). But we then do want
>  	 * to insert the scissor line here to reliably remove the
> -	 * diff before committing.
> +	 * diff before committing, if we didn't already include one
> +	 * before.
>  	 */
>  	if (s->fp != stdout) {
>  		rev.diffopt.use_color = 0;
> -		wt_status_add_cut_line(s->fp);
> +		if (s->cleanup_mode != COMMIT_MSG_CLEANUP_SCISSORS)
> +			wt_status_add_cut_line(s->fp);
>  	}

The machinery to populate the log message buffer should ideally be
taught to remember if it already has added a scissors-line and to
refrain from adding redundant ones.  That way, we do not have to
rely on the order of places that make wt_status_add_cut_line() calls
or what condition they use to decide to make these calls.

This hunk for example knows not just this one produces cut-line
after the other one potentially added one, but also the logic used
by the other one to decide to add one, which is even worse.  I find
the solution presented here a bit unsatisfactory, for this reason,
but for now it may be OK, as we probably are not adding any more
places and conditions to emit a scissors line.

>  builtin/commit.c | 2 ++
>  sequencer.h      | 7 -------
>  wt-status.c      | 6 ++++--
>  wt-status.h      | 8 ++++++++
>  4 files changed, 14 insertions(+), 9 deletions(-)

If this change did not break any existing tests that checked the
combination of options and output when they are used together, it
means we have a gap in the test coverage.  We needs a test or two
to protect this fix from future breakages.

Thanks.
