Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72714BF92
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770255970; cv=none; b=s7/gzT7refI6RDhxVfoYvp5U0TaP8+J4ek/RjE6ykIzi8/hc+Jb9WLe7vhnSkAQ8na4ZaheGn8Pa9wbSmbyox6nbJ9pLT551JmBvtmuHxLbYT1d55S8c1XQ2m+cMXoXeOeE1rlBaXxEBHfUf1YqPHwuUV8JUc7MLLn7pF79r3EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770255970; c=relaxed/simple;
	bh=0d9o1mb3xHeLr3AxPCc360cuTN9PLkYyY+9tvW2APus=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr4AFz0cpv8xqBg+yXBXY8NpzYEcXIOrKm7pui1+nNiqelVYEVto5L0SgOnAPsNCDAexNZ+9x46vwze1eWeNt8RZt4sFeN88N565ZPb/VsIogEcs0HFqsQ0hTh0MO7pdPf2bOQGhTP7faZ0F+GqsqUE01DYEMm46uWIcRkwyZiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1vnoRW-00000007Gou-1gew;
	Thu, 05 Feb 2026 01:46:06 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1vnoRN-00000007AKm-1dju;
	Thu, 05 Feb 2026 10:45:53 +0900
Date: Thu, 5 Feb 2026 10:45:53 +0900
From: Mike Hommey <mh@glandium.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	gitster@pobox.com, ps@pks.im
Subject: Re: [RFC PATCH] Move rust gitcore crate to a different subdirectory
Message-ID: <5h7fs4smilvvuqyry4uef3rjgky5woodmapb3fy72src2hvlzv@o3bbh7zxqqvt>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20260204232208.1615320-1-mh@glandium.org>
 <aYPf9CnNLjJtinqw@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYPf9CnNLjJtinqw@fruit.crustytoothpaste.net>

On Thu, Feb 05, 2026 at 12:10:28AM +0000, brian m. carlson wrote:
> On 2026-02-04 at 23:22:08, Mike Hommey wrote:
> > While `src/` is the default directory convention for Rust projects, it
> > is too generic in the context of a multi-language project that is barely
> > starting to (optionally) use Rust code.
> > 
> > Additionally, having `Cargo.toml` at the top-level of the repository
> > implies that one can run `cargo build` directly, but this doesn't
> > produce anything useful on its own.
> > 
> > Moving all Rust-specific files into a dedicated `rust/` subdirectory
> > makes things clearer.
> 
> If we're going to do this, we should place the `src` directory under the
> `rust` subdirectory to maintain the normal layout.  There are many tools
> that depend on this repository layout and we want to make it as easy as
> possible for people to use native, standard tooling to build things.

Not that I'm going to argue your preference, but I'm curious what tools
you'd know that would not support a layout different than the typical
one, because that means they're broken with some existing crates (e.g.
those from https://github.com/servo/servo/) and should probably be
fixed.

It might also be worth moving into a rust/gitcore/src directory too,
including the crate name in the path.

> Note that I don't have strong opinions for or against placing the Rust
> code in a subdirectory, but I do very much want the standard layout to
> be honoured.
> 
> > The above is a post hoc justification. I do think it makes sense to do,
> > but I should mention my real immediate motivation.
> > 
> > git-cinnabar, a git remote helper used to talk to Mercurial servers, is
> > a project based on libgit (the C parts). As such, its repository
> > includes the git codebase as a submodule.
> > 
> > As of about 3 years ago, most code that is not libgit in git-cinnabar is
> > written in Rust, and is published on crates.io.
> > 
> > Part of publishing on crates.io involves running `cargo publish`, which
> > does `cargo package` under the hood. `cargo package` has the feature
> > of... not including directories that contain a Cargo.toml, so upgrading
> > libgit to 2.52.0 breaks the publishing process because all of the git
> > source code is skipped, and git-cinnabar can't be built as a result.
> > 
> > Of course, what this means is that this change is merely kicking the can
> > down the road, because the problem will reappear when the rust code
> > becomes non-optional in Git, thus why I'm making this RFC at the moment.
> 
> Perhaps you could ask Cargo upstream to add a feature to override that
> in the meantime (or add such a feature yourself).  I can imagine other
> uses for such a feature.

I'm not sure this would be well received, considering there are already
`exclude` and `include` fields to control such things, and they
explicitly and purposely don't act on directories with a Cargo.toml:

| Regardless of whether exclude or include is specified, the following
| files are always excluded:
|   - Any sub-packages will be skipped (any subdirectory that contains a
|     Cargo.toml file).
|   - A directory named target in the root of the package will be skipped.
https://doc.rust-lang.org/cargo/reference/manifest.html#the-exclude-and-include-fields

Mike
