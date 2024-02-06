Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5FB1AB7FE
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 03:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707189895; cv=none; b=VCaDgOKYfrbap5pxMi3xV6FP9ifYY3rH5SVC7Vvp3V3MR9XWys6kFNXYJkvuPTfGlEx/RGXzgEJOsVv8bjGUYxzy1i54H71kHCQc4RVPX48sd8lBw/SZVC4/cdBVPEvOBIuBHxtEgUEPoen4Qnv7GiUY7S/iswW0I1yGbx8rkvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707189895; c=relaxed/simple;
	bh=W15hySBljuINTNsyHZtYDxh1w9cLPpVpmHm9FSnK8f0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ihzPYY+MOdyXzuJaFxcZ/Hn6texpAP4w0Qxy7hrhAKrIqjkvSSv+Qb3LN1XCWWIdWPgdhKWfkpjqVjvbtbM4IZWVcAN8C9SPLOOhAAzWJnUDveQ+qejmZEEE39HhTtasKaWn7mJf6IpE33WLBETY1OFiPrd7wxGs8RKxH1i6R+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rFmVUurz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rFmVUurz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7104C1E559C;
	Mon,  5 Feb 2024 22:24:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W15hySBljuINTNsyHZtYDxh1w9cLPpVpmHm9FS
	nK8f0=; b=rFmVUurzqJXmWbSO9I9XAtT5niWyjEwpDDMtBFz5IrUdHZSW0Qm+LZ
	L6cYosRQ3f57PSDRzN6cv6U7tW86E9XjwHcN0zpmqp44/rw+ZqEEZGwoag50USKr
	e1agG3d5N9yIyeDwxczbH6iy4gGBhiPCkb4QjaoO6VVmpYscSkdFg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 697181E559B;
	Mon,  5 Feb 2024 22:24:51 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C15AD1E559A;
	Mon,  5 Feb 2024 22:24:50 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  moti sd <motisd8@gmail.com>
Subject: Re: [PATCH] builtin/stash: report failure to write to index
In-Reply-To: <2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 5 Feb 2024 08:01:04 +0100")
References: <CAPvDF0P7_s-iy_V7FNSHtXXc9v5E3Fm=AdgduDDsd0rM-zNg-g@mail.gmail.com>
	<2cd44b01dc29b099a07658499481a6847c46562d.1707116449.git.ps@pks.im>
Date: Mon, 05 Feb 2024 19:24:49 -0800
Message-ID: <xmqqo7cul1fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 49905E28-C49F-11EE-9A80-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The git-stash(1) command needs to write to the index for many of its
> operations. When the index is locked by a concurrent writer it will thus
> fail to operate, which is expected. What is not expected though is that
> we do not print any error message at all in this case. The user can thus
> easily miss the fact that the command didn't do what they expected it to
> do and would be left wondering why that is.

Hopefully, they know they notice the exit status of the command, or
do we throw the error away and exit(0) from the program?

In any case, telling the users what did (and did not) happen is a
good idea.

> Fix this bug and report failures to write to the index. Add tests for
> the subcommands which hit the respective code paths.
>
> Note that the chosen error message ("Cannot write to the index") does
> not match our guidelines as it starts with a capitalized letter. This is
> intentional though and matches the style of all the other messages used
> in git-stash(1).

Style may be OK, but I wonder if they should say different things,
to hint what failed.  For example:

> @@ -537,7 +537,7 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
>  	repo_read_index_preload(the_repository, NULL, 0);
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL))
> -		return -1;
> +		return error(_("Cannot write to the index"));
>
>  	if (write_index_as_tree(&c_tree, &the_index, get_index_file(), 0,
>  				NULL))

This failure and message comes before anything interesting happens.
We attempted to refresh the current index and failed to write out
the result, meaning that whatever index we had on disk did not get
overwritten.  Is this new message enough to tell the user that we
didn't touch the working tree or the index, which would happen if
even some part of "stash apply" happened?  Or is it obvious that we
did not do anything?

> @@ -1364,7 +1364,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
>  	repo_read_index_preload(the_repository, NULL, 0);
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL) < 0) {
> -		ret = -1;
> +		ret = error(_("Cannot write to the index"));
>  		goto done;
>  	}

Ditto.

> @@ -1555,7 +1555,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
>  
>  	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET, 0, 0,
>  					 NULL, NULL, NULL)) {
> -		ret = -1;
> +		ret = error(_("Cannot write to the index"));
>  		goto done;
>  	}
>  

Ditto.

Thanks.
