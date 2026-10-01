Received: from mta1.migadu.com (out-54.mta1.migadu.com [95.215.58.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B92C45D904
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790886637; cv=none; b=GLQt/DD/62glGBmYQYtjG0CAtF1cxycJTmrSzEfkcinBpoc8OXL9p1KNM+R0xa19PPP5AYvlgllQYHJkM0hXI+qWZAi0qVX+JyuOGJzwjV1JA2fQW4Q5tw4DcazMdzTNGjQU+B/+a+Ypkrxj3Cfc9u++0jlfTp7z/ypJm09P+h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790886637; c=relaxed/simple;
	bh=487Ojz1XbFD+2CihYml/4rV/zl859IuZ5CC8AyVR/pM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k1WLZBwphsQoCIxxXuGC3yvhNb7hzrR1t7b/qp4k5q78NBJ0ONd3s+g7iJXJz1cY1vMVf4y1aLiIJEJbulwkOFopEFfujNw8X7f7GfQEWTRsq53f2e/yoErVLE6gIsPjgQTvNX5KCIGpDplJtvm++U1Bx70LUisIEdEZgT8WMgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fN/4u3q9; arc=none smtp.client-ip=95.215.58.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fN/4u3q9"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=487Ojz1XbFD+2CihYml/4rV/zl859IuZ5CC8AyVR/pM=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790886629; v=1; x=1791491429;
 b=fN/4u3q9m/0C4TE9pEyxqAnNN/VTJgD1OFe2Kcj3GI2kBoKEGsamngbO7K3gadCUdvMtCY4+
 J5DcqTgumvKIL+IdL3foJYoWeWk3uoQFFb0gKMyk40pxuJcIZyWL+4N+h+IanZtGLu4iqKBHwGQ
 KLTpNHkKkvTbk1H5JEjxe7Bg=
X-Envelope-To: git@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 7f309e5c82668646;
	Thu, 01 Oct 2026 20:30:27 +0000
X-Mizu-Trace-ID: 7f309e5c82668646
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] packed-refs: use `fwrite()` when passing refs verbatim
In-Reply-To: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
Date: Thu, 01 Oct 2026 22:30:24 +0200
Message-ID: <87y0ch5fkv.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> The `write_with_updates()` function uses a `struct ref_iterator` to
> iterate over all refs to write to the temporary packfile. It receives

I would say in general "packfile" is only used for objects, but it seems
there is one mention of "packfile" in this file, so I'm not sure.

> the iterator from `packed_ref_iterator_begin()` which takes a snapshot
> of the 'packed-refs' file.
>
> While writing to the new packfile, writes are routed via
> `write_packed_entry()` which uses `fprintf()`. Even for references which
> haven't changed, we use the same mechanism. Instead, let's track the
> position of unchanged references in the snapshot iterator and directly
> use `fwrite()`.

There are a few sanitizations that get lost by using fwrite():

* oid_to_hex() is no longer called, so if an OID would be written in the
  old packed-ref as uppercase, it would be copied as such

* next_record() uses isspace(3) to split the oid from the refname. If
  the record would be separated by a tab instead of a space, that would
  be copied over.

* next_record() calls check_refname_format(), if it ain't good, oidclr()
  is called. Before this patch, that means the zero OID will be written
  for such ref. That changes with this patch, and the original OID is
  written if refname_is_safe() passes.
  This won't make a difference in Git though, because upon reading back
  from the packed-refs, the zero OID is read into memory anyway, so
  there is no observable difference.

* similar to the item above, when the ref is peelable, and REF_ISBROKEN
  (around line 985), the `peeled_oid` is not filled in. This means for a
  refname not matching the format will not contain a peeled OID for that
  ref.
  For example, in the source file:

    1937b04ead6e53d949a4e2eb97ed743b42692fde refs/tags/a-bad~tag
    ^67c1263aae5c1750e9d9211995e6d1bb38314fca

  is converted to:

    0000000000000000000000000000000000000000 refs/tags/a-bad~tag

  After this patch, the ref and it's peeled commit OID is copied
  verbatim.

I'm not saying any of this is bad. These are just some side-effects of
your fwrite() approach. And some might be worht mentioning in the commit
message.

>
> This removes the unnecessary formatting operation involved. We can see a
> consistent ~20% performance improvement when deleting from packed
> references.
>
> Benchmark 1: update-ref: delete ref (refcount =3D 100000, revision =3D ma=
ster)
>   Time (mean =C2=B1 =CF=83):      28.7 ms =C2=B1   1.7 ms    [User: 22.5 =
ms, System: 5.9 ms]
>   Range (min =E2=80=A6 max):    26.7 ms =E2=80=A6  33.3 ms    46 runs
>
> Benchmark 2: update-ref: delete ref (refcount =3D 100000, revision =3D b4=
/kn-speedup-packed-refs)
>   Time (mean =C2=B1 =CF=83):      23.8 ms =C2=B1   1.2 ms    [User: 17.5 =
ms, System: 6.0 ms]
>   Range (min =E2=80=A6 max):    22.1 ms =E2=80=A6  27.7 ms    56 runs
>
> Summary
>   update-ref: delete ref (refcount =3D 100000, revision =3D b4/kn-speedup=
-packed-refs) ran
>     1.21 =C2=B1 0.09 times faster than update-ref: delete ref (refformat =
=3D files, refcount =3D 100000, revision =3D master)

Not bad.

>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/packed-backend.c | 43 ++++++++++++++++++++++++++++++++-----------
>  1 file changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index a73fc6aca7..ef952cdba6 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -879,6 +879,12 @@ struct packed_ref_iterator {
>  	/* The current position in the snapshot's buffer: */
>  	const char *pos;
>=20=20
> +	/*
> +	 * Start of the current record, set when advancing `pos`. Used to
> +	 * pass records verbatim to `fwrite()`.

I assume there was a version you've been working on that was calling
fwrite() directly from ref_transaction_error write_with_updates()? With
that being wrapped by a helper function, I think it's better to name
that function here.

> +	 */
> +	const char *record_start;
> +
>  	/* The end of the part of the buffer that will be iterated over: */
>  	const char *eof;
>=20=20
> @@ -933,6 +939,7 @@ static int next_record(struct packed_ref_iterator *it=
er)
>  	if (iter->pos =3D=3D iter->eof)
>  		return ITER_DONE;
>=20=20
> +	iter->record_start =3D iter->pos;
>  	iter->base.ref.flags =3D REF_ISPACKED;
>  	p =3D iter->pos;
>=20=20
> @@ -1218,17 +1225,27 @@ static struct ref_iterator *packed_ref_iterator_b=
egin(
>=20=20
>  /*
>   * Write an entry to the packed-refs file for the specified refname.
> - * If peeled is non-NULL, write it as the entry's peeled value. On
> - * error, return a nonzero value and leave errno set at the value left
> - * by the failing call to `fprintf()`.
> + *
> + * If the raw data is available, skip the formatting and directly write =
to
> + * the file using `fwrite()`. e.g. when deleting references and remaining
> + * refs need to be written verbatim. Otherwise, use `fprintf()`.
> + *
> + * If peeled is non-NULL, write it as the entry's peeled value.
> + *
> + * On error, return a nonzero value and leave errno set at the value left
> + * by the failing call to `fwrite()` or `fprintf()`.
>   */
> -static int write_packed_entry(FILE *fh, const char *refname,
> -			      const struct object_id *oid,
> +static int write_packed_entry(FILE *fh, const char *raw, size_t raw_len,
> +			      const char *refname, const struct object_id *oid,
>  			      const struct object_id *peeled)

I'm not convinced it's worth to have both ways of writing in a single
function.

I rather keep this function as-is and add a function:

    static int write_packed_entry_preformatted(FILE *fh,
                                               const char *line,
                                               size_t line_len)
    {
    	if (fwrite(raw, raw_len, 1, fh) !=3D 1)
    			return -1;
    	return 0;
    }

Or maybe even:

    static int write_packed_entry_from_iter(FILE *fh,
                                            struct packed_ref_iterator *pac=
ked_iter)
    {
    	size_t ret =3D fwrite(packed_iter->record_start,
                            packed_iter->pos - packed_iter->record_start,
                            1, fh);
        if (ret !=3D 1)
    			return -1;
    	return 0;
    }

>  {
> -	if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
> -	    (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0))
> +	if (raw) {
> +		if (fwrite(raw, raw_len, 1, fh) !=3D 1)

I see in some places, for example in fwrite_or_die(), `len` and `1` are
swapped and the return value is compared against `len`. This is useful
when the length can be 0. But that cannot the case here, so no need to
change that.

> +			return -1;
> +	} else if (fprintf(fh, "%s %s\n", oid_to_hex(oid), refname) < 0 ||
> +		   (peeled && fprintf(fh, "^%s\n", oid_to_hex(peeled)) < 0)) {

For what's it's worth, I think it's really ugly to do this in a single
if() statement, but that just could be me.

>  		return -1;
> +	}
>=20=20
>  	return 0;
>  }
> @@ -1530,9 +1547,13 @@ static enum ref_transaction_error write_with_updat=
es(struct packed_ref_store *re
>  		}
>=20=20
>  		if (cmp < 0) {
> -			/* Pass the old reference through. */
> -			if (write_packed_entry(out, iter->ref.name,
> -					       iter->ref.oid, iter->ref.peeled_oid))
> +			const struct packed_ref_iterator *packed_iter =3D
> +				(const struct packed_ref_iterator *)iter;
> +			size_t len =3D packed_iter->pos - packed_iter->record_start;

This is nice. Because packed_iter->pos points at the next record, the
`len` will include the peeled OID line as well. Which is fwrite(3)'n in
one go. That's a nice win.

> +
> +			if (write_packed_entry(out, packed_iter->record_start,
> +					       len, iter->ref.name, iter->ref.oid,
> +					       iter->ref.peeled_oid))
>  				goto write_error;
>=20=20
>  			if ((ok =3D ref_iterator_advance(iter)) !=3D ITER_OK) {
> @@ -1551,7 +1572,7 @@ static enum ref_transaction_error write_with_update=
s(struct packed_ref_store *re
>  		} else {
>  			bool peeled =3D update->flags & REF_HAVE_PEELED;
>=20=20
> -			if (write_packed_entry(out, update->refname,
> +			if (write_packed_entry(out, NULL, 0, update->refname,
>  					       &update->new_oid,
>  					       peeled ? &update->peeled : NULL))
>  				goto write_error;
>
> ---
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
> change-id: 20260930-kn-speedup-packed-refs-9868f5d0abe9
>
>
> Thanks
> - Karthik
>

--=20
Laters,
Toon
