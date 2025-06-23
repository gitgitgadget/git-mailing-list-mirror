Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC0723A9BE
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 10:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750676146; cv=none; b=UCJNDej8ej/Vb16h6fsglzJyB37sytT5VSpiyrV67hqCPEkQeaRYt3LiHJvlAy8PFyDUPUSPtlC/qIWrcZO09SWJlmn1dHADXHQnrsmcdq3ctBQnR84TXwvX0sKsz5VMt8gCWps8Ww2rlIvNRcjGUf4UKOZzFSCwBILoWstMew8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750676146; c=relaxed/simple;
	bh=FKwpxphHavyr4zbJb/rsDcv/OrS6NcubbCnW/rpnhns=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQi9SKtU5WuSWkxaUnhRNYb7IFyXJfglYyIbh2sxNdjGAdbvnn47KxJ/Cz9UOpdrHacju/IBuAyJejbAYsIiPUPPfY9h2KfBahMuMy5J00MDhMM7zKRxNSlH6QiNV/qHJVtZrfSTWGOMDYYgsKIQrgzdeHvV6Vnn3i+ARpkqMx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G3XCKoJM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G3XCKoJM"
Received: (qmail 10125 invoked by uid 109); 23 Jun 2025 10:55:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=FKwpxphHavyr4zbJb/rsDcv/OrS6NcubbCnW/rpnhns=; b=G3XCKoJMlf8qSQ23nSIR7Zuo8yQHVL5AGuGi2RJpL8q53deFT8jWkysqIPYDqtU33/0s3rCHZSAxIEDb5FsDX7mzdVPAL40PV8tWOJDyHQJf8XRNGkIxzLy1FFDBx3UR+qipq3K7LZuFiNW51ul1h7fQ5aKpd7/yiIiHg3XeUP5lT0UCuFvhCDCymwwe/Koa6WeGplJ1lQEysMlV2qYFZ7X8M8QcyZvAESdNPXUN+rMKLC8zgAJrGzWGsTpR+kTboeVUTaHx1jVA9LjziOoOo/S9BJd/Etyhfk4/GSLrOxViDhepG5+Ynqr58xjCOBYVT2KbvdHHEttdI/B5Sr21cw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Jun 2025 10:55:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16014 invoked by uid 111); 23 Jun 2025 10:55:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Jun 2025 06:55:43 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Jun 2025 06:55:42 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 1/2] t7422: replace confusing printf with echo
Message-ID: <20250623105542.GA654412@coredump.intra.peff.net>
References: <20250623105516.GA654296@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623105516.GA654296@coredump.intra.peff.net>

While looping over a counter "i", we do:

  printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i"

So we are passing "$i" as an argument to be filled in, but there is no
"%" placeholder in the format string, which is a bit confusing to read.

We could switch both instances of "$i" to "%d" (and pass $i twice). But
that makes the line even longer. Let's just keep interpolating the value
in the string, and drop the confusing extra "$i" argument.

And since we are not using any printf specifiers at all, it becomes
clear that we can swap it out for echo. We do use a "\n" in the middle
of the string, but breaking this into two separate echo statements
actually makes it easier to read.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t7422-submodule-output.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t7422-submodule-output.sh b/t/t7422-submodule-output.sh
index 023a5cbdc4..ea67057f1a 100755
--- a/t/t7422-submodule-output.sh
+++ b/t/t7422-submodule-output.sh
@@ -180,7 +180,8 @@ test_expect_success !MINGW 'git submodule status --recursive propagates SIGPIPE'
 		COMMIT=$(git rev-parse HEAD) &&
 		for i in $(test_seq 2000)
 		do
-			printf "[submodule \"sm-$i\"]\npath = recursive-submodule-path-$i\n" "$i" ||
+			echo "[submodule \"sm-$i\"]" &&
+			echo "path = recursive-submodule-path-$i" ||
 			return 1
 		done >gitmodules &&
 		BLOB=$(git hash-object -w --stdin <gitmodules) &&
-- 
2.50.0.385.g2a828bf5b7

