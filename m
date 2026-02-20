Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED5A2877E5
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771606933; cv=none; b=IXWq7X+EIV4WsZlINsze/c/W3WktrCmLlmgPzcWkbq6suJOHSq8aW0B5FHzeNRmQnMj3Dcgw8ODR9yFzrglA4z45CskJHtS7yjn3M0FciwR7hlC0+jE6T6Geid/WgZseuNnrK9TBeaNh4oBmC/AXTrdymMCugTMGNwPwqRbMB8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771606933; c=relaxed/simple;
	bh=5PRhd0M3XtU6Oe0RRGFVF8lomw3ekzYbwLy9sQ35P44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s2RWAx/XxK22sg7c8UGrwPWYxH7EH+H3FLFzKc+5bn2mLcRr4h3sZ+JkvDO7/1aT6VMMHxhOwZQhB53q0LnX6BUc0AKFYmKcbXObTywBEE1Z5pTlnNsbdPdl6aeZWCgDyFCx9oy0+BoUCxveiOR6JKWVMGRKM79PKdScaMf8WWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=g6PmHsKA; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="g6PmHsKA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771606928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyvIt8rEY3FEQuuw2ZW/IbPZIXF9AeT9vLZJiull2F4=;
	b=g6PmHsKA0PODNP9AJ7H9DEQaCQ5TEdpcDc6DkAZ6kPIo0/gyiNwFaX69mTkhX5bzug0i8w
	nwHOzCMe9QOZ/Mn3+drGlo3zVLzkckNUKuwXLImqwwBKw8X8tNb6l1dtznPpiT7J1PvqGZ
	LFOMODq4JC8e++BJp/KYmK9aoy4OCvg=
From: Toon Claes <toon@iotcl.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de, Siddharth Asthana
 <siddharthasthana31@gmail.com>
Subject: Re: [PATCH v3 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <20260218234215.89326-2-siddharthasthana31@gmail.com>
References: <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260218234215.89326-2-siddharthasthana31@gmail.com>
Date: Fri, 20 Feb 2026 18:01:47 +0100
Message-ID: <87wm07e4ck.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> The logic for formatting revert commit messages (handling "Revert" and
> "Reapply" cases) is currently duplicated between sequencer.c and will be
> needed by builtin/replay.c.
>
> Extract this logic into a new sequencer_format_revert_header() function
> that can be shared. The function handles both regular reverts ("Revert
> "<subject>"") and revert-of-revert cases ("Reapply "<subject>"").
> When an oid is provided, the function appends the full commit hash and
> period; otherwise the caller should append the commit reference.
>
> Update do_pick_commit() to use the new helper, eliminating code
> duplication while preserving the special handling for commit_use_reference.
>
> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
> ---
>  sequencer.c | 47 +++++++++++++++++++++++++++++++----------------
>  sequencer.h | 11 +++++++++++
>  2 files changed, 42 insertions(+), 16 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 1f492f8460..b32347c853 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2356,8 +2356,6 @@ static int do_pick_commit(struct repository *r,
>  	 */
>  
>  	if (command == TODO_REVERT) {
> -		const char *orig_subject;
> -
>  		base = commit;
>  		base_label = msg.label;
>  		next = parent;
> @@ -2365,22 +2363,10 @@ static int do_pick_commit(struct repository *r,
>  		if (opts->commit_use_reference) {
>  			strbuf_commented_addf(&ctx->message, comment_line_str,
>  				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
> -			   /*
> -			    * We don't touch pre-existing repeated reverts, because
> -			    * theoretically these can be nested arbitrarily deeply,
> -			    * thus requiring excessive complexity to deal with.
> -			    */
> -			   !starts_with(orig_subject, "Revert \"")) {
> -			strbuf_addstr(&ctx->message, "Reapply \"");
> -			strbuf_addstr(&ctx->message, orig_subject);
> -			strbuf_addstr(&ctx->message, "\n");
> +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>  		} else {
> -			strbuf_addstr(&ctx->message, "Revert \"");
> -			strbuf_addstr(&ctx->message, msg.subject);
> -			strbuf_addstr(&ctx->message, "\"\n");
> +			sequencer_format_revert_header(&ctx->message, msg.subject, NULL);
>  		}
> -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>  		refer_to_commit(opts, &ctx->message, commit);

I still find it somewhat confusing we have some the code that deals with
`opts->commit_use_reference` partly in here and partly in
sequencer_format_revert_header().

Part of the confusion comes from sequencer_format_revert_header() being
called with NULL for the commit OID.

Was is not possible to incorporate Patrick's suggestion[1]?

[1]: https://lore.kernel.org/git/aTZ5RrjnwJ2ZnT7A@pks.im/

-- 
Cheers,
Toon
