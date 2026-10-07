Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7092492E2E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 12:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791375470; cv=none; b=BUTaZnvzNR1t2K8wHwYwwQPTeIOCYv8EzOA6JkA4L/Xt86tF7eo695Ivw8DbK6Hj/zVm437fMbrORSEKsW6uucCsPHvSA4rHwVLdsITlk58klKBmj1rEEdNcSwdq14NJsb6bV5/aH3pDODYRH+jw5n3kbov6SyrV81lJUCIFrm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791375470; c=relaxed/simple;
	bh=NA9vKOQt5TJ/cBcgyJsqwkw0QIsJXtSdd+oFdg0slfk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZZyACIH7+tigLkInuToEQu7vzTx8Y77vz9AZDVM1F0uVghe7GIcs0vOviVJshQEkvQD839lSFmA+q9rcciIyCvpEBjFvrwZ/pxTUrC6J3SCiNoSFik8V3xrM8z+JInQt4QPY2TFZ/wJ/c3lZZR5LaeRf58kSbvG0XTrrWdIE2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=jeP97pHg; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="jeP97pHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791375452; x=1791980252;
	i=johannes.schindelin@gmx.de;
	bh=lCCX+EG8DSzEGz4m3NWSnUq7P1i8PqCsQIaqub+6an0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jeP97pHgCeueTOw2zDKXpmxD4UB5uDmMMvOahZAe4zNsivCPb6ZZl1tJcJXXZeqN
	 QAkfCPSoN8XX3FQf+Os7+7jTbey2Zeh0QUgMyV7T2ZaD62Eiu5WpVHmjU9PMxwqzW
	 oBxpfQhv/naXpZsP0+uNz4gCFJhKGZx/YRfw/j/nUAs69TbSFkpGDXzV2b4wrf2ru
	 GIdLynxjm+m1S5ugimTM3Y9wLBORiotyircN1uiKQyImMBBmZYTIzl4Qw+u0YONEQ
	 Ul+NPk2GxipcPBR8uc6d8qsbkL73xQbsC/iaWf0xRs/HBA0YUlxlnyfE7+56Ov8ej
	 2orbLvQnQJHP2dG/xA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1wry4k2rSc-00a0st; Wed, 07
 Oct 2026 14:17:32 +0200
Date: Wed, 7 Oct 2026 14:17:31 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Chacon <scott@gitbutler.net>
cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] sha1dc-accel: add a block loop for sha1dc's
 SHA1_CTX
In-Reply-To: <20260929112544.86511-2-scott@gitbutler.net>
Message-ID: <f9138fbc-be3b-36eb-1efb-bedeca22f15b@gmx.de>
References: <20260929112544.86511-1-scott@gitbutler.net> <20260929112544.86511-2-scott@gitbutler.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:DwdzHGZhwv5m2vRkmfVVOizg8fh3lIE0YRXQvLNKKR5TZ8K9K3s
 A3TrKOccPUroDKF0McU5N7YmOC6NFp7CcEBD9+HnG+FEhM/vP0na5xEnYdrOPIujvJF4/3s
 FJelc5N0AbqEcvw93mQ3MN+gXRxhLqYYOB12Fskc2hpV4PCE9g83uKMhnrluaGGV/72Yj9Y
 3XcTU0QHxsMe1H9Aw8tiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MWFlL3LeptA=;1cIOdbl3lyYwwDCtdCxwC8lnVIh
 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

Hi Scott,

On Tue, 29 Sep 2026, Scott Chacon wrote:

> diff --git a/sha1dc-accel/sha1.c b/sha1dc-accel/sha1.c
> new file mode 100644
> index 0000000000..fd75289997
> --- /dev/null
> +++ b/sha1dc-accel/sha1.c
> @@ -0,0 +1,434 @@
> +/*
> + * SHA-1 with collision detection.
> + *
> + * This computes exactly what sha1dc/ computes: the SHA-1 digest of the
> + * input, and whether any block of it looks like one half of a collision
> + * made by one of the 32 known disturbance vectors (DVs) of Stevens and
> + * Shumow. It works on sha1dc's SHA1_CTX, and uses its table of DVs, but
> + * has its own block loop, which gives the following patches room to
> + * follow the approach of the "sha1dc" Rust crate by Sam Reis
> + * (https://github.com/srijs/sha1dc), which gitoxide uses.
> + *
> + * Each block is compressed by a "backend", which also spills the expanded
> + * message schedule, and the two intermediate states that recompression
> + * starts from (at steps 58 and 65). The unavoidable-bitconditions (UBC)
> + * filter then rules out about 95% of blocks; the rest are recompressed,
> + * once for each DV the filter could not rule out.
> + */
> +
> +#include "../git-compat-util.h"
> +#include "../sha1dc_git.h"
> +#if defined(DC_SHA1_SUBMODULE)
> +#include "../sha1collisiondetection/lib/ubc_check.h"
> +#else
> +#include "../sha1dc/ubc_check.h"
> +#endif
> +#include "sha1.h"
> +#include "internal.h"
> +
> +#define ROL(x, n) (((x) << (n)) | ((x) >> (32 - (n))))
> +
> +#define F_CH(b, c, d) ((d) ^ ((b) & ((c) ^ (d))))
> +#define F_PARITY(b, c, d) ((b) ^ (c) ^ (d))
> +#define F_MAJ(b, c, d) (((b) & (c)) | ((d) & ((b) | (c))))
> +
> +#define K0 0x5A827999
> +#define K1 0x6ED9EBA1
> +#define K2 0x8F1BBCDC
> +#define K3 0xCA62C1D6
> +

