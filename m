Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E67322D4DA
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745570116; cv=none; b=msrEODfRIC+aieKYOD9kU5Rnppiz0CQbKRTg132h7DL5hcB8IlH79QsKzC2FidTe/DcxLia2GQe+PUWgp4kxxQJyigrXsVEOVYTUZ1HT2r05+8SGboWdb33l2T3rda9Y7lT5kZ7zL4MEj0VJjZgxUtovERAFtYTQNOThscpvGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745570116; c=relaxed/simple;
	bh=jTu7Lyp/dByTl0t0Zs61D6FSxCgd2qKrdkjuOWl9P14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R+xfNMxZnMeNQOYWrlWN60bSRnLzMloDCl3cEURTuXpulwFG70Y6XOyE78FlerY8NdSUaGbGCCvLzNdJZ35akTY6YuOAWJQ7I+cVv91XDOI9N1NRaH5kDgOpp70za7Y6XFaQ4duf7lmMEkOa29gx60z43NG8l69BmNwHVyIRzMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=fPhfbgOb; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="fPhfbgOb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1745570109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=He+NlmTQKV29bkqZqqBWkWx1bc+50Gq68R8zYg7wQjw=;
	b=fPhfbgObi2PSi9Zo8ieGYB5eqgKG1MOXh4GjAEAB4rnYSrnVAeF02NK+KODjsKiCjRAbUO
	AyLIkHcO0dJtA5DC9N75xkNghudYNoS29nKzatTswrPso1+z6viLnJYancAhdCKjJ9/Dtv
	MB4UEhGIP/YFSrvG+hDA7pmiVwiA8Ec=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Peter Seiderer <ps.report@gmx.net>, Junio C Hamano <gitster@pobox.com>,
 Eli Schwartz <eschwartz@gentoo.org>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/2] meson: prefer POSIX-specified shell path
In-Reply-To: <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
References: <20250425-pks-meson-posix-shell-v2-0-fddc6123511b@pks.im>
 <20250425-pks-meson-posix-shell-v2-2-fddc6123511b@pks.im>
Date: Fri, 25 Apr 2025 10:35:01 +0200
Message-ID: <874iycfxl6.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Meson detects the path of the target shell via `find_program("sh")`,
> which essentially does a lookup via `PATH`. This may easily lead to a
> subtly-broken Git distribution when the build host has its shell in a
> non-standard location that the target host doesn't know about.
>
> Fix the issue by appending "/bin" to the custom program path, which
> causes us to prefer "/bin/sh" over a `PATH` lookup. As this location is
> specified by POSIX this should make us pick a better default shell path
> on all POSIX-compliant systems.
>
> Note that we intentionally append, not prepend, to the custom program
> path. This is because the program path can be configured by the user via
> the `-Dsane_tool_path=` build option, which should take precedence over
> any defaults we pick for the user.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  meson.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index a180c66ee69..c0d0982b00f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -236,7 +236,10 @@ sed = find_program('sed', dirs: program_path, native: true)
>  shell = find_program('sh', dirs: program_path, native: true)
>  tar = find_program('tar', dirs: program_path, native: true)
>  
> -target_shell = find_program('sh', dirs: program_path, native: false)
> +# Detect the target shell that is used by Git at runtime. Note that we prefer
> +# '/bin/sh' over a PATH-based lookup given that '/bin/sh' is the location
> +# specified by POSIX. This lookup can be overridden via `program_path`.
> +target_shell = find_program('sh', dirs: program_path + [ '/bin' ], native: false)

It was not instantly obvious to me, but this is what the docs[1] say
about the use of `dirs` in `find_program()`:

   extra list of absolute paths where to look for program names

So the function *first* looks in `dirs` *before* it looks in $PATH. I
wasn't fully aware what `program_path` contained, but I assumed it had
to contain the dirs in $PATH. But it seems $PATH is searched if the
program is not found in `dirs`.

So I agree with these changes.

[1]: https://mesonbuild.com/Reference-manual_functions.html#find_program

--
Toon
