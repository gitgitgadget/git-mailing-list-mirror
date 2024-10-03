Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9071AC423
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727990001; cv=none; b=h3eMZCcM99SOoSUGlionT+Fv3FRq3lolzXitkAohL2/Lt1/RaY8HNfn5BbuSR3jeRM2iTRH8qHiDEY0fcq4Rja6GCMppruUonhiZHzwO80eiEroeALuj2ly0adUJa3xyuJ1U3oDArsWzpeU3VmXW9zJiEhp9/q/Op7QVf/0z5/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727990001; c=relaxed/simple;
	bh=utSH1cWBnMfyl7ozS7L9Q9KEEYG0lWRKBlr5c4elyrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5MgqRuAVY4pL5oeBuN/ka/turI5nPeZA0d1fG4j64z2dF7TQVfItqziWMUXih59qEJG9KHSk8YiWm0+DuAKFMECNV/vDA1DuwLm7T4L73l4x1qbrJgoxUp+P29t7J6hmg4LRhlqQo5OqHZTkILZAqw4LFF1cIJZ3moIp2sVdj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MLhuVDDr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MLhuVDDr"
Received: (qmail 19382 invoked by uid 109); 3 Oct 2024 21:13:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=utSH1cWBnMfyl7ozS7L9Q9KEEYG0lWRKBlr5c4elyrM=; b=MLhuVDDrjeg/ISL6StARpsfzaKRGK0zM4nxOk620DJvvr/XRAmxzDhLu3IV/SHYeaDcWU8JILVF13GbnsO798S0a2O450oVxQJghEP8TkC9M0gtqkWzuiMaWXH553krXdee0dfyPSykXFjNzS7ULK+xrb+zJJU1jciYrs7nSJucvSuiGCfqiYFz1Yj3PHWXRtfCTkouw4WjidzXGEidBlkPYlPskvBZH9EQ1lB2+qHau8yATT/DccpxjiCDUEu0K+HGRkOw/sKiOyhyydBbsM1Bzf6OEEVXbsM6ktLMTD1sEkClBXLB9Rb+IdtL/iqwvLyFN3fP2JG8sT2Il09JmiQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:13:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21835 invoked by uid 111); 3 Oct 2024 21:13:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:13:18 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:13:17 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 5/5] diff: store graph prefix buf in git_graph struct
Message-ID: <20241003211317.GE11328@coredump.intra.peff.net>
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

The diffopt output_prefix interface makes it the callback's job to
handle ownership of the memory it returns, keeping it valid while
callers are using it and then eventually freeing it when we are done
diffing.

In diff_output_prefix_callback() we handle this with a static strbuf,
effectively "leaking" it when the diff is done (but not triggering any
leak detectors because it's technically still reachable). This has not
been a big problem in practice, but it is a problem for libification:
two diffs running in the same process could stomp on each other's prefix
buffers.

Since we only need the strbuf when we are formatting graph padding, we
can give ownership of the strbuf to the git_graph struct, letting us
free it when that struct is no longer in use.

Signed-off-by: Jeff King <peff@peff.net>
---
 graph.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/graph.c b/graph.c
index 0d200ca77f..bf000fdbe1 100644
--- a/graph.c
+++ b/graph.c
@@ -309,24 +309,28 @@ struct git_graph {
 	 * stored as an index into the array column_colors.
 	 */
 	unsigned short default_column_color;
+
+	/*
+	 * Scratch buffer for generating prefixes to be used with
+	 * diff_output_prefix_callback().
+	 */
+	struct strbuf prefix_buf;
 };
 
 static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
-	static struct strbuf msgbuf = STRBUF_INIT;
 
 	assert(opt);
 
 	if (!graph)
 		return opt->line_prefix;
 
-	strbuf_reset(&msgbuf);
+	strbuf_reset(&graph->prefix_buf);
 	if (opt->line_prefix)
-		strbuf_addstr(&msgbuf, opt->line_prefix);
-	if (graph)
-		graph_padding_line(graph, &msgbuf);
-	return msgbuf.buf;
+		strbuf_addstr(&graph->prefix_buf, opt->line_prefix);
+	graph_padding_line(graph, &graph->prefix_buf);
+	return graph->prefix_buf.buf;
 }
 
 static const struct diff_options *default_diffopt;
@@ -396,6 +400,7 @@ struct git_graph *graph_init(struct rev_info *opt)
 	 * The diff output prefix callback, with this we can make
 	 * all the diff output to align with the graph lines.
 	 */
+	strbuf_init(&graph->prefix_buf, 0);
 	opt->diffopt.output_prefix = diff_output_prefix_callback;
 	opt->diffopt.output_prefix_data = graph;
 
@@ -411,6 +416,7 @@ void graph_clear(struct git_graph *graph)
 	free(graph->new_columns);
 	free(graph->mapping);
 	free(graph->old_mapping);
+	strbuf_release(&graph->prefix_buf);
 	free(graph);
 }
 
-- 
2.47.0.rc1.384.g9f398d04fd
