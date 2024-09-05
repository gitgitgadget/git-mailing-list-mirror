Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894911A7266
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 21:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571224; cv=none; b=gxBBdQCMEHvno8nDpRGXR5yZEHiAX7/nVQ+M6NfH/tcumRu5rQWvAiRd+4zcMT+1abJwq0Lh9btQ/dEv9lZqD3N0l9trWRk0fQqhtM/3uLqqFHhbyOZr2pOSGRpLt2SnZX5v30n7HmiQI5hblpyCqMBbgb2p02RLZWvKRY7C4p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571224; c=relaxed/simple;
	bh=N8InAEf3VZf05WqADM30ymwFtiiMlellIhNBpfBR3GQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikmOs2pUNnjj9behm49LLW9WHuObTmA99rCXyXrfnUDpy06oQMeh9lYv6vk9ziRVNF0uQR/Lm8Y41PL25DN67AKOc58VFg9/qaMNyvjHnTH3b/1AY7G83LXB6xWKMjf7/GBB4mxolpjT16uZ2BkPOkyE02aCqx6itBy4vgI3Oco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=D70LYLwG; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D70LYLwG"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 898392FCB7;
	Thu,  5 Sep 2024 17:20:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=N8InAEf3VZf05WqADM30ymwFtiiMlellIhNBpf
	BR3GQ=; b=D70LYLwGVi+ZT4tS0RlBgrtjUSnolan+GrLTqQszSbNSFmdme4b39j
	0gy28MpiEyi4bTjU7DCF8WELfJ5vZrJVg6AH2jtfDw3DA8GtqXRu4O5qwTzEcy7X
	t/PQCyhWM7aBAzn67P4Hx7tQNmuYmHgTUWF+fyk3YlsS8WMkoH80g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 814642FCB6;
	Thu,  5 Sep 2024 17:20:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D3802FCB5;
	Thu,  5 Sep 2024 17:20:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
In-Reply-To: <xmqqr09xztqa.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	05 Sep 2024 14:16:45 -0700")
References: <20240905082749.GA88220@coredump.intra.peff.net>
	<ZtmN6sZCvDy1BGfn@pks.im> <xmqqr09xztqa.fsf@gitster.g>
Date: Thu, 05 Sep 2024 14:20:18 -0700
Message-ID: <xmqqmsklztkd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A754D780-6BCC-11EF-B7E6-9B0F950A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> +	if (commit_lock_file(&lk))
>>> +		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
>>>  
>>>  	clear_pattern_list(pl);
>>
>> I think the error handling is broken. `commit_lock_file()` calls
>> `rename_tempfile()`, which deletes the temporary file even in the error
>> case. The consequence is that `lk->tempfile` will be set to the `NULL`
>> pointer. When we call `get_locked_file_path()` we then dereference it
>> unconditionally and would thus segfault.
>
> Hmph.  Would this be sufficient as a band-aid, then?

Of course not.  That would refer to a piece of memory that we
already free'ed in this function.

Perhaps like this?

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index f1bd31b2f7..27d181a612 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -328,7 +328,7 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	char *sparse_filename;
 	FILE *fp;
 	struct lock_file lk = LOCK_INIT;
-	int result;
+	int result = 0;
 
 	sparse_filename = get_sparse_checkout_filename();
 
@@ -336,19 +336,18 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		die(_("failed to create directory for sparse-checkout file"));
 
 	hold_lock_file_for_update(&lk, sparse_filename, LOCK_DIE_ON_ERROR);
-	free(sparse_filename);
 
 	result = update_working_directory(pl);
 	if (result) {
 		rollback_lock_file(&lk);
 		clear_pattern_list(pl);
 		update_working_directory(NULL);
-		return result;
+		goto out;
 	}
 
 	fp = fdopen_lock_file(&lk, "w");
 	if (!fp)
-		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
+		die_errno(_("unable to fdopen %s"), sparse_filename);
 
 	if (core_sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
@@ -356,11 +355,13 @@ static int write_patterns_and_update(struct pattern_list *pl)
 		write_patterns_to_file(fp, pl);
 
 	if (commit_lock_file(&lk))
-		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
+		die_errno(_("unable to write %s"), sparse_filename);
 
 	clear_pattern_list(pl);
 
-	return 0;
+out:
+	free(sparse_filename);
+	return result;
 }
 
 enum sparse_checkout_mode {
