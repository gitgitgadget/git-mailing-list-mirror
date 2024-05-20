Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A9139CF1
	for <git@vger.kernel.org>; Mon, 20 May 2024 21:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716239987; cv=none; b=PNc11pR+9Y2FRJ+zEXgAx+ou3i1M8Z7ad8fxKuUzfXuhjv9GS64P0dIkNcXj6R4gC+X9l6xnR8Fu3Rcybwn4FmCYq+sDGIql2drh+jGVWZkjgxnYlMjVnce/o7MnFwfRsFQ96Yc8Vib88Uog2iHcwa8lr8o9EBjpjKFp2fafzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716239987; c=relaxed/simple;
	bh=Txuj+eNS64y3yljRq+ZXbmmZcA48QMMHk+vJyDQWjWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m8IORDFunSFvR8k1DC58cPQkxKM4edXkXmJkt6lbkoGZozE+NZ7/AIptwHQ2jYC6IE8AKIw7yU9DjaoxlkcWP6qt3Mx9OufuE9zuHBD1l2Bqrld0kTGZZgDmal5B1zSIWnyqbjjlVwX+dy+3EgqvKg0mLHQmS55nQO3F7iPPWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=dxYzfgZt; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dxYzfgZt"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B3FF1A384;
	Mon, 20 May 2024 17:19:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Txuj+eNS64y3yljRq+ZXbmmZcA48QMMHk+vJyD
	QWjWo=; b=dxYzfgZtckLky0zxudHkz5sgd0kCcXICInLVIcsxGQf1zgtyxZVg+p
	fzzud6sIN9vcb1jqmKvRX5veuTzaPGU1D0QgXK7S+uTKgK3v7FxvRwijclf4Zlbq
	KSy6MsVIqL6LPXG39hozRx7Qn4lffMYrQ6kGxWo2BIO0RYAYQth/A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 624801A383;
	Mon, 20 May 2024 17:19:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E0BD1A382;
	Mon, 20 May 2024 17:19:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/5] builtin/hash-object: fix uninitialized hash
 function
In-Reply-To: <xmqqmsoodmoe.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	17 May 2024 16:49:05 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-5-gitster@pobox.com>
	<xmqqmsoodmoe.fsf@gitster.g>
Date: Mon, 20 May 2024 14:19:42 -0700
Message-ID: <xmqqed9wdvv5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AD3988CC-16EE-11EF-B868-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> From: Patrick Steinhardt <ps@pks.im>
>>
>> The git-hash-object(1) command allows users to hash an object even
>> without a repository. Starting with c8aed5e8da (repository: stop setting
>> SHA1 as the default object hash, 2024-05-07), this will make us hit an
>> uninitialized hash function, which subsequently leads to a segfault.
>>
>> Fix this by falling back to SHA-1 explicitly when running outside of
>> a Git repository. Users can use GIT_DEFAULT_HASH environment to
>> specify what hash algorithm they want, so arguably this code should
>> not be needed.
>
> By the way, this breaks the expectation of t1007 and t1517 when run
> with GIT_DEFAULT_HASH=sha256 (I recall that they passed with the
> earlier iteration of my "fall back to GIT_DEFAULT_HASH" in [1/5],
> but we decided abusing GIT_DEFAULT_HASH is a bad idea).

The breakage in 1517 turns out to be a thinko on my part.  Outside a
repository, we do use SHA-1 with our "if the_hash_algo is not set
yet, default to SHA-1" in patch-id and hash-object but the way I
prepared the expected output was to use whatever GIT_TEST_DEFAULT_HASH
was in use.  A fix would be to go outside a repository and force the
hash with GIT_DEFAULT_HASH to sha1 when preparing the expected output.

I haven't looked at the breakage in 1007 yet, though.

diff --git i/t/t1517-outside-repo.sh w/t/t1517-outside-repo.sh
index 6f32a40c6d..6363c8e3c4 100755
--- i/t/t1517-outside-repo.sh
+++ w/t/t1517-outside-repo.sh
@@ -21,22 +21,24 @@ test_expect_success 'set up a non-repo directory and test file' '
 	git diff >sample.patch
 '
 
-test_expect_success 'compute a patch-id outside repository' '
-	git patch-id <sample.patch >patch-id.expect &&
+test_expect_success 'compute a patch-id outside repository (default to SHA-1)' '
 	(
 		cd non-repo &&
-		git patch-id <../sample.patch >../patch-id.actual
-	) &&
-	test_cmp patch-id.expect patch-id.actual
+		GIT_DEFAULT_HASH=sha1 \
+		git patch-id <../sample.patch >patch-id.expect &&
+		git patch-id <../sample.patch >patch-id.actual &&
+		test_cmp patch-id.expect patch-id.actual
+	)
 '
 
-test_expect_success 'hash-object outside repository' '
-	git hash-object --stdin <sample.patch >hash.expect &&
+test_expect_success 'hash-object outside repository (default to SHA-1)' '
 	(
 		cd non-repo &&
-		git hash-object --stdin <../sample.patch >../hash.actual
-	) &&
-	test_cmp hash.expect hash.actual
+		GIT_DEFAULT_HASH=sha1 \
+		git hash-object --stdin <../sample.patch >hash.expect &&
+		git hash-object --stdin <../sample.patch >hash.actual &&
+		test_cmp hash.expect hash.actual
+	)
 '
 
 test_expect_success 'apply a patch outside repository' '

