Received: from mail.luna.gl (mail.luna.gl [141.147.12.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62983D76
	for <git@vger.kernel.org>; Fri, 29 May 2026 11:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.147.12.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780055618; cv=none; b=RKBpKThIHUgaDw7Gx0Z8RkAYJEz3QQhRaqd9jgo9FxSX7kzOY5vbrv5BAWn/lO+hFopA2O5eVyLymT3ZozrmlzvR6+gQUAuijS77hM32JUuZImPne3yrXygEA9evNiBWeMO9lloiiag3139pD1TKfWbNyUpZue47amQ4lbJl9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780055618; c=relaxed/simple;
	bh=wbiztgB5MGA7sba6/+DsIhp4+4u44FIYOFY+p8rjDw8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Z6OIEYvZZWVSjmlsxkg7TaVnzpDm8gKcjzb2HuMZFcWkUzemoLCTiHEplHKg66AoOVDmbYHGG5S3Tgv9Mn3AbUfZ3NAalid+7oTr7+J3XZE+mjk7gGJGNy0jNt7Gx54iWQvthLwEIPY+UroVSE+9JhweRm3Yq1yW0DFwvTXiDKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl; spf=pass smtp.mailfrom=luna.gl; dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b=qGBjt0Ph; dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b=CRUpcq6R; arc=none smtp.client-ip=141.147.12.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luna.gl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luna.gl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luna.gl header.i=@luna.gl header.b="qGBjt0Ph";
	dkim=permerror (0-bit key) header.d=luna.gl header.i=@luna.gl header.b="CRUpcq6R"
DKIM-Signature: v=1; a=rsa-sha256; s=202405r; d=luna.gl; c=relaxed/relaxed;
	h=Subject:From:To:Date:Message-ID; t=1780055483; bh=a4PVk2G9svClGS8DT8ulNdy
	SkfeDXjUV8Xp9iIl1SYM=; b=qGBjt0PhN7L5nhYJZqa8wC4GzCM6chKNWDvznh2ZUIyr8IpYn9
	rzo+5LabbFg8GMh3CmBiiBZ7RPeU+JhWIKfl+tki702U/F0VtYlXhp6luAjQDqvh+FvuwhMNxVi
	ym+NHXpHoXcYUmNHB8jKuBUtg3QV/p2idM87Y+DyZTn88VC2x+aQ6gXTY6pTLaXTXmO5t/SIQk3
	FCtZea5lnwL3g2MnKdUFQGW4Qpm+D3qGQLzmxHOUm7BbvpYWyQXUFQFpnBAke9/WNg5dpi4izVs
	wHhwjeiqB2IZd3LgfyXHRNx5TjijTvZr658i/m5n5YnjDsOPm/1ZH2EXeUQYeOVelAw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202405e; d=luna.gl; c=relaxed/relaxed;
	h=Subject:From:To:Date:Message-ID; t=1780055483; bh=a4PVk2G9svClGS8DT8ulNdy
	SkfeDXjUV8Xp9iIl1SYM=; b=CRUpcq6RCUpGWjDEbGcu4Jgb+Tz4ECNutBKoUctJOu0bE0dV6u
	Ri1RU7/yWyEDCbknF1XtaFr/dh9zRvXnUEBg==;
Message-ID: <fffe0ea9-baea-47cc-b354-5be4fff08983@luna.gl>
Date: Fri, 29 May 2026 13:51:23 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Luna Schwalbe <dev@luna.gl>
Subject: [BUG] internal date format does not accept small unix timestamps
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

While trying to create some test commits, I noticed the following issue:

GIT_AUTHOR_DATE and GIT_COMMITTER_DATE should accept the "Git internal 
format" (displayed by git log with --date=raw), but this fails for small 
unix timestamps. A quick binary search indicates that it happens when 
the unix timestamp is below 100000000 (9 digits).

So for example, GIT_AUTHOR_DATE='99999999 +0000' fails with "fatal: 
invalid date format", while GIT_AUTHOR_DATE='100000000 +0000' works as 
expected.
It seems to be unaffected by the choice of timezone offset.
Padding the timestamp with zeroes also does not change the behavior.

The --date option does accept all the values, but interprets them 
wrongly and gives bogus results (most of them time it seems to act as if 
no date option was given, using the current system time, but with some 
inputs I've also observed things like "current date&time but set the 
year to 2000").

I tested everything with git built from commit 
2f8565e1d14d2de4cfbc9da0132131bf0d0dc087.

Luna
