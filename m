Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB5C18BBAC
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734084091; cv=none; b=lKBP4Yh7TqTuRyo5Y6hnhYiPDAZNwmTgcdBvCtAOEKpx4UBQGas87pJY142PUMbV2K21wzbtfzwL/UWkLr953ASCKWfg5dZ2yupF6MoKzPmk0wnKVaW1CBFTsMgfqXQTb4b9zxXrU/f6lAiTB/2UCUgJISrA3DPOFe9w7sbquJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734084091; c=relaxed/simple;
	bh=PlTmJhXOUgtcj/3Gdegj7MK+yyAIQ3Yu1sFYWdhvF80=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YK2Y4JgYbRZNzhU5spleb5ZLdq5Dyio9SySxGJ8LGzuYZGz2hFOnqgUIp8MYti0+1swjW3aoqL2FXfV504llc/1bqCq9IF3uJc1gcXCeKnQRj5z2Vm+h5uVKEV0bKtBHT/BoT9imTdOx09ruf0szfjC6QFOfGepdFXoarjMmD7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=UAp5q4aS; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="UAp5q4aS"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734084084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M8C/t0Yj5C7tWC9dKZDsbIQ6DTDTvhfunOP/tGAkh3g=;
	b=UAp5q4aSnR6iCCkwjkNNCaAUFRdxe1ZVKJljSlEUMYz68tkMKRk2LWNKES+fwPe/qwlhpA
	YxwErF6lwFEQFnb+WuTcHaKKXPvorRMTrUjOgsdWT+fo0WKbXl+3u/tMmDRHnimlQo8z22
	vCOX+eeKTUYQdfq/6XZ26iZSDR67IFs=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 8/8] ci: wire up Meson builds
In-Reply-To: <20241211-pks-meson-ci-v1-8-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
 <20241211-pks-meson-ci-v1-8-28d18b494374@pks.im>
Date: Fri, 13 Dec 2024 11:01:15 +0100
Message-ID: <877c83j40k.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index a1bc92893f27d6dd404133686b71c8061e55618c..8163aacc8c8715d09f19bd1cc7199532fb5141e2 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -20,6 +20,7 @@ test:linux:
>      - saas-linux-medium-amd64
>    variables:
>      CUSTOM_PATH: "/custom"
> +    TEST_OUTPUT_DIRECTORY: "/tmp/test-output"
>    before_script:
>      - ./ci/install-dependencies.sh
>    script:
> @@ -31,6 +32,7 @@ test:linux:
>        if test "$CI_JOB_STATUS" != 'success'
>        then
>          sudo --preserve-env --set-home --user=builder ./ci/print-test-failures.sh
> +        mv "$TEST_OUTPUT_DIRECTORY"/failed-test-artifacts t/
>        fi
>    parallel:
>      matrix:
> @@ -67,6 +69,10 @@ test:linux:
>          image: fedora:latest
>        - jobname: linux-musl
>          image: alpine:latest
> +      - jobname: linux-meson
> +        image: ubuntu:latest
> +        CC: gcc
> +        CC_PACKAGE: gcc

Is it needed to explicitly set the CC_PACKAGE? I see in other places we
only set it when it's set to `gcc-8`?

-- 
Toon
