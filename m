Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAFA14A087
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 20:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722888924; cv=none; b=dIZHKYA/qhZPSRXRgfNiHa5CippNJ3bHk6suQzBYEPc+TD8VVMZAGmjRMfoiJbP6VKe9uHPQi6DzrCUZnsYJ2ZmZGmx2pBr+fhBc8UP3Ha8GDJxv/bcKLoL/KwGG8vc4IU5Jq3K+WDodMkF9Bcu4negYdpjMQ0blMhuEp0+GZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722888924; c=relaxed/simple;
	bh=Qb4rjHj7kcOSXrmUeRJzTJR3scVr1JLT3+gwGKZb//E=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=eAVisJfEJF8RTnAM7MJvSpmmAxcIMEH5860cUDc51VllM298mUj5y3jWBie8AR5RwMDZYHLrWLgkdYAQltd0bp9aEdb7tusBCP1k+ALQfLM18njSgm/O9rJkY0YUXpGsanKVtR8Q0IqdwmoyOA14xJJpMiOzNkdSezax0QtEZOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 475KF7qr011456
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 20:15:07 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>, <git@vger.kernel.org>
Cc: "'Elijah Newren'" <newren@gmail.com>, "'Jeff King'" <peff@peff.net>,
        "'Junio C Hamano'" <gitster@pobox.com>
References: <95cdc30bad38f464b37e87d78f38e1d91c9e083b.1722886630.git.me@ttaylorr.com>
In-Reply-To: <95cdc30bad38f464b37e87d78f38e1d91c9e083b.1722886630.git.me@ttaylorr.com>
Subject: RE: [PATCH] t/t7704-repack-cruft.sh: avoid failures during long-running tests
Date: Mon, 5 Aug 2024 16:15:01 -0400
Organization: Nexbridge Inc.
Message-ID: <06b601dae774$2a9373a0$7fba5ae0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFs/TnSCFS4z9rgcVmU+xpxj6ozgrL07bSQ

On Monday, August 5, 2024 3:37 PM, Taylor Blau wrote:
>On systems where running t7704.09 takes longer than 10 seconds, the =
test can fail.
>
>The test works by doing the following:
>
>  - First write three unreachable objects, backdating the mtime for a
>    single object ($foo) which we expect to prune.
>
>  - Repack the repository into a pack containing reachable objects, and
>    another three cruft packs, each containing one of the objects
>    written in the previous step.
>
>  - Backdate the mtimes of the cruft pack *.mtimes files themselves.
>    (Note that this does not affect what is pruned further down in the
>    test, but is done to ensure that the cruft packs are rewritten
>    during that step).
>
>  - Then repack with --cruft-expiration=3D10.seconds.ago, expecting to
>    prune one of the three unreachable objects written in the first
>    step.
>
>  - Assert that the surviving cruft packs were rewritten, object $foo =
is
>    pruned, and unreachable objects $bar, and $baz remain in the
>    repository.
>
>If longer than 10 seconds pass between writing the three unreachable =
objects (the
>first step) and the "git repack --cruft" (the fourth step), we will =
mistakenly prune
>more objects than expected, causing the test to fail.
>
>The $foo object which we expect to prune has its mtime set back to
>10,000 seconds relative to the current time, but we prune it with a =
cutoff of
>10.seconds.ago.
>
>Instead, set the cutoff to be 1,000 seconds to give the test much =
longer time to run
>without failing. This helps platforms where running individual tests =
can perform
>slowly, on my machine this test runs much more quickly:
>
>    $ hyperfine './t7704-repack-cruft.sh --run=3D9'
>    Benchmark 1: ./t7704-repack-cruft.sh --run=3D9
>      Time (mean =C2=B1 =CF=83):     647.4 ms =C2=B1  30.7 ms    [User: =
528.5 ms, System: 124.1 ms]
>      Range (min =E2=80=A6 max):   594.1 ms =E2=80=A6 696.5 ms    10 =
runs
>
>Reported-by: Randall Becker <randall.becker@nexbridge.com>
>Signed-off-by: Taylor Blau <me@ttaylorr.com>
>---
> t/t7704-repack-cruft.sh | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh index
>71e1ef3a10..959e6e2648 100755
>--- a/t/t7704-repack-cruft.sh
>+++ b/t/t7704-repack-cruft.sh
>@@ -330,7 +330,7 @@ test_expect_success '--max-cruft-size with pruning' =
'
> 		# repack (and prune) with a --max-cruft-size to ensure
> 		# that we appropriately split the resulting set of packs
> 		git repack -d --cruft --max-cruft-size=3D1M \
>-			--cruft-expiration=3D10.seconds.ago &&
>+			--cruft-expiration=3D1000.seconds.ago &&
> 		ls $packdir/pack-*.mtimes | sort >cruft.after &&
>
> 		for cruft in $(cat cruft.after)
>
>base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
>--
>2.46.0.46.g406f326d27.dirty

LGTM. Thank you.

