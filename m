Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iZFl//Mt"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1618B9F
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 11:30:28 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BA1192EB0E;
	Tue, 12 Dec 2023 14:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HQThWD/t1l2mCyITjEjYC+wv1sylJaJh1jNe0Q
	1043I=; b=iZFl//MtCQS1/2L+WrPmu0q2+i0zExBr+5vRkMsYxT7yzzJSNFjVt3
	OG/EVPw5YFUvbDPE5OfNAk9pXMoNxyUTmw3NJKYVkhOPuhzSmpG3ap+I7IwfPVc4
	L0DvLHym54bDL9dMxod6yCIqLatJZUCfuNAJb/V3KYmikRqpLMiUE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B20762EB0D;
	Tue, 12 Dec 2023 14:30:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C08E2EAD8;
	Tue, 12 Dec 2023 14:30:24 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tests: prefer host Git to verify chainlint self-checks
In-Reply-To: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 12 Dec 2023 12:32:50 +0100")
References: <4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im>
Date: Tue, 12 Dec 2023 11:30:22 -0800
Message-ID: <xmqq8r5zrzg1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E5897856-9924-11EE-A109-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> To accomodate for cases where the host system has no Git installation we
> use the locally-compiled version of Git. This can result in problems
> though when the Git project's repository is using extensions that the
> locally-compiled version of Git doesn't understand. It will refuse to
> run and thus cause the checks to fail.
>
> Fix this issue by prefering the host's Git resolved via PATH. If it
> doesn't exist, then we fall back to the locally-compiled Git version and
> diff as before.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>
> I've started to dogfood the reftable backend on my local machine and
> have converted many repositories to use the reftable backend. This
> surfaced the described issue because the repository now sets up the
> "extensions.refStorage" extension, and thus "check-chainlint" fails
> depending on which versions of Git I'm trying to compile and test.

I do not think "prefer host Git" is necessarily a good idea; falling
back to use host Git is perfectly fine, of course.

Other than that, I agree with the motivation.

>  t/Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/Makefile b/t/Makefile
> index 225aaf78ed..8b7f7aceaa 100644
> --- a/t/Makefile
> +++ b/t/Makefile
> @@ -111,7 +111,9 @@ check-chainlint:
>  	if test -f ../GIT-BUILD-OPTIONS; then \
>  		. ../GIT-BUILD-OPTIONS; \
>  	fi && \
> -	if test -x ../git$$X; then \
> +	if command -v git >/dev/null 2>&1; then \
> +		DIFFW="git --no-pager diff -w --no-index"; \
> +	elif test -x ../git$$X; then \
>  		DIFFW="../git$$X --no-pager diff -w --no-index"; \
>  	else \
>  		DIFFW="diff -w -u"; \
