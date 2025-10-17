Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B662192D68
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698081; cv=none; b=hbQqAX0Wc+XpW7i8Us1U+jcV82EJ7tfKtfW2T853F1U3FIF2y7bhLidONV54TgHFH0wonOFUFRNVmRkWCeLS3oCeoz1wfJv5noJrnjvUJP8KcoK30PqtDtgQjGFPKQ5aXlATH7LeRWJ0s1DOHurhOeh6uCd6wjiIaGNAWDiEFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698081; c=relaxed/simple;
	bh=PD7t+o29nG25CrzKHaOdjptXaKvTUG++p8F/wAj2sfI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wsj2aA53001u9K+bz4RwTbyclLAUX2M/symJ+H+uB6Q46vJb1T94TMGY2wL7G69UJgw5g8XMzt+LcNF+XlUVxGCulTUmAVh40u+3phrtn7FU9ZUzghTgFF52Rdg6TK71dvtU5ZgYxVj08XHAQF6K+exzup3Nnsp1Yfo+CnDO7TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ajwn195Q; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ajwn195Q"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1760698077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bdfl5XQ8KqJqLMznF1PII/WTy5blENvZ99B+o9nAITM=;
	b=ajwn195QzhihxeEynr/KUgVuC8RKnHIGNOeQ3hF1c3E3I8xlLW4f1tgFR5fZi3kJ61DwgB
	pYd+zA+JtzA82dAnBXohSc7KIcC2Opkfo33vZJczaA4X+/8ZbRuq+uoXjSO7nZu89s/g6X
	p3QPVZH0qXXUj4SDVqgW0ZVeL6CzhgU=
From: Toon Claes <toon@iotcl.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <20251017063701.GA3091356@coredump.intra.peff.net>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251017063701.GA3091356@coredump.intra.peff.net>
Date: Fri, 17 Oct 2025 12:47:41 +0200
Message-ID: <87ms5pu7n6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Jeff King <peff@peff.net> writes:

> On Thu, Oct 16, 2025 at 10:39:25AM +0200, Toon Claes wrote:
>
>> +	for (i = 0; i < diff_queued_diff.nr; i++) {
>> +		struct diff_filepair *fp = diff_queued_diff.queue[i];
>> +		size_t k = path_idx(lm, fp->two->path);
>> +		if (0 <= k && bitmap_get(active_c, k))
>> +			bitmap_set(lm->scratch, k);
>> +		diff_free_filepair(fp);
>> +	}
>
> Just one little oddity while looking at this versus the old patches from
> Taylor. Here you call diff_free_filepair(). But later...
>
>> +	diff_queued_diff.nr = 0;
>> +	diff_queue_clear(&diff_queued_diff);
>
> ...you call diff_queue_clear(), which frees the filepairs itself. It
> does the right thing, because you truncate the queue explicitly. But
> would it be simpler to just leave them in place and let the _clear()
> function clean up? I.e., this:
>
> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> index 40e520ba18..47f2b0ed44 100644
> --- a/builtin/last-modified.c
> +++ b/builtin/last-modified.c
> @@ -315,7 +315,6 @@ static void process_parent(struct last_modified *lm,
>  		size_t k = path_idx(lm, fp->two->path);
>  		if (0 <= k && bitmap_get(active_c, k))
>  			bitmap_set(lm->scratch, k);
> -		diff_free_filepair(fp);
>  	}
>  	for (i = 0; i < lm->all_paths_nr; i++) {
>  		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
> @@ -331,7 +330,6 @@ static void process_parent(struct last_modified *lm,
>  	}
>  
>  	memset(lm->scratch->words, 0x0, lm->scratch->word_alloc);
> -	diff_queued_diff.nr = 0;
>  	diff_queue_clear(&diff_queued_diff);
>  }
>
> which feels a lot more idiomatic to me.

Hah, yes. I think I ended up in this situation because initially I was
only trying to fix memory leaks. Thanks, I will included these changes.

-- 
Cheers,
Toon
