Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7741C6B9
	for <git@vger.kernel.org>; Mon, 26 Feb 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.68.5.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708980073; cv=none; b=T+9REzFmwn2Y3wFLZah21t5PwPZPKT9QMhnLZstUTekWG8+sBvShSxrfRcIEviVKu7ONYGM79YA/PNRX55cGyoOjDUXOcDFhbZXQAAldwv6gU395P582QcN+a9a4MfUrocKg5ZqRh+sHCFoW+L6EG+FSCqE4F51J5pAwaDdmoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708980073; c=relaxed/simple;
	bh=Dwho6yQBVuXn7iy/PNg7jpNQEmNk8k+JSz9RfCLKark=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLneszmO0DeTNYuBWlyA6ZMqsUcpPs9s6g3+9u83xzgp5ZYK70ivFHhyiNN9El4rDVak9cPMjw61SXndR7KB8mJfbuBPCXtP1BGN1UnZBchL6LOHP2t/bGsZGeEsux5/h0Hp2tJfKoNA3Qq4ILOu3/vWnvHqqKsxpystIv5PiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com; spf=fail smtp.mailfrom=jeffhostetler.com; arc=none smtp.client-ip=209.68.5.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jeffhostetler.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=jeffhostetler.com
Received: from siwi.pair.com (localhost [127.0.0.1])
	by siwi.pair.com (Postfix) with ESMTP id 043BDCA125B;
	Mon, 26 Feb 2024 15:41:09 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:b846:2f3e:cac1:b0eb] (unknown [IPv6:2600:1700:840:e768:b846:2f3e:cac1:b0eb])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id B089DCC83BB;
	Mon, 26 Feb 2024 15:41:08 -0500 (EST)
Message-ID: <b6cfe94a-adcf-04fa-2ed8-dfd4f0fdc77a@jeffhostetler.com>
Date: Mon, 26 Feb 2024 15:41:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 14/16] fsmonitor: support case-insensitive events
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>,
 Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Jeff Hostetler <jeffhostetler@github.com>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
 <288f3f4e54e98a68d72e97125b1520605c138c3c.1708658300.git.gitgitgadget@gmail.com>
 <xmqqjzmvt5d3.fsf@gitster.g>
From: Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <xmqqjzmvt5d3.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: mailmunge 3.11 on 209.68.5.199



On 2/23/24 1:14 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +/*
>> + * Use the name-hash to do a case-insensitive cache-entry lookup with
>> + * the pathname and invalidate the cache-entry.
>> + *
>> + * Returns the number of cache-entries that we invalidated.
>> + */
>> +static size_t handle_using_name_hash_icase(
>> +	struct index_state *istate, const char *name)
>> +{
>> +	struct cache_entry *ce = NULL;
>> +
>> +	ce = index_file_exists(istate, name, strlen(name), 1);
>> +	if (!ce)
>> +		return 0;
>> +
>> +	/*
>> +	 * A case-insensitive search in the name-hash using the
>> +	 * observed pathname found a cache-entry, so the observed path
>> +	 * is case-incorrect.  Invalidate the cache-entry and use the
>> +	 * correct spelling from the cache-entry to invalidate the
>> +	 * untracked-cache.  Since we now have sparse-directories in
>> +	 * the index, the observed pathname may represent a regular
>> +	 * file or a sparse-index directory.
>> +	 *
>> +	 * Note that we should not have seen FSEvents for a
>> +	 * sparse-index directory, but we handle it just in case.
>> +	 *
>> +	 * Either way, we know that there are not any cache-entries for
>> +	 * children inside the cone of the directory, so we don't need to
>> +	 * do the usual scan.
>> +	 */
>> +	trace_printf_key(&trace_fsmonitor,
>> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
>> +			 name, ce->name);
>> +
>> +	untracked_cache_invalidate_trimmed_path(istate, ce->name, 0);
>> +	ce->ce_flags &= ~CE_FSMONITOR_VALID;
>> +	return 1;
>> +}
> 
> You first ask the name-hash to turn the incoming "name" into the
> case variant that we know about, i.e. ce->name, and use that to
> access the untracked cache.  Clever and makes sense.  But if we have
> ce->name, doesn't it mean the name is tracked?  Do we find anything
> useful to do in the untracked cache invalidation codepath in that
> case?
> 
> An FSmonitor event with case-incorrect pathname for a directory may
> not be this trivial, I presume, and I expect that is what the
> remainder of this patch is about.

