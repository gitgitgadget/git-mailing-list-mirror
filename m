Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA011B85D6
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989590; cv=none; b=GcGbk7KPk6hTxQwQ/dRZ1Q2heE0ewE7HthVP795DmWWWF3pJDZt/ssTuNQacJhxxfWcOV5fd5zFixmMNxsZTNvFyF6BJbaABAwkjzSLmPne5P6+BAk8wlER5kNNt+G1MDlxm+I8wEoxRenCFpCdT7qnxZ/1CF2U887Ng8HXZr68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989590; c=relaxed/simple;
	bh=9eNMHCRMh+R0g/8wakjjaqeDTr2KNnTMOA9W2hKmJxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNq3C1l/V1J5S8WNBUQ61hVD7lcpTkrl+0UWXwFRKx1tq8QWxpcfZEBP3Xp5cQwlvQYmb5zEcZkw55WkNAZAtjoesFwUg6edeL7oA5k61IvSH6mRYCzwGfuWFMac4LlDJTHNu7LPcoKdCtJwbf/K8QM0B8TKV1akz3LgbrJCTSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JY9qI46O; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JY9qI46O"
Received: (qmail 19317 invoked by uid 109); 3 Oct 2024 21:06:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9eNMHCRMh+R0g/8wakjjaqeDTr2KNnTMOA9W2hKmJxQ=; b=JY9qI46OlQKABp72JUFMSSJST2j33DsQB33akmee1Cf0/+JKx1Z2adOZF299cDfCs8Xe84dVSbvyYL0Et97y4x4pSADmThfWLoVWdH89MhC3WMXwWHT0wucbmNXXDmOeed0YQsWjUdPutZwrn1THB9wjw+idurMiefGj3NLJqPW4uG/N1vfxdUGImJBtXZxW8ywENetzp7W0gfrf1OPISVzT/lAZ1fP96OwRaUSut/O3iImbAm0AWEUjJDE9qu4WOrtxc6yrH+nnMqJBB8Bm89pAOzjwI++2uq0lcULwONLEJVa95+NTBwrxbAkPvtaPmogSlEECxbIQ7yVKcq5tNw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:06:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21755 invoked by uid 111); 3 Oct 2024 21:06:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:06:27 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:06:27 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 1/5] line-log: use diff_line_prefix() instead of custom helper
Message-ID: <20241003210627.GA11328@coredump.intra.peff.net>
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

Our local output_prefix() is exactly the same as the public
diff_line_prefix() function. Let's just use that one, saving us a little
bit of code.

Signed-off-by: Jeff King <peff@peff.net>
---
 line-log.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/line-log.c b/line-log.c
index 29cf66bdd1..63945c4729 100644
--- a/line-log.c
+++ b/line-log.c
@@ -897,16 +897,6 @@ static void print_line(const char *prefix, char first,
 		fputs("\\ No newline at end of file\n", file);
 }
 
-static const char *output_prefix(struct diff_options *opt)
-{
-	if (opt->output_prefix) {
-		struct strbuf *sb = opt->output_prefix(opt, opt->output_prefix_data);
-		return sb->buf;
-	} else {
-		return "";
-	}
-}
-
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *range)
 {
 	unsigned int i, j = 0;
@@ -916,7 +906,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
 	struct diff_ranges *diff = &range->diff;
 
 	struct diff_options *opt = &rev->diffopt;
-	const char *prefix = output_prefix(opt);
+	const char *prefix = diff_line_prefix(opt);
 	const char *c_reset = diff_get_color(opt->use_color, DIFF_RESET);
 	const char *c_frag = diff_get_color(opt->use_color, DIFF_FRAGINFO);
 	const char *c_meta = diff_get_color(opt->use_color, DIFF_METAINFO);
@@ -1011,7 +1001,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *range)
 {
-	const char *prefix = output_prefix(&rev->diffopt);
+	const char *prefix = diff_line_prefix(&rev->diffopt);
 
 	fprintf(rev->diffopt.file, "%s\n", prefix);
 
-- 
2.47.0.rc1.384.g9f398d04fd

