Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5B8173C
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155406; cv=none; b=J0qLHnkK6GmXDMZClDjYQmM2l2n4pMI32Q19KZHrrGYI3VJoJL0oubjtFGvSzYwNcLf91OPDD4JLCF5P4OvED2eo13/WhRtRo0xdex9y7eTjj3KAePzIoP7cjcsyCiR3P0IKUx9h9EyaMNbZtB3eOYoJy5wShjEAdFb1zFAeCkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155406; c=relaxed/simple;
	bh=cL2YgQidHJDYBa+D/feW+dFpk/wnAQ/rwfKS+fZKbB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qxzcyuRmrn54PyLAD91d8tPIap2J24YTgy87nglUe/nOZ9YcJ6EZyArGGeQmf9aqMchtOpwgbXAfI1fH/K7v8iIbfkepQ8DqT8dnNDy2mEv17UcYwzaxL0kZB2aww0Hjw//otLox2d9a7Qc9rINMS1+OYk3ghnq7Jkw2YXXrAjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22783 invoked by uid 109); 31 May 2024 11:36:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:36:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9385 invoked by uid 111); 31 May 2024 11:36:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:36:43 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:36:43 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 12/13] sparse-checkout: free string list after displaying
Message-ID: <20240531113643.GL428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

In sparse_checkout_list(), we put the hashmap entries into a string_list
so we can sort them. But after printing, we forget to free the list.

This patch drops 5 leaks from t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index bc07df925f..0b979a17d6 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -95,6 +95,8 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
 			printf("\n");
 		}
+
+		string_list_clear(&sl, 0);
 	} else {
 		write_patterns_to_file(stdout, &pl);
 	}
-- 
2.45.1.727.ge984192922

