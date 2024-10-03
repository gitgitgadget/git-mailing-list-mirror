Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21951C9B6B
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989618; cv=none; b=VGI/Fy+6lI3v+66mlQsfJ94OcwrS7Ahz5m70wuFT3JXiM8iIt1NG2XGAdZsT5IyaDxUGT2gI1A4Dd/imxENKnaGCLgANLSa++sGC6XQCSAAhxBJXnrGfVQ+lHgCzFxICxjkagNNYqSuWOrI0C+6ePNuWq+KEkZqRkf39ET53iow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989618; c=relaxed/simple;
	bh=NnbBtYAH5BKwdOQe6GZlQ3bYMNszQKleTPgArwBNXJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKYJuy23gQPNKRuqaubqv53MzoZb+Alid+FXgr613//oM3fhXCfJHwhar3S8sBMPbPpcCEDLiI+PWRfJ8sW/VeinC63RvtO5eFWtHuBrEBWWSXQ0+5s1gIx2kFBYG6TuG6BBQQW3QhKb12c/lE7n2o71XV+u983QgBNEvZgddEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YCpYgKd1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YCpYgKd1"
Received: (qmail 19329 invoked by uid 109); 3 Oct 2024 21:06:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NnbBtYAH5BKwdOQe6GZlQ3bYMNszQKleTPgArwBNXJ8=; b=YCpYgKd11v6A+zedaxFYr4JSCNOQh1s+cJt6JXm8TqR7MHA+/+OSyEfBl1e7saFdSJTCHLvgtIMKvKv1uz9bNpdm/07AjkbpozAO9fwJGOw6vFwfwCHbuAs7AosVFzIh8IuzS7E7paXGQuq1KnJabq2XvL9RV3AMXrkeYJCuTJ31qM++p7+qKGQb1VLXgN8NadCimDQuPFWgUot/5put2Yz6CSTUT+XKr255/WKZfBO9bYaXbKYUXJd3fpxKkNY5rQteb5RZN+/yS5zWq+hDKkp4MGsNHWKdjnadmdjxZlN7b91l4JxyeiM5147IFcUPjvyk7/X8jhPhAAPpn4d/Kg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:06:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21766 invoked by uid 111); 3 Oct 2024 21:06:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:06:55 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:06:54 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 2/5] diff: drop line_prefix_length field
Message-ID: <20241003210654.GB11328@coredump.intra.peff.net>
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

The diff_options structure holds a line_prefix string and an associated
length. But the length is always just the strlen() of the NUL-terminated
string. Let's simplify the code by just storing the string pointer and
assuming it is NUL-terminated when we use it.

This will cause us to compute the string length in a few extra spots,
but I don't think any of these are particularly hot code paths.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c  | 1 -
 diff.h  | 1 -
 graph.c | 8 ++------
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 173cbe2bed..858e001993 100644
--- a/diff.c
+++ b/diff.c
@@ -5400,7 +5400,6 @@ static int diff_opt_line_prefix(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 	options->line_prefix = optarg;
-	options->line_prefix_length = strlen(options->line_prefix);
 	graph_setup_line_prefix(options);
 	return 0;
 }
diff --git a/diff.h b/diff.h
index 0cde3b34e2..ea3634106d 100644
--- a/diff.h
+++ b/diff.h
@@ -274,7 +274,6 @@ struct diff_options {
 	const char *single_follow;
 	const char *a_prefix, *b_prefix;
 	const char *line_prefix;
-	size_t line_prefix_length;
 
 	/**
 	 * collection of boolean options that affects the operation, but some do
diff --git a/graph.c b/graph.c
index 091c14cf4f..2cee47294f 100644
--- a/graph.c
+++ b/graph.c
@@ -76,10 +76,7 @@ static void graph_show_line_prefix(const struct diff_options *diffopt)
 	if (!diffopt || !diffopt->line_prefix)
 		return;
 
-	fwrite(diffopt->line_prefix,
-	       sizeof(char),
-	       diffopt->line_prefix_length,
-	       diffopt->file);
+	fputs(diffopt->line_prefix, diffopt->file);
 }
 
 static const char **column_colors;
@@ -323,8 +320,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 
 	strbuf_reset(&msgbuf);
 	if (opt->line_prefix)
-		strbuf_add(&msgbuf, opt->line_prefix,
-			   opt->line_prefix_length);
+		strbuf_addstr(&msgbuf, opt->line_prefix);
 	if (graph)
 		graph_padding_line(graph, &msgbuf);
 	return &msgbuf;
-- 
2.47.0.rc1.384.g9f398d04fd

