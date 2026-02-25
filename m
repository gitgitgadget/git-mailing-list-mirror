Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6438F941
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014436; cv=none; b=vGdfgfCC+AT6vPQIbp0FNMCqtKLx8BlX5iAprAGRKo96cXDYMikM0gfWolpqioV87COY9UCR1Iw4Ve//Pz/lXPdc4XfeWMib5AGrAsKDZ/qgiy8tMIquTbZ2NNFcn6WORx4JEXRy3MuZqWghDTASgMmXsqvXeNvEelnh4yv60ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014436; c=relaxed/simple;
	bh=B9o4GtExiq9kdeoXRHH2uYxspEN8DbnQuMIw2ITYiRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnt5+q7Q13yQhvz9g5pYh1MB2UIByHwnZk09EbIbq9VYO+u7jt2EjxCvVpidjato6xK3dz17QfhTCbt1CL73LKnDY3MlsmGmKiFO1pbLir51KxOASeMdh4+2dUWMLt/DgHgzGp0PwurcH3eUkhIS25NhCSvar0qIV5WLOTkF6pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=v4n29ndB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="v4n29ndB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1772014430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nUZeo/Nue2PYCB11N5ExSHeYIFAjZvLUmgop0uMOM4E=;
	b=v4n29ndBXP/D/bXeWyubMZtCLtIJkNv11N7huS9ns2H4O/p1oQxNQG9ZkYPEu0ZR3fPNKu
	Kr0M5VyMCgTtABkrAUZj4xlivHSZioyjOtPU3chs5/q/zRJNyg7RQoOJLsE6NLYI8jo4Gr
	r9XPM6HdSF8EQL+Sp73u/Z73t6K4ZM4=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 6/8] t6500: explicitly use "gc" strategy
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-6-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
 <20260224-b4-pks-maintenance-default-geometric-strategy-v2-6-8657338c6fa1@pks.im>
Date: Wed, 25 Feb 2026 11:13:35 +0100
Message-ID: <871pi9nnao.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The test in t6500 explicitly wants to exercise git-gc(1) and is thus
> highly specific to the actual on-disk state of the repository and
> specifically of the object database. An upcoming change modifies the
> default maintenance strategy to be the "geometric" strategy though,
> which breaks a couple of assumptions.
>
> One fix would arguably be to disable auto-maintenance altogether, as we
> do want to explicitly verify git-gc(1) anyway. But as the whole test
> suite is about git-gc(1) in the first place it feels more sensible to
> configure the default maintenance strategy to be "gc".
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t6500-gc.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index bef472cb8d..ea9aaad470 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -11,6 +11,7 @@ test_expect_success 'setup' '
>  	# behavior, make sure we always pack everything to one pack by
>  	# default
>  	git config gc.bigPackThreshold 2g &&
> +	git config set --global maintenance.strategy gc &&

I wasn't sure (no more) what effect setting globally would have. But
because each test file operates in it's own $TRASH_DIRECTORY, a global
setting only affects that file.

Makes sense.

-- 
Cheers,
Toon
