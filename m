Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519F1DFFC
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989894; cv=none; b=nb98EAwgc0DzQ7n/y72Hx7XDsJc3Ee5gVNpGVu2EsNoh5nIUNtg8ic9AvXgJX5uEI4cAGbfldHVgqr8ItAOnURsQbyAh2Y2DtuC77AMrgfWngVosVAa3NX/TYDIi5RxB/IoCqD9lJDmWk4BaNUARw5NCtol6Ji0rR5Rpv2iNR/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989894; c=relaxed/simple;
	bh=6y7U4n4G/286rRqLaMCZJF3x5vhICq0YgRlwE7WzHQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B996HXZNZgNhTFFoTcg7u7jmh0mlHTDQ0PU5Qve6HL1fpV4faJlMkFDmPUmFruQvpwiypdydybBYgxP5qOvpddEQvWERTuQP95VMuNuzecLreTgAQ0t7R66OCIPuK/3vFkm1FJzIHZgCeXY6f29xfGYtaNBWIMSYTa1r187STWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=XcqKwUPZ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="XcqKwUPZ"
Received: (qmail 19368 invoked by uid 109); 3 Oct 2024 21:11:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6y7U4n4G/286rRqLaMCZJF3x5vhICq0YgRlwE7WzHQo=; b=XcqKwUPZYf1wXC8zyC96F/8hbJzS8nT+xaMJW1SOaBgOD4COVFU88V2nnl0pVvkOtJe9pCNPViaLLO43tEjzMM78KmwxKJI0B2CdxnvpHRp0ldic1X6bng7ph1xh27ARHtCwRidbE0VgqDCfvbLkOzj3UbaC+snxp0Z5+w8BRHnmiJv6cxLpu6deHkRV52AetHDuEqhiIfN949s4ibVLbvd8zi7yWuwJHHkSbVhkbu7eD0kX6Kwd9kBNSKpstgPXKWa4VdKeSDm8wyr7aUayE63/S8uVFHFIwwsby8ich44Hxmgync+60alpKARqjEenb7pv07dETUIhT53+ZrSCEQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:11:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21827 invoked by uid 111); 3 Oct 2024 21:11:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:11:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:11:31 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 4/5] diff: return line_prefix directly when possible
Message-ID: <20241003211131.GD11328@coredump.intra.peff.net>
References: <20241003210548.GB11180@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003210548.GB11180@coredump.intra.peff.net>

We may point our output_prefix callback to diff_output_prefix_callback()
in any of these cases:

  1. we have a user-provided line_prefix

  2. we have a graph prefix to show

  3. both (1) and (2)

The function combines the available elements into a strbuf and returns
its pointer.

In the case that we just have the line_prefix, though, there is no need
for the strbuf. We can return the string directly.

This is a minor optimization by itself, but also will allow us to clean
up some memory ownership issues on top.

Signed-off-by: Jeff King <peff@peff.net>
---
The old code did handle a case "0" where neither is set. But in that
case we would never set up the callback in the first place. So I didn't
think it was worth being defensive there.

 graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/graph.c b/graph.c
index c046f6285d..0d200ca77f 100644
--- a/graph.c
+++ b/graph.c
@@ -318,6 +318,9 @@ static const char *diff_output_prefix_callback(struct diff_options *opt, void *d
 
 	assert(opt);
 
+	if (!graph)
+		return opt->line_prefix;
+
 	strbuf_reset(&msgbuf);
 	if (opt->line_prefix)
 		strbuf_addstr(&msgbuf, opt->line_prefix);
-- 
2.47.0.rc1.384.g9f398d04fd

