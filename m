Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A399149E1A
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215393; cv=none; b=DNqcyzPCDTZRCWmcI2iUgiRzL0jbKs/PaY8FcL2yIUwmzS1HP5rx+s5eGH+HryvtNTd0wh6v66lBuUb+JNZ/Ap83v4Js/lWnUKnb23TYfw1krlssCVzBnOWHGV2iF6Lto/R2cDpIH35enf7CrfEGE3C3M023IZqCJQf7ZO4HzwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215393; c=relaxed/simple;
	bh=60lrT4z+Q/l88KkEMWOC7ehlO6U1WzsIYc+eEJtvsrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak8eotAdKWvKkAdQuQ8UWlqwfe1nDjnF4Z1ENo1NCJ9ipa9+qctBPKVZ7CsUHR9dijzvJDlmCttEBarrQCuBXJ/kFSla+iqAIbKvcWE3/XHbiBqCHmIclt3M87Gm/R1gxcpzcfI2+/4LrPn5aZEF8Fg/vswpETzBAR9IiygbrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15552 invoked by uid 109); 24 Sep 2024 22:03:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:03:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18724 invoked by uid 111); 24 Sep 2024 22:03:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:03:10 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:03:10 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 17/28] remote-curl: free HEAD ref with free_one_ref()
Message-ID: <20240924220310.GQ1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

After dumb-http downloads the remote info/refs file, it adds an extra
HEAD ref struct to our list by downloading the remote symref and finding
the matching ref within our list. If either of those fails, we throw
away the ref struct. But we do so with free(), when we should use
free_one_ref() to catch any embedded allocations (in particular, if
fetching the remote HEAD succeeded but the branch is unborn, its
ref->symref field will be populated but we'll still throw it all away).

This leak is triggered by t5550 (but we still have a little more work to
mark it leak-free).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 4adcf25ed6..9a71e04301 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -347,7 +347,7 @@ static struct ref *parse_info_refs(struct discovery *heads)
 		ref->next = refs;
 		refs = ref;
 	} else {
-		free(ref);
+		free_one_ref(ref);
 	}
 
 	return refs;
-- 
2.46.2.1011.gf1f9323e02

