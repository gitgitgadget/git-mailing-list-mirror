Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA715B0EC
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770815022; cv=none; b=lCYmg2UWyjJjDj1EYwNjfEvsNa/rQllinn0FNGjC5erpJ0ZANOIf30ECWSv/Hjovsopr/LG9WkJfUyMFPVe1FhvY6PDjyM+XDwmNvsaPqR7CQV19WzOFNt3R67QOdGgfRlPZm3EXkGWkylbGyYYifriQm0jseeWtBcBLCwqsi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770815022; c=relaxed/simple;
	bh=yI3FFRLXF9ApmZ4ClJ30wQjZB7AoK07j+woEDaj2yBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sulelav9Y2LVHieYv/HZ46FwY4cCSRFc5CbC3YPsMmVtnmJ7nMBw7/yGwALyF921E3Y2QPNe7Ctpq8WvzRXdv7oMzGRwVj3S8+/e4HU/tVr+kSPNOluBoWP1mvJP9HGLpkxOlNMK8yV4LVd/NgeiDX6gdwJQKVeDacryHMsoWfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yDVf7xjW; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yDVf7xjW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1770815017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S6/Mv+TRIhyZhsFsDvTTsk+LBjaKFxwFYiP39UsDNNw=;
	b=yDVf7xjWslX1mBOYDAgmFnhnnIoAPV4YcppTyBqVNXtR/mzZEyql1SvZZUb2KF9mxZJU80
	zaTWqNdMwgc6FGIQ1tKiW0dqE06TFzfiblzL/r/fhuEFC8Fj2GVxlobvvJBync2lw3I7LQ
	FseEK/8RuROSVsE2/6TyKzSn4oBVZK8=
From: Toon Claes <toon@iotcl.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v2 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <aTZ5RrjnwJ2ZnT7A@pks.im>
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-2-siddharthasthana31@gmail.com>
 <aTLDA11AKs0jlxFJ@pks.im> <ac12100d-4aba-4d15-8bcf-c50e6100c95e@gmail.com>
 <aTZ5RrjnwJ2ZnT7A@pks.im>
Date: Wed, 11 Feb 2026 14:03:22 +0100
Message-ID: <87bjhvqvol.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Dec 08, 2025 at 04:30:58AM +0530, Siddharth Asthana wrote:
>> 
>> On 05/12/25 17:03, Patrick Steinhardt wrote:
>> > On Wed, Dec 03, 2025 at 01:46:10AM +0530, Siddharth Asthana wrote:
>> > > diff --git a/sequencer.c b/sequencer.c
>> > > index 5476d39ba9..9f621aef4b 100644
>> > > --- a/sequencer.c
>> > > +++ b/sequencer.c
>> > > @@ -2365,22 +2365,10 @@ static int do_pick_commit(struct repository *r,
>> > >   		if (opts->commit_use_reference) {
>> > >   			strbuf_commented_addf(&ctx->message, comment_line_str,
>> > >   				"*** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
>> > > -		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject) &&
>> > > -			   /*
>> > > -			    * We don't touch pre-existing repeated reverts, because
>> > > -			    * theoretically these can be nested arbitrarily deeply,
>> > > -			    * thus requiring excessive complexity to deal with.
>> > > -			    */
>> > > -			   !starts_with(orig_subject, "Revert \"")) {
>> > > -			strbuf_addstr(&ctx->message, "Reapply \"");
>> > > -			strbuf_addstr(&ctx->message, orig_subject);
>> > > -			strbuf_addstr(&ctx->message, "\n");
>> > > +			strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>> > >   		} else {
>> > > -			strbuf_addstr(&ctx->message, "Revert \"");
>> > > -			strbuf_addstr(&ctx->message, msg.subject);
>> > > -			strbuf_addstr(&ctx->message, "\"\n");
>> > > +			sequencer_format_revert_header(&ctx->message, msg.subject);
>> > >   		}
>> > > -		strbuf_addstr(&ctx->message, "\nThis reverts commit ");
>> > >   		refer_to_commit(opts, &ctx->message, commit);
>> > >   		if (commit->parents && commit->parents->next) {
>> > Is there any reason why we don't also handle `refer_to_commit()` in that
>> > new function?
>> 
>> 
>> The `refer_to_commit()` function depends on `struct replay_opts` and its
>> `commit_use_reference` flag, which controls whether to use abbreviated
>> commit info ("%h (%s, %ad)") or the full OID. This is specific to
>> sequencer.c's interactive workflow where users can choose the reference
>> style via --reference.
>> 
>> In replay.c, we always use the full OID via `oid_to_hex()` since it's
>> designed for non-interactive server-side operations without the
>> `replay_opts` framework.

Even if it's non-interactive, I wonder if we should make it obey the
config 'revert.reference' as well? To me it makes sense git-replay(1)
and git-revert(1) give the same outcome if that config is set.

>> Including `refer_to_commit()` would require either
>> passing `replay_opts` to the shared function (leaking sequencer internals)
>> or adding a format parameter which feels like over-engineering for current
>> needs.
>> 
>> Happy to reconsider if you think there's a cleaner way to share this.
>
> A simple alternative might be to convert the `struct replay_opts`
> parameter into a `flags` field that tells the function whether it is
> expected to use the object ID or whether it should try using the
> abbreviated commit info instead.

I was considering to add a bool for this option alone, but I agree flags
is probably more future-proof.

Patrick, I assume you don't mean to revamp the `struct replay_opts`
completely, but only the parameter that would be passed into
sequencer_format_revert_header() and refer_to_commit()?

Siddharth, I see you have plenty of good reviews on this version of the
series ([PATCH 2/2] in particular). I'd love to see you post v3. Or do
you have any open questions you need answers to before you can send it
out? Let me know if I can help with any decision-making.

-- 
Cheers,
Toon
