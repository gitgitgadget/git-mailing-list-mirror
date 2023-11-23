Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PGK8GxVj"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F5101
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 03:44:39 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B42753CDE1;
	Thu, 23 Nov 2023 06:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4xxst/TAI9g/4QlhO2CogahF3kXSaBIjFDvgs9
	q+d7A=; b=PGK8GxVjE7ukgK28vvXuI7aC89vPBiI5FA7gvPRfE2dFYClUYYszPf
	huLSDnx3tbWhyqMXrg8UFmASGzEmAByqayObyJY9TXAt+k6/TTyRCanhGNTQqfIo
	8de2PhYqbFhg9gUJlSuv0B/EtacoH/Bpyaz/AZApfh3Oxe84lA4Lc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id AC5133CDE0;
	Thu, 23 Nov 2023 06:44:38 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4DA223CDDF;
	Thu, 23 Nov 2023 06:44:35 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v2] commit-graph: disable GIT_COMMIT_GRAPH_PARANOIA by
 default
In-Reply-To: <f1235741cea5866e67c83aca83a760e0cdde8730.1700478031.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 20 Nov 2023 12:01:11 +0100")
References: <7e2d300c4af9a7853201121d66f982afa421bbba.1699957350.git.ps@pks.im>
	<f1235741cea5866e67c83aca83a760e0cdde8730.1700478031.git.ps@pks.im>
Date: Thu, 23 Nov 2023 20:44:33 +0900
Message-ID: <xmqq7cm8bsny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ACC08174-89F5-11EE-803C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Note that this requires us to amend some tests to manually turn on the
> paranoid checks again. This is because we cause repository corruption by
> manually deleting objects which are part of the commit graph already.
> These circumstances shouldn't usually happen in repositories.
> ...
> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 40265a4f66..1ca4eb5a36 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -13,6 +13,11 @@ test_expect_success 'create repository and alternate directory' '
>  	test_commit 3
>  '
>  
> +# We manually corrupt the repository, which means that the commit-graph may
> +# contain references to already-deleted objects. We thus need to enable
> +# commit-graph paranoia to not returned these deleted commits from the graph.
> +export GIT_COMMIT_GRAPH_PARANOIA=true

test-lint-shell-syntax is a bit overly strict and complains against
this line, so until it is loosened, I'd suggest to do

	GIT_COMMIT_GRAPH_PARANOIA=true
	export GIT_COMMIT_GRAPH_PARANOIA

instead here.

