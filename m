Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DFF13D503
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600653; cv=none; b=Ait9eH6fpR1i+G6Dy+dZ1++uGLwEqzi38p4r7A/NHiVv7fy8+VoRC4fbo6ivpS35pnyvJtbCg1v/16r1GpDafPtMIXpCcRCTCwrFg4GUqUuH2NO3tPg2nSRZ9JnMJWtRghykaV5sjOgSGLL901p8/q6JAxJnOVXieYoKpIgOnfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600653; c=relaxed/simple;
	bh=aRhY8ZKQSSceMhqDPsks+t8+MiE/suLbNyLAvHmjFf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl672EKo/7C6ffoKYSsRwZTIKmTxh2ZppC7V9GUGrhNRBQuUhF3fCwKDFp8pl62+8wjO4dylcPVinsEgIQUc6G9b8F4W+s6ek9amAiCm0L1+p3PgX5vCoq5KL1iVWPF/si3oAIBBfcJ2nzKhBRmtvrt1krfGRoU0s0FYRrhP7cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1665 invoked by uid 109); 10 Jul 2024 08:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10440 invoked by uid 111); 10 Jul 2024 08:37:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:37:28 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:37:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 4/9] chainlint.pl: force CRLF conversion when opening
 input files
Message-ID: <20240710083730.GD2060601@coredump.intra.peff.net>
References: <20240710083416.GA2060328@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240710083416.GA2060328@coredump.intra.peff.net>

The lexer in chainlint.pl can't handle CRLF line endings; it complains
about an internal error in scan_token() if we see one. For example, in
our Windows CI environment:

  $ perl chainlint.pl chainlint/for-loop.test | cat -v
  Thread 2 terminated abnormally: internal error scanning character '^M'

This doesn't break "make check-chainlint" (yet), because we assemble a
concatenated input by passing the contents of each file through "sed".
And the "sed" we use will strip out the CRLFs. But the next patch is
going to rework this a bit, which does break check-chainlint on Windows.
Plus it's probably nicer to folks on Windows who might work on chainlint
itself and write new tests.

In theory we could fix the parser to handle this, but it's not really
worth the trouble. We should be able to ask the input layer to translate
the line endings for us. In fact, I'd expect this to happen by default,
as perl's documentation claims Win32 uses the ":unix:crlf" PERLIO layer
by default ("unix" here just refers to using read/write syscalls, and
then "crlf" layers the translation on top). However, this doesn't seem
to be the case in our Windows CI environment. I didn't dig into the
exact reason, but it is perhaps because we are using an msys build of
perl rather than a "true" Win32 build.

At any rate, it is easy-ish to just ask explicitly for the conversion.
In the above example, setting PERLIO=crlf in the environment is enough
to make it work. Curiously, though, this doesn't work when invoking
chainlint via "make". Again, I didn't dig into it, but it may have to do
with msys programs calling Windows programs or vice versa.

We can make it work consistently by just explicitly asking for CRLF
translation when we open the files. This will even work on non-Windows
platforms, though we wouldn't really expect to find CRLF files there.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/chainlint.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 118a229a96..fb749d3d5c 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -762,7 +762,7 @@ sub check_script {
 	while (my $path = $next_script->()) {
 		$nscripts++;
 		my $fh;
-		unless (open($fh, "<", $path)) {
+		unless (open($fh, "<:unix:crlf", $path)) {
 			$emit->("?!ERR?! $path: $!\n");
 			next;
 		}
-- 
2.45.2.1249.gb036353db5

