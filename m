Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4C34ED198
	for <git@vger.kernel.org>; Fri, 18 Sep 2026 15:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743783; cv=none; b=OWXPuXHRCilfnwlDZnKFACgOrln+oX0Uo735AIPqfDt2D9UhmCc6Yv4UtUsBGe6wec1kbd98lKCKU4ErZmDYQkzE4CDyYEKnTSM8dx79zr0UPOqoNYrSVx0Ihrz2O9CKB1T41wVaC3jy4WrYylOekkNTGUlAaHy05cuuwfVCMaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743783; c=relaxed/simple;
	bh=4zGA4i5/PdUKzMDFpp5WEx6Yfhpbn10juz7U49w3btk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIGxthoedBbBF6hWelnejX73XKUZ2Xe3cNnNm2jPk+wBUYnYWcYRlVlH/iLpNyHIIJAI8Yug1UQQp/mCx1HwA7/y7t4JkYxeVSvDUqLtqatsUTNQSME9SAhDJA1+D+1lih5PteFzWQbNxqQVkys2NEfcHOhvYqiXp3Ol8OPiVtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x7a6z-00000001MV1-2KgY;
	Fri, 18 Sep 2026 15:02:50 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x7a6o-0000000GMr2-3SDe;
	Sat, 19 Sep 2026 00:02:38 +0900
Date: Sat, 19 Sep 2026 00:02:38 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, sandals@crustytoothpaste.net
Subject: Re: [PATCH v5] move rust gitcore crate to a different subdirectory
Message-ID: <yc4bgjoyxnm6o7q4gwols4d6zvdrq3ydw2c65wjdwof3hjyde6@2osv37jtuxx3>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <xmqq5x0df19l.fsf@gitster.g>
 <20260917060415.2986259-1-mh@glandium.org>
 <xmqqfqz7otr0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfqz7otr0.fsf@gitster.g>

On Fri, Sep 18, 2026 at 01:20:51AM -0700, Junio C Hamano wrote:
> It would have been a friendly thing to do to describe what base was
> chosen, especially with a few other topics in flight that touch the
> build procedure for Rust part of the system recently, here below the
> three-dash line.  
> 
> It seems that this patch is designed to apply cleanly on top of Git
> 2.56-rc1, which already has these topics merged, so I do not have to
> worry about conflicts with them when queueing this patch, which is
> good.

I must admit I hadn't given much thought about where this would be
applied, but it was based off master at the time of refreshing the
patch, which was, indeed, v2.56.0-rc1.

> So things in src/ move to either rust/ directory or rust/src/
> directory.

Correct. Mostly rs files (except build.rs) move to rust/src/, and the
rest to rust/.

> > -$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> > -	$(QUIET_CARGO)cargo build $(CARGO_ARGS)
> > +$(RUST_LIB): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> > +	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS)
> > ...
> > -RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> > -$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> > -	$(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> > +RUST_MEMBER_LIBS = $(foreach target,$(RUST_TARGETS),rust/target/$(target)/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> > +$(RUST_MEMBER_LIBS): rust/target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): rust/Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> > +	$(QUIET_CARGO)cargo build --manifest-path rust/Cargo.toml $(CARGO_ARGS) --target $*
> 
> Is the reason why we now need to sprinkle --manifest-path all over
> is because rust/Cargo.toml is a non-standard place for cargo tool?
> Not complaining, but am wondering if it is simpler to set and export
> CARGO_MANIFEST_DIR from the Makefile.

It's non-standard in the sense that it's not Cargo.toml is $PWD. An
alternative could be to `cd rust` before running cargo commands.

> > diff --git a/meson.build b/meson.build
> > index 0a95d90d21..432e306b21 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -1795,7 +1795,7 @@ libgit_sources += version_def_h
> >  
> >  rust_option = get_option('rust')
> >  if rust_option.allowed()
> > -  subdir('src')
> > +  subdir('rust')
> 
> Not 'rust/src'?  Just double-checking.

Not rust/src because the rust meson.build was moved to rust/, not
rust/src. It felt like it was in src/ along the .rs files just because
there was no other place for it in the first place.

> > @@ -13,7 +13,7 @@ libgit_rs_sources = [
> >  cargo_command = [
> >    shell,
> >    meson.current_source_dir() / 'cargo-meson.sh',
> > -  meson.project_source_root(),
> > +  meson.current_source_dir(),
> >    meson.current_build_dir(),
> >  ]
> 
> What is this change about?

IIRC project_source_root is the git top-level directory, and
current_source_dir is the one containing meson.build. Keeping
project_source_root would put the target directory at the git top-level,
which would be different from what the Makefile does (since it doesn't
pass a --target-dir)

Mike
