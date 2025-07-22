Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F5517A2F7
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753199779; cv=none; b=j8ocNK4BXKmHEAoHaGHFU1et5bdlE19D2pNUzbd7Q4+zyDeJ/YGTz3BdsBGV9+O/UD7LOTzbp/hEn4ljcDQMUs6I1cGVdXucYHrs/2u2gU+QemPj3oZukv8MrnCi8VcmQEp7dXbKAVVl7dngu52mkX/WMKQEgl1elazxitmNdXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753199779; c=relaxed/simple;
	bh=A40F/mvG14FC0nT+QPEpscakSaZmHJewq5pt+bcu3es=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=DkY4ceyuR9sU7t/zBAe1b/Ib2fr23TzWosZm389/tfRb/GFUrQ0AunUEHMTHWjYIQfpuZiGAyL6Q486iOflWy2op/VFfYw+boCiylMZ8weQiR2yoQr2xBYuL/ik28O9H1RpxYQIs3+xxdI6mFkAwgpuFM8kuyNRYSdip/f1PHPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C3D7A335D9E;
	Tue, 22 Jul 2025 15:56:15 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: ps@pks.im
Cc: eschwartz@gentoo.org,ethomson@edwardthomson.com,ezekielnewren@gmail.com,git@vger.kernel.org,gitgitgadget@gmail.com,me@ttaylorr.com,newren@gmail.com,phillip.wood123@gmail.com,sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <aH-fDEX7gdpALJ6w@pks.im>
Organization: Gentoo
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Tue, 22 Jul 2025 16:56:12 +0100
Message-ID: <874iv4gqxv.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

There's a few issues from our perspective:

* Old platforms which don't have LLVM can't yet have Rust either, as
  rustc is based on LLVM.

  These need gccrs to be unblocked. I can understand not caring too much
  about these, though it is unfortunate, because I think if git hadn't
  supported many platforms to begin with, I doubt it'd have the adoption
  it does today.

  (There is another effort which seeks to take rustc and bolt on
  libgccjit as a replacement backend, but that isn't feasible for use
  yet either.)

* New platforms where rustc or various Rust crates don't support it
  and we have to go around patching them.

  The crate model makes this much harder. Not having git available when
  doing such porting if doing it natively is going to suck. It also
  means even more software needs Rust ported first.
  
* Platforms which aren't ancient, just not "the default", which tend not
  to work well with Rust.

  For example, rustc assumes that all musl configurations will be
  statically linked, which isn't the case. Working around this is a
  hassle.

* rustc doesn't have LTS releases or the like.

  The only supported release is the latest one. Upgrading to the latest
  release often means we have to deal with new portability problems
  but we can't not upgrade because:
  a) some software will start to require bleeding-edge Rust immediately,
  and
  b) it means we're missing out on bug fixes (miscompilations are
  serious)

* Crate creep

  Rust projects tend to end up having a huge list of crates that they
  pull-in which makes us worried about something nasty creeping in, but
  there's also popular crates with serious portability problems like the
  'ring' crate for TLS.

git is a fundamental piece of system software and making it harder to
build it or use it is a real worry for us.
