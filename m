Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6183A186E40
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761314490; cv=none; b=WdmJ3Wb9rR7VlxuRiehMKTc4akMbCE7HY4DSHspPDUaFKDF9pn1MMfShX292dYht23Kn3OU5Oel0KAEu6xZPBbhFPS+40wIm+C/LYn2iDvHgrFzoRMAh+my9Lz0eSfijfwX+Ca8pXnVEDFdlE5M6EEAJLHnBJHoZUV6MWnajyHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761314490; c=relaxed/simple;
	bh=Y4k1/eZAyiEnzTOejdnonZCZeRhGryA1uDpinGUYVTE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q4fKqQce+nN+9/tIQ7eqkdUdkJqUDmR4rBNhdr9Xp6OMaKchfNsDrJAGtLX0VEucsPKM/mzYVGOcqEdQ53wkR1HBCJ2IsSJhvnYuuzs/1A6mcnmvS6Qw4ZktUINR+YqEe1vZe26OXfsGz9YjhFeTFAQ3A+iWIK3CseQUx1CpeSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Nv43ZKaa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Nv43ZKaa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761314481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RRJlImni5qYU3GnLItEJ2hvOwMJfTME1MxAKuJ0zr50=;
	b=Nv43ZKaavLsLm/PeGe2j0a7J1NXGx674y2YFwVtzNgXO3iMBR2uiErsaM56PtpOA5ydLYo
	aURrQNo9OwUGrrnUbDJhYPraQk5q6eq8Km30My2bmqOm8SYM1B9HIO2TgTWP3WefcPtUE3
	/HP7AUDCc2zeRoIIymOdr9UAsUSebag=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, Ezekiel Newren
 <ezekielnewren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] rust: generate bindings via cbindgen
In-Reply-To: <20251024-b4-pks-rust-cbindgen-v2-5-4b4bd4f18490@pks.im>
References: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
 <20251024-b4-pks-rust-cbindgen-v2-5-4b4bd4f18490@pks.im>
Date: Fri, 24 Oct 2025 16:01:07 +0200
Message-ID: <87v7k4pffg.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> [snip]
>
> diff --git a/meson.build b/meson.build
> index 308798e861..b4acc417ad 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -523,6 +523,7 @@ libgit_sources = [
>    'usage.c',
>    'userdiff.c',
>    'utf8.c',
> +  'varint.c',
>    'version.c',
>    'versioncmp.c',
>    'walker.c',
> @@ -1704,7 +1705,9 @@ version_def_h = custom_target(
>  libgit_sources += version_def_h
>  
>  cargo = find_program('cargo', dirs: program_path, native: true, required: get_option('rust'))
> -rust_option = get_option('rust').disable_auto_if(not cargo.found())
> +cbindgen = find_program('cbindgen', dirs: program_path, native: true, required: get_option('rust'))
> +
> +rust_option = get_option('rust').disable_auto_if(not cargo.found() or not cbindgen.found())

This means to compile with Rust we not only need cargo, but also
cbindgen. As we ideally want to have a broad platform support, would
adding another dependency (i.e. `cbindgen`) narrow the platforms we'd
eventually support? Or can we consider platforms supporting Rust also
have cbindgen?

> [snip]
>
> diff --git a/varint.c b/varint.c
> index 03cd54416b..1ed738a756 100644
> --- a/varint.c
> +++ b/varint.c
> @@ -1,6 +1,14 @@
>  #include "git-compat-util.h"
>  #include "varint.h"
>  
> +/*
> + * When building with Rust we don't compile the C code, but we only verify
> + * whether the function signatures of our C bindings match the ones we have
> + * declared in "varint.h".
> + */
> +#ifdef WITH_RUST
> +# include "c-bindings.h"

So when we rewrite more subsystems into Rust, this will include
definitions from all those subsystems into this compilation unit.
If one subsystem with a Rust alternative implementation includes the
header from another subsystem with a Rust-alternative implementation,
the function signatures are checked twice, and errors are surfaced
twice. I guess this is a tradeoff we can accept for now, because:

* We only have one subsystem in Rust now.
* The approach in this patch simplifies the build setup.

We might revisit that at some point, but I can agree this is the most
sensical approach for now.

-- 
Cheers,
Toon
