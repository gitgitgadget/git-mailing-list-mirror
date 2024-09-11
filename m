Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0DC186607
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 13:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726060338; cv=none; b=jWvNPNCwutfeHoq1/7PxIC9xOUjPyVIEnytt7zye/JHTAaCi0/PG6fX0eJFOR6ew3vG6ezgRFtYN4te3a+cbwva4ZWa9Xh9JPBJsJWbyVfhCFKOGD66cCvGDTUaRC1RuxrDgcR+xkeWRjVWvQ1nEVrYXXofylLMI0lz+M11vlW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726060338; c=relaxed/simple;
	bh=zOjwczM+4NGfqUp7YH4qlG/VixO/4jfCr1ea3jVjMvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ldkJl3410nvb9ekfwYCkOtZMvHwJBe+EU9FEdRjnye0x7rrEOhS/MgN89iN+xKtIm2b2H38E7BoLf1mWjpPAsQATNtfLVcoB3k1xP6HxHpvY3AemtCXKS074bb94iR+8Lz5IJYlxnvxO8THH+RJMpLy0e/8p+8DQtXWIgH/D5UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kMqz4xay; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kMqz4xay"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1726060329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WkpsCa4S+CVYETiBBVMIM96VFDxTxiasO0YZQbWRdjM=;
	b=kMqz4xayFERQjqlbrU6oooadzmvZPXM989m95NdVY0DwgrPwOdzYf3H5Ug80Uc3nN+wGhC
	ItYqsTMxFhDmu6GpkDwABvGPcrPYrQLTux7y72YApwL4Gd1B5HJkHt4RaUSuH8mBbWjmR3
	vOpRhLAZG9IBD9AWBhovpnN9f2jrzrs=
From: Toon Claes <toon@iotcl.com>
To: Eric Ju <eric.peijian@gmail.com>, git@vger.kernel.org
Cc: calvinwan@google.com, jonathantanmy@google.com, chriscool@tuxfamily.org,
 eric.peijian@gmail.com, karthik.188@gmail.com, toon@iotcl.com,
 jltobler@gmail.com
Subject: Re: [PATCH v2 6/6] cat-file: add remote-object-info to batch-command
In-Reply-To: <20240720034337.57125-7-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
 <20240720034337.57125-7-eric.peijian@gmail.com>
Date: Wed, 11 Sep 2024 15:11:58 +0200
Message-ID: <87ldzy9vxd.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Eric Ju <eric.peijian@gmail.com> writes:

[snip]

> diff --git a/t/t1017-cat-file-remote-object-info.sh b/t/t1017-cat-file-remote-object-info.sh
> new file mode 100755
> index 0000000000..64eb55bd9e
> --- /dev/null
> +++ b/t/t1017-cat-file-remote-object-info.sh
> @@ -0,0 +1,748 @@
> +#!/bin/sh
> +
> +test_description='git cat-file --batch-command with remote-object-info command'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +echo_without_newline () {
> +    printf '%s' "$*"
> +}
> +
> +echo_without_newline_nul () {
> +    echo_without_newline "$@" | tr '\n' '\0'
> +}
> +
> +strlen () {
> +    echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> +}
> +
> +hello_content="Hello World"
> +hello_size=$(strlen "$hello_content")
> +hello_oid=$(echo_without_newline "$hello_content" | git hash-object --stdin)
> +
> +# This is how we get 13:
> +# 13 = <file mode> + <a_space> + <file name> + <a_null>, where
> +# file mode is 100644, which is 6 characters;
> +# file name is hello, which is 5 characters
> +# a space is 1 character and a null is 1 character
> +tree_size=$(($(test_oid rawsz) + 13))
> +
> +commit_message="Initial commit"
> +
> +# This is how we get 137:
> +# 137 = <tree header> + <a_space> + <a newline> +
> +# <Author line> + <a newline> +
> +# <Committer line> + <a newline> +
> +# <a newline> +
> +# <commit message length>
> +# An easier way to calculate is: 1. use `git cat-file commit <commit hash> | wc -c`,
> +# to get 177, 2. then deduct 40 hex characters to get 137
> +commit_size=$(($(test_oid hexsz) + 137))
> +
> +tag_header_without_oid="type blob
> +tag hellotag
> +tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
> +tag_header_without_timestamp="object $hello_oid
> +$tag_header_without_oid"
> +tag_description="This is a tag"
> +tag_content="$tag_header_without_timestamp 0 +0000
> +
> +$tag_description"
> +
> +tag_oid=$(echo_without_newline "$tag_content" | git hash-object -t tag --stdin -w)
> +tag_size=$(strlen "$tag_content")
> +
> +set_transport_variables () {
> +	hello_sha1=$(echo_without_newline "$hello_content" | git hash-object --stdin)
> +	tree_sha1=$(git -C "$1" write-tree)
> +	commit_sha1=$(echo_without_newline "$commit_message" | git -C "$1" commit-tree $tree_sha1)
> +	tag_sha1=$(echo_without_newline "$tag_content" | git -C "$1" hash-object -t tag --stdin -w)

I see here and various other places in this file names with "_sha1". I
think it makes more sense to name them "_oid" because these works also
fine with GIT_TEST_DEFAULT_HASH=sha256.

Other than that I don't have any comments about this patch series.

--
Toon
