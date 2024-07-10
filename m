Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE58120F
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600517; cv=none; b=DWxPKQhiytLtO1gmVQk4McLcWvKwDfYlslqo64tY6SZVsdFLvqKZ9X+Jya7klOKdKAUUfJVSmKDE7U9Riy9PQzpgG+xV9sYgHCDNDjinGMJAbk2DiIOC90cLV7kGkg4JQ8vIrcq9qMKMAeofT7pAcOUhDEIzyqTTa/NQBTLuMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600517; c=relaxed/simple;
	bh=XdBEYD2Piu7SU01BsGSk2vyYyZRrb0pWjy1jFlVPaK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=On+7UBgsaMSPxdvVCk3Nq6cHT0aHRoMB5lUsRwLR5QO+4bqsoAH0IRPbGkoo0obtQ5m9xMhBzXtGjC4H1QJJhBGIJJxSAJMK9/N5SAcH6UOsX/AYrI/T6O/a7yQU3Y0vPGYYM0tSYAUPerCGSSsd3eMhcsp1YLKk3Lkd6qj+87w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1642 invoked by uid 109); 10 Jul 2024 08:35:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:35:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10424 invoked by uid 111); 10 Jul 2024 08:35:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:35:11 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:35:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 2/9] chainlint.pl: only start threads if jobs > 1
Message-ID: <20240710083513.GB2060601@coredump.intra.peff.net>
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

If the system supports threads, chainlint.pl will always spawn worker
threads to do the real work. But when --jobs=1, this is pointless, since
we could just do the work in the main thread. And spawning even a single
thread has a high overhead. For example, on my Linux system, running:

  for i in chainlint/*.test; do
	perl chainlint.pl --jobs=1 $i
  done >/dev/null

takes ~1.7s without this patch, and ~1.1s after. We don't usually spawn
a bunch of individual chainlint.pl processes (instead we feed several
scripts at once, and the parallelism outweighs the setup cost). But it's
something we've considered doing, and since we already have fallback
code for systems without thread support, it's pretty easy to make this
work.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/chainlint.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 1bbd985b78..1864d048ae 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -807,7 +807,8 @@ sub exit_code {
 	exit;
 }
 
-unless ($Config{useithreads} && eval {
+unless ($jobs > 1 &&
+	$Config{useithreads} && eval {
 	require threads; threads->import();
 	require Thread::Queue; Thread::Queue->import();
 	1;
-- 
2.45.2.1249.gb036353db5

