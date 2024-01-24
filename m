Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06A7132C24
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124682; cv=none; b=PWPhiB92hW++4XpFheHFAGNGagnwJ/cvSS1tfYNVjsF3rJ9THqA8Z1HFRu6wOv6QGc2SSdSsnq7doebmSIh/5kJQdfTlhG6DuQ53ZEcBUkbDhnIgJSrBijm+yHPwweY1RTj9yLdKup9QZRHPsygtgc4O2f74WTf03PvsRV1VofM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124682; c=relaxed/simple;
	bh=cjowRMCho7XUsOnxU65neNPyvUvxEvlaBUN1+XZ1gZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pifvkRlULMvSBy7eACDMKxf3kTuurMNKpSpXBKJZr1lZ8z9hj7EQ8g6gkCx+hNAntpSRH4Mc0C3eNxG1qUDI5O7GVIum8ljkA9Udqy31cRPYyV331afgETQfK6ibI+tnbSVr19db6kqAprkPPJlACsao7B8oyp+xtzOM4O1fg+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=M69CaoYU; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="M69CaoYU"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 87EDE1BB0E;
	Wed, 24 Jan 2024 14:31:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cjowRMCho7XUsOnxU65neNPyvUvxEvlaBUN1+X
	Z1gZw=; b=M69CaoYUkhuapm0YM0+5Wosz+T2JRlq8lx1ncJhZiDnMhKjXck+5ZM
	7nAx5GC5kUXJwtz09811x3eIlrpiVDXljArI6CpO6rrg4zZ9F4hAQJGAZRlb/4TB
	o9N17gJcHnVut8vQvQESSegSBzoZusdpfaOPupZaEC2mB8qW6Og5w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7849E1BB0D;
	Wed, 24 Jan 2024 14:31:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF8541BB0C;
	Wed, 24 Jan 2024 14:31:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  bcmills@google.com
Subject: Re: [PATCH] transport-helper: re-examine object dir after fetching
In-Reply-To: <20240124010056.GA2603087@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 23 Jan 2024 20:00:56 -0500")
References: <ZbAqsf-2DWaXbN7K@google.com>
	<20240124010056.GA2603087@coredump.intra.peff.net>
Date: Wed, 24 Jan 2024 11:31:09 -0800
Message-ID: <xmqq5xziedfm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2114081E-BAEF-11EE-9C63-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> Thanks, I was able to reproduce it. Besides using the v0 protocol, two
> key elements are that the server is http and the use of --depth.
>
> The patch below explains what's going on and should fix it. I prepared
> the patch on top of 'master', but it can also be applied directly on
> 61c7711cfe or on v2.21.0, modulo some minor textual conflicts in the
> test script (modern t5551 has some more tests, and no longer calls
> stop_httpd manually).

Thanks.

The usual "one liner fix that requires two-page explanation"
that only you can produce ;-).

> ...
>      So everything works, but mostly due to luck. Whereas in a fetch
>      with --depth, we skip step 2 entirely, and thus the out-of-date
>      cache is still in place for step 3, giving us the wrong answer.
>
> So the test works with a small "--depth 1" fetch, which makes sure that
> we don't store the pack from the other side, and that we don't trigger
> the accidental cache invalidation. And of course it forces the use of
> v0 along with using the http protocol.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5551-http-fetch-smart.sh | 18 ++++++++++++++++++
>  transport-helper.c          |  3 +++
>  2 files changed, 21 insertions(+)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index e069737b80..a623a1058c 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -733,4 +733,22 @@ test_expect_success 'no empty path components' '
>  	! grep "//" log
>  '
>  
> +test_expect_success 'tag following always works over v0 http' '
> +	upstream=$HTTPD_DOCUMENT_ROOT_PATH/tags &&
> +	git init "$upstream" &&
> +	(
> +		cd "$upstream" &&
> +		git commit --allow-empty -m base &&
> +		git tag not-annotated &&
> +		git tag -m foo annotated
> +	) &&
> +	git init tags &&
> +	git -C tags -c protocol.version=0 \
> +		fetch --depth 1 $HTTPD_URL/smart/tags \
> +		refs/tags/annotated:refs/tags/annotated &&
> +	git -C "$upstream" for-each-ref refs/tags >expect &&
> +	git -C tags for-each-ref >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/transport-helper.c b/transport-helper.c
> index e34a8f47cf..07e42e239a 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -17,6 +17,7 @@
>  #include "refspec.h"
>  #include "transport-internal.h"
>  #include "protocol.h"
> +#include "packfile.h"
>  
>  static int debug;
>  
> @@ -432,6 +433,8 @@ static int fetch_with_fetch(struct transport *transport,
>  			warning(_("%s unexpectedly said: '%s'"), data->name, buf.buf);
>  	}
>  	strbuf_release(&buf);
> +
> +	reprepare_packed_git(the_repository);
>  	return 0;
>  }
