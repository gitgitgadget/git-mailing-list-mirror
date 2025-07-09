Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8307801
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752100617; cv=none; b=PeMmrhdyBGlxLE/HU2vNxvQHxRV48GhXuN6oFM1DDJnsQhD9y52kGNNM+IL8Z01UKv7CN/YwE6P8B6Ekks2vHllhib/6gb+9lGJn4H9CMD+G1KJXTLPcdIGZMK1KM8bvyj9dtNqKcALN7eBWBrsDghsbc/uon3KwBWHnSIfCMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752100617; c=relaxed/simple;
	bh=Tp9BS/4WU5WyopLJtqwIieIoSTO2oUOtQosnjxslPgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxIBEGuCCo7+JeNNqy12v52mZIDKrJQXIS5K8buQl36byVOks/Nmat9ITATy4vn+rmT1sHW84YS/ubZFdO8FK8qE+Ys+HQUDCrwVDDmCkiDEZh8VxxXWv9hUb1boZtJ6k2L0T1nSiXJMRMsuMfWMfdCVOx5nz+rLjzHzbmR3CY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=e5q+ALd/; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="e5q+ALd/"
Received: (qmail 30101 invoked by uid 109); 9 Jul 2025 22:36:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Tp9BS/4WU5WyopLJtqwIieIoSTO2oUOtQosnjxslPgQ=; b=e5q+ALd/kril/vdvzLs3asWtO+6qCtxXV3js75ZvwGZXpgrLUNH7nU9vb1aMtOZYkF41i8gfnpqx6EXGPSDH3882+0/IMnls13dKlPFKryQgE4HI2O8EtG1zay90tAmc3dUT834d0TLw8I9rPPxJTzNTH0HTJa60U4ZHwjLiM7axLehaxx71hMcM5cPLrNGqKVdk4OG8pLvutxvW+WN1wn2MsFyQ+FnjaCoj0P+B1Lv7HSI6PbRRY9t9Gh8sVkEtOwV7IKrxIpULm65TQ5bEGu+oqae6IuHLJYDEPGoytPFdkRa6Yn3NzatkAYJXk3cL90J1G5FUGHNJXYh8SKJwAg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Jul 2025 22:36:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16835 invoked by uid 111); 9 Jul 2025 22:36:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Jul 2025 18:36:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 9 Jul 2025 18:36:50 -0400
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] reflog: close leak of reflog expire entry
Message-ID: <20250709223650.GA2046725@coredump.intra.peff.net>
References: <20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-jk-fix-leak-reflog-expire-config-v1-1-34d5461cf8f5@gmail.com>

On Wed, Jul 09, 2025 at 02:49:14PM -0700, Jacob Keller wrote:

> find_cfg_ent() allocates a struct reflog_expire_entry_option via
> FLEX_ALLOC_MEM and returns its pointer to reflog_expire_config(). The
> function exits without freeing the memory:
> 
> Direct leak of 39 byte(s) in 1 object(s) allocated from:
>     #0 0x7ff975ee6883 in calloc (/lib64/libasan.so.8+0xe6883)
>     #1 0x0000010edada in xcalloc ../wrapper.c:154
>     #2 0x000000df0898 in find_cfg_ent ../reflog.c:28
>     #3 0x000000df0898 in reflog_expire_config ../reflog.c:70
>     #4 0x00000095c451 in configset_iter ../config.c:2116
>     #5 0x0000006d29e7 in git_config ../config.h:724
>     #6 0x0000006d29e7 in cmd_reflog_expire ../builtin/reflog.c:205
>     #7 0x0000006d504c in cmd_reflog ../builtin/reflog.c:419
>     #8 0x0000007e4054 in run_builtin ../git.c:480
>     #9 0x0000007e4054 in handle_builtin ../git.c:746
>     #10 0x0000007e8a35 in run_argv ../git.c:813
>     #11 0x0000007e8a35 in cmd_main ../git.c:953
>     #12 0x000000441e8f in main ../common-main.c:9
>     #13 0x7ff9754115f4 in __libc_start_call_main (/lib64/libc.so.6+0x35f4)
>     #14 0x7ff9754116a7 in __libc_start_main@@GLIBC_2.34 (/lib64/libc.so.6+0x36a7)
>     #15 0x000000444184 in _start (/home/jekeller/libexec/git-core/git+0x444184)
> 
> Close this leak by freeing the entry pointer on exit of the
> reflog_expire_config() function. This frees both the entry structure and
> its embedded pattern array thanks to the use of FLEX_ALLOC_MEM.

Hmm, this can't be right, can it? The end of reflog_expire_config()
looks like this:

        ent = find_cfg_ent(opts, pattern, pattern_len);
        if (!ent)
                return -1;
        switch (slot) {
        case REFLOG_EXPIRE_TOTAL:
                ent->expire_total = expire;
                break;
        case REFLOG_EXPIRE_UNREACH:
                ent->expire_unreachable = expire;
                break;
        }
        return 0;

So if we free(ent), then what was the point of the function? We'd set
some fields in it and then throw it away?

And indeed, find_cfg_ent() seems to add the newly allocated entry to the
list opt->entries list. So by freeing here, we're leaving a dangling
pointer in that list.

Probably that list needs to be cleaned up when cmd_reflog_expire()
finishes?

-Peff
