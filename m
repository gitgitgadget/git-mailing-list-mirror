Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C431D5CFB
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752579405; cv=none; b=tBJAg2rqhmyKaltAjbBFPU2XF+Gt7NUdBzAC69S8NQ4qpmZ9Jv2gkCCQkgHWDOgEJRZhFQkJ+wcPxgh8x3PLGVJgIeFhCAPu2cqI/Mxl104IirGB3QjtvnSRWDug3q1gQh3z0u6DUMjJzTJbJTIJ+3ywYLC2YBaSEAcwqCg4TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752579405; c=relaxed/simple;
	bh=MVK6CZ20Vj7SB2nUjmwJFvh0/2mxBnBv7KShFQmhHJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IfvlZKcMSz1AKaQNgz7F3PxJ3lBtyBkK8jYg6AHqTFbK7pT8Rs+VgI5RQdyDU4/ojXNCRRw/GywWtcFyqVe+XqhI3XWgasSDOIFmB7l/fqZChhFDAtK9HVAQhQKss9rWEF8TVNnMykGfgnp72bAhUwl2rAdWSYyq48ZPJ0AlfWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=B8fvXAro; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="B8fvXAro"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752579398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5dy9DHYMcJWhL+sAs+KujpudLf2XdVfa6+rk5Tka91U=;
	b=B8fvXAroxeyyj/5EuYqVlWUW0TLXxRhUGv/tq/Vgff/KMwROSwC30vIwqAJzcmZ5xqcWa6
	yw1rZ1kQ+fnDKM708660vt/Ofl5/jbqSND6xNQK2gCbG6KhJxhhEmRhacw4ozOx47+ZNWq
	x7pW3Jw3oviujqiHibMUCJIqGwCR28Q=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/19] object-file: get rid of `the_repository` in
 `force_object_loose()`
In-Reply-To: <aHYya4PKoWT3-wPQ@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-15-62627b55707f@pks.im>
 <CAOLa=ZQ2msNYfURDXe1eNBtbFxDjmc4dJ-u1s0Fo-mqyjnnQHA@mail.gmail.com>
 <aHYya4PKoWT3-wPQ@pks.im>
Date: Tue, 15 Jul 2025 13:36:26 +0200
Message-ID: <87wm89bs91.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jul 11, 2025 at 05:38:35AM -0500, Karthik Nayak wrote:
>> 
>> Q: Since it exists in the packed form, won't the check always return
>> true?
>
> I'm not quite sure I understand the question. This function is about
> _ensuring_ that the object exists in its loose format. So if it only
> exists in a packfile, it will be written in its loose format. If it
> already exists as a loose object, nothing happens.

The way I understand Karthik's question: We check all the odb->sources
for the object, so Karthik assumes (rightfully) one of the sources will
have the object, and thus the function early returns.

But when I look at the implementation of has_loose_object() it
eventually calls odb_loose_path() to find the object. So we check all
sources, but check if it exists in loose form only.

From the commit message:

> While the check whether any such loose object exists already acts on the
> whole object database, writing the loose object happens in one specific
> source.

I must admit this last sentence from commit message now also makes more
sense to me.

-- 
Cheers,
Toon
