Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD541547EA
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723463266; cv=none; b=tjQ0Bq8gkGrwFakgwJqNLsPvlbywlvloTCC8a+tx+yaEaIuJx9QQ/QUIU/cJ4ZBBZZ6OydukYKgELBQezpH+tSLEqzgK6mYcG3AFRoDUZ9RPc80FUVLRbu8qwY4Z1wFoeoy0V8qWLtSNq9mpSo77ajzhnwzm7szhCf2UUV4IzCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723463266; c=relaxed/simple;
	bh=pVNMHJF9aUS9u2kNFJNT3hvgrcEJe1JBkSx20je173Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsDmD49zxRE9c0Q2cP+Ny5R6viav4JSnIn5OznloUNI6n/YPIIvRBpyczV2AWceX+gT96IhwPus3HR/ilHrEBLiudVf8K/DLVYLv23+bbQXSH81TiFY5lavYUtGscAQdTy/KP0Mc3hbXhLPbWN3kWF8y3mAcl4+eQhtOWvUvQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27592 invoked by uid 109); 12 Aug 2024 11:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Aug 2024 11:47:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28843 invoked by uid 111); 12 Aug 2024 11:47:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Aug 2024 07:47:34 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 12 Aug 2024 07:47:33 -0400
From: Jeff King <peff@peff.net>
To: ArcticLampyrid <ArcticLampyrid@outlook.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: SIGSEGV Error Occurs When Attempting to Unbundle Without
 Initializing Git Repository.
Message-ID: <20240812114733.GA3732689@coredump.intra.peff.net>
References: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <TYWP301MB0563973ECA440E7DAF0F7E89C4852@TYWP301MB0563.JPNP301.PROD.OUTLOOK.COM>

On Mon, Aug 12, 2024 at 06:57:25PM +0800, ArcticLampyrid wrote:

> #### Steps to Reproduce
> I attempted to unbundle a pack but forgot to execute `git init` beforehand.
> 
> #### Expected Behavior
> An error message should have been displayed, reminding me to run `git init`.
> 
> #### Actual Behavior
> The process unexpectedly terminated with a SIGSEGV (Address boundary error).
> 
> #### Difference Between Expected and Actual Behavior
> Instead of gracefully exiting, the process terminated abruptly.

Thanks for the report, it's pretty easy to reproduce. Looks like another
casualty of c8aed5e8da (repository: stop setting SHA1 as the default
object hash, 2024-05-07). Author cc'd.

A sample stack trace is:

  #0  0x000055555573a93c in get_hash_hex_algop (
      hex=0x555555a11180 "b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06 refs/heads/master", hash=0x7fffffffdc00 "$h\240UUU",
      algop=0x0) at hex.c:11
  #1  0x000055555573a9aa in get_oid_hex_algop (
      hex=0x555555a11180 "b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06 refs/heads/master", oid=0x7fffffffdc00, algop=0x0)
      at hex.c:29
  #2  0x000055555573aad1 in parse_oid_hex_algop (
      hex=0x555555a11180 "b2f0a7f47f5f2aebe1e7fceff19a57de20a78c06 refs/heads/master", oid=0x7fffffffdc00,
      end=0x7fffffffdc28, algop=0x0) at hex.c:62
  #3  0x00005555556acaf3 in read_bundle_header_fd (fd=3, header=0x7fffffffddf0, report_path=0x555555a110a0 "foo")
      at bundle.c:121
  #4  0x00005555556accdf in read_bundle_header (path=0x555555a110a0 "foo", header=0x7fffffffddf0) at bundle.c:153
  #5  0x000055555558c8d6 in open_bundle (path=0x555555a110a0 "foo", header=0x7fffffffddf0, name=0x0)
      at builtin/bundle.c:123
  #6  0x000055555558cd8b in cmd_bundle_unbundle (argc=1, argv=0x7fffffffe4b0, prefix=0x0) at builtin/bundle.c:210
  #7  0x000055555558cff1 in cmd_bundle (argc=2, argv=0x7fffffffe4b0, prefix=0x0) at builtin/bundle.c:244

Curiously, the next line after the open_bundle() call is:

          if (!startup_info->have_repository)
                  die(_("Need a repository to unbundle."));

So one option is to just do that check earlier. But that leaves other
sub-commands of "git bundle":

  - "create" likewise requires a repo, and seems OK. That makes sense
    since we're not reading anything.

  - "verify" requires a repo, which I wouldn't have expected, but I
    guess it's because we probably unbundle under the hood to walk.
    Anyway, it gets the ordering right here and checks the repo before
    opening the bundle.

  - list-heads doesn't require a repo, and segfaults. So it really does
    need some kind of detection or default to know which hash to use.

-Peff
