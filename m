Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42211FF60E
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729264896; cv=none; b=XmmWvVoFWM7f0uIUZC09qlaPbjdwL2OQYUhOO2HdDBZCda41c5s9T5DpVT8ePIbNhCJY5ZLJvQrDFnYygldwaqu0rtSiaAibHuL+UH1aXjL/6SSBSChvqiERkspcOEhtmDpmLAGVhbAYGOo9oJGGlwy6pTES4NmTp0O7Yxke8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729264896; c=relaxed/simple;
	bh=iVyV7+bafZfGAFFT9uugnVlqBNLwmG8V/mEeGbvLC5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6nYmM/+lLUFO/JrVlrfdaGJY6V4Z0ArFWsD+69g1+YwRhBq9x0QW0POOMU7wUdBGifIuf6R2ANjqITK7SxYqGy2cGZ8gr/7/vkxNyU3m4OySyTGduNUl7izgsdV4UEGuDmdB1QyoDyaVcqlonT/Mstzj3iyAmcnzXnyHgxRUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kY4ryQax; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kY4ryQax"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1729264889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4QX+okrQl2F1PMNKRckuvcdeUgpqui6278bSwxLAyq4=;
	b=kY4ryQaxCLXfpCW/E6a1vGH72DEOlDbCSH7WnSG3p9OmSRIILmAy0mCtF1VBwKQGsNQdgN
	qqLJs7nyRCCdJHdQweiWTk4cbm6dkw8ZrL2Yg8HTYanB9okXwEbVkF4kdA5YZFMEUKYWhX
	OjWy8ICdDReY2F4cf+yGNl8VLoFt5mo=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Ed Reel <edreel@gmail.com>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/3] Makefile: extract script to generate clar
 declarations
In-Reply-To: <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>
References: <CAGjHeYfyH+cOMYYYHnFR+Vu9T+RbmzO1SpB_-kbmBSf1DitJhA@mail.gmail.com>
 <cover.1728985514.git.ps@pks.im>
 <7a619677c7af6ba8213a36208e20ab75c4318e38.1728985514.git.ps@pks.im>
Date: Fri, 18 Oct 2024 17:21:17 +0200
Message-ID: <871q0dcu8i.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Extract the script to generate function declarations for the clar unit
> testing framework into a standalone script. This is done such that we
> can reuse it in other build systems.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Makefile                            |  4 +---
>  t/unit-tests/generate-clar-decls.sh | 16 ++++++++++++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
>  create mode 100755 t/unit-tests/generate-clar-decls.sh
>
> diff --git a/Makefile b/Makefile
> index feeed6f9321..87b86c5be1a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3904,9 +3904,7 @@ GIT-TEST-SUITES: FORCE
>              fi
>  
>  $(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
> -	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
> -		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
> -	done >$@
> +	$(QUIET_GEN)$(SHELL_PATH) $(UNIT_TEST_DIR)/generate-clar-decls.sh "$@" $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES))
>  $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
>  	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
>  $(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
> diff --git a/t/unit-tests/generate-clar-decls.sh b/t/unit-tests/generate-clar-decls.sh
> new file mode 100755
> index 00000000000..81da732917a
> --- /dev/null
> +++ b/t/unit-tests/generate-clar-decls.sh
> @@ -0,0 +1,16 @@
> +#!/bin/sh
> +
> +if test $# -lt 2
> +then
> +	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
> +	exit 1
> +fi
> +
> +OUTPUT="$1"
> +shift
> +
> +for suite in "$@"
> +do
> +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||

In the Makefile the first `suite` was wrapped in curly braces. And I
think we need to keep them in this script as well. I noticed because I
was reviewing this code in my editor I've noticed it highlights
"source__" as the variable name. You can see what happens if you add
`set -x` to the top of the script:

    $ make t/unit-tests/clar-decls.h V=1
    /bin/sh t/unit-tests/generate-clar-decls.sh "t/unit-tests/clar-decls.h" t/unit-tests/ctype.c t/unit-tests/strvec.c
    + test 3 -lt 2
    + OUTPUT=t/unit-tests/clar-decls.h
    + shift
    + for suite in "$@"
    + sed -ne 's/^\(void test_[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p' t/unit-tests/ctype.c
    + for suite in "$@"
    + sed -ne 's/^\(void test_[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p' t/unit-tests/strvec.c

So it seems the script currently works "by accident".

You should replace the first $suite with something like:

    $(basename $suite .c)

One other suggestion, and feel free to disagree. What do you think about
replacing the `$(patsubst ...)` in the recipe to `$(filter %.c,$^)`?

--
Toon

