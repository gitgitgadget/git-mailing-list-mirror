Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382515AD9
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 07:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314455; cv=none; b=i0h13HDWMTFUnzkc/76It6Sntj2/8mCirJD1Ywy0fVEwNMN0dTGWiapuFyZ2bQoxxpjiXOEdYhQBlB9IHihY3fA29VwgBLBW6wUKdeDO8U9InAqT5cEGejfXLJ3WCB655HUKEkjfY99s89voVCvx910D2HbyhWKEtxg2/HzgRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314455; c=relaxed/simple;
	bh=9VbXXidcSZA19eF0oXzNuLIBqsBqklaQFnHHBVuJByk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QpOMEVOrYWy2EL6+6FRJAXW4DyK6yu5L/631mVr86SqvrPc6D7Xct7ilZB/F9bWUbnLlSnTNU0p5jXtpcAFrjZBU0/ZQRd87XN+IfMFwkoN1EDqdRMgsnXKAa0Pl/9yycBbNIcOLoJ1acrdUvJXg4IWnrqw3JJBxU4SBlCj9s2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 30286 invoked by uid 109); 13 Mar 2024 07:20:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 13 Mar 2024 07:20:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4827 invoked by uid 111); 13 Mar 2024 07:20:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 Mar 2024 03:20:57 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 13 Mar 2024 03:20:52 -0400
From: Jeff King <peff@peff.net>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: t0032 fails on NFS mounts
Message-ID: <20240313072052.GC125150@coredump.intra.peff.net>
References: <ZfBwZTL9zqDsac5m@manet.1015granger.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfBwZTL9zqDsac5m@manet.1015granger.net>

+cc Patrick for reftable

On Tue, Mar 12, 2024 at 11:10:29AM -0400, Chuck Lever wrote:

> Unit test t0032 fails when run on an NFS mount:
> 
> [vagrant@cel t]$ ./t0032-reftable-unittest.sh 
> not ok 1 - unittests
> #	
> #		TMPDIR=$(pwd) && export TMPDIR &&
> #		test-tool reftable
> #	
> # failed 1 among 1 test(s)
> 1..1

The output for this test script is particularly unhelpful because it's
not using our test harness at all, but just running a bunch of internal
tests using a single program.

Running with "-v" should give more details about what's failing.

I set up a basic loopback server like:

  mkdir /mnt/{server,client}
  exportfs -o rw,sync 127.0.0.1:/mnt/server
  mount -t nfs 127.0.0.1:/mnt/server /mnt/client

and then ran:

  ./t0032-reftable-unittest.sh --root=/mnt/client -v

Looks like it fails at:

  running test_reftable_stack_compaction_concurrent_clean
  reftable/stack_test.c: 1063: failed assertion count_dir_entries(dir) == 2
  Aborted

> v2.43.2 seems to work OK.

For me, too. Bisecting shows the problem appearing in 4f36b8597c
(reftable/stack: fix race in up-to-date check, 2024-01-18).

-Peff

PS That test seems to run ~20x slower on NFS versus directly on ext4.
   I'd expect a little overhead, but that's quite a bit.
