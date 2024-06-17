Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E31891DB
	for <git@vger.kernel.org>; Mon, 17 Jun 2024 17:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718646193; cv=none; b=co9M3zWtHo8H6fp9oLbPb4wwHi4b3mV6OlMD7Ih0VwsjPGjx9oAermy/dfW8hVc47p7Tc+d1+7pIxVSoU1tTthBZmWhLl71P7Ts9nzAjFG0IuG1znBZ1ihp3eHL3D0fXnPkdyBNEM+wwzt0hlGFkx/peGEjRPVsUDAovI+KOROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718646193; c=relaxed/simple;
	bh=tHAevQ+W4zc+lHYZwAhjgZBl816gcZ696FqgXEz99IE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OY7DOj2g6MWMGfbInn3u/PY8pMYEsQRInV7y2WS4fz7+xt9Zd9OAuMlj9HeawRkbCgACilnQgalPGdky35VICw/qtLFJM5vJW3PcvcLkbRjke329NjkFRwNkDtpICImlBA42LSYDy8XwuwJElwivuZarWtsHxEQXrkOMIH5bAAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ijGkn0qD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ijGkn0qD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 023301DEA5;
	Mon, 17 Jun 2024 13:42:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tHAevQ+W4zc+lHYZwAhjgZBl816gcZ696FqgXE
	z99IE=; b=ijGkn0qDoSXBT202bY0HAvKrdW9ygu8SgPWA2XEXgyR/CwL+Ra61NJ
	fItWl3WgtPYTvDRyfN42xYI5HCWlv7eYhD+9nhG0Ft/f0QS97iVL7QvZkBUDLI16
	NRSjn40jmSYNbwhWR1YTfmjFkbmjs0HzGo3crRJHECpVs5aCx5Ohc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECBF61DEA3;
	Mon, 17 Jun 2024 13:42:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 621DA1DEA2;
	Mon, 17 Jun 2024 13:42:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Mathew George <mathewegeorge@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 03/11] remote: transfer ownership of memory in
 add_url(), etc
In-Reply-To: <20240616045937.GB17750@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 16 Jun 2024 00:59:37 -0400")
References: <20240614102439.GA222287@coredump.intra.peff.net>
	<20240614102722.GC222445@coredump.intra.peff.net>
	<xmqq1q4zh2vh.fsf@gitster.g>
	<20240616045937.GB17750@coredump.intra.peff.net>
Date: Mon, 17 Jun 2024 10:42:25 -0700
Message-ID: <xmqqv827a2ke.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F605C064-2CD0-11EF-886A-965B910A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> On Fri, Jun 14, 2024 at 10:04:50AM -0700, Junio C Hamano wrote:
>
>> >  static void add_pushurl_alias(struct remote_state *remote_state,
>> > @@ -79,6 +79,7 @@ static void add_pushurl_alias(struct remote_state *remote_state,
>> >  	char *alias = alias_url(url, &remote_state->rewrites_push);
>> >  	if (alias)
>> >  		add_pushurl(remote, alias);
>> > +	free(alias);
>> >  }
>> 
>> OK.  I wondered if we want to strdup(url) in my review on the
>> previous step, but now we are making the add_url() responsible
>> for making a copy, we instead do the opposite, i.e. free alias
>> that was allocated for us because we no longer need it.
>
> Yeah. Possibly the two should be squashed. I was trying to make this
> patch a little less long/confusing, but maybe breaking things up just
> posed new questions. :)

No squashing is needed.  It's just that [02/11] could go in either
direction and the reader was held in suspense until [03/11] that
picked one direction to go ;-).

> Right. I had originally written it that way, since that would be the
> mechanical conversion. But since there was already cleanup at the bottom
> of the function, it felt more natural to shuffle it there. Which is
> correct as long as there are no other references to buf nor early
> returns. You can't see that from the context, but it is true in this
> case.

Yeah, either way it is correct, and I think the "cleanup at the end,
where the single label is there for any new error code paths to jump
to" pattern is a good approach going forward.

Looking good.
