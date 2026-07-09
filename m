Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D63EEACE
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590287; cv=none; b=U8xUYpIphp2wMaB6Vbv+nCTL5Q4MbkUT2AxBxyLJCqCtX70by8jNKmcSA9UgRL0xUPdUtJ7nEFIjRsd651OX42+nC6PzkA432RboomKIapnS5ipXT2ha+jkHtTbMpZDpOpbXjp58tAPiYps43d+I8FcBY1ZpS97GxdFq3M/IVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590287; c=relaxed/simple;
	bh=ucYQSB6N1aT2aOipy0QevEcDr+w1vIEZ4XpySED67Cc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EWb2K6nDavZ58I6xCnEuMK3F/HUYbVMUp9A3HDlRF3SWxmAqEwRQfFXpSpkgbB1VsxHwUOwlPWxPiXLraLHUiZc1vamnYbwEtRgGrvjpCiRMmFPch4MLFUE4xwrEmfQP2koR5Jy7KxiJsH7W+mIiUeeXp2FpnsVYQxvgk6vfz4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=c009esKe; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="c009esKe"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783590278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OxkeCMQvfB5jzvGlCOJ34a+qH+xGUg0i68RqJhmqN6c=;
	b=c009esKeNaQGB45KYmKVxlsRdxXTOc7YnKABIc30M5RgXca0/87xJNdKpgQ5BABSCx+6iJ
	RssuSZmJlhkBPQLT8xzke9hWsSXAJFOXmb6Ck7R7k8o86ApiqmgNR7khvTZe6cvqLvAs4m
	T9HSS0hYkmPBzz0ElJdfXKDjA6e0UpI=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/5] builtin/refs: add "delete" subcommand
In-Reply-To: <20260706-pks-refs-writing-subcommands-v4-2-d51f6ce7f830@pks.im>
References: <20260706-pks-refs-writing-subcommands-v4-0-d51f6ce7f830@pks.im>
 <20260706-pks-refs-writing-subcommands-v4-2-d51f6ce7f830@pks.im>
Date: Thu, 09 Jul 2026 11:44:26 +0200
Message-ID: <874ii8o5tx.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> +test_expect_success 'delete symref with --no-deref verifies target OID' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		B=$(git rev-parse B) &&
> +		git update-ref refs/heads/foo $A &&
> +		git symbolic-ref refs/heads/symref refs/heads/foo &&
> +
> +		test_must_fail git refs delete --no-deref refs/heads/symref $B &&
> +		git refs exists refs/heads/symref &&
> +
> +		git refs delete --no-deref refs/heads/symref $A &&
> +		test_must_fail git refs exists refs/heads/symref &&
> +		git refs exists refs/heads/foo
> +	)

So with --no-deref it still checks the dererenced OID, not the target
ref? I expected it to work like this:

    test_expect_success 'delete symref with --no-deref verifies target ref' '
            test_when_finished "rm -rf repo" &&
            setup_repo repo &&
            (
                    cd repo &&
                    A=$(git rev-parse A) &&
                    B=$(git rev-parse B) &&
                    git update-ref refs/heads/foo $A &&
                    git symbolic-ref refs/heads/symref refs/heads/foo &&

                    test_must_fail git refs delete --no-deref refs/heads/symref refs/heads/bar &&
                    git refs exists refs/heads/symref &&

                    git refs delete --no-deref refs/heads/symref refs/heads/foo &&
                    test_must_fail git refs exists refs/heads/symref &&
                    git refs exists refs/heads/foo
            )


-- 
Cheers,
Toon
