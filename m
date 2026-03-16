Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56533A0E95
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688384; cv=none; b=ODrtYO9Wo9+sj4Opp0w6C9GDbe80J0XA+yqyLQ3MoXmmS4fADZCKwZtNfWGsKvkwAlqdhk3CPml/S1Zv7yGV73v7CQfXHrB2GC2YX/j84Y6ZidJ/t7vmaUe/cveFhn6M5CkOfgZeTvwNChLF29cjabpOy78uEit0r5EspD8u6K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688384; c=relaxed/simple;
	bh=qpHIM6YnYllXJBhjTIesa6Zq2KS90k/uo07qBiUB/WE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bmjQLMQZ1xBjNP2hcIqbbwO4XOpRR+y1Bnv0ZoiEn4QbFpi1cjvJmT/azYVtsX41tiXJ361Qqk1jIXvUkEU+7mVfJNReNBIVZ02YXNCUu0VbQIz6oHTR514yLFlA7z6dU5t/laYVUOOBCbQznR7zc0KLwX9PiOP+0xoHpyHrSEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yOTnd+5d; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yOTnd+5d"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1773688378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LNwjG7vphj87A52917jo1EKcEXJ0csNxpuAemw6xfDg=;
	b=yOTnd+5d2W9JIfF1WKm8uu/A+iwLOe6zl3vvz8Qu/YXexigOzko2a62Jfg3PQts3TkhJfZ
	/h5Q3fsphDDlSy0fmFXy28GXO0wN2ex4n5JSgA2Vf905pzz7gOiSNfiCoodXlLGUF4SP1I
	znDVbfMAbmWkRoZAqyTzSGzzAocc0+Q=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>, Siddharth Asthana
 <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 1/2] sequencer: extract revert message formatting
 into shared function
In-Reply-To: <xmqqy0jv7ml9.fsf@gitster.g>
References: <20260218234215.89326-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260313054035.26605-2-siddharthasthana31@gmail.com>
 <xmqqy0jv7ml9.fsf@gitster.g>
Date: Mon, 16 Mar 2026 20:12:37 +0100
Message-ID: <87pl53si56.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> The logic for formatting revert commit messages (handling "Revert" and
>> "Reapply" cases, appending "This reverts commit <ref>.", and handling
>> merge-parent references) currently lives inline in do_pick_commit().
>> The upcoming replay --revert mode needs to reuse this logic.
>>
>> Extract all of this into a new sequencer_format_revert_message()
>> function. The function takes a repository, the subject line, commit,
>> parent, a use_commit_reference flag, and the output strbuf. It handles
>> both regular reverts ("Revert "<subject>"") and revert-of-revert cases
>> ("Reapply "<subject>""), and uses refer_to_commit() internally to
>> format the commit reference.
>>
>> Update refer_to_commit() to take a struct repository parameter instead
>> of relying on the_repository, and a bool instead of reading from
>> replay_opts directly. This makes it usable from the new shared function
>> without pulling in sequencer-specific state.

I wouldn't mind if you put removing the use of `the_repository` in a
separate commit.

>>
>> Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
>> ---
>>  sequencer.c | 78 +++++++++++++++++++++++++++++++----------------------
>>  sequencer.h | 14 ++++++++++
>>  2 files changed, 60 insertions(+), 32 deletions(-)
>
> Relative to the previous round, sequencer_format_revert_message()
> that does a bit more than sequencer_format_revert_header() we had
> makes the existing code easier to follow, even though the total
> codeflow amounts to the same thing.  A new caller that will use the
> function now has to do less.
>
> Also, even though this is an internal implementation detail,
> changing the list of parameters refer_to_commit() takes makes it
> easier to understand which part of the replay_opts structure is used
> (i.e., we only care about "do we use the commit reference, or not?"
> bit, and we have no interest in any other members of the struct).

Patrick suggested[1] to use flags, but it makes sense to keep it simple
for now.

[1]: https://lore.kernel.org/git/aTZ5RrjnwJ2ZnT7A@pks.im/

>
>> +/*
>> + * Formats a complete revert commit message following standard Git conventions.
>> + * Handles regular reverts ("Revert \"<subject>\""), revert of revert cases
>> + * ("Reapply \"<subject>\""), and the --reference style. Appends "This reverts
>> + * commit <ref>." using either the abbreviated or full commit reference
>> + * depending on use_commit_reference. Also handles merge-parent references.
>> + */

I think you're trying to put too much in the comments here. I would
suggest to be a bit more concise. Maybe something like:

/*
 * Format a revert commit message with appropriate "Revert" or "Reapply"
 * prefix and "This reverts commit <ref>." body. When use_commit_reference
 * is set, <ref> is an abbreviated hash with subject and date.
 */

>> +void sequencer_format_revert_message(struct repository *r,
>> +				     const char *subject,
>> +				     const struct commit *commit,
>> +				     const struct commit *parent,
>> +				     bool use_commit_reference,
>> +				     struct strbuf *message);
>> +
>>  #endif /* SEQUENCER_H */
>
> OK.
>

-- 
Cheers,
Toon
