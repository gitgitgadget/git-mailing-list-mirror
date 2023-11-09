Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B61B20339
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0266420E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:55:16 -0800 (PST)
Received: (qmail 31546 invoked by uid 109); 9 Nov 2023 18:55:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 18:55:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9335 invoked by uid 111); 9 Nov 2023 18:55:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 13:55:16 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 13:55:15 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] contrib/subtree: stop using `-o` to test for number
 of args
Message-ID: <20231109185515.GD2711684@coredump.intra.peff.net>
References: <cover.1699526999.git.ps@pks.im>
 <b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1ea45b8a8884d09ab070bb0f099834447d28938.1699526999.git.ps@pks.im>

On Thu, Nov 09, 2023 at 11:53:35AM +0100, Patrick Steinhardt wrote:

> Functions in git-subtree.sh all assert that they are being passed the
> correct number of arguments. In cases where we accept a variable number
> of arguments we assert this via a single call to `test` with `-o`, which
> is discouraged by our coding guidelines.
> 
> Convert these cases to stop doing so.

OK. I think these ones really are safe, because they're only expanding
$#, but I agree with the principle to follow the guidelines.

>  # Usage: process_subtree_split_trailer SPLIT_HASH MAIN_HASH [REPOSITORY]
>  process_subtree_split_trailer () {
> -	assert test $# = 2 -o $# = 3
> +	assert test $# -ge 2
> +	assert test $# -le 3

It took me a minute to figure out why we were swapping "=" for "-ge". It
is because we want to logical-OR the two conditions, but "assert"
requires that we test one at a time. I think that is probably worth
explaining in the commit message.

> @@ -916,7 +919,7 @@ cmd_split () {
>  	if test $# -eq 0
>  	then
>  		rev=$(git rev-parse HEAD)
> -	elif test $# -eq 1 -o $# -eq 2
> +	elif test $# -eq 1 || test $# -eq 2

OK, this one is a straight-forward use of "||".

>  cmd_merge () {
> -	test $# -eq 1 -o $# -eq 2 ||
> +	if test $# -lt 1 || test $# -gt 2
> +	then
>  		die "fatal: you must provide exactly one revision, and optionally a repository. Got: '$*'"
> +	fi
> +

But here we swap "-eq" for other operators. We have to because we went
from "||" to an "if". I think what you have here is correct, but you
could also write:

  if ! { test $# -eq 1 || test $# -eq 2; }

(I am OK with either, it just took me a minute to verify that your
conversion was correct. But that is a one-time issue now while
reviewing, and I think the code is readable going forward).

-Peff
