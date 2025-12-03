Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E45E28B415
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764760326; cv=none; b=ls+hjzIPHZg4iiInWwuiaG3m/s+a2UWnU8t7G+HW/hYluQznp1LMjlYbhwyHyePH3zmkHDrWoC9UNjMcYp52X0vfjurW1kgIE5lCGHFOG2owwnbsNN1snvT62gb96Kw6sd5UoOKaFsrdfl1pbUJdHprIqsHcBld1JzIYjJqHqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764760326; c=relaxed/simple;
	bh=ggJ4NpCrWQjXTZMSjVlaGsHhlUw/fZ9fx3EBA7butLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ep97MYFd8gJBGjHqmZuiizJjRMFiJ0w7cC+lUzecQUZ35nbbV5sSSLIVKP+BXnBwlKpY0UPNvTo9eIiTNcAjkbqzYiNs7ltpe83BWsUUN10mqz2HtTvrML7ivZJOIliPOK7CTBMSHaGojGTkxYi6bGyvVN8uer4FhzOUJKY/UDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Fr6257oi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Fr6257oi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1764760319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXKU2SDVRisXL/fuw+eG8yQGGrLlq/G+0xGRktTYvz0=;
	b=Fr6257oi9SfjG8dlkilNGr3b16q6DY53m50Obgd4acoL4heKc1id6P9z7l2L/+MtEuf9TX
	PistmT3+Ik5j0HkiPb/LWvyG3PId+yqqVK7dThypDSGiN4G1KP/g2ic9tP9/jJtxqITjAE
	kKSpNBsxPZs9gaGq0zGrmaPwGOx57+Q=
From: Toon Claes <toon@iotcl.com>
To: Derrick Stolee <stolee@gmail.com>, Johannes Schindelin via GitGitGadget
 <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] last-modified: support sparse checkouts
In-Reply-To: <75f862a5-2663-4211-b96c-d2c5d1c6f91e@gmail.com>
References: <pull.2013.git.1764423826908.gitgitgadget@gmail.com>
 <75f862a5-2663-4211-b96c-d2c5d1c6f91e@gmail.com>
Date: Wed, 03 Dec 2025 12:11:50 +0100
Message-ID: <87qztbx1jd.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Derrick Stolee <stolee@gmail.com> writes:

> On 11/29/2025 8:43 AM, Johannes Schindelin via GitGitGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> In a sparse checkout, a user might want to run `last-modified` on a
>> directory outside the worktree.
>> 
>> And even in non-sparse checkouts, a user might need to run that command
>> on a directory that does not exist in the worktree.
>> 
>> These use cases should be supported via the `--` separator between
>> revision and file arguments, which is even advertised in the
>> documentation. This patch fixes a tiny bug that prevents that from
>> working.
>
>>  	argc = parse_options(argc, argv, prefix, last_modified_options,
>>  			     last_modified_usage,
>> -			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
>> +			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT |
>> +			     PARSE_OPT_KEEP_DASHDASH);
>
> I'm intrigued that this is the only fix that was required.

I like it!

>> +test_expect_success 'last-modified in sparse checkout' '
>> +	test_when_finished "git sparse-checkout disable" &&
>> +	git sparse-checkout set b &&
>> +	check_last_modified -- a <<-\EOF
>
> Would we expect this to work without the '--'? Should it
> fail for a directory that exists at HEAD but is outside of
> the sparse-checkout?

I don't think we need to complicate things that much. Arguments after
the '--' are handled as pathspecs. If no paths match that pathspec, the
output is simply nothing.

Just to demonstrate:

On 'master':

    $ git last-modified a
    fatal: ambiguous argument 'a': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

    $ git last-modified -- a
    fatal: ambiguous argument 'a': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

With this patch applied:

    $ git last-modified a
    fatal: ambiguous argument 'a': unknown revision or path not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'

    $ git last-modified -- a

    $ echo $?
    0

I agree this behavior is better. Thanks for this fix. I approve.

-- 
Cheers,
Toon
