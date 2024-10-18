Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9B42AAE
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729252990; cv=none; b=pzgiB2ljyjAOFwsczzH82GEuAJ2gX0x1SG3SbWu+V41HITdgWTT7BU9yPED4bdH2TmzTDDKjfKeYo7ZFo2kcBk91skOPEBBFCMumMqyxzNSPWVvaO+QJzM1xMDZBPzPVqwTk3440aKjSM3gZH1li/z6+UQYxXMyN3rbTjOSieKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729252990; c=relaxed/simple;
	bh=JZ0bUhZXuNkDQi/iPm19NLPiKvfiFWDN7xJOSyp0vHE=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d5H/ex9r8BzvWm0aj0YfXcDDpvzSCuu+uiHnkmkuQU6P5jnl1tWR+iAHe72mM4y131dH6EQ576T3Bbt/i3DkUvEQ/A4/N55jmxQ3FFKrFbAKPJ/Z1VhfI/yqKghqyyywBYujBS1FRMdap/oVs2lAUDKhaWLMABs78dSIU6XZ5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=hHttkhPi; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="hHttkhPi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729252979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YtDrkv4fMu2WAaCTH91g20AtmQQtP2Zg9Y657ejUUk=;
	b=hHttkhPiIYL1bY/8YU8WZ9vqN1f9F1Vn/r7OIb6rU7MIu+bBdrrmsui7x0NYKTuwkQ8aCV
	LHFZPjZ+gLFS2aLlj7DeAmMlJD4ou+oqzZHj28eLs9BfAP67aDU2yIfZOUQorFBwBviR09
	D/1MovL9Xir26mRH1pyuCcDG6tmbPcU=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 07/21] pretty: clear signature check
In-Reply-To: <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1728624670.git.ps@pks.im>
Date: Fri, 18 Oct 2024 14:02:48 +0200
Message-ID: <87a5f1d3fb.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The signature check in of the formatting context is never getting
> released. Fix this to plug the resulting memory leak.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  pretty.c                         | 1 +
>  t/t4202-log.sh                   | 1 +
>  t/t7031-verify-tag-signed-ssh.sh | 1 +
>  t/t7510-signed-commit.sh         | 1 +
>  t/t7528-signed-commit-ssh.sh     | 1 +
>  5 files changed, 5 insertions(+)
>
> diff --git a/pretty.c b/pretty.c
> index 6403e268900..098378720a4 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
>  
>  	free(context.commit_encoding);
>  	repo_unuse_commit_buffer(r, commit, context.message);
> +	signature_check_clear(&context.signature_check);

I was having a very hard time finding where this gets allocated, and to
be honest, I still don't know for sure. I think in
check_commit_signature() which is called by format_commit_one().
In "[PATCH 20/21] builtin/merge: release outbut buffer after performing
merge" you mention it's not obvious to the caller they need know about
memory they need to clean up, isn't that case here as well?

--
Toon
