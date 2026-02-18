Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95122D9796
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 15:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771428481; cv=none; b=uyfnAGJgj/EnsOCSFzxZT2M4v7UfQcfplInhmN9RV+rNLsDf+Td2C3l/NQH9iJkcGUADH6HKRhAEvrQun9oj5ll1COuAWt7vluP707eVb1n3MVZrLXS+UATVmDkQ+mNwE/XO9J4lu/OxyHuvtvTHACLKlBJ13p2ObIVjgagqkm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771428481; c=relaxed/simple;
	bh=XoXEinfxwt5QcUTRe81Al+XGc/SsNNTNJfeMsDnbh5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EGfoxUKFueohBdiZTO4PoPJHOqm9USUXjpwd7Zb2Ux4KbWyLz4o5P14Um0rP+T4q8vZ+LrqUwMFfaqXxdD0WDD5uHMH4jOX9xOAK8Dz0EWLOFssvjjdgeijSKu2zjAqfBHkqeFjrG/e09xqevok2cILWyy4Z0dD12+MM2PUAEfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=R/KyiFZT; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="R/KyiFZT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1771428476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4qrZimRHkCMWDD7gpw9IFdqQay2gal7YaDIW0Q5GZc=;
	b=R/KyiFZTM9+1hKdOkHHul2sKQ872HcAVijQesjO/qx4CqJgC42WRJsFd/bmZZxt2n5PGPo
	D5g/jS2yMbNLYLezJqej+m0B1i+9MhZ1YnFZxim9p119/2Bj8oTSHwW9DrFTcqd9dMT8D4
	sk7GdUal6CTUiQEwX34SPiaZAcJesEQ=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>, gitster@pobox.com, ps@pks.im
Subject: Re: [PATCH v6 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
In-Reply-To: <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com>
References: <20260214-kn-alternate-ref-dir-v6-0-86a82c77cf59@gmail.com>
 <20260214-kn-alternate-ref-dir-v6-6-86a82c77cf59@gmail.com>
Date: Wed, 18 Feb 2026 16:27:44 +0100
Message-ID: <87jywacbrj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references. In
> the previous commit we extended the 'extensions.refStorage' config to
> also support an URI input for reference backend with location.
>
> Let's also add a new environment variable 'GIT_REFERENCE_BACKEND' that
> takes in the same input as the config variable. Having an environment
> variable allows us to modify the reference backend and location on the
> fly for individual Git commands.
>
> The environment variable also allows usage of alternate reference
> directories during 'git-clone(1)' and 'git-init(1)'. Add the config to
> the repository when created with the environment variable set.
>
> When initializing the repository with an alternate reference folder,
> create the required stubs in the repositories $GIT_DIR. The inverse,
> i.e. removal of the ref store doesn't clean up the stubs in the $GIT_DIR
> since that would render it unusable. Removal of ref store is only used
> when migrating between ref formats and cleanup of the $GIT_DIR doesn't
> make sense in such a situation.
>
> Helped-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git.adoc |   5 ++
>  environment.h          |   1 +
>  refs.c                 |  23 +++++---
>  setup.c                |  55 ++++++++++++++++-
>  t/t1423-ref-backend.sh | 157 ++++++++++++++++++++++++++++++++++++++-----=
------
>  5 files changed, 198 insertions(+), 43 deletions(-)
>
> [snip]
>
> diff --git a/refs.c b/refs.c
> index 87ef54abd4..6b3883a325 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2192,16 +2192,21 @@ int ref_store_create_on_disk(struct ref_store *re=
fs, int flags, struct strbuf *e
>  {
>  	int ret =3D refs->be->create_on_disk(refs, flags, err);
>=20=20
> -	if (!ret &&
> -	    ref_storage_format_by_name(refs->be->name) !=3D REF_STORAGE_FORMAT_=
FILES) {
> -		struct strbuf msg =3D STRBUF_INIT;
> -
> -		strbuf_addf(&msg, "this repository uses the %s format", refs->be->name=
);
> -		refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> -		strbuf_release(&msg);
> +	if (!ret) {
> +		/* Creation of stubs for linked worktrees are handled in the worktree =
code. */
> +		if (!(flags & REF_STORE_CREATE_ON_DISK_IS_WORKTREE) && refs->repo->ref=
_storage_payload) {
> +			refs_create_refdir_stubs(refs->repo, refs->repo->gitdir,
> +						 "repository uses alternate refs storage");
> +		} else if (ref_storage_format_by_name(refs->be->name) !=3D REF_STORAGE=
_FORMAT_FILES) {
> +			struct strbuf msg =3D STRBUF_INIT;
> +			strbuf_addf(&msg, "this repository uses the %s format", refs->be->nam=
e);
> +			refs_create_refdir_stubs(refs->repo, refs->gitdir, msg.buf);
> +			strbuf_release(&msg);
> +		}
>  	}
>=20=20
>  	return ret;
> +
>  }
>=20=20
>  int ref_store_remove_on_disk(struct ref_store *refs, struct strbuf *err)
> @@ -2216,6 +2221,10 @@ int ref_store_remove_on_disk(struct ref_store *ref=
s, struct strbuf *err)
>  		if (format =3D=3D REF_STORAGE_FORMAT_FILES)
>  			return ret;
>=20=20
> +		/* Alternate refs backend require stubs in the gitdir. */

I find this comment rather confusing, you say "require stubs" and you do
an early return. I had to read it more than once to understand. What do
you think about:

 +		/* No stubs required in the alternate refs backend,
 +		 * stubs only should be created in the gitdir. */

> +		if (refs->repo->ref_storage_payload)
> +			return ret;
> +

--=20
Cheers,
Toon
