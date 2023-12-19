Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FF374D0
	for <git@vger.kernel.org>; Tue, 19 Dec 2023 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xSB1vbJf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 31DDD1B16BE;
	Tue, 19 Dec 2023 12:12:35 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=K09GFRsqbSnx
	c1TrcZN24VCZt00Id4Min1buy6rSepg=; b=xSB1vbJfTXXbo/VhR0eZYjQmkUYk
	CKugDMYFZxayVM/fWn3hmqu45ipuzgQy5tmVLcCCqyCGELurR1C3uRPZvDUrScs4
	Wn39T7lI36duQM5vi28OFqbhKCVhlqPYMVfO26PgR6g+5i6l+/a8sygV72SYgTOk
	0fSn6dj2b027N7M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 296881B16BC;
	Tue, 19 Dec 2023 12:12:35 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 85BBC1B16BA;
	Tue, 19 Dec 2023 12:12:34 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] rebase: use strvec_pushf() for format-patch revisions
In-Reply-To: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 19 Dec 2023 08:42:18 +0100")
References: <4ab7431c-6c1b-448c-b4d2-e8b9be0e4eef@web.de>
Date: Tue, 19 Dec 2023 09:12:33 -0800
Message-ID: <xmqqmsu6ce0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CD3A475E-9E91-11EE-BD08-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> In run_am(), a strbuf is used to create a revision argument that is the=
n
> added to the argument list for git format-patch using strvec_push().
> Use strvec_pushf() to add it directly instead, simplifying the code.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---

Makes sense.  Between the location of the original strbuf_addf()
call and the new strvec_pushf() call, nobody mucks with *opts so
this change won't affect the correctness.  We no longer use the
extra strbuf, and upon failing to open the rebased-patches file,
we no longer leak the contents of it.  Good.

> @@ -615,34 +614,32 @@ static int run_am(struct rebase_options *opts)
>  		return run_command(&am);
>  	}
>
> -	strbuf_addf(&revisions, "%s...%s",
> -		    oid_to_hex(opts->root ?
> -			       /* this is now equivalent to !opts->upstream */
> -			       &opts->onto->object.oid :
> -			       &opts->upstream->object.oid),
> -		    oid_to_hex(&opts->orig_head->object.oid));
> -
>  	rebased_patches =3D xstrdup(git_path("rebased-patches"));
>  	format_patch.out =3D open(rebased_patches,
>  				O_WRONLY | O_CREAT | O_TRUNC, 0666);
>  	if (format_patch.out < 0) {
>  		status =3D error_errno(_("could not open '%s' for writing"),
>  				     rebased_patches);
>  		free(rebased_patches);
>  		strvec_clear(&am.args);
>  		return status;
>  	}
>
>  	format_patch.git_cmd =3D 1;
>  	strvec_pushl(&format_patch.args, "format-patch", "-k", "--stdout",
>  		     "--full-index", "--cherry-pick", "--right-only",
>  		     "--default-prefix", "--no-renames",
>  		     "--no-cover-letter", "--pretty=3Dmboxrd", "--topo-order",
>  		     "--no-base", NULL);
>  	if (opts->git_format_patch_opt.len)
>  		strvec_split(&format_patch.args,
>  			     opts->git_format_patch_opt.buf);
> -	strvec_push(&format_patch.args, revisions.buf);
> +	strvec_pushf(&format_patch.args, "%s...%s",
> +		     oid_to_hex(opts->root ?
> +				/* this is now equivalent to !opts->upstream */
> +				&opts->onto->object.oid :
> +				&opts->upstream->object.oid),
> +		     oid_to_hex(&opts->orig_head->object.oid));
>  	if (opts->restrict_revision)
>  		strvec_pushf(&format_patch.args, "^%s",
>  			     oid_to_hex(&opts->restrict_revision->object.oid));
> @@ -665,10 +662,8 @@ static int run_am(struct rebase_options *opts)
>  			"As a result, git cannot rebase them."),
>  		      opts->revisions);
>
> -		strbuf_release(&revisions);
>  		return status;
>  	}
> -	strbuf_release(&revisions);
>
>  	am.in =3D open(rebased_patches, O_RDONLY);
>  	if (am.in < 0) {
> --
> 2.43.0
