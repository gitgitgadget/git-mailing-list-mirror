Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HrGfODSg"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2BECD
	for <git@vger.kernel.org>; Tue, 12 Dec 2023 12:28:54 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EB21E2C1CD;
	Tue, 12 Dec 2023 15:28:53 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZpG2c3v7TGbiuoymW7B3mSiV4AH17uH7/vhlaE
	1YEgQ=; b=HrGfODSgBjmvJcx09/y3gx1jGaVMl2eJxtnmlUKLZM59gOgN+6bHKk
	ynNHBhEnDfM3/3vN4uq2JY/xnS7/M12uVcr5ONNKpyV5+Mw+WCqnmG7DNCPSS04H
	8LIWSkLrsQ/ZRbLozrC2pKdzsgTwGl6Qc92K8sA5RdFibH1g82toQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E3F1A2C1CC;
	Tue, 12 Dec 2023 15:28:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87DCF2C193;
	Tue, 12 Dec 2023 15:28:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v2 2/4] refs: propagate errno when reading special refs
 fails
In-Reply-To: <24032a62e54fb37dad46c3ede7151efc8a7a8818.1702365291.git.ps@pks.im>
	(Patrick Steinhardt's message of "Tue, 12 Dec 2023 08:18:52 +0100")
References: <cover.1701243201.git.ps@pks.im> <cover.1702365291.git.ps@pks.im>
	<24032a62e54fb37dad46c3ede7151efc8a7a8818.1702365291.git.ps@pks.im>
Date: Tue, 12 Dec 2023 12:28:49 -0800
Message-ID: <xmqqfs07qi66.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0F621F9A-992D-11EE-B406-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Some refs in Git are more special than others due to reasons explained
> in the next commit. These refs are read via `refs_read_special_head()`,
> but this function doesn't behave the same as when we try to read a
> normal ref. Most importantly, we do not propagate `failure_errno` in the
> case where the reference does not exist, which is behaviour that we rely
> on in many parts of Git.
>
> Fix this bug by propagating errno when `strbuf_read_file()` fails.

Hmph, I thought, judging from what [1/4] did, that your plan was to
use the refs API, instead of peeking directly into the filesystem,
to access these pseudo refs, and am a bit puzzled if it makes all
that much difference to fix errno handling while still reading
directly from the filesystem.  Perhaps such a conversion happens in
later steps of this series (or a follow on series after this series
lands)?

>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs.c              |  4 +++-
>  t/t1403-show-ref.sh | 10 ++++++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/refs.c b/refs.c
> index fcae5dddc6..00e72a2abf 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1806,8 +1806,10 @@ static int refs_read_special_head(struct ref_store *ref_store,
>  	int result = -1;
>  	strbuf_addf(&full_path, "%s/%s", ref_store->gitdir, refname);
>  
> -	if (strbuf_read_file(&content, full_path.buf, 0) < 0)
> +	if (strbuf_read_file(&content, full_path.buf, 0) < 0) {
> +		*failure_errno = errno;
>  		goto done;
> +	}
>  
>  	result = parse_loose_ref_contents(content.buf, oid, referent, type,
>  					  failure_errno);
> diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
> index b50ae6fcf1..66e6e77fa9 100755
> --- a/t/t1403-show-ref.sh
> +++ b/t/t1403-show-ref.sh
> @@ -266,4 +266,14 @@ test_expect_success '--exists with directory fails with generic error' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success '--exists with non-existent special ref' '
> +	test_expect_code 2 git show-ref --exists FETCH_HEAD
> +'
> +
> +test_expect_success '--exists with existing special ref' '
> +	test_when_finished "rm .git/FETCH_HEAD" &&
> +	git rev-parse HEAD >.git/FETCH_HEAD &&
> +	git show-ref --exists FETCH_HEAD
> +'
> +
>  test_done
