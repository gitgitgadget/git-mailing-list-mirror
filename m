Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F71DF74F
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777049104; cv=none; b=ERRN8/LuYh/AVOrxJDdhYwbusFBbIKdvpVtuGI3JWW1KCSHJKPR9N6i+641NL/nEWmat5r3EdLeYqVgv3//axUurhPfjkiWCEJL9JP1Z+Q/rFRJF+e8doEp4lSaJLiZTiR2Rqg88iaftNJ1G5u3O4fE4tSeQte8sJszFZOHYbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777049104; c=relaxed/simple;
	bh=h2UIl4QUi4QkeYlYsQvUHqZigCiWsJGVBXeNCkM3ShA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gTi89uMqEb1gA/w7bQyWuJhBu2ESjAwOV3XszL4dZfip8I7GoJ/sz44XbEgeYggOcPUA9D7WEChjK8FqvYXTNsJGlsCnAhkhkRWpWILSJrcZ5HoDuh7c52gg9Uqo7S6n2mya3eUiP6IWrzuGnDTaqZ5uMufUwKkN4bzLKUCaFfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=aohLoTsi; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="aohLoTsi"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1777049098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bAhZ2HqLrtpZqDZKG2xjbfce1rSEfhvSs8798lWJF88=;
	b=aohLoTsireW7T3h48rxBgikwEyEBS/nbh5tnks6RdptS4OECfDgep6XpOpMv0nQrezbJgr
	G4gNTWIo+f46T8OHDtVGVbfuDeqm2yZvJLESnzO3SzcE9LDSuQN9/ZCCXbDgv/zPknJIxr
	pL3odWOnWxz5qlrk2G6jOs9wr379JMA=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v2 8/9] refs: add peeled object ID to the `ref_update`
 struct
In-Reply-To: <20260423-refs-move-to-generic-layer-v2-8-ae5a4f146d7d@gmail.com>
References: <20260423-refs-move-to-generic-layer-v2-0-ae5a4f146d7d@gmail.com>
 <20260423-refs-move-to-generic-layer-v2-8-ae5a4f146d7d@gmail.com>
Date: Fri, 24 Apr 2026 18:44:53 +0200
Message-ID: <87v7dgcnp6.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Certain reference backend {packed, reftable}, have the ability to also

Shouldn't it be:

  Certain reference backends {packed, reftable} have the ability to also

> store the peeled object ID for a reference pointing to a tag object.
> This has the added benefit that during retrieval of such references, we
> also obtain the peeled object ID without having to use the ODB.
>
> To provide this functionality, each backend independently calls the ODB
> to obtain the peeled OID. To move this functionality to the generic
> layer, there must be support infrastructure to pass in a peeled OID for
> reference updates.
>
> Add a `peeled` field to the `ref_update` structure and modify
> `ref_transaction_add_update()` to receive and copy this object ID to the
> `ref_update` structure. Finally, modify `ref_transaction_update()` to
> peel tag objects and pass the peeled OID to
> `ref_transaction_add_update()`.
>
> Update all callers of these functions with the new function parameters.
> Callers which only add reflog updates, need to only pass in NULL, since
> for reflogs, we don't store peeled OIDs. Reference deletions also only
> need to pass in NULL. For others, pass along the peeled OID if
> available.
>
> In a following commit, we'll modify the backends to use this peeled OID
> instead of parsing it themselves.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  | 15 +++++++++++++--
>  refs/files-backend.c    | 20 ++++++++++++--------
>  refs/refs-internal.h    | 14 ++++++++++++++
>  refs/reftable-backend.c |  6 +++---
>  4 files changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index d103387ebf..307dcb277b 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -39,6 +39,13 @@ struct ref_transaction;
>   */
>  #define REF_LOG_ONLY (1 << 7)
>  
> +/*
> + * The reference contains a peeled object ID. This is used when the
> + * new_oid is pointing to a tag object and the reference backend
> + * wants to also store the peeled value for optimized retrieval.
> + */
> +#define REF_HAVE_PEELED (1 << 15)

How did you end up picking this value?

I did some grepping to figure out if it would conflict with anything:

    git grep -h '#define REF_' -- '*.h' '*.c' |
      awk '/0x/{n=strtonum($3);b=0;while(n>1){n/=2;b++};$3="(1 << "b")"} 1' |
      sort -t'<' -k3 -n |
      column -t

(Yeah I got some help from AI to write the `awk` command)

Resulting in:

    #define  REF_EXCLUSIONS_INIT                   {                \
    #define  REF_FILTER_H
    #define  REF_FILTER_INIT                       {                \
    #define  REF_FORMAT_INIT                       {                \
    #define  REF_FORMATTING_STATE_INIT             {                0   }
    #define  REF_NO_DEREF                          (1               <<  0)
    #define  REF_NORMAL                            (1u              <<  0)
    #define  REF_STATES_INIT                       {                \
    #define  REF_STORE_ALL_CAPS                    (REF_STORE_READ  |   \
    #define  REF_STORE_CREATE_ON_DISK_IS_WORKTREE  (1               <<  0)
    #define  REF_STORE_READ                        (1               <<  0)
    #define  REF_TRANSACTION_UPDATE_ALLOWED_FLAGS  \
    #define  REF_BRANCHES                          (1u              <<  1)
    #define  REF_FORCE_CREATE_REFLOG               (1               <<  1)
    #define  REF_STORE_WRITE                       (1               <<  1)   /*  can  perform  update  operations  */
    #define  REF_HAVE_NEW                          (1               <<  2)
    #define  REF_STORE_ODB                         (1               <<  2)   /*  has  access   to      object      database  */
    #define  REF_TAGS                              (1u              <<  2)
    #define  REF_HAVE_OLD                          (1               <<  3)
    #define  REF_STORE_MAIN                        (1               <<  3)
    #define  REF_DIR                               (1               <<  4)
    #define  REF_IS_PRUNING                        (1               <<  4)
    #define  REF_DELETING                          (1               <<  5)
    #define  REF_INCOMPLETE                        (1               <<  5)
    #define  REF_KNOWS_PEELED                      (1               <<  6)
    #define  REF_NEEDS_COMMIT                      (1               <<  6)
    #define  REF_LOG_ONLY                          (1               <<  7)
    #define  REF_UPDATE_VIA_HEAD                   (1               <<  8)
    #define  REF_UPDATE_VIA_HEAD                   (1               <<  8)
    #define  REF_DELETED_RMDIR                     (1               <<  9)
    #define  REF_SKIP_OID_VERIFICATION             (1               <<  10)
    #define  REF_SKIP_REFNAME_VERIFICATION         (1               <<  11)
    #define  REF_SKIP_CREATE_REFLOG                (1               <<  12)
    #define  REF_LOG_USE_PROVIDED_OIDS             (1               <<  13)
    #define  REF_LOG_VIA_SPLIT                     (1               <<  14)
    #define  REF_HAVE_PEELED                       (1               <<  15)

So I guess it makes sense to use `(1 << 15)`.

-- 
Cheers,
Toon
