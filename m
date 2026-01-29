Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374711A5B8A
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769698815; cv=none; b=AvCkeo/fF8ref57wUnOM1BwjpeAFzvcSa8zlkS2HGnVdzI9EvA21QFisleTlRbZ0fDeQ/Lh7mmv2ySi9YSFwQszYtDeYWnKMYvP99ivhZS0FAhYJuMfLBwigYBK7TD+heLcuLEWxOJR2iXxRI6GCZithQbSXFvAl06ITfgDayzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769698815; c=relaxed/simple;
	bh=T3eCR+69gSEgwI+Mt4TVile4k66wpsOv+3UsLAJXt88=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=msezo+HMrojMn3x/e6l4IwXPZL51+8+BHU9BHoo4rnEd5H2syK15jtFu0vVsNzK1HVA4tlFRAm298b1/LWP0M4sn8Ssf6qkH1hebNXc0zwTzmTHmuPwCSDCfCPx4iQrU0u05NOP8GbsJuyYdXlFZyAF92ppL5Q1XPyTWNIHSvFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=WB47tIEG; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="WB47tIEG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1769698810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O1v7bWCxpYSwuKH8T8c52LrTX7vSJDgZRwOn/T7llT0=;
	b=WB47tIEGmI3rSCw5mmIR3evo1uBJE6hBtSN7DRNqYDyeB2tSNx5dPefmowZMulcPj6uANk
	pNq72AsxIX775W3X6nDaJDyCPoWge4iPnLBnMXQheFz3WCbnckwmFmCZjutRcM8njixanx
	ZIQQoOdKoRkWWB0eNcML4CACTS4uPYE=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v5 0/4] Fix git-last-modified(1) bug triggered when
 passing a tree-ish
In-Reply-To: <xmqqjyx2elbs.fsf@gitster.g>
References: <20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com>
 <20260127-toon-last-modified-tree-v5-0-38d18a0956d4@iotcl.com>
 <xmqqjyx2elbs.fsf@gitster.g>
Date: Thu, 29 Jan 2026 15:59:47 +0100
Message-ID: <87v7gkqxb0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Changes in v5:
>> - Use 'commit' instead of 'revision'.
>> - Small typo fixes.
>> - Link to v4: https://patch.msgid.link/20260123-toon-last-modified-tree-v4-0-86bf97bad4e2@iotcl.com
>
> Looking good.  Queued.  Thanks.

I noticed this causes a failure[1] with Meson on Windows. Better leave
it out for now. One of the failures:

    expecting success of 8020.3 'last-modified recursive': 
    	check_last_modified -r <<-\EOF
    	3 a/b/file
    	2 a/file
    	1 file
    	EOF

    ++ check_last_modified -r
    ++ local indir=
    ++ test 1 '!=' 0
    ++ case "$1" in
    ++ break
    ++ cat
    ++ git last-modified -r
    ++ git name-rev --annotate-stdin --name-only --tags
    ++ tr '\t' ' '
    ++ test_cmp expect actual
    ++ test 2 -ne 2
    ++ eval 'GIT_DIR=/dev/null git diff --no-index --ignore-cr-at-eol --' '"$@"'
    +++ GIT_DIR=/dev/null
    +++ git diff --no-index --ignore-cr-at-eol -- expect actual
    diff --git a/expect b/actual
    index 65ac8be..d17615e 100644
    --- a/expect
    +++ b/actual
    @@ -1,3 +1,3 @@
     3 a/b/file
    -2 a/file
    +t2^0 a/file
     1 file
    error: last command exited with $?=1

[1]: https://gitlab.com/gitlab-org/git/-/jobs/12899403428


-- 
Cheers,
Toon
