Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B91898EE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553943; cv=none; b=FOD1J6kmfGGEzLFgD18yaa86+hU38i9RsM2KXt8BWtcoxQqmu6Vg9/kVZvhkdvSSANZ9Vxhxd1UKQppKWh9u8hkdg0cSuJH8u3b8mCWXUm6b8ixwnzlpv6hfrTeuj76cXB+phMxrFHVJ0lQOzOrSsoFVy8TP68LLikM1UAvwGvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553943; c=relaxed/simple;
	bh=SokajMYtRXtTUjN2txSMBa6R+lsRlmgxec4ox2tgFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEjw84MLFIiLD4vbU88Gi7o5USck9bYOwt3PJPxXDWYfvRZQ9lBmPfvnrNUxDYRjK8imEO5eGII9S4IHUDNrI4OrnC8zj5U0X308msV7Ev8dG0wq8TbYREAj3InLRwhPvlX/OXNqqBRYumoVUv8LSz9Rza+4oYN3CaGiFiUeS20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4682 invoked by uid 109); 13 Aug 2024 12:59:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 12:59:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6664 invoked by uid 111); 13 Aug 2024 12:59:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 08:59:00 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 08:59:00 -0400
From: Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] tests: drop use of 'tee' that hides exit status
Message-ID: <20240813125900.GD968816@coredump.intra.peff.net>
References: <xmqq4j7uhfvm.fsf@gitster.g>
 <f5d0510c-d455-5e80-08b7-e08c81df4adb@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d0510c-d455-5e80-08b7-e08c81df4adb@gmx.de>

On Tue, Aug 13, 2024 at 02:22:11PM +0200, Johannes Schindelin wrote:

> >  test_expect_success 'a/b vs a, plus c/d case test.' '
> >  	read_tree_u_must_succeed -u -m "$treeH" "$treeM" &&
> > -	git ls-files --stage | tee >treeMcheck.out &&
> > +	git ls-files --stage >treeMcheck.out &&
> 
> While this obviously fixes the bug where the test case was incorrectly
> allowed to continue after a failing `git ls-files --stage` call, I will
> note that I interpret the intention of the `| tee` as showing the output
> in the logs in addition to redirecting it to a file for the benefit of
> additional checks in the same test case.
> 
> I know that I investigate CI failures a lot more than most, therefore many
> might disagree that removing such output makes future debugging
> potentially a lot harder.

I also look at a lot of CI failures. IMHO this isn't that big an issue.

If "ls-files" succeeds, then the file is fed to test_cmp(), where we
report any differences from the expected output. I find this way more
useful than a dump of the file.

If "ls-files" fails, we won't see the output. But we will see its
stderr, which is probably the more useful stream. Though for cases where
we redirect stderr, I do think it can sometimes be confusing (this is
just not one of those).

But even in that case, we tar up the trash directory of the failing
scripts and save them separately. So the output is still recorded, but
in a less expensive way than dumping it into the log (i.e., it is only
when we see a failure).

Sometimes that isn't sufficient, if later tests overwrite the logs. I
usually run with "--immediate" when locally debugging tests. And I've
very occasionally done the same with CI, pushing up a commit on top to
customize the test environment.

I do wonder if "--immediate" mode would be a better default for CI,
since we expect things to pass. But it it comes at the cost of giving no
information about subsequent tests. So I think it really depends on
whether you are debugging tests you just wrote, or chasing down a flake
or other issue introduced in a script that was not recently touched.

I guess we could record the trash directory state for every failing test
within a script. That would need some cooperation from test-lib.sh, but
probably wouldn't be too hard.

-Peff
