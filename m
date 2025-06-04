Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C7175A5
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043501; cv=none; b=TmY/QjVH9afi4YXXCAQWdG6J6R1iG9j1mVw3crL45cQq3JNeXfC9nH8ILP/f3Twhs0NFXkmvAHq51swYsoE+mUzpSltTPkwy7BnYIoO2F0qaBSF5MQTvDAG/zxggs4cPOBs0gAO3xQFI2ZP0mB1/7Dgymyyd6nIYovyBINhbM8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043501; c=relaxed/simple;
	bh=8W/IUvAGn6Ijp56A6FdipIGuDacyJPRx5ZoPQrB4qCQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AC26R55Fha2pbppQNJ/XcKTV4QGHTOH4LogJU4mb/1wnjGlPXQJfknfhPTnCEBjM49UiCoEEyK06RxTeOqFUkRFaAVESGTq/cxX7B2vJ/hpeCSF+ZxxYOMrIkst+VADTrSniS4OwFkjUHkFZOnCe/IY3usfLFhHghAb7F7xNj0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oVYBtC9u; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oVYBtC9u"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1749043493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nR1Uwkm2XO/eW+G2gCXjUW4bbxFs5p4Ko9oCOtYykCw=;
	b=oVYBtC9utKiFs6Rc1T6avrJtVN4vdVn5hHDNEY8uQYfEie2sSfLrJhU/gyhfCvOx4VHeWn
	RMfAq1FOjli2GjFQWQCGJL4X9/7A6Man5A0n62ZOYHhbLFZOEg/xnsuiJkat4xmk55U4B+
	bDGZbkCMVD31dx4d9pq6wPQuwE9Vxoo=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 02/17] object-store: rename `object_directory` to
 `odb_source`
In-Reply-To: <20250602-pks-object-store-wo-the-repository-v4-2-e986804a7c62@pks.im>
References: <20250602-pks-object-store-wo-the-repository-v4-0-e986804a7c62@pks.im>
 <20250602-pks-object-store-wo-the-repository-v4-2-e986804a7c62@pks.im>
Date: Wed, 04 Jun 2025 15:24:43 +0200
Message-ID: <875xhb3ahw.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> The `object_directory` structure is used as an access point for a single
> object directory like ".git/objects". While the structure isn't yet
> fully self-contained, the intent is for it to eventually contain all
> information required to access objects in one specific location.
>
> While the name "object directory" is a good fit for now, this will
> change over time as we continue with the agenda to make pluggable object
> databases a thing. Eventually, objects may not be accessed via any kind
> of directory at all anymore, but they could instead be backed by any
> kind of durable storage mechanism. While it seems quite far-fetched for
> now, it is thinkable that eventually this might even be some form of a
> database, for example.
>
> As such, the current name of this structure will become worse over time
> as we evolve into the direction of pluggable ODBs. Immediate next steps
> will start to carve out proper self-contained object directories, which
> requires us to pass in these object directories as parameters. Based on
> our modern naming schema this means that those functions should then be
> named after their subsystem, which means that we would start to bake the
> current name into the codebase more and more.
>
> Let's preempt this by renaming the structure. There have been a couple
> alternatives that were discussed:
>
>   - `odb_backend` was discarded because it led to the association that
>     one object database has a single backend, but the model is that one
>     alternate has one backend. Furthermore, "backend" is more about the
>     actual backing implementation and less about the high-level concept.
>
>   - `odb_alternate` was discarded because it is a bit of a stretch to
>     also call the main object directory an "alternate".
>
> Instead, pick `odb_source` as the new name. It makes it sufficiently
> clear that there can be multiple sources and does not cause confusion
> when mixed with the already-existing "alternate" terminology.
>
> In the future, this change allows us to easily introduce for example a
> `odb_files_source` and other format-specific implementations.

Sorry for being pedantic (but I guess this series is all about naming
anyway, so better get it right), but wouldn't this be
`odb_files_backend`?

-- 
Cheers,
Toon
