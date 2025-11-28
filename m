Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32FC248886
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 18:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764355854; cv=none; b=HK51Ug/aOJNO0wd7N+rFbYBk6JXc3Mz4gZhSG8amZzlYK2YX4FuwDdvrfVAGl7vnv+sFpZnTOtPViZc3zDxeAEt4PxtkNuVyIsuj/7NxjHCD29G8oD7F9olR+rIqg9+g/UaDr20hFW3SADATY1dGWSDxj6tKu5Rq+3CDZsGC6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764355854; c=relaxed/simple;
	bh=JupQcd89L4PTEoCj+FePGWqf4o2pCrBNEC1J48KJUfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YXEuB8HhxaD3gmm7vKceENnFjcJvNdBAMowg7Vd1U1yTShzOH9ngD319h5RlZc7G8g8SQSQfZP8CkP63ghhtHwKuVjSAiT36oe+4JSamiTrgNZNgchzzmj/LjJqD8lSzFQ7bQOYTh2eJwdAFBDgJESqZovk4UIq6i1LmVfVyPXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=VyjgbahD; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="VyjgbahD"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764355844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzSjNRiv2jlsjces1kAPmB8AostIP3ms8Tl0ukJvbT0=;
	b=VyjgbahDTQlrxKYfeqMp7GZIbO8jV6hkEB+fGod25ENKf7+HisgyK/XiT5383w0YHLj2Qr
	oF1zJ0JcpcnIydq2/Vh6hIuP+pnjOFaLOCo9EXCqgfLeNO0xXoVpDD/tMYQlWcavXZa+kO
	Bn4iEPWImIQxYipw6J++xY8Zqk+Jg5U=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] last-modified: handle and document NUL termination
In-Reply-To: <xmqq3460pw8y.fsf@gitster.g>
References: <20251126-toon-last-modified-zzzz-v1-0-608350df0caa@iotcl.com>
 <20251126-toon-last-modified-zzzz-v1-1-608350df0caa@iotcl.com>
 <xmqq3460pw8y.fsf@gitster.g>
Date: Fri, 28 Nov 2025 19:50:30 +0100
Message-ID: <87tsye0z61.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> When option `-z` is provided to git-last-modified(1), each line is
>> separated with a NUL instead of a newline. Document this properly and
>> handle parsing of the option in the builtin itself.
>
> I think documenting does make sense, but it is not clear from the
> description why it is better to handle the option in the builtin
> itself, instead of letting the setup_revisions() take care of it.

I know it's silly, but I wanted to feed these options to
parse_options(). Doing this would make them show up in `git
last-modified -h`.

> Is it because after the command lets setup_revisions() to parse out
> the revision range, the command does not really let the revision
> machinery drive diffs and let it output anything (hence, even though
> rev.diffopt.line_termination is set from the command line, the calling
> builtin is the only one that pays attention, and the revision machinery
> and the diff machinery called from there does not pay attention to it?

That too, at least for this option. Not the other patch.

> And assuming that this new division of labor between the revision
> machinery and the subcommand makes sense (it needs to be explained
> better), the updated code does make sense to me.
>
> But it looks suboptimal.  See below.
>
>> +#define LAST_MODIFIED_INIT { \
>> +	.line_termination = '\n', \
>> +}
>
> You have to introduce such a non-zero initialization, only because
> you pretend to accept _any_ byte here, and use it as the line
> termination character.  If you were porting Git to ancient Macintosh,
> you could set this to '\r' and it would follow their text file
> convention there ;-)
>
> But ...
>
>>  struct last_modified_entry {
>>  	struct hashmap_entry hashent;
>>  	struct object_id oid;
>> @@ -55,6 +59,7 @@ struct last_modified {
>>  	struct rev_info rev;
>>  	bool recursive;
>>  	bool show_trees;
>> +	int line_termination;
>>  
>>  	const char **all_paths;
>>  	size_t all_paths_nr;
>> @@ -165,7 +170,7 @@ static void last_modified_emit(struct last_modified *lm,
>>  		putchar('^');
>>  	printf("%s\t", oid_to_hex(&commit->object.oid));
>>  
>> -	if (lm->rev.diffopt.line_termination)
>> +	if (lm->line_termination)
>>  		write_name_quoted(path, stdout, '\n');
>>  	else
>>  		printf("%s%c", path, '\0');
>
> ... you use hardcoded '\n' here, without allowing the value of
> line_termination to affect the termination character.
>
> This is way suboptimal.  Instead, would it work if you add
>
> 	bool null_termination;
>
> to the last_modified structure, and do
>
> 	if (!lm->null_termination)
> 		write_name_quoted(path, stdout, '\n');
> 	else
> 		printf("%s%c", path, '\0');
>
> here?   Then
>
>> @@ -507,10 +512,10 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>>  		      struct repository *repo)
>>  {
>>  	int ret;
>> -	struct last_modified lm = { 0 };
>> +	struct last_modified lm = LAST_MODIFIED_INIT;
>
> You do not need this change, and
>
>>  	const char * const last_modified_usage[] = {
>> -		N_("git last-modified [--recursive] [--show-trees] "
>> +		N_("git last-modified [--recursive] [--show-trees] [-z] "
>>  		   "[<revision-range>] [[--] <path>...]"),
>>  		NULL
>>  	};
>> @@ -520,6 +525,8 @@ int cmd_last_modified(int argc, const char **argv, const char *prefix,
>>  			 N_("recurse into subtrees")),
>>  		OPT_BOOL('t', "show-trees", &lm.show_trees,
>>  			 N_("show tree entries when recursing into subtrees")),
>> +		OPT_SET_INT('z', NULL, &lm.line_termination,
>> +			N_("lines are separated with NUL character"), '\0'),
>
> This will become OPT_BOOL() to set the &lm.null_termination.
>
>>  		OPT_END()
>>  	};
>

I actually agree this is better. But I was following the pattern of
`line_termination` other in various other places. I'll adapt it to use a
bool instead.

-- 
Cheers,
Toon
