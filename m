Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9361DF27C
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736294211; cv=none; b=Cdb7noLlhOgGph9UzFoppC5opca0xtsh3sT9F1yY3LSGMh997MffKAQv6doJflj4CL6kV3TU8KMfqa7UZOukHdlQeO2G/N2UZC4bWHWSZIq51bVWJdJAg3sSporzuymLmaDhaZSVr+45fUJovwdBm9xxrWlnpIQNpYgmyo+8+Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736294211; c=relaxed/simple;
	bh=SFL0oVSbJpygefofTKXU5IoQig9LXzfkJVl1oYq2LXA=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=AsUi28M9aYlBkLPY59QBr+V1mp1wee05DanUMRGaJuWEf8dSL0PUTBKMzbMLwFo4uAkSvmm76KzdfDf2lEwhlu9tF6RsHaEYrK8BB2PODfxEUKAIMPs4RYX1Yp5SNhvlfCv9W9EF3THvhuKXKe8XzjefhcdC0Kt/LSYxaXyXhWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 507Nuhvo1623148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 23:56:44 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im> <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
Subject: RE: [PATCH 2/2] reftable/stack: accept insecure random bytes
Date: Tue, 7 Jan 2025 18:56:38 -0500
Organization: Nexbridge Inc.
Message-ID: <00ad01db615f$ce9b6740$6bd235c0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKra1ik1fhxhiR8lx9L1yKHV+swtwKZ2O1MsVcZoYA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250107-4, 1/7/2025), Outbound message
X-Antivirus-Status: Clean



>-----Original Message-----
>From: Patrick Steinhardt <ps@pks.im>
>Sent: January 7, 2025 10:27 AM
>To: git@vger.kernel.org
>Cc: Randall S. Becker <randall.becker@nexbridge.ca>
>Subject: [PATCH 2/2] reftable/stack: accept insecure random bytes
>
>The reftable library uses randomness in two call paths:
>
>  - When reading a stack in case some of the referenced tables
>    disappears. The randomness is used to delay the next read by a
>    couple of milliseconds.
>
>  - When writing a new table, where the randomness gets appended to the
>    table name (e.g. "0x000000000001-0x000000000002-0b1d8ddf.ref").
>
>In neither of these cases do we need strong randomness.
>
>Unfortunately though, we have observed test failures caused by the =
former case. In
>t0610 we have a test that spawns a 100 processes at once, all of which =
try to write
>a new table to the stack. And given that all of the processes will =
require
>randomness, it can happen that these processes make the entropy pool =
run dry,
>which will then cause us to
>die:
>
>    + test_seq 100
>    + printf %s commit\trefs/heads/branch-%s\n
>    68d032e9edd3481ac96382786ececc37ec28709e 1
>    + printf %s commit\trefs/heads/branch-%s\n
>    68d032e9edd3481ac96382786ececc37ec28709e 2
>    ...
>    + git update-ref refs/heads/branch-98 HEAD
>    + git update-ref refs/heads/branch-97 HEAD
>    + git update-ref refs/heads/branch-99 HEAD
>    + git update-ref refs/heads/branch-100 HEAD
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>    fatal: unable to get random bytes
>
>The report was for NonStop, which uses OpenSSL as the backend for =
randomness.
>In the preceding commit we have adapted that backend to also return =
randomness
>in case the entropy pool is empty and the caller passes the
>`CSPRNG_BYTES_INSECURE` flag. Do so to fix the issue.
>
>Reported-by: Randall S. Becker <rsbecker@nexbridge.com>
>Signed-off-by: Patrick Steinhardt <ps@pks.im>
>---
> reftable/stack.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/reftable/stack.c b/reftable/stack.c index
>6d0aa774e7e29d5366ed55df19725944f8eef792..572a74e00f9ed6040534e060
>652e72c26641749d 100644
>--- a/reftable/stack.c
>+++ b/reftable/stack.c
>@@ -493,7 +493,7 @@ static int reftable_stack_reload_maybe_reuse(struct
>reftable_stack *st,
> 		close(fd);
> 		fd =3D -1;
>
>-		delay =3D delay + (delay * rand()) / RAND_MAX + 1;
>+		delay =3D delay + (delay * git_rand(CSPRNG_BYTES_INSECURE)) /
>+UINT32_MAX + 1;
> 		sleep_millisec(delay);
> 	}
>
>@@ -659,7 +659,7 @@ int reftable_stack_add(struct reftable_stack *st,  =
static int
>format_name(struct reftable_buf *dest, uint64_t min, uint64_t max)  {
> 	char buf[100];
>-	uint32_t rnd =3D (uint32_t)git_rand(0);
>+	uint32_t rnd =3D git_rand(CSPRNG_BYTES_INSECURE);
> 	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
> 		 min, max, rnd);
> 	reftable_buf_reset(dest);
>
>--
>2.48.0.rc1.245.gb3e6e7acbc.dirty

The tests that are all impacted on ia64 (using PRNGD) are:

t0610-reftable-basics
t1092-sparse-checkout-compatibility
t1300-config
t1404-update-ref-errors
t1410-reflog
t1414-reflog-walk
t1415-worktree-refs
t1450-fsck
t1460-refs-migrate
t1500-rev-parse
t2006-checkout-index-basic
t2009-checkout-statinfo
t2013-checkout-submodule
t2017-checkout-orphan
t2030-unresolve-info
t2400-worktree-add

Everything passes on x86.