We're going to use "handle_using_name_hash_icase()" to lookup both
qualified (with trailing slash provided by the daemon) paths and
unqualified paths (either a file or a directory on a platform that
can't tell), so there are 3 cases to worry about.

If we fail to find a cache-entry in the name-hash, we know nothing
about the path and we still have the three cases to worry about and
we let the caller deal with that.

If we DO find a matching cache-entry, then it is either a tracked
file or one of the new sparse-directories cache-entries.  We now know
the correct case-spelling.  I don't think it is possible for the UC
to have an entry for this spelling, so you're right, we may not need
to explicitly invalidate the UC here.  I'll add a comment to the code
about this.


> 
>> +
>> +/*
>> + * Use the dir-name-hash to find the correct-case spelling of the
>> + * directory.  Use the canonical spelling to invalidate all of the
>> + * cache-entries within the matching cone.
>> + *
>> + * Returns the number of cache-entries that we invalidated.
>> + */
>> +static size_t handle_using_dir_name_hash_icase(
>> +	struct index_state *istate, const char *name)
> 
> It is a bit unfortunate that here on the name-hash side we contrast
> the two helper function variants as "dir-name" vs "name", while the
> original handle_path side use "without_slash" vs "with_slash".
> 
> If I understand correctly, it is not like there are two distinct
> hashes, "name-hash" vs "dir-name-hash".  Both of these helpers use
> the same "name-hash" mechanism, and this function differs from the
> previous one in that it is about a directory, which is why it has
> "dir" in its name.  I wonder if we renamed the other one with
> "nondir" in its name, and the other without_slash and with_slash
> pair to match, e.g., handle_nondir_path() vs handle_dir_path(), or
> something like that, the resulting names for these four functions
> become easier to contrast and understand?

name-hash.[ch] has 2 distinct hash-maps inside it. The "name-hash"
that we typically think about. And a well-hidden "dir-name-hash"
in the same source file.

The "name-hash" maps each cache-entry's pathname to its ce* in
the cache-entry[] (case-insensitively).

The "dir-name-hash" maps each unique directory prefix over all
of the cache-entries to the case-correct prefix.  That is, if the
index contains "dir1/Dir2/DIR3/file1" and "dir1/dir4/file2", the
dir hash will have 4 entries
     { "dir1", "dir1/Dir2", "dir1/Dir2/DIR3", "dir1/dir4" }.
This lets us do lookups without having to do a linear search on
the entire cache-entry[] every time.

These 2 hashes are demand-loaded only when needed (and usually only
when ignore_case is set IIRC).

When "handle_using_dir_name_hash_icase()" is called we still don't
know if the pathname is actually a file or directory, all we know
is that we did not find a case-sensitive exact match nor a
case-insensitive match against the cache-entry[] using the name-hash.
The pathname could be a (unqualified) directory or just a plain
untracked file.  So here, if we find it in the dir-name-hash, we now
know that it is a directory and that there was a case-error and we now
know the directory's correct case-spelling.

So we use that discovered case-correct spelling to invalidate the
untracked-cache.

> 
>> +{
>> +	struct strbuf canonical_path = STRBUF_INIT;
>> +	int pos;
>> +	size_t len = strlen(name);
>> +	size_t nr_in_cone;
>> +
>> +	if (name[len - 1] == '/')
>> +		len--;
>> +
>> +	if (!index_dir_find(istate, name, len, &canonical_path))
>> +		return 0; /* name is untracked */
>> +
>> +	if (!memcmp(name, canonical_path.buf, canonical_path.len)) {
>> +		strbuf_release(&canonical_path);
>> +		/*
>> +		 * NEEDSWORK: Our caller already tried an exact match
>> +		 * and failed to find one.  They called us to do an
>> +		 * ICASE match, so we should never get an exact match,
>> +		 * so we could promote this to a BUG() here if we
>> +		 * wanted to.  It doesn't hurt anything to just return
>> +		 * 0 and go on becaus we should never get here.  Or we
>> +		 * could just get rid of the memcmp() and this "if"
>> +		 * clause completely.
>> +		 */
>> +		return 0; /* should not happen */
>> +	}
> 
> "becaus" -> "because".
> 
> If we should never get here, having BUG("we should never get here")
> would not hurt anything, either.  On the other hand, silently
> returning 0 will hide the bug under the carpet, and I am not sure it
> is fair to call it "doesn't hurt anything".

I'll make it a BUG().

> 
>> +
>> +	trace_printf_key(&trace_fsmonitor,
>> +			 "fsmonitor_refresh_callback MAP: '%s' '%s'",
>> +			 name, canonical_path.buf);
>> +
>> +	/*
>> +	 * The dir-name-hash only tells us the corrected spelling of
>> +	 * the prefix.  We have to use this canonical path to do a
>> +	 * lookup in the cache-entry array so that we repeat the
>> +	 * original search using the case-corrected spelling.
>> +	 */
>> +	strbuf_addch(&canonical_path, '/');
>> +	pos = index_name_pos(istate, canonical_path.buf,
>> +			     canonical_path.len);
>> +	nr_in_cone = handle_path_with_trailing_slash(
>> +		istate, canonical_path.buf, pos);
>> +	strbuf_release(&canonical_path);
>> +	return nr_in_cone;
>> +}
> 
> Nice.  Do we need to give this corrected name to help untracked
> cache invalidation from the caller that called us?

In an earlier commit, I moved the call to invalidate the untracked-cache
into the two handle_path_with[out]_trailing_slash() functions so that
we wouldn't have to worry about it here.

> 
>> @@ -319,6 +416,19 @@ static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
>>   	else
>>   		nr_in_cone = handle_path_without_trailing_slash(istate, name, pos);
>>   
>> +	/*
>> +	 * If we did not find an exact match for this pathname or any
>> +	 * cache-entries with this directory prefix and we're on a
>> +	 * case-insensitive file system, try again using the name-hash
>> +	 * and dir-name-hash.
>> +	 */
>> +	if (!nr_in_cone && ignore_case) {
>> +		nr_in_cone = handle_using_name_hash_icase(istate, name);
>> +		if (!nr_in_cone)
>> +			nr_in_cone = handle_using_dir_name_hash_icase(
>> +				istate, name);
>> +	}
> 
> It might be interesting to learn how often we go through these
> "fallback" code paths by tracing.  Maybe it will become too noisy?
> I dunno.

I'm afraid it will be very noisy. On Windows and Mac we'll probably end
up falling back for anything that is untracked, unfortunately.  That is,
if there is no cache-entry for "foo.obj", then we'll look for a
case-error (maybe there is a tracked "FOO.OBJ" file in the index or a
"Foo.Obj" directory), before we can say it is untracked.

I'm not happy about this (and no, I haven't had time to measure the
perf hit we'll take), but right now I'm just worried about the
correctness -- I've had several reports of stale/incomplete status
when IDE tools change file/directory case in unexpected ways....

Thanks
Jeff
