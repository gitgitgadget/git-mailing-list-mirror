Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6B1F934
	for <git@vger.kernel.org>; Mon, 13 May 2024 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715642003; cv=none; b=vACV5ytYfPodEdCY04kkwZdb5Bchhr/ty3bFGotXc+yClgMt/2YjDyge7/1QJxM5lvwIrtmo7gkWSIQB5l1LfRTWWKUx0CDE/4/0Cz2XBlZp2fMBj725cWMwcrvBuwFmZe4Fl/lmwslfOW2dgjU4oE8dtVsYOTWueq3cKNmlOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715642003; c=relaxed/simple;
	bh=3lzwx5CU+Yjs92Z/csX9Kya/ZhU4pjJm3mXH6vDG6v0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naFPXwxTb5uADVh0pWzE93R68rYmcgmAZQ6uyaba/W592SXJ3HF/Q8N7vqPv1QHEy/3+Ni6iGHXSbZAt9kduVH2yvklQNWHXgGzR5m/XvL8jD1n1SJNYmLgsaGfL+HASo5oCp7j0k1ho7ADbEK9uc1pbvZjaV61kd2lrLI2Smvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PjBd0lXi; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PjBd0lXi"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 568A6373EC;
	Mon, 13 May 2024 19:13:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3lzwx5CU+Yjs92Z/csX9Kya/ZhU4pjJm3mXH6v
	DG6v0=; b=PjBd0lXiWUMyKpBJT7Ve0d5RT4LaAjc2rqc9FJdcovv4HtsUx0sBFi
	SQJ9ncijfnGIgIeBK3gSgzGmuqBwOU1EKSKYqJDzGIh2d+nwZv7IfSU1RdEhFOtk
	mHFtPUohdaGfTEsV3RtOHvQrlNhg6SJYvEiNRoCeTm1ZFEq2etv90=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4DC6D373EB;
	Mon, 13 May 2024 19:13:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFBF3373EA;
	Mon, 13 May 2024 19:13:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 4/5] builtin/hash-object: fix uninitialized hash
 function
In-Reply-To: <20240513224127.2042052-5-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 13 May 2024 15:41:26 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240513224127.2042052-1-gitster@pobox.com>
	<20240513224127.2042052-5-gitster@pobox.com>
Date: Mon, 13 May 2024 16:13:19 -0700
Message-ID: <xmqq7cfxcnlc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 63A8ED76-117E-11EF-9AAC-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> From: Patrick Steinhardt <ps@pks.im>
>
> The git-hash-object(1) command allows users to hash an object even
> without a repository. Starting with c8aed5e8da (repository: stop setting
> SHA1 as the default object hash, 2024-05-07), this will make us hit an
> uninitialized hash function, which subsequently leads to a segfault.
>
> Fix this by falling back to SHA-1 explicitly when running outside of a
> Git repository. Users can use GIT_DEFAULT_HASH_ALGORITHM environment to
> specify what hash algorithm they want, so arguably this code should not
> be needed.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/hash-object.c   | 3 +++
>  t/t1007-hash-object.sh  | 6 ++++++
>  t/t1517-outside-repo.sh | 2 +-
>  3 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/hash-object.c b/builtin/hash-object.c
> index 82ca6d2bfd..c767414a0c 100644
> --- a/builtin/hash-object.c
> +++ b/builtin/hash-object.c
> @@ -123,6 +123,9 @@ int cmd_hash_object(int argc, const char **argv, const char *prefix)
>  	else
>  		prefix = setup_git_directory_gently(&nongit);
>  
> +	if (nongit && !the_hash_algo)
> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);

This is slightly different from your version, which always used SHA-1
when nongit is true, in the hope that it would make it more useful if
the user can say "GIT_DEFAULT_HASH_ALGORITHM=sha256 git hash-objects"
outside a repository.  I am not 100% convinced it is better or we
rather should aim for predictability that you'd always and only get
SHA-1 outside a repository.


