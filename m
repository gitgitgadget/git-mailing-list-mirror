Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792F19D890
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717657583; cv=none; b=jQVHETlUyP669R2jBjRqkblWMIW7oHF4TRgLj5gzjBMToqcMcoOWIQM7ICwRpmpb8BPQ7t3pZfE73mHk9wAMnTmMK6yhGKta04fz0s0sC4jvvr8hehr7aQ5YQhWNli9toUzu68vJUtKr+DLIL4Qd3gvEf8TsdV6plaIFfVOjIpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717657583; c=relaxed/simple;
	bh=3vY9hvI+ThkrN0sYy0xfYP+7OSPEqu8apYjVmyKRgGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9UdIvRzImHrA/Ns9v+Od+pdXSgqUc/f+GCbzf5ccT/c6plhKlvdxX9VAtxcaV+uDJEsH74YuZT+zJ1DO0yVJH7D+G7Q3VGE3AphDt/HAvNZ52eiNfvjAAQMA3iuTABKj2H6Rkg1sP2XQ8/tS1I0i0sXwyi8mgi7GUpKoRSoDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9963 invoked by uid 109); 6 Jun 2024 07:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 07:06:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6038 invoked by uid 111); 6 Jun 2024 07:06:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 03:06:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 03:06:19 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 00/12] refs: ref storage migrations
Message-ID: <20240606070619.GD646308@coredump.intra.peff.net>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717649802.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717649802.git.ps@pks.im>

On Thu, Jun 06, 2024 at 07:28:52AM +0200, Patrick Steinhardt wrote:

> the ref storage migration was merged to `next`, but got reverted due to
> some additional findings by Peff and/or Coverity.
> 
> Changes compared to v4:
> 
>   - Adapt comment of `ref_store_init()` to the new parameter.
> 
>   - Fix use of an uninitialized return value in `for_each_root_ref()`.
> 
>   - Fix overwrite of ret code in `files_ref_store_remove_on_disk()`.
> 
>   - Adapt an error message to more clearly point out that deletion of
>     "refs/" directory failed in `reftable_be_remove_on_disk()`.
> 
>   - Fix a leak when `mkdtemp()` fails.

These all looked good to me (though I did not carefully read the
original topic, so was just looking at the parts I mentioned earlier).

>  6:  f7577a0ab3 !  6:  86cf0c84b1 refs/files: extract function to iterate through root refs
>     @@ refs/files-backend.c: static void add_root_refs(struct files_ref_store *refs,
>       		strbuf_setlen(&refname, dirnamelen);
>       	}
>      +
>     ++	ret = 0;
>     ++
>      +done:
>       	strbuf_release(&refname);
>       	strbuf_release(&path);

Since the context doesn't show much, I wondered whether there was any
case where we'd overwrite an earlier "ret" here. But nope, we always
jump to "done" after finding "ret" contains a non-zero value. So setting
it to zero here is the right thing.

-Peff
