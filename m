Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B65224D4
	for <git@vger.kernel.org>; Sat, 25 Jan 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737815318; cv=none; b=aatKKIYpV8A4RoDAFQKryDt+pV+xzgYiVS6duJk9zC0YmqLlAPL9Zt4AzzJnQ+j9heEAOQW2s8EP/LFvRNArnbNVmbZDEoJuX7N5wpqUGHE5yZQtPu5WOighx0gxSozbo68GY9odjV6tM4KuqF6iZSYOrEYQ0TRA6fscu/ZdTEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737815318; c=relaxed/simple;
	bh=kXZHeO3M4KvSvgV3Ts0qG6C5FAETHaDozjbYJjvpff4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC45r4Kb46o8091xopOrWfCBjauMddQ4r0aujGUeTSmXxQCHnBjPNGK+Hhor3PbfLLaknB5znd6dJ+JUc+M4FyfyyK7JKyDXh7hgAtwMyi0VHW0TKnRzUNmYdGjuR4WARxKX1RWsY4YV6hoLgUYoa+FvoUZXBqBW0Q1+YUw8CWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.100] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4YgH984K2KzRpL2;
	Sat, 25 Jan 2025 15:28:28 +0100 (CET)
Message-ID: <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org>
Date: Sat, 25 Jan 2025 15:28:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p) fails
 on Windows
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org> <Z5ShoLCWREAsWZVh@pks.im>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <Z5ShoLCWREAsWZVh@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 25.01.25 um 09:32 schrieb Patrick Steinhardt:
> The user report was explicitly about compatibility with JGit, which
> still had these files open. We don't have control over third-party
> clients and how exactly they open files, so it is expected that we may
> still see failures with the deletion of in-use files.

Fair enough.

> I'd be happy to hear about alternative ideas that didn't came to my
> mind.

Instead of calling _wunlink() in mingw_unlink, we could CreateFileW()
with access mode DELETE and flag FILE_FLAG_DELETE_ON_CLOSE, then close
the file right away. That would apply semantics that is similar, but not
quite, POSIX at least among the files that we open ourselves.

It would be even better that we do not depend on the POSIX behavior in
the first place. As you said, the reftable library can live with failed
deletes. And I don't think we depend on the POSIX behavior anywhere else
because we would see the "try again?" question much more frequently than
we do right now.

-- Hannes

