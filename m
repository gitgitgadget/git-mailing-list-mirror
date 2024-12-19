Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12691BBBC5
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734636753; cv=none; b=DQGxqTWzy+Yk05RsnXbm8T6DkhK06Z1DHeF95sv4FHpcuacfG6X02IWbfkLFXRRSsQtM+lCVzOnGS5iqb4WO1tLZfcZNYiiLDtnBzwqfX/s8Ad032ue08tv8RZ6QXM53I1eyxzGyJlkUQRlZBmFGeXoPUOgFt51y2taG9NGnELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734636753; c=relaxed/simple;
	bh=JLAsu6MTPMk35BRKuqA1VOuXooOzAH40RbjwegtkmvM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dN+Fc7p8KaVIXARcSsnUfsgG2ueA+GoBlT/KeV9CU7DhzSvcXFzQCNBbUQOa+vwnbkYYCAL7aFCGg1Ja82nhEuKplRvChKnmIDnWa93504QHrFJ/6Ug2IICF5W10V90hyb6orYVK1M+HXQv2Pf0dX1ykX8gmLzPWvJ0u4Ss30S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=J6qRktxX; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="J6qRktxX"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1734636749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQxx9iXNqTzOmA/wtgrPWy4t7OmCHuKQI728kP8ZGL4=;
	b=J6qRktxXX62b52d3d28vk9xhGboi/3tphxItytomxCdSTJ3OH/SMZDHX9sMlmHZJ8NMsTU
	3NV57iCNmopT7wQxP6o9NmpKDUNXQeJrBJYhVj5Wgd1JExelPb0SxynHlNtn4G9t1bnXS6
	cf2D8vPjd2UIypSMIh6d4Y3Gi/62fRo=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/8] refs: add reflog support to `git refs migrate`
In-Reply-To: <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
References: <20241215-320-git-refs-migrate-reflogs-v3-0-4127fe707b98@gmail.com>
 <20241216-320-git-refs-migrate-reflogs-v4-0-d7cd3f197453@gmail.com>
Date: Thu, 19 Dec 2024 20:32:20 +0100
Message-ID: <874j2zh3jv.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The `git refs migrate` command was introduced in
> 25a0023f28 (builtin/refs: new command to migrate ref storage formats,
> 2024-06-06) to support migrating from one reference backend to another.
>
> One limitation of the feature was that it didn't support migrating
> repositories which contained reflogs. This isn't a requirement on the
> server side as repositories are stored as bare repositories (which do
> not contain any reflogs). Clients however generally use reflogs and
> until now couldn't use the `git refs migrate` command to migrate their
> repositories to the new reftable format.
>
> One of the issues for adding reflog support is that the ref transactions
> don't support reflogs additions:
>   1. While there is REF_LOG_ONLY flag, there is no function to utilize
>   the flag and add reflogs.
>   2. reference backends generally sort the updates by the refname. This
>   wouldn't work for reflogs which need to ensure that they maintain the
>   order of creation.
>   3. In the files backend, reflog entries are added by obtaining locks
>   on the refs themselves. This means each update in the transaction, will
>   obtain a ref_lock. This paradigm fails to accompany the fact that there
>   could be multiple reflog updates for a refname in a single transaction.
>   4. The backends check for duplicate entries, which doesn't make sense
>   in the context of adding multiple reflogs for a given refname.
>
> We overcome these issue we make the following changes:
>   - Update the ref_update structure to also include the committer
>   information. Using this, we can add a new function which only adds
>   reflog updates to the transaction.

Out of interest, I see various changes happen around committer info. But
why is the committer info more relevant for reflog updates, in contrast
to normal ref updates?

-- 
Toon
