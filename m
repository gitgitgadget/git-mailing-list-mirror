Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C383CBA
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600560; cv=none; b=K0+fH4ZLaJ28ANN7rAHEGfv0Gn7AnXpXtfpOSHounCsiU+A6YHLQQVDwDq7IP4Nv4jAaMU9V8uyUc/cd+o/ZI1rTMEroE6sctpdFWpPQuw+yD0LIG4ux0sj/0H+jUzUdllxr4l3bdQA8c1kPGqCo61/CAS/TS7e0WJWFp1jyNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600560; c=relaxed/simple;
	bh=KuOLgqcvLQBZrs73xizM9CkiCe0QI43+1ePq8822AJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c93m25EVoUIYe8uG7X7pMnTy5ezzQZ1ybd7OukpydREk2+okL02MUnrwSrqz6CciF4zABD8NgYZ4zsPF3U9ZHllCeiqLJGPB1XdedU90Zb/R/jNKPipjJQpF7irxuEQUoCOYwnx/C851DLqFNxZqz+GH5FGV1EPNC9p8b2ItAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1650 invoked by uid 109); 10 Jul 2024 08:35:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Jul 2024 08:35:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10430 invoked by uid 111); 10 Jul 2024 08:35:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Jul 2024 04:35:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 10 Jul 2024 04:35:57 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 3/9] chainlint.pl: do not spawn more threads than we have
 scripts
Message-ID: <20240710083557.GC2060601@coredump.intra.peff.net>
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

The chainlint.pl script spawns worker threads to check many scripts in
parallel. This is good if you feed it a lot of scripts. But if you give
it few (or one), then the overhead of spawning the threads dominates. We
can easily notice that we have fewer scripts than threads and scale back
as appropriate.

This patch reduces the time to run:

  time for i in chainlint/*.test; do
	perl chainlint.pl $i
  done >/dev/null

on my system from ~4.1s to ~1.1s, where I have 8+8 cores.

As with the previous patch, this isn't the usual way we run chainlint
(we feed many scripts at once, which is why it supports threading in the
first place). So this won't make a big difference in the real world, but
it may help us out in the future, and it makes experimenting with and
debugging the chainlint tests a bit more pleasant.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/chainlint.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 1864d048ae..118a229a96 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -806,6 +806,7 @@ sub exit_code {
 	show_stats($start_time, \@stats) if $show_stats;
 	exit;
 }
+$jobs = @scripts if @scripts < $jobs;
 
 unless ($jobs > 1 &&
 	$Config{useithreads} && eval {
-- 
2.45.2.1249.gb036353db5

