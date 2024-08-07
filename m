Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D61B15534D
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071673; cv=none; b=uX++GBEnPFMoM4SGCUezou8MpzECKN8xKqG2o8y9Y8gHX7JzrZeqj9gc2GI3vesFCRZ2NDTwjqbKfpm1Xc1Ckb5qnGoZiW8jr1PvQU2NgB9TLto5Z4P9tpJ76XqB3NISdJLsYherwwr5RAxmsmbiBmUqv4V4UkI+4selp6WVMNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071673; c=relaxed/simple;
	bh=8d1qqf5bc4q0W4sk9/kh3IIm7L+ITXiMVqt2E0PJ7cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRv9sXq8ami+dtXTa6PL/TsHAS2SMopEVr3v948pIvpB9X3qhKpsGFkJfBs/qqo4G3PKFNRdZ/h6qlvWJn655RqUEXD5QiYu+jVIqq1OW6HFr27EWuhi/2R2a+Nhg11nuwlzx7MDto1F+0f4CiYo6pXyAxiPBO6STQaeiZO9bwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbpRs-009M6Q-2S;
	Wed, 07 Aug 2024 22:48:05 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <mh@glandium.org>)
	id 1sbpRk-005Pqd-2J;
	Thu, 08 Aug 2024 07:47:56 +0900
Date: Thu, 8 Aug 2024 07:47:56 +0900
From: Mike Hommey <mh@glandium.org>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org, calvinwan@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for
 libgit.a
Message-ID: <20240807224756.2zq5hkfq5j43b7jk@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover.1723054623.git.steadmon@google.com>
 <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com>

On Wed, Aug 07, 2024 at 11:21:28AM -0700, Josh Steadmon wrote:
> +contrib/cgit-rs/hidden_symbol_export.o: contrib/cgit-rs/partial_symbol_export.o
> +	$(OBJCOPY) --localize-hidden $^ $@

This is ELF-specific and won't work on Mac or Windows.

> +    let make_output = std::process::Command::new("make")
> +        .env_remove("PROFILE")
> +        .current_dir(git_root.clone())
> +        .args(&[
> +            "CC=clang",

You should probably not set CC at all here.

> +            "CFLAGS=-fvisibility=hidden",

This won't work for Windows targets.

> +            "contrib/cgit-rs/libcgit.a"
> +        ])
> +        .output()
> +        .expect("Make failed to run");
> +    if !make_output.status.success() {
> +        panic!(
> +                "Make failed:\n  stdout = {}\n  stderr = {}\n",
> +                String::from_utf8(make_output.stdout).unwrap(),
> +                String::from_utf8(make_output.stderr).unwrap()
> +        );
> +    }
> +    std::fs::copy(crate_root.join("libcgit.a"), dst.join("libcgit.a"))?;
> +    println!("cargo::rustc-link-search=native={}", dst.into_os_string().into_string().unwrap());

You might as well use `dst.display()`.

> +    println!("cargo::rustc-link-lib=cgit");
> +    println!("cargo::rustc-link-lib=z");
> +    println!("cargo::rerun-if-changed={}", git_root.into_os_string().into_string().unwrap());

Likewise.

Mike
