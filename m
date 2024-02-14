Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543A2F844
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951483; cv=none; b=FbVFUbVf0Hz2JJMjQsowPeG5wM1JToiM+8EB916+BFIDh5zNGg6JlBYlutkM7iiAoU5UM6mFa5eMEH7MxvI5u8KKELxAOJPLcWRXBoW1X/8auuV3+EP977bgYOe5jp4Hp8aCLI703ySlSOyyukhN9OKwftyIEiGgF0XSR5wS248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951483; c=relaxed/simple;
	bh=wsMxrcDsNUIvwsugcJHBPOpriUviDCgBUcytVM1PcIc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lti4T9GQC+UEyFgwA/qQs4kuP3Ul6BP5gt5wGSjTT93vtzqg2dJgeGpiISQyf+/qSqNhViG32DSuNz0lG1LZ+4nEMHY6h6BS2Z/HcxRRYO6mQjabY4Gk9ohG6wD8AeeEBcd9CAoBCg7y+ufo9vglMYL7zssL+EHwbcppC24KHm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Knet3Oag; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Knet3Oag"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 6855B214EC;
	Wed, 14 Feb 2024 17:58:01 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=wsMxrcDsNUIvwsugcJHBPOpriUviDCgBUcytVM
	1PcIc=; b=Knet3Oag4H4rJLtvMFCxONEU9nbIHKoS1YpyOH28qiduK8lxUq9+Z1
	bhdcC7XVIFuk8TnLgkXWnM8OMbyD9swIjzHngRp+qsjMgum8pjfwzd4/aSLte0jH
	k4t8snetWo8s7NPIc+az10rG/DZPQ1XjaOeMHYR+2+l8l9EroRyEQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E59CC214EA;
	Wed, 14 Feb 2024 17:58:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7B4FC214E9;
	Wed, 14 Feb 2024 17:57:57 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,
    Jonathan Nieder <jrnieder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/7] t0410: enable tests with extensions with
 non-default repo format
In-Reply-To: <feef6a3e6cd0d9096816d0a8a5789837fb784517.1707463221.git.ps@pks.im>
	(Patrick Steinhardt's message of "Fri, 9 Feb 2024 08:23:13 +0100")
References: <cover.1707463221.git.ps@pks.im>
	<feef6a3e6cd0d9096816d0a8a5789837fb784517.1707463221.git.ps@pks.im>
Date: Wed, 14 Feb 2024 14:57:55 -0800
Message-ID: <xmqqle7mu00c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7E9DE1DC-CB8C-11EE-B812-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> In t0410 we have two tests which exercise how partial clones behave in
> the context of a repository with extensions. These tests are marked to
> require a default repository using SHA1 and the "files" backend because
> we explicitly set the repository format version to 0.
>
> Changing the repository format version to 0 is not needed though. The
> "noop" extension is ignored as expected regardless of what the version
> is set to, same as the "nonsense" extension leads to failure regardless
> of the version.

Isn't the reason why 11664196 kept the forcing of the format version
because it wanted to see noop ignored and nonsense failed even if
the format version is 0 to ensure the regression it fixed will stay
fixed?  IOW, we force version 0 not because we do not want to test
with anything but SHA1 and REFFILES; we pretty much assume that with
the default version, noop and nonsense will be handled sensibly, and
we want to make sure they will be with version 0 as well.

And once we force to version 0, we have trouble running with
anything other than SHA1 and REFFILES, hence these prerequisites.

So, I dunno.

>
> Stop setting the version so that these tests can execute with SHA256 and
> "reftable" repositories.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t0410-partial-clone.sh | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 6b6424b3df..d913f3c453 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -49,24 +49,22 @@ test_expect_success 'convert shallow clone to partial clone' '
>  	test_cmp_config -C client 1 core.repositoryformatversion
>  '
>  
> -test_expect_success SHA1,REFFILES 'convert to partial clone with noop extension' '
> +test_expect_success 'convert to partial clone with noop extension' '
>  	rm -fr server client &&
>  	test_create_repo server &&
>  	test_commit -C server my_commit 1 &&
>  	test_commit -C server my_commit2 1 &&
>  	git clone --depth=1 "file://$(pwd)/server" client &&
> -	test_cmp_config -C client 0 core.repositoryformatversion &&
>  	git -C client config extensions.noop true &&
>  	git -C client fetch --unshallow --filter="blob:none"
>  '
>  
> -test_expect_success SHA1,REFFILES 'converting to partial clone fails with unrecognized extension' '
> +test_expect_success 'converting to partial clone fails with unrecognized extension' '
>  	rm -fr server client &&
>  	test_create_repo server &&
>  	test_commit -C server my_commit 1 &&
>  	test_commit -C server my_commit2 1 &&
>  	git clone --depth=1 "file://$(pwd)/server" client &&
> -	test_cmp_config -C client 0 core.repositoryformatversion &&
>  	git -C client config extensions.nonsense true &&
>  	test_must_fail git -C client fetch --unshallow --filter="blob:none"
>  '
