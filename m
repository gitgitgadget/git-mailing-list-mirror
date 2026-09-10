Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F336474274
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789042190; cv=none; b=nW8HDrc/00eGp1v/2fNj+JrxqBSKfd/oDIqsVJ6ORUN3De4dhioA43KrOMu1DZDP+cDcz7syp/ZD5YPWJCQ31J7xbrJQ97bHn+jbA3pGixkzdO/at7CvfcVsKSeC/FVeWs9MJKmTTOJsioBvnvuXuIAuJy5KK7wk7+5nLyx4Tl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789042190; c=relaxed/simple;
	bh=0IdblBdWb8dJTcH9Cs9NnOmD+/2iXr7ygHwWoC7q73E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaPvxH2vtlLGTSo1BatDHjq+ekUUjGOAdzvGA/sXdoQqgQlSWOgUgmyyonI+eZzUZtZ9yfWjjwXltICTRlUSSp3LpSektWL7zNFgAKK88Sq1ewbwJyx0sbmY3bkj0B7RJXReShYZQ1W8K2edRTp+KK+VwP6wss5sgaDyD/4FpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from [2001:3b0:22:ba05:3c99:5d75:c899:ae5e] (helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x4db6-0000000Gwtn-0Ml8;
	Thu, 10 Sep 2026 12:09:44 +0000
Received: from glandium by goemon with local (Exim 4.98.2)
	(envelope-from <mh@glandium.org>)
	id 1x4db0-0000000BXAf-0oYf;
	Thu, 10 Sep 2026 21:09:38 +0900
Date: Thu, 10 Sep 2026 21:09:38 +0900
From: Mike Hommey <mh@glandium.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, sandals@crustytoothpaste.net
Subject: Re: [PATCH v3] Move rust gitcore crate to a different subdirectory
Message-ID: <mzrpnwtg3nkij74yp35gz74u7svzedx2kom2dsiq3dk7zhb7yp@4fihynejp63w>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <20260209224847.1416916-1-mh@glandium.org>
 <20260909013858.1729643-1-mh@glandium.org>
 <xmqqbja6qjyc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbja6qjyc.fsf@gitster.g>

On Wed, Sep 09, 2026 at 12:54:35PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> > 
> > Having `Cargo.toml` at the top-level of the repository implies that one
> > can run `cargo build` directly, but this doesn't produce anything useful
> > on its own.
> >
> > Additionally, when including the git source as a submodule of a Rust
> > project, it prevents the git source from being included at all in the
> > crate package because cargo skips directories that contain a Cargo.toml,
> > assuming that everything in the directory is relevant to the crate.
> >
> > This moves all Rust-specific files into a dedicated `rust/`
> > subdirectory.
> 
> Very readable and understandable.  It is customary in this project
> to write that last sentence in imperative mood, though.  I.e.  "Move
> all files there".
> 
> > Signed-off-by: Mike Hommey <mh@glandium.org>
> 
> 
> > diff --git a/.gitignore b/.gitignore
> > index 4da58c6754..3ac0685800 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -261,3 +261,5 @@ Release/
> >  /contrib/buildsystems/out
> >  /contrib/libgit-rs/target
> >  /contrib/libgit-sys/target
> > +/rust/target
> > +/rust/Cargo.lock
> 
> There are /target/ and /Cargo.lock listed in this file; aren't these
> two entries meant to _replace_ them?  I am wondering if they need to
> disappear as part of this patfch.

This and the RUST_SOURCES thing you raised are rebase errors,
apparently.

> > @@ -3913,7 +3915,7 @@ clean: profile-clean coverage-clean cocciclean
> >  	$(RM) $(FUZZ_PROGRAMS)
> >  	$(RM) $(SP_OBJ)
> >  	$(RM) $(HCC)
> > -	$(RM) -r Cargo.lock target/
> > +	$(RM) -r Cargo.lock rust/target/
> 
> The Cargo.lock file does not move together with the rest?  That
> contradicts with what .gitignore says, doesn't it?

Huh, thanks for noticing this one.

Mike
