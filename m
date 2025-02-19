Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91771C3BFC
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739959591; cv=none; b=eX5yjwdO1TsMz6bU6uhN+AGg2W8bYWn/vWMsUJ5EvsB43cN3ZAjaEilwWtnD+zZKZU7wqfHSl8878nrtUAS1gpR2HWibJwFlKo5uTF56oI0TljJKzd+hWYBIfDLj2akf3Jm6NHzWQcjyeX8MCYrj6aFjwsB3d7k40ja7bhb0AfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739959591; c=relaxed/simple;
	bh=taJaP4JWG6vWVDFTUEukkSQ715SrWYk6nZTO51LCfkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o3lbUHYPKfEQsyoks9jMMX3bcONRSCEKXJNUh/ypdj72OTsQNP8hyrz6i+t9LDv6r7V9VaPMytdW0Eih022LQcqk6t8RtzFDrARJynWX3Nk+eII3r/UTWlZ+rfxHBjs7Ex25OgQoYl9uAl4OPLtB/Dq2pWN1ynmmk5CkfnDJbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=rI494Msl; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="rI494Msl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1739959584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YsLyFUY0SZo/6q6Qgn0AJRtKXVh0qfgiq4vnb5DySFw=;
	b=rI494MslKf10TvTvOkzXxCjslqIzjRJxe4PsbB/Q5XNkmj9YnbfgBHcvPsxnfKlHhYtVpn
	uOcbHUDfjofdFgIfs2C/h7Rpuy1ZwXz/FjK0ft02FBKgqW6sGd+kvEpOnVkjHYc3jkC9PX
	vep/TM41b2wnkqTz75EPxEEJ4dIf9Ik=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, gitster@pobox.com, Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v3] builtin/refs: add '--skip-reflog' flag to bypass
 reflog migration
In-Reply-To: <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
References: <20250211-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v2-1-991a2ec9a796@gmail.com>
 <20250212-477-refs-migrate-add-a-flag-to-ignore-reflogs-during-migration-v3-1-98b2c4d2bb0c@gmail.com>
Date: Wed, 19 Feb 2025 11:06:05 +0100
Message-ID: <87a5aiqmeq.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git-refs(1)' migrate subcommand, which transfers repositories
> between reference backends, currently migrates reflogs by default as of
> 246cebe320 (refs: add support for migrating reflogs, 2024-12-16).
>
> While this behavior is desirable for most client-side repositories,
> server-side repositories are not expected to contain reflogs. However,
> due to historical reasons, some may still have them. This could be
> caused, for example, by bugs, misconfiguration, or an administrator
> enabling reflogs on the server for debugging purposes.
>
> To address this, introduce the --skip-reflog flag, allowing users to
> bypass reflog migration. This ensures that the repository ends up in the
> expected state after migration.

It wasn't really obvious to me this change removes the reflog, instead
of "skipping". So I was surprised the reflog was removed after
migrating, instead of staying in tact using the files backend.

Only after reading through the test and the discussion in this thread I
realized that's the intented behavior.

So can I suggest to name the option `--no-reflog`? To me that makes it
more obvious the reflog won't exist no more after migrating, and is more
in line with the common UX of Git. Also emphasizing this more clearly in
the commit message and help message also would be advised.

-- 
Toon