The following lines, including the definition of `compress_portable()`,
duplicate the functionality implemented in `sha1_compression_states()` in
sha1dc/. Maybe we could use that latter function here, too, to make the
code DRYer?

> +/*
> + * One step, on names that rotate: after it, (e, a, b, c, d) are the new
> + * (a, b, c, d, e).
> + */
> +#define STEP(f, k, a, b, c, d, e, x) \
> +	do { \
> +		e += ROL(a, 5) + f(b, c, d) + (k) + (x); \
> +		b = ROL(b, 30); \
> +	} while (0)
> +
> +#define LOAD(t) (w[t] = get_be32(block + 4 * (t)))
> +#define EXPAND(t) (w[t] = ROL(w[(t) - 3] ^ w[(t) - 8] ^ w[(t) - 14] ^ w[(t) - 16], 1))
> +
> +#define FIVE_LOAD(f, k, a, b, c, d, e, t) \
> +	do { \
> +		STEP(f, k, a, b, c, d, e, LOAD(t)); \
> +		STEP(f, k, e, a, b, c, d, LOAD((t) + 1)); \
> +		STEP(f, k, d, e, a, b, c, LOAD((t) + 2)); \
> +		STEP(f, k, c, d, e, a, b, LOAD((t) + 3)); \
> +		STEP(f, k, b, c, d, e, a, LOAD((t) + 4)); \
> +	} while (0)
> +
> +#define FIVE_EXPAND(f, k, a, b, c, d, e, t) \
> +	do { \
> +		STEP(f, k, a, b, c, d, e, EXPAND(t)); \
> +		STEP(f, k, e, a, b, c, d, EXPAND((t) + 1)); \
> +		STEP(f, k, d, e, a, b, c, EXPAND((t) + 2)); \
> +		STEP(f, k, c, d, e, a, b, EXPAND((t) + 3)); \
> +		STEP(f, k, b, c, d, e, a, EXPAND((t) + 4)); \
> +	} while (0)
> +
> +/*
> + * The portable compression. Like the hardware ones it spills the schedule,
> + * but it writes the states at steps 58 and 65 directly, on the way past.
> + */
> +static void compress_portable(uint32_t ihv[5], const unsigned char *block,
> +			      uint32_t w[80], uint32_t state_58[5],
> +			      uint32_t state_65[5])
> +{
> +	uint32_t a = ihv[0], b = ihv[1], c = ihv[2], d = ihv[3], e = ihv[4];
> +
> +	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 0);
> +	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 5);
> +	FIVE_LOAD(F_CH, K0, a, b, c, d, e, 10);
> +	STEP(F_CH, K0, a, b, c, d, e, LOAD(15));
> +	STEP(F_CH, K0, e, a, b, c, d, EXPAND(16));
> +	STEP(F_CH, K0, d, e, a, b, c, EXPAND(17));
> +	STEP(F_CH, K0, c, d, e, a, b, EXPAND(18));
> +	STEP(F_CH, K0, b, c, d, e, a, EXPAND(19));
> +
> +	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 20);
> +	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 25);
> +	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 30);
> +	FIVE_EXPAND(F_PARITY, K1, a, b, c, d, e, 35);
> +
> +	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 40);
> +	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 45);
> +	FIVE_EXPAND(F_MAJ, K2, a, b, c, d, e, 50);
> +	STEP(F_MAJ, K2, a, b, c, d, e, EXPAND(55));
> +	STEP(F_MAJ, K2, e, a, b, c, d, EXPAND(56));
> +	STEP(F_MAJ, K2, d, e, a, b, c, EXPAND(57));
> +	state_58[0] = c;
> +	state_58[1] = d;
> +	state_58[2] = e;
> +	state_58[3] = a;
> +	state_58[4] = b;
> +	STEP(F_MAJ, K2, c, d, e, a, b, EXPAND(58));
> +	STEP(F_MAJ, K2, b, c, d, e, a, EXPAND(59));
> +
> +	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 60);
> +	state_65[0] = a;
> +	state_65[1] = b;
> +	state_65[2] = c;
> +	state_65[3] = d;
> +	state_65[4] = e;
> +	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 65);
> +	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 70);
> +	FIVE_EXPAND(F_PARITY, K3, a, b, c, d, e, 75);
> +
> +	ihv[0] += a;
> +	ihv[1] += b;
> +	ihv[2] += c;
> +	ihv[3] += d;
> +	ihv[4] += e;
> +}

Ciao,
Johannes
