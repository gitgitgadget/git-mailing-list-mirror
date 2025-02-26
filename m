Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36535968
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740583290; cv=none; b=esHGEuYTzkxBh+bOTLA2OdHLrak0rehO2gDLOzOC49k/yIsk5Y6ujylBq3u3O5g9BkIvyqLYOXeKxm+LC4hbqoTF6JdyqxzspN8FE4hpBD/G3QWS/zVJQCxeUnYZ8vmgNx/7hARhafW72n9NC5vsOFafuEQO9FOdf4hZOpFZC/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740583290; c=relaxed/simple;
	bh=uEgSdSTLDfB5+x33zfPDazhntSvF32Y+CGX+mi3kQ7Q=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAGTyVIHmlGqlji66OG0DdtP+N3eLtHigk2UN7SVkAclWUfI9jQ3C+3bTUsPP/pGB7nXKv32O+Fgg4yual8QWZzu5+BeyLkzmB6W/DVWOQkoYSkHt7UTf5PNI27dYJiviEAGNjyMhEyxPR4wxrldZxvGfeo6ZheUfuOVL0I8Iy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=IRM4TJFJ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="IRM4TJFJ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1740583283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xAZIttq5ilml/nJVWib5Wj7qlQtst4q6UtYrOf/Y2tc=;
	b=IRM4TJFJveeIlY+VBb0y6KZiCItmEaTYkk+xOcPe5rrUtHAp454MOC39Qf+1fOdryh94k1
	+3KXh3LVidoxqfkMUMeiAR1GfnRFyhcnBXmfpJOFh5CW3AWtxaWvrT8n7nWBEcdAB8okrJ
	n0Lu3Sv70iPgKCdIbO1dLkeBrweJk4I=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] builtin/cat-file: wire up an option to filter objects
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
 <20250221-pks-cat-file-object-type-filter-v1-2-0852530888e2@pks.im>
Date: Wed, 26 Feb 2025 16:20:55 +0100
Message-ID: <874j0graug.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> In batch mode, git-cat-file(1) enumerates all objects and prints them
> by iterating through both loose and packed objects. This works without
> considering their reachability at all, and consequently most options to
> filter objects as they exist in e.g. git-rev-list(1) are not applicable.
> In some situations it may still be useful though to filter objects based
> on properties that are inherent to them. This includes the object size
> as well as its type.
>
> Such a filter already exists in git-rev-list(1) with the `--filter=`
> command line option. While this option supports a couple of filters that
> are not applicable to our usecase, some of them are quite a neat fit.
>
> Wire up the filter as an option for git-cat-file(1). This allows us to
> reuse the same syntax as in git-rev-list(1) so that we don't have to
> reinvent the wheel. For now, we die when any of the filter options has
> been passed by the user, but they will be wired up in subsequent
> commits.
>
> Note that we don't use the same `--filter=` name fo the option as we use
> in git-rev-list(1). We already have `--filters`, and having both
> `--filter=` and `--filters` would be quite confusing. Instead, the new
> option is called `--objects-filter`.

I'm not sure I agree. I would rather have consistency in various
commands. Because `--filters` doesn't accept an argument, so I would say
having both `--filters` and `--filter=` is fine. I see in various places
we already use `OPT_PARSE_LIST_OBJECTS_FILTER` which defines the option
as `--filter=`, so it's pretty standard for several commands. I'd
prefer git-cat-file(1) to follow that as well. But that's my 2 cents.

-- 
Toon
