Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6975227CCDD
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 19:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707270; cv=none; b=VSgfJbI+KOwtIrd0G895CCXc9ubPnJxHPGNWpRV7VxtSaK2l8inoGdIkvyZpO9QsEp3F4YKnp68fzf1AS37mKJ15TcPJ/yfT3xedHpcNtKj6LqGCc7fehPTTMdhH7nE2++X/Ee74RtRSA8N+5+HWQBVK0HBIkKIzXE6VU70EbZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707270; c=relaxed/simple;
	bh=AzMdi3AWQye2gXjh13baigbn8TP5fhSQqUdRJNssTwQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SH5LVZR6rzsQS6voIOAr3spBmUe51+tVsUxvCeJUoKJb+Te0LSHyINehxF5lJIiosEmRMI/6LOBWaefeHMF0L8S7zPGAemb/sNAJlrTkbWlnqi58RFIJr8SlWyiCi1FaxXSU5bMFrVYAto+rCfNF6iLF6qT5J8WLXcLWZS8ZZx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3rNQoNET; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3rNQoNET"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1743707264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JzGUhELLqQvTd/0Yk92EuNNF/0aYZsYF5gnZGVwH2pA=;
	b=3rNQoNETFdoyOAW8TaH7bVJcO+XUDuSlR4yV0eWnNgWOpKX9/7dAuZTMdxNIJxqDSek+7h
	8mMc+DZXCF5MIwV40hOTtRpn3+a7t+cv1CxxpqL/LWDn4DvzvoupC37idlpDAsVlx9i0Ro
	aYoQp/j8TiMXZwahM6iEmicqWOqgU/4=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] bundle: fix non-linear performance scaling with refs
In-Reply-To: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-2-6d23b2d96557@gmail.com>
References: <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-0-6d23b2d96557@gmail.com>
 <20250401-488-generating-bundles-with-many-references-has-non-linear-performance-v1-2-6d23b2d96557@gmail.com>
Date: Thu, 03 Apr 2025 21:07:31 +0200
Message-ID: <874iz5f4i4.fsf@iotcl.com>
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

> The 'git bundle create' command has non-linear performance with the
> number of refs in the repository. Benchmarking the command shows that
> a large portion of the time (~75%) is spent in the
> `object_array_remove_duplicates()` function.
>
> The `object_array_remove_duplicates()` function was added in
> b2a6d1c686 (bundle: allow the same ref to be given more than once,
> 2009-01-17) to skip duplicate refs provided by the user from being
> written to the bundle. Since this is an O(N^2) algorithm, in repos with
> large number of references, this can take up a large amount of time.
>
> Let's instead use a 'strset' to skip duplicates inside
> `write_bundle_refs()`. This improves the performance by around 6 times
> when tested against in repository with 100000 refs:
>
> Benchmark 1: bundle (refcount =3D 100000, revision =3D master)
>   Time (mean =C2=B1 =CF=83):     14.653 s =C2=B1  0.203 s    [User: 13.94=
0 s, System: 0.762 s]
>   Range (min =E2=80=A6 max):   14.237 s =E2=80=A6 14.920 s    10 runs
>
> Benchmark 2: bundle (refcount =3D 100000, revision =3D HEAD)
>   Time (mean =C2=B1 =CF=83):      2.394 s =C2=B1  0.023 s    [User: 1.684=
 s, System: 0.798 s]
>   Range (min =E2=80=A6 max):    2.364 s =E2=80=A6  2.425 s    10 runs
>
> Summary
>   bundle (refcount =3D 100000, revision =3D HEAD) ran
>     6.12 =C2=B1 0.10 times faster than bundle (refcount =3D 100000, revis=
ion =3D master)

That's a good find!

> Previously, `object_array_remove_duplicates()` ensured that both the
> refname and the object it pointed to were checked for duplicates. The
> new approach, implemented within `write_bundle_refs()`, eliminates
> duplicate refnames without comparing the objects they reference. This
> works because, for bundle creation, we only need to prevent duplicate
> refs from being written to the bundle header. The `revs->pending` array
> can contain duplicates of multiple types.

