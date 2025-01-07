Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60F1EF08A
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264276; cv=none; b=iV8hh3S7fVThWpgq4Xie3CfQezIUT80xRXvxaFb3kfFgo006FT23wMoEcGi0s6wcIibkmM622UwIUOY11JErgGeWp7aWfDRME17PTyBRnMxOhTUQW4JHVERHH5t7t15lZwnepCC11dheCrC8N7UKdywDLDkKa5b0/9RHJhs+aoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264276; c=relaxed/simple;
	bh=YQLDE2xzws7GYpVmZgK23uKzoqVaVxCPDFkCyoaGtso=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRK/7sojfN3fMlFA5Xx5TiWAJZcaJjeePA/L1PeijDuTgQY0AKnSjASbJau1ZHbarJt4G/K3yWFjDIp48fX8c9UXJfI6AaA3Ikned2ibHM7SOqeIpBot8EJdnYU8JpE8wRu6Nb7eezBI5wuWgpXrrXO41mtOefsd6TIiSXLydqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 507Fbkuk1506295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 7 Jan 2025 15:37:46 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>
Cc: "'Randall S. Becker'" <randall.becker@nexbridge.ca>
References: <20250107-b4-pks-reftable-csprng-v1-0-6109a54a8756@pks.im> <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
In-Reply-To: <20250107-b4-pks-reftable-csprng-v1-2-6109a54a8756@pks.im>
Subject: RE: [PATCH 2/2] reftable/stack: accept insecure random bytes
Date: Tue, 7 Jan 2025 10:37:41 -0500
Organization: Nexbridge Inc.
Message-ID: <005d01db611a$19ed55f0$4dc801d0$@nexbridge.com>
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
Thread-Index: AQKra1ik1fhxhiR8lx9L1yKHV+swtwKZ2O1MsVaOVXA=
Content-Language: en-ca
X-Antivirus: Norton (VPS 250107-2, 1/7/2025), Outbound message
X-Antivirus-Status: Clean

On January 7, 2025 10:27 AM, Patrick Steinhardt wrote:
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

I think this is a good catch. We are seeing other tests fail similarly =
through this path. I will retest rc3
on both platforms since we cannot exhaust randomness on x86 using the =
hardware randomizer
inside OpenSSL.

