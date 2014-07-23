From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Wed, 23 Jul 2014 14:16:15 -0700
Message-ID: <xmqqzjfzdbds.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:16:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA3tl-0007Sg-H6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933671AbaGWVQZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Jul 2014 17:16:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55313 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933664AbaGWVQY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 17:16:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 55B472AB4B;
	Wed, 23 Jul 2014 17:16:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=f8nmSMJD1q2u
	wnK5hOMmlqghud8=; b=nZ88Bpu7sMREB52OlO7c3qT8UVm68SG3S/UWKDnUtuL3
	winI9BGnT2+wGzOD7TB+3tHjsrgmEDxNvV1BlT5rW9YhVuGq0/OgS4v0teurNG1D
	2xWnJ0LEuf15a/Cxn/0a+2chwpJooFTC3PoR4JXyJ3BrmZVsLEu01bpf3Axyqs8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pXblU9
	+8a7vOA0vY1D7cu2R1DOhw66O8Bo4VPltnQh3xuFcLZoz6KA+2IAD/Uv/xY9cQoU
	W338c3Y2yc2OifcnE5m5iFSD++cwP9x7CVknhpbDy9aMnA3/ZzOM5+lJzATsXIKt
	FYU6+Qlqjy9M8IcizUGMf+3qi6q4eOdHMwRvE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 477022AB4A;
	Wed, 23 Jul 2014 17:16:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0461D2AB44;
	Wed, 23 Jul 2014 17:16:16 -0400 (EDT)
In-Reply-To: <1406115795-24082-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 23
 Jul 2014 18:43:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 9588C6D8-12AE-11E4-A394-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254122>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index c83f476..d35245a 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1006,31 +1006,52 @@ static const char *unique_tracking_name(const=
 char *name, unsigned char *sha1)
>  	return NULL;
>  }
> =20
> -static int check_linked_checkout(struct branch_info *new,
> -				  const char *name, const char *path)
> +static void check_linked_checkout(struct branch_info *new, const cha=
r *id)
>  {
>  	struct strbuf sb =3D STRBUF_INIT;
> +	struct strbuf path =3D STRBUF_INIT;
> +	struct strbuf gitdir =3D STRBUF_INIT;
>  	const char *start, *end;
> -	if (strbuf_read_file(&sb, path, 0) < 0 ||
> -	    !skip_prefix(sb.buf, "ref:", &start)) {
> -		strbuf_release(&sb);
> -		return 0;
> -	}
> =20
> +	if (id)
> +		strbuf_addf(&path, "%s/repos/%s/HEAD", get_git_common_dir(), id);
> +	else
> +		strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +
> +	if (strbuf_read_file(&sb, path.buf, 0) <=3D 0 ||
> +	    !skip_prefix(sb.buf, "ref:", &start))
> +		goto done;
>  	while (isspace(*start))
>  		start++;
>  	end =3D start;
>  	while (*end && !isspace(*end))
>  		end++;

Not new in this round of update, and may not even be an issue, but:

 - Earlier, the code returned early on a negative return value from
   read-file (i.e., an error), but this round it also does so for
   zero.  Intended?

 - The above duplicates the logic in resolve_ref_unsafe() and
   resolve_gitlink_ref_recursive(); three places now knows what a
   textual symref looks like (i.e. begins with "ref:", zero or more
   whitespaces, the target ref and then zero or more trailing
   whitespaces).  Perhaps we need to consolidate the code further,
   so that this knowledge does not leak out of refs.c?

> +	if (strncmp(start, new->path, end - start) ||
> +	    new->path[end - start] !=3D '\0')
> +		goto done;
> +	if (id) {
> +		strbuf_reset(&path);
> +		strbuf_addf(&path, "%s/repos/%s/gitdir",
> +			    get_git_common_dir(), id);
> +		if (strbuf_read_file(&gitdir, path.buf, 0) <=3D 0)
> +			goto done;
> +		while (gitdir.len && (gitdir.buf[gitdir.len - 1] =3D=3D '\n' ||
> +				      gitdir.buf[gitdir.len - 1] =3D=3D '\r'))
> +			gitdir.buf[--gitdir.len] =3D '\0';

Accepting arbitrary numbers of '\r' and '\n' sounds as if the code
is allowing it, but text editors would not end their files with a
nonsense sequence like "\r\r\n\r" unless the end-user works to do
so, and if you are prepared to be lenient to noisy human input, not
trimming trailing whitespaces does not look it is going far enough
to help them.

I do not see a good reason to allow random text editors to edit this
file in the first place, so my preference is:

	if (strbuf_read_file(...) < 0 ||
	    gitdir.len =3D=3D 0 ||
            gitdir.buf[gitdir.len - 1] !=3D '\n')
            goto error_return;
	gitdir.buf[--gitdir.len] =3D '\0';

Alternatively, if you are trying to be lenient to human input, I
would understand:

	if (strbuf_read_file(...) < 0)
        	goto error_return;
	strbuf_rtrim(&gitdir);

The code in the patch, which is something in between, does not make
much sense to me.