Makes sense to me.

> First, references which resolve to the same refname. For e.g. "git
> bundle create out.bdl master master" or "git bundle create out.bdl
> refs/heads/master refs/heads/master" or "git bundle create out.bdl
> master refs/heads/master". In these scenarios we want to prevent writing
> "refs/heads/master" twice to the bundle header. Since both the refnames
> here would point to the same object (unless there is a race), we do not
> need to check equality of the object.

Yeah, we can never be sure about the changes that happen while the
bundle is being created. I fixed another race[1] recently which also was
comparing equality of the object, that causes the ref to be omitted. We
can only act by "best effort" and having the ref point to /some/ object
is the best we can do.

[1]: https://lore.kernel.org/git/20241211-fix-bundle-create-race-v3-1-0587f=
6f9db1b@iotcl.com/

> Second, refnames which are duplicates but do not point to the same
> object. This can happen when we use an exclusion criteria. For e.g. "git
> bundle create out.bdl master master^!", Here `revs->pending` would
> contain two elements, both with refname set to "master". However, each
> of them would be pointing to an INTERESTING and UNINTERESTING object
> respectively. Since we only write refnames with INTERESTING objects to
> the bundle header, we perform our duplicate checks only on such
> objects.

Thanks for that context, I didn't consider that.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  bundle.c               | 10 +++++++++-
>  object.c               | 33 ---------------------------------
>  object.h               |  6 ------
>  t/t6020-bundle-misc.sh |  4 ----
>  4 files changed, 9 insertions(+), 44 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index d7ad690843..30cfba0be2 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -384,6 +384,9 @@ static int write_bundle_refs(int bundle_fd, struct re=
v_info *revs)
>  {
>  	int i;
>  	int ref_count =3D 0;
> +	struct strset objects;
> +
> +	strset_init(&objects);

Any reason why you're not using the `STRMAP_INIT` macro?

>=20=20
>  	for (i =3D 0; i < revs->pending.nr; i++) {
>  		struct object_array_entry *e =3D revs->pending.objects + i;
> @@ -401,6 +404,9 @@ static int write_bundle_refs(int bundle_fd, struct re=
v_info *revs)
>  			flag =3D 0;
>  		display_ref =3D (flag & REF_ISSYMREF) ? e->name : ref;
>=20=20
> +		if (strset_contains(&objects, display_ref))
> +			goto skip_write_ref;
> +
>  		if (e->item->type =3D=3D OBJ_TAG &&
>  				!is_tag_in_date_range(e->item, revs)) {
>  			e->item->flags |=3D UNINTERESTING;
> @@ -423,6 +429,7 @@ static int write_bundle_refs(int bundle_fd, struct re=
v_info *revs)
>  		}
>=20=20
>  		ref_count++;
> +		strset_add(&objects, display_ref);
>  		write_or_die(bundle_fd, oid_to_hex(&e->item->oid), the_hash_algo->hexs=
z);
>  		write_or_die(bundle_fd, " ", 1);
>  		write_or_die(bundle_fd, display_ref, strlen(display_ref));
> @@ -431,6 +438,8 @@ static int write_bundle_refs(int bundle_fd, struct re=
v_info *revs)
>  		free(ref);
>  	}
>=20=20
> +	strset_clear(&objects);
> +
>  	/* end header */
>  	write_or_die(bundle_fd, "\n", 1);
>  	return ref_count;
> @@ -566,7 +575,6 @@ int create_bundle(struct repository *r, const char *p=
ath,
>  	 */
>  	revs.blob_objects =3D revs.tree_objects =3D 0;
>  	traverse_commit_list(&revs, write_bundle_prerequisites, NULL, &bpi);
> -	object_array_remove_duplicates(&revs_copy.pending);
>=20=20
>  	/* write bundle refs */
>  	ref_count =3D write_bundle_refs(bundle_fd, &revs_copy);
> diff --git a/object.c b/object.c
> index 100bf9b8d1..a2c5986178 100644
> --- a/object.c
> +++ b/object.c
> @@ -491,39 +491,6 @@ void object_array_clear(struct object_array *array)
>  	array->nr =3D array->alloc =3D 0;
>  }
>=20=20
> -/*
> - * Return true if array already contains an entry.
> - */
> -static int contains_object(struct object_array *array,
> -			   const struct object *item, const char *name)
> -{
> -	unsigned nr =3D array->nr, i;
> -	struct object_array_entry *object =3D array->objects;
> -
> -	for (i =3D 0; i < nr; i++, object++)
> -		if (item =3D=3D object->item && !strcmp(object->name, name))
> -			return 1;
> -	return 0;
> -}
> -
> -void object_array_remove_duplicates(struct object_array *array)
> -{
> -	unsigned nr =3D array->nr, src;
> -	struct object_array_entry *objects =3D array->objects;
> -
> -	array->nr =3D 0;
> -	for (src =3D 0; src < nr; src++) {
> -		if (!contains_object(array, objects[src].item,
> -				     objects[src].name)) {
> -			if (src !=3D array->nr)
> -				objects[array->nr] =3D objects[src];
> -			array->nr++;
> -		} else {
> -			object_array_release_entry(&objects[src]);
> -		}
> -	}
> -}
> -
>  void clear_object_flags(unsigned flags)
>  {
>  	int i;
> diff --git a/object.h b/object.h
> index 17f32f1103..0e12c75922 100644
> --- a/object.h
> +++ b/object.h
> @@ -324,12 +324,6 @@ typedef int (*object_array_each_func_t)(struct objec=
t_array_entry *, void *);
>  void object_array_filter(struct object_array *array,
>  			 object_array_each_func_t want, void *cb_data);
>=20=20
> -/*
> - * Remove from array all but the first entry with a given name.
> - * Warning: this function uses an O(N^2) algorithm.

Funny this has been here for more than 10 years. Thanks for this cleanup.

> - */
> -void object_array_remove_duplicates(struct object_array *array);
> -
>  /*
>   * Remove any objects from the array, freeing all used memory; afterwards
>   * the array is ready to store more objects with add_object_array().
> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> index dd09df1287..500c81b8a1 100755
> --- a/t/t6020-bundle-misc.sh
> +++ b/t/t6020-bundle-misc.sh
> @@ -684,7 +684,6 @@ test_expect_success 'create bundle with duplicate ref=
names' '
>  	test_cmp expect actual
>  '
>=20=20
> -# This exhibits a bug, since the same refname is now added to the bundle=
 twice.
>  test_expect_success 'create bundle with duplicate refnames and --all' '
>  	git bundle create out.bdl --all "main" "main" &&
>=20=20
> @@ -701,7 +700,6 @@ test_expect_success 'create bundle with duplicate ref=
names and --all' '
>  	<TAG-2> refs/tags/v2
>  	<TAG-3> refs/tags/v3
>  	<COMMIT-P> HEAD
> -	<COMMIT-P> refs/heads/main
>  	EOF
>  	test_cmp expect actual
>  '
> @@ -717,7 +715,6 @@ test_expect_success 'create bundle with duplicate exl=
usion refnames' '
>  	test_cmp expect actual
>  '
>=20=20
> -# This exhibits a bug, since the same refname is now added to the bundle=
 twice.
>  test_expect_success 'create bundle with duplicate refname short-form' '
>  	git bundle create out.bdl "main" "main" "refs/heads/main" "refs/heads/m=
ain" &&
>=20=20
> @@ -725,7 +722,6 @@ test_expect_success 'create bundle with duplicate ref=
name short-form' '
>  		make_user_friendly_and_stable_output >actual &&
>  	cat >expect <<-\EOF &&
>  	<COMMIT-P> refs/heads/main
> -	<COMMIT-P> refs/heads/main
>  	EOF
>  	test_cmp expect actual
>  '

Great work on the alternative implmentation. And thanks for adding these
tests and actually fixing them. I've been manually testing a few more
edge cases, I couldn't find any other scenario that's not covered by the
current implementation.

I approve.

--
Toon
