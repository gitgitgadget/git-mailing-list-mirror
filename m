Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C678A1F5FF
	for <git@vger.kernel.org>; Sat,  8 Jun 2024 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717871878; cv=none; b=CsfBUpXzOu2ed7PHwNToeCR1UhlYS3RtRENj+arMdI/Q7Wi+R+6fJ1tm0/LDMcmnsF92un5Gtxwo9znaQXncFE+NVqxDASdVZHrPDXT8K3YAnhyOiLlRd9fpgaDMwsjufW8Y0hbievmTlY9T/ENwO1Kl+QY6F7mZkcp6rFlZ/18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717871878; c=relaxed/simple;
	bh=zT68Vgoiz2sXwkiHyYmpcvWEiWyETAkh+Ec1nT9nBl4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcSgvGm0YJvautTxM3I9oH+g1GGdzp2MwPhwoElnUowOkMLU+FPBBYnwRNGBAuedtZ32ugSXRwAur/IiBnrB0DaN8YaK1UygaHbwKlrGimNzNixvq0bxSIH3pBIosq4BKUjWVYTW1Q/9b+uMw7fOh4P9hjYD92iGc/iajTdhklQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Lb50/Rmb; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Lb50/Rmb"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 66ECC38CC8;
	Sat,  8 Jun 2024 14:37:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=zT68Vgoiz2sXwkiHyYmpcvWEi
	WyETAkh+Ec1nT9nBl4=; b=Lb50/RmbTco/s3CgNkaqEZ1pznOKPjsW2BLRR/IUX
	zLyKfT+tJ3H15WkDiut5aL3IQCMZAU9bw1JDByWCfE918j6r6bU9sGGoZnW9in16
	4Xs7ajOQXq8aONYA+bpW44C3CKamf1bywjCX/8HGWCeWoENBFeSjBpM4KOktLHkh
	WM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FB0638CC7;
	Sat,  8 Jun 2024 14:37:50 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C7CAA38CC6;
	Sat,  8 Jun 2024 14:37:49 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/4] __attribute__: trace2_region_enter_printf() is like "printf"
Date: Sat,  8 Jun 2024 11:37:44 -0700
Message-ID: <20240608183747.2084294-2-gitster@pobox.com>
X-Mailer: git-send-email 2.45.2-445-g1b76f06508
In-Reply-To: <20240608183747.2084294-1-gitster@pobox.com>
References: <20240608183747.2084294-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 3537203C-25C6-11EF-A55A-6488940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

The last part of the parameter list the function takes is like
parameters to printf. mark it as such.

An existing call that formats a value of type size_t using "%d" was
found by the compiler with the help with this annotation; fix it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 run-command.c | 3 ++-
 trace2.h      | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 1b821042b4..ec2c12e98b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1753,7 +1753,8 @@ void run_processes_parallel(const struct run_proces=
s_parallel_opts *opts)
=20
 	if (do_trace2)
 		trace2_region_enter_printf(tr2_category, tr2_label, NULL,
-					   "max:%d", opts->processes);
+					   "max:%"PRIuMAX,
+					   (uintmax_t)opts->processes);
=20
 	pp_init(&pp, opts, &pp_sig);
 	while (1) {
diff --git a/trace2.h b/trace2.h
index 1f0669bbd2..19e04bf040 100644
--- a/trace2.h
+++ b/trace2.h
@@ -390,6 +390,7 @@ void trace2_region_enter_printf_va_fl(const char *fil=
e, int line,
 	trace2_region_enter_printf_va_fl(__FILE__, __LINE__, (category), \
 					 (label), (repo), (fmt), (ap))
=20
+__attribute__((format (printf, 6, 7)))
 void trace2_region_enter_printf_fl(const char *file, int line,
 				   const char *category, const char *label,
 				   const struct repository *repo,
--=20
2.45.2-445-g1b76f06508

