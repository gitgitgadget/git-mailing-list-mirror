Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A0144D2D
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496020; cv=none; b=flDkmYtmc476/AtmDPBZD1gKd+awpwkS7VKWrL+MyFfizP0TQNZyBJotOrBu6Sm1z81JeAeOae4nZSvOYwf2gOaMQ/X8p3TjPMKNQF5Xg9u7Crwd0npMMeiJc4nrT1CPvPzXzOEAvJx3l9N1i+x0ykJg8wXso4jwi63bOvjmsLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496020; c=relaxed/simple;
	bh=87YmY9b0D9MyjTaWynAiIN6LPEUO0ZlDySTQmG0jycs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQl0PZQnY7lMoMdnJCmfK2femsjCRcrUR40ugPinVr0F8T5GhX8x4gshFTB5+NBbm8MW5g5JOthzZezkJSEsUgEhtrW7t9NqLY+MWgZkltUL1N/glKvWPcTnV9D9w5sClMLs1vGCoKVsaZ+DHDKBgswjy9Y8N/VTqJs40yaBv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21561 invoked by uid 109); 4 Jun 2024 10:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18402 invoked by uid 111); 4 Jun 2024 10:13:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:35 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:37 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 12/13] sparse-checkout: free string list after displaying
Message-ID: <20240604101337.GL1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

In sparse_checkout_list(), we put the hashmap entries into a string_list
so we can sort them. But after printing, we forget to free the list.

This patch drops 5 leaks from t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index fb43bb7577..e648e035ab 100644
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
2.45.2.807.g3b5fadc4da

