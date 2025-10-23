Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D932797AC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 08:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206532; cv=none; b=Rc2N4AAqBDoAjxbI1b4T/fNn/tyHTQZfhuJaUfQMwHu99RHebpL2tWvd3172gJL54acSLMR3cB/li6SYFAOr4a+9eZhIKjiZeIdDsUgcBsK0ZrsX+QYnCXL8VFLnZBE+mPLMVLnCbuxZUclKc0kbb2EGQhCGNCuMGOvkyL/2/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206532; c=relaxed/simple;
	bh=m9yh4JTq4Tg3H0mLu0u+gLHY98fGRtjzRMJisHXW858=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jGmIF3OSRwKbNMbziqU7hUMS3UPfWT2nsn1+VfXQXSwB3kCckCKlUP/DNCc0Znmx2RS6BkGSUFn7ZEODGwVm3YAG5uNVnw3fkrodKOpfHs9moF8DYkdMx9YyMHCtq8ChLToTlyO/dG2f3y031iEhnq3laFUW0opkcctX2n/pIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=j69GTsOE; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="j69GTsOE"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761206517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tFihgVpAdMTfNNc8gxoLabEeEhIgysiEjr1tRin62ak=;
	b=j69GTsOEzWfIoQKZzmab4njFBgHn5X9w62QBZ3yz5OySp363Z7M/+5FWbdCYRQavsEvo2I
	Xut0vj8a1MXgq1NmtBru1vCAeddgwRE0exKByFiPVYlS+kl2DqCUpNt1sp5CfHHap2zXEq
	QrclHM/Iy1r8oKEp34k3YTFuqpZaL2w=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>, "D. Ben
 Knoble" <ben.knoble@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
In-Reply-To: <xmqqy0p4uoqc.fsf@gitster.g>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g>
Date: Thu, 23 Oct 2025 10:01:38 +0200
Message-ID: <87347aqc65.fsf@iotcl.com>
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
>> +static size_t path_idx(struct last_modified *lm, char *path)
>> +{
>> +	struct last_modified_entry *ent;
>> +	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
>> +					  struct last_modified_entry, hashent);
>> +
>> +	return ent ? ent->diff_idx : -1;
>> +}
>
> size_t is unsigned and cannot reutrn -1 sanely, unless the caller
> knows that ((size_t)-1) signals an error.  The compiler warns, and
> we compile with -Werror, so we end up getting
>
>     builtin/last-modified.c: In function 'path_idx':
>     builtin/last-modified.c:235:38: error: operand of '?:' changes signedness from 'int' to 'size_t' {aka 'long unsigned int'} due to unsignedness of other operand [-Werror=sign-compare]
>       235 |         return ent ? ent->diff_idx : -1;
>           |                                      ^~

Whoops, I didn't realize I wasn't compiling with the proper DEVELOPER
settings. I recently set up a new computer and didn't bring over all
configuration correctly.

I just sent out v3 and in that version I decided to solve this issue
differently: inline the code from path_idx() in only place it was used.


-- 
Cheers,
Toon
