Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1413B7BC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215130; cv=none; b=tATKRRl1xh3S+EF0UPoNEMMxnmUTDLzRRUSd3YkgkhK/+dmhjT+UcuIQ1tMGaD5DBFhpDnf8son85hTHOQQTPdV7/k/8nZoQmZliFPWxNm97pbwiyrFMOIZco6Zf6ArRNOUB/sIwkwMferT0WDDptCuXJNOcMJ52VLdFxDJ2WtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215130; c=relaxed/simple;
	bh=a4vOnXl/zkSeI5KFYQGxoYLuj936FcOFhSXEq2bsAV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyD1M0L2NZY0d5mcgCcwL4Lh3yUC6T3C6nID00aHi/VVn7OAAi6AVJmMuOv2yxrwE/TeYlBZKyH0BLMfLWW2l9Zxuy4vX+6dr9cd0auBp1gTI3DDejoGG+Y9pmatJ77om7Zjw5A+IFp49DP8dBtj2OkHdgS4sZXydTU50MncGHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15490 invoked by uid 109); 24 Sep 2024 21:58:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:58:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18611 invoked by uid 111); 24 Sep 2024 21:58:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:58:47 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:58:47 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 12/28] transport-helper: fix leak of dummy refs_list
Message-ID: <20240924215847.GL1143820@coredump.intra.peff.net>
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

When using a remote-helper, the fetch_refs() function will issue a
"list" command if we haven't already done so. We don't care about the
result, but this is just to maintain compatibility as explained in
ac3fda82bf (transport-helper: skip ls-refs if unnecessary, 2019-08-21).

But get_refs_list_using_list(), the function we call to issue the
command, does parse and return the resulting ref list, which we simply
leak. We should record the return value and free it immediately (another
approach would be to teach it to avoid allocating at all, but it does
not seem worth the trouble to micro-optimize this mostly historical
case).

Triggering this requires the v0 protocol (since in v2 we use stateless
connect to take over the connection). You can see it in t5551.37, "fetch
by SHA-1 without tag following", as it explicitly enables v0.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 9c8abd8eca..013ec79dc9 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -717,8 +717,14 @@ static int fetch_refs(struct transport *transport,
 		return -1;
 	}
 
-	if (!data->get_refs_list_called)
-		get_refs_list_using_list(transport, 0);
+	if (!data->get_refs_list_called) {
+		/*
+		 * We do not care about the list of refs returned, but only
+		 * that the "list" command was sent.
+		 */
+		struct ref *dummy = get_refs_list_using_list(transport, 0);
+		free_refs(dummy);
+	}
 
 	count = 0;
 	for (i = 0; i < nr_heads; i++)
-- 
2.46.2.1011.gf1f9323e02

