Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FDD2550D5
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 14:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026413; cv=none; b=CEehtPwuZj/4UZBQqesvAVvhOjoiamiyhNoVH2fOpb2xFrg65ZRow2M98dSSzFsVjxdt0aqRas0f2JtxbfWkN33YrgP7cpxPUWzFH27DicipWwFRFF3eFynAU9+EPouWG0cGG2OPjDZbXFdHh9pn+DD0oVK9cI10lIA1SiD1kcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026413; c=relaxed/simple;
	bh=mFNT5QZq9yZ6ZNyZpqGkS1myF9BInen2DgXJBolqDM0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hpB2MXdv44Eqr3UCMJGpU/9u7N7GPetivPX7ATkKBORtkxXzf70gGtZXVl7E6vPqflkP1Hn1TPI8X0DkOnN/VwiRrQrscA2grGVyAQob6G6cgFOU9ElLJxMre9if9wFz8qBqXhEEBdG/lYDqwqRLpz6ENHRItf6YDKa9NpmX3Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=wKz+YXyR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="wKz+YXyR"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1786026408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+TRoOv27OqDGYeIzVYW3z7mFSQrCnMI1dTRWEW6LRYE=;
	b=wKz+YXyR9JgzYefDXf8NdbsVnugea/+eFT3RbqIuz/JRfwBbd1mqnoMycne2WO+FpVyC9l
	5zIWqjJrdh9NWgjMmM1+caAyDu0VQGcXvBPccHAEZ3NJQA0XHMByEhubnz7HH4crb/jvdg
	XBESEtmIh3mYr3HtyrsGMXjVf6McwbQ=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 0/6] odb: make creation of object database pluggable
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
Date: Thu, 06 Aug 2026 16:26:39 +0200
Message-ID: <87qzkb495s.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> when creating a new repository we create a couple of on-disk data
> structures for the object database. This includes the "objects/"
> directory hierarchy with "objects/info" and "objects/pack", which are
> specific to the backend.
>
> This patch series makes the creation of the on-disk data structures
> pluggable. While we continue to always create "objects/" regardless of
> the backend (it's required for a repository to be recognized as such),
> the other subdirectories are now created by the backend. This will allow
> other backends to plug in their own logic.
>
> The series starts with a small detour into the loose-object map. This
> detour is required so that we can defer initialization of the object
> database itself to a later point in time.
>
> The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).
>
> Changes in v4:
>   - Drop `APPLY_REPOSITOY_FORMAT_SKIP_ODB_CREATION` in favor of explicit
>     calls to `odb_new()`.
>   - Remove a useless call to `xstrdup()`.
>   - Mark a string as translatable.
>   - Link to v3: https://patch.msgid.link/20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im

Structurally I'm very happy about this version. Only had some nits about
comments and formatting, but overall this version looks good to me.

Thanks!

-- 
Cheers,
Toon
