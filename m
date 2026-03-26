Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2999939099C
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 04:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774498112; cv=none; b=cvvbmU8AVT7ziw/XDNs77JL8CjtXraIcpPmy5L+42aMRKUYjLMd+GvgPdkRxAK/00dSGT00ShDQ9MBtPrkGEKidhSTfxXoXMwYuS5EoyYQJcjHg6OPi67s9RX8Gjn6fo2EzP0Y/va5N8HwbPE1C1UgniZOFUAhjBeOOg88Vc5V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774498112; c=relaxed/simple;
	bh=GHd6xAQ/BoFnbqns34zQl4CLG3w12B3cAam/sdGE/UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+0gv2lHIiEKMF8gIQOAoGvIKYOCHq8rgXz42kSN1opeo8lI6hFEMZTgX2tQgyaHHwQ9fZlSRgMxp3QrcIHUbHbH0WyxoR6rR+EPP7ukCnzg7EuxsMSX3CX2g4ImzHQ0K5KshT7/a4PiBUpdKdd2y//DydBEo4485qI2g9nbSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dZCmMHJ5; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dZCmMHJ5"
Received: (qmail 147180 invoked by uid 106); 26 Mar 2026 04:08:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=GHd6xAQ/BoFnbqns34zQl4CLG3w12B3cAam/sdGE/UE=; b=dZCmMHJ5ZIla+tzmcOBcvvWFUE5CE6XDEDQjhEfxbhjMRopYibRsoaqOzlyIexDj5LU+IMDg5DHVebtt1N+qKG6Dg7nbVv4vrJzf6lbLezDPWKZsOkufv0hhI86VALZhVkocfnsH5dFoQFWwHbZd6/Nt9K82rkX5KAND/CQmpXoVASxDMP8DG+x9XE4+StFvYSU+/qwzS1i+mlgECN/bL2+/vjKrO8pptllKmIJqZFlh7d751nQsWOPppf+TlSk0ruSiFnsyJTc1QaY1pnouHny7knX+8/ybW/NyKcoGGRe0FvGTtg7k4P1mha5SEofXr97KINLVa/ao9gCHnlRljQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Mar 2026 04:08:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 199990 invoked by uid 111); 26 Mar 2026 04:08:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2026 00:08:28 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Mar 2026 00:08:28 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/11] test-lib: catch misspelt 'test_expect_successo'
Message-ID: <20260326040828.GA686242@coredump.intra.peff.net>
References: <20260325062114.2067946-1-gitster@pobox.com>
 <20260325062114.2067946-2-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260325062114.2067946-2-gitster@pobox.com>

On Tue, Mar 24, 2026 at 11:21:04PM -0700, Junio C Hamano wrote:

>  # Test the binaries we have just built.  The tests are kept in
>  # t/ subdirectory and are run in 'trash directory' subdirectory.
> +
> +set -e

This causes failures in t0005 and t3600 with dash, but not bash.

It looks like the suppression of "-e" on the left-hand-side of an && is
different when there is command substitution in play:

  $ dash -c 'OUT=$( ((yes; echo $? 1>&3) | :) 3>&1) && echo out=$OUT'
  out=141

  $ dash -ec 'OUT=$( ((yes; echo $? 1>&3) | :) 3>&1) && echo out=$OUT'
  out=

whereas with bash, both produce 141.

The idea is that $OUT becomes the exit status of "yes" here, and we are
expecting to see SIGPIPE. With "-e" in effect, the failing "yes" will
terminate before we echo $?.

To demonstrate the effect as we build it up from smaller pieces:

  # produces 141, SIGPIPE from yes
  dash -c '((yes; echo $? 1>&3) | :) 3>&1'

  # produces nothing, "-e" kills subshell after yes fails
  dash -ec '((yes; echo $? 1>&3) | :) 3>&1'

  # produces 141 (and "ok"), as the && suppresses -e
  dash -ec '((yes; echo $? 1>&3) | :) 3>&1 && echo ok'

  # produces "out="; the $() makes us forget that we're on LHS of &&
  dash -ec 'OUT=$( ((yes; echo $? 1>&3) | :) 3>&1) && echo out=$OUT'

The actual failing code in t0005 is:

  OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
  test_match_signal 13 "$OUT"

and the one in t3600 is similar. I guess you could do:

diff --git a/t/t0005-signals.sh b/t/t0005-signals.sh
index afba0fc3fc..0bf1f16750 100755
--- a/t/t0005-signals.sh
+++ b/t/t0005-signals.sh
@@ -42,7 +42,7 @@ test_expect_success 'create blob' '
 '
 
 test_expect_success !MINGW 'a constipated git dies with SIGPIPE' '
-	OUT=$( ((large_git; echo $? 1>&3) | :) 3>&1 ) &&
+	OUT=$( ((large_git || echo $? 1>&3) | :) 3>&1 ) &&
 	test_match_signal 13 "$OUT"
 '
 

That neglects to echo $? when large_git surprisingly succeeds, but that
would mean $OUT is empty, which would cause the test to (correctly)
fail. I kind of hate it, though.

-Peff
