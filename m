Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD372D879A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 18:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172816; cv=none; b=mr5K1+5g05jLUnLIpHe98EgcfDbT79om9L7HKopXhs67AawEoShlaZHskOFHldAw0MHFDjgjfaOSghYE8AbchO9xXQeS+kOZcK3R5LJ+d47AneguY0fGqFyF4a544M3IlD3WPTwM+ADOjIjTI7oT0g3rP0ZBruJSCvr/Rkgj5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172816; c=relaxed/simple;
	bh=A3tGuSO/6o995CDDtXXK2272LoZN3S/qriYlEPSQe5w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGZueRi8PMfNWeUQum4Q2YT1gvx4zeFLAf0P1iPzPuQQWYMTO/KAC+eARWKFv8ph6mAC5Ad8FHgL4VCpho7VKgXjdzhXKgtyZvjO9J+tdIbJ39OAM25TJ4e/Ne/JDXs/VxHaSpO/iyGPLqGmwnT9pgMAUF7nV2BlZHYTLuxw2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=scng1dwM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="scng1dwM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1752172809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mETL+h64li2NWuZrSimHU4fbhKb7RWd/E1r7TTgDej4=;
	b=scng1dwMIfVVbcTANL0C+acUkvtj6aXY+6A37/ozQPN92ZbEebHRH2u0LEh8sH9fawCrqY
	yJAHppH99m8kFhSs/IKGVibUc9uwGdHjcyxOy1S8/d2o1pjP0FbD3XtDbfq1cRmojrHSuN
	rgPXadmCyt0SAyL+pSR9cyn/FWPqSsM=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 09/19] odb: introduce `odb_write_object()`
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-9-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-9-62627b55707f@pks.im>
Date: Thu, 10 Jul 2025 20:39:56 +0200
Message-ID: <878qkvdh4z.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> We do not have a backend-agnostic way to write objects into an object
> database. While there is `write_object_file()`, this function is rather
> specific to the loose object format.
>
> Introduce `odb_write_object()` to plug this gap. For now, this function
> is a simple wrapper around `write_object_file()` and doesn't even use
> the passed-in object database yet. This will change in subsequent
> commits, where `write_object_file()` is converted so that it works on
> top of an `odb_source`. `odb_write_object()` will then become
> responsible for deciding which source an object shall be written to.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  apply.c                  | 11 +++++++----
>  builtin/checkout.c       |  2 +-
>  builtin/merge-file.c     |  3 ++-
>  builtin/mktag.c          |  2 +-
>  builtin/mktree.c         |  2 +-
>  builtin/notes.c          |  3 ++-
>  builtin/receive-pack.c   |  4 ++--
>  builtin/replace.c        |  3 ++-
>  builtin/tag.c            |  4 ++--
>  builtin/unpack-objects.c | 12 ++++++------
>  cache-tree.c             |  5 ++---
>  commit.c                 |  4 ++--
>  match-trees.c            |  2 +-
>  merge-ort.c              |  7 ++++---
>  notes-cache.c            |  3 ++-
>  notes.c                  | 12 ++++++++----
>  object-file.c            | 18 +++++++++---------
>  object-file.h            | 26 +++-----------------------
>  odb.c                    | 10 ++++++++++
>  odb.h                    | 38 ++++++++++++++++++++++++++++++++++++++
>  read-cache.c             |  2 +-
>  21 files changed, 106 insertions(+), 67 deletions(-)
>

[snip]

> diff --git a/odb.h b/odb.h
> index e922f256802..c96d2c29e9f 100644
> --- a/odb.h
> +++ b/odb.h
> @@ -437,6 +437,44 @@ enum for_each_object_flags {
>  	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
>  };
>  
> +enum {
> +	/*
> +	 * By default, `odb_write_object()` does not actually write anything
> +	 * into the object store, but only computes the object ID. This flag
> +	 * changes that so that the object will be written as a loose object
> +	 * and persisted.
> +	 */
> +	WRITE_OBJECT_PERSIST = (1 << 0),
> +
> +	/*
> +	 * Do not print an error in case something gose wrong.

While at it, shall we fix this typo?: s/gose/goes

-- 
Cheers,
Toon
