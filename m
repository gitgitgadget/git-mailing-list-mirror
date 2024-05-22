Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4687A3F
	for <git@vger.kernel.org>; Wed, 22 May 2024 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716411365; cv=none; b=kIWWHMf0fZLaGu5DFn3OhPVeiqElE7P42Hr7rQcHxPgP90TXC+U2B0liSgY9j5Nz/CEj3Jw0h4Zz5BigAGq1zw9bRdLu+tlN5g0G6fz+EVHKBkFdYS3Wtpjyju4U9LPCg7qtz/tmJs6LJQEdQt3i0XD+zbhMdI7yvbNQnc1MIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716411365; c=relaxed/simple;
	bh=kf9qv9ra9TFgB1wZyGWpRIBLyuIvkgifgVQ9Jo435Xg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XdCQi0c2Bvj88LxHPbU/22zXC0J69T97xOk35bVx2MwtKu1aqb3uf39xaYQiDes/v5Bowwi+n5Dxt312TDX51eV+A+ZHNiJLwRbqNMUun9/ibmDAhfGdLO9Kg8BM48VUzM+tibPhKktTALvDtXEq2FSAlxthxW5ZO4O3kQ4n3Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PkVsn2ZV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PkVsn2ZV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B00B119FBE;
	Wed, 22 May 2024 16:55:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=kf9qv9ra9TFgB1wZyGWpRIBLyuIvkgifgVQ9Jo
	435Xg=; b=PkVsn2ZV2NXQ3uoVKfikZGiZ+vmoWIg/KPJOcIz9iPwkzlsGcTwe7Z
	oMBAMqHxD/6bzNESMRQNf7hZuP4zXzxAa1CN6YPtD48Xh9E12NDLwLQF5iBys3DX
	sQ+Ujh66dU6rXv6GVbjRYPUxlvFsLx2TwjMhZoa7M5TQejmIZGYOk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A839519FBD;
	Wed, 22 May 2024 16:55:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B12CD19FB6;
	Wed, 22 May 2024 16:55:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tom Hughes <tom@compton.nu>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] push: don't fetch commit object when checking existence
In-Reply-To: <20240522201559.1677959-1-tom@compton.nu> (Tom Hughes's message
	of "Wed, 22 May 2024 21:15:40 +0100")
References: <xmqq8r014pyn.fsf@gitster.g>
	<20240522201559.1677959-1-tom@compton.nu>
Date: Wed, 22 May 2024 13:55:52 -0700
Message-ID: <xmqqed9t36sn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 ADC97046-187D-11EF-849C-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Tom Hughes <tom@compton.nu> writes:

> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 88a66f0904..7797391c03 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -689,6 +689,25 @@ test_expect_success 'lazy-fetch when accessing object not in the_repository' '
>  	! grep "[?]$FILE_HASH" out
>  '
>  
> +test_expect_success 'push should not fetch new commit objects' '
> +	rm -rf server client &&
> +	test_create_repo server &&
> +	test_config -C server uploadpack.allowfilter 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	test_commit -C server server1 &&

OK, we create the source that allows a partial clone.

> +	git clone --filter=blob:none "file://$(pwd)/server" client &&
> +	test_commit -C client client1 &&

And make a clone out of it, without blobs.

> +	test_commit -C server server2 &&
> +	COMMIT=$(git -C server rev-parse server2) &&

Then we create a new commit that the client does not yet have.

> +	test_must_fail git -C client push 2>err &&

We try to overwrite it.  We expect it to fail with "not a fast forward".

> +	grep "fetch first" err &&

May want to use "test_grep" but this script does not use it, so
being consistent with the surrounding tests is good.

> +	git -C client rev-list --objects --missing=print "$COMMIT" >objects &&
> +	grep "^[?]$COMMIT" objects
> +'

OK.

>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  start_httpd

Looking good.  Thanks, will queue.
