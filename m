Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF69194A6B
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550048; cv=none; b=U8YbqZ3BbnMlKKwZtENWxPGo+mkw1DafJQTcG3pg9ar0IVRf+5rjp2hXfMxdkzDG5Sw2eWzwJuJF/kxEfmN1YBNFtA3YJtT222UrZiIy52gRuQp91l1ofEvfU7MSBJaBmC9OwcEmFdEci9rFTRzQPU9jBiLAP5+gcQbnZW66OOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550048; c=relaxed/simple;
	bh=qxPif2OOpYxcdenI/PE9KOx7w+AyvgSRZ9mgtvz6hK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjdHoes2y17g1Ym+tVIOFiDNSWmoSMjH00ZbIxc3RK2k4amp4Cdf7MsMdOtDUfK7jSs/XxurKOR6cdoKD4XqDLcOi+2vfGYkeiOxXduw6HPVboc0Upymn6NoQgSvKiOvgqQ0+uRAu2HyCIhb+gYPT3KDVCTtEYZnVV+DPCokpOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4178 invoked by uid 109); 13 Aug 2024 11:53:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 11:53:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6320 invoked by uid 111); 13 Aug 2024 11:53:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 07:53:58 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 07:53:58 -0400
From: Jeff King <peff@peff.net>
To: Matt Thompson <fortran@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Bug: Git sees branch as valid commit ref and works; should fail
Message-ID: <20240813115358.GB968816@coredump.intra.peff.net>
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
 <xmqqy15b2aiz.fsf@gitster.g>
 <CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>

On Mon, Aug 05, 2024 at 12:58:57PM -0400, Matt Thompson wrote:

> $ git for-each-ref | grep /bugfix/mathomp4/trivial-ci-commit-gcc14
> $ echo $?
> 1

Hmm, this is quite an interesting case. Let's simplify the test case by
just resolving the name instead of using checkout:

  $ git clone https://github.com/GEOS-ESM/GFDL_atmos_cubed_sphere.git fvdycore
  [...]
  $ cd fvdycore
  $ git rev-parse bugfix/mathomp4/trivial-ci-commit-gcc14
  cc14d30e332cd06327fe5a81ed26c24140882f42

That narrows it down to the name resolution code. If I step through it
in a debugger, the culprit seems to be get_describe_name(). I think it's
taking the "-gcc14" on the end as a git-describe. E.g., in a clean repo:

  $ git init
  $ git commit --allow-empty -m foo
  $ git tag -m mytag mytag
  $ git commit --allow-empty -m bar
  $ git describe
  mytag-1-g1a4fb75

So git describe will append "-g<hex_hash>", and we likewise accept that
style during name resolution. But in this case, "cc14" happens to be a
valid hex (and you'll note that it matches the start of the one we
found!).

In other words, it's a false positive in the name resolver looking for
"describe" names. We'd prefer a real ref of that full name, I think, but
since there isn't one, we prefer the describe resolution rather than
treating it as a path.

I can think of a few ways to make this better:

  - we ignore everything before the "-g<hex>" part entirely. Generally
    this should be the name of a tag or at least some ref, so we could
    perhaps verify that. But part of the point of sticking the hash in
    the name is that you might have gotten the name from another source,
    and your local one might not have the same tag. So that might be a
    bad direction.

  - the hash is abbreviated in the usual way, making it as short as
    possible while remaining unambiguous. But unless the user goes out
    of their way to set core.abbrev to something smaller, the minimum is
    always 7. So perhaps get_describe_name() should be a bit more picky
    about about that?

    That doesn't fix the problem, but it makes it a lot less likely to
    trigger in the real world. And anybody who really does somehow end
    up with a describe name with 4 characters can always pick the hash
    out of the string themselves (or just set core.abbrev in their local
    repo to be more permissive).

I think the second one is something like this:

diff --git a/object-name.c b/object-name.c
index 527b853ac4..a90338aa62 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1276,6 +1276,10 @@ static int get_describe_name(struct repository *r,
 			if (ch == 'g' && cp[-1] == '-') {
 				cp++;
 				len -= cp - name;
+				if (len < (default_abbrev < 0 ?
+					   FALLBACK_DEFAULT_ABBREV :
+					   default_abbrev))
+					return -1;
 				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}

-Peff
