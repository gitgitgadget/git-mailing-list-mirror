Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74B4B674
	for <git@vger.kernel.org>; Sun,  5 May 2024 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904407; cv=none; b=HvE38PIFx30+VCO7XBKZQm6BRAU/HwqTo0LUfIBB+HEwdvpvdUVp0NVh4QHfvpPqDrmeU26Y27IVUyzydRnwZPh7fVgvSZK05CRCzpmgnRvUErZPA+PlToj8600TiM7ZexAtqg1yjc5PQII9EMN2MPG2G5nWDsf9ggbhdAKqAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904407; c=relaxed/simple;
	bh=F3lwT5vzDo5DAoORjs7W/h6EUVoQ+pHygIbH8qvDqxQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=Sbpzi5wXfR/Q1pUS9Di4TkskUHKcM8bvXku9piEPwihD/VE2k+G9m54TfF23McawWf6v44BEFrZpjcSyq+3CD1QL2384/lZ3pWhAX/Oz3hZKgaGdIz8coCqICT1im0PvyAUaYAxFd80xuWcIkqBy1Edfm832Qh1anXj9yjBkbPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=DgrSeLAA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="DgrSeLAA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714904397; x=1715509197; i=l.s.r@web.de;
	bh=3QS3zchuBaFQ9GMVy3pA5IFCg9fNc/V9H1mcagxnVUM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DgrSeLAAFkCxxnG+XEEVgTdAYBo11GVOVKFhZUY7nkKfPddHND42li3dHOi5QNKu
	 CepNjlFuBoqwFkjkYtlfMt1uEqIvl+T/NyqxuolMAZIZqA7vJ09OR5wM0cGC6SSh3
	 +fDqcTzufilxTyubeLraSBxnZRQyF2i2TDdhFZCDejVtpVfenhU4kqUEBfsQo3hPM
	 4EkDLDKz6Y11ISmIKWDIhfsijNT7N+Mru1srnu4HFt5GmhjKyFZNPHOUapN6rQGh5
	 qarQ1EFcCLKnptgVqfx7vVrBrVYMWzrOOR1ue0iMDhFfX5BwvN9JTOUrJ56aq1eHQ
	 i8IfX1PniKRGeory7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.153.5]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5j5k-1s0n1L1cEc-007AGL; Sun, 05
 May 2024 12:19:57 +0200
Message-ID: <ac611156-71e5-40f9-bce7-220a874ea91a@web.de>
Date: Sun, 5 May 2024 12:19:56 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] diff: report unmerged paths as changes in run_diff_cmd()
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: German Lashevich <german.lashevich@gmail.com>, git@vger.kernel.org
References: <CACDhgro3KXD0O9ZdE1q46jmXE0O=vf-Z+ZX50WMqmRHAeowGAA@mail.gmail.com>
 <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>
In-Reply-To: <82561c70-ec33-41bf-b036-52310ffc1926@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v+KvzftgEy0tzyJWuzMLmBHTT/sGveK3IpjougB+X7XtwDPPQJo
 fJJJPaiyZ7ZKbirZlkFRTNW95LVJpKt4Os/jTIsTEnJJRyU2MHqaJxUAYyP4LvJxeUePnnC
 o0keVvxKQJMML52RpnR4EFx1iySAY3r8YQaV3CM2avTUeRpBxlrhhfPFdQzF5T4gKm7l+4M
 BOmpZDjD+7QTAsmocBIlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jqJiqjQxRMI=;Bg7MXLhUtnDZP2MMVM3o9HOjHNp
 gIYZ9nJU7B77P5lvL7To1ud3k9hK6y0JSQDFK0E9HraX1tEqDaRkA53uGaM+Z5XKKWKXlUjob
 eAK7xByCcLlOSAS8aTjvNEmJ4euM1a+dCUwgXqgds6DRKiLamXRmL/V68kOSeqLj9zCGWK7Na
 popGDYgzWnrhSauIyFlhYa3OthKcha0RSob2mOvhxZBoDlC+bN9D3ZFr0w7jReA5jge0QcPE5
 IoL2SV+KUh7ZFEWUmobEhQBc9/IsGd5uWJq9T88gQeW7oKQWbuj0EnshORbrVnmllf0CEzEIy
 FObgqjeZOAyr8ADzhpZ4s3Gh1nVPrQcPXN5Z3mzHbw/ISid/t4dy84rlNs9REjhhuwG6T2wTj
 bSPggUYipPW+TG32iXENkXXxrZR+ZCGJlX+AETU1VMhCp9Tl+27LC7aaVXE9BHPSCVzW7yf39
 zzyh4laQY1+Uj1I6hh5LZAR8aDpX+dokqzJf+8xrOUcli9IbCmhEB2mWgOep0+oFWJ6yTHnUB
 N+9NBCoVJwXtq/7TUIfeD8KUKaNV7J7DGcoivoGGFbMZx3GZpqgyQZzDTI6YMEfcj+ipX6l8G
 BA8lyGiZNLwt0IycuTdUFJphY9jzS8Rg+UZybma6p/0JKSHF6AufP35y3tuaiSsOy6+igF2bB
 AiCEIFd0m0XEBpeyqcBCDx6odS+LGS4od4cW2G6PX3hk3BnXPVqyZLm3HegeMQNZAC4TBO0cA
 w4RbbztT/5N+h6kGZgSbwgNVO8cUasIVt07Mdx8N+OTJ3pbFA9AflsX3PLjj2sU6ixdOOf/og
 CFKNLnXfMO3ACSCNdWiAEIm4yyifEhGFoOLEKdE+mdCg0=

You can ask the diff machinery to let the exit code indicate whether
there are changes, e.g. with --quiet.  It as two ways to calculate that
bit: The quick one assumes blobs with different hashes have different
content, and the more elaborate way actually compares the contents,
possibly applying transformations like ignoring whitespace.

The quick way considers an unmerged file to be a change and reports
exit code 1, which makes sense.

The slower path uses the struct diff_options member found_changes to
indicate whether the blobs differ even with the transformations applied.
It's not set for unmerged files, though, resulting in exit code 0.

Set found_changes in run_diff_cmd() for unmerged files, for a consistent
exit code of 1 if there's an unmerged file, regardless of whether
whitespace is ignored.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 diff.c                   | 1 +
 t/t4046-diff-unmerged.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/diff.c b/diff.c
index 108c187577..ded9ac70df 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -4555,6 +4555,7 @@ static void run_diff_cmd(const char *pgm,
 			     o, complete_rewrite);
 	} else {
 		fprintf(o->file, "* Unmerged path %s\n", name);
+		o->found_changes =3D 1;
 	}
 }

diff --git a/t/t4046-diff-unmerged.sh b/t/t4046-diff-unmerged.sh
index ffaf69335f..c606ee4c40 100755
=2D-- a/t/t4046-diff-unmerged.sh
+++ b/t/t4046-diff-unmerged.sh
@@ -96,4 +96,12 @@ test_expect_success 'diff --stat' '
 	test_cmp diff-stat.expect diff-stat.actual
 '

+test_expect_success 'diff --quiet' '
+	test_expect_code 1 git diff --cached --quiet
+'
+
+test_expect_success 'diff --quiet --ignore-all-space' '
+	test_expect_code 1 git diff --cached --quiet --ignore-all-space
+'
+
 test_done
=2D-
2.45.0
