Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F804E01E3
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.131.90.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783640; cv=none; b=IRrV7LvU+XEdHlzXKPHr32Zu3oV5xq+jR81uk482RcqeedoAbJZwiGRop1UPs2mtk+u0OMOIAmxFcRmMAa78z6b5vbNCeyiOs7kZk4kyW3ewFDGWcBur/TbP7BA+s9DhlHkVVUjRpwcbWx4iNmEf9Y7SDttNePyZyT/jlaY1bFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783640; c=relaxed/simple;
	bh=zgUNcfIGiYdEJKzuxrl6CaUGPEeHvv9AT8WUKESjhKg=;
	h=Message-ID:Date:Mime-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qWJBD6M/TAxSXrZG60b/yTQPSbEPD4hQOTEV3j4C7lqSGCRn7w358VnR8NFiAZUUJjtH2ocUtISX2Jzm69gshBdGoF9gCAGaG98zRKpFUT0fVGw7EGlljTBtIF6DoZgfRj+mtWj+h6MNIbVf75guItVsk7Quy9bjuuZLLrzhero=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com; spf=pass smtp.mailfrom=grantmoyer.com; dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b=bA1MYeyY; arc=none smtp.client-ip=145.131.90.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grantmoyer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=startmail.com header.i=@startmail.com header.b="bA1MYeyY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
	s=2020-07; t=1790783308;
	bh=BJxawQpGu+E7zKcLqEibU9EM4uLD8N2zC2TEImDe19Y=;
	h=Message-ID:Date:Mime-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:From:Subject:To:
	 Date:Sender:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition:Mime-Version:Reply-To:In-Reply-To:References:
	 Message-Id:Autocrypt;
	b=bA1MYeyYfbY+gcKFQMSzFS5as3/BP8w4H0+csQppjBIJkhKQkmwE6jNqQlwfTLg14
	 k1cFaxWOwsbVa1HR2DZYK5mLhnHhiJxkIi6mTquz9zkicfcfdj9Y5MztIqG4DhMhom
	 b7QwbNWeFjotN1WWnU6M+z2SVpOUhBDfhVmVPhwHDnlE15afjAnhskJkBpE0ESTEJh
	 bCF7Zzj7INtPdfOqW8cUke3ZO+Ydr+rzyo4hJraNhbChgfIfzU8LibQFBZWfgrvQT+
	 78f/t+PWAUujLZjD/pOlKVJd/vb/P4ayCHZloc5RzRhQ2rhJ5Q2eWnLNncBttKwfCj
	 QVdYwReRA7gLA==
Message-ID: <c6d3deb4-088b-476e-921c-c2ee788fb309@grantmoyer.com>
Date: Wed, 30 Sep 2026 11:48:25 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Grant Moyer <dev@grantmoyer.com>
Subject: Re: [PATCH] fiter-branch: fix commit map init from state branch
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Michele Locati <michele@locati.it>
References: <20260801033127.10606-1-dev@grantmoyer.com>
 <ar0fRtN8XMG-fyis@pks.im>
Content-Language: en-US
In-Reply-To: <ar0fRtN8XMG-fyis@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On September 30, 2026 10:40:06 AM EDT, Patrick Steinhardt <ps@pks.im> wrote:
>Okay. A simpler fix could've been the following diff:
>
>- echo "${line%:*}" >../map/"${line#*:}";;
>+ echo "${line#*:}" >../map/"${line%:*}";;

Yep, that's equivalent and was my first version, but I decided to err on 
the side of clearer intent. Plus, the more verbose version mirrors how 
the state branch is constructed further down in the script.

>So... does this mean that we don't have test coverage for this case at
>all?

Yeah, the test for this case was broken.

>>  test_expect_success 'using --state-branch to skip already rewritten commits' '
>>  test_when_finished git reset --hard $V &&
>>  git reset --hard $V &&
>> - git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
>> + git filter-branch --state-branch state -f --tree-filter "exit 1" HEAD &&
>>  test_cmp_rev $W HEAD
>>  '
>
>So does this now detect the issue? If so, it feels somewhat roundabout.

The current test seemingly intends to check if the --tree-filter filter 
was run on already processed commits, but it only checks that the filter 
produces the same final result. Since the filter is deterministic, the 
final result is the same whether or not the filter is re-run on already 
processed commits.

The proposed change makes the test fail immediately if the tree-filter
is re-run. I looked around other tests for a test_* command or
conventions to fail with a message, but I didn't find anything. I've
checked that the test fails without the filter-branch change, and passes
with it.

>Nit: pointed out by Michele: the subject has a typo in "fiter-branch".

I'm new here. Is this something I should fix by submitting a new version 
of the patch, or will the maintainer fix it  up if/when they merge the 
patch?


Grant
