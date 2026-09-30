Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F1533B970
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790811861; cv=none; b=XFlxe0Uj0RK4AH4igu6UwMtlmiMgSLGRSeJBrssIHxN6E38nGhCJPYp5eMicNzkZknTC0ks83OPqm6bJ6FrfXEcPWkHzUpU1hAQPrHxx9Xztnxu40lSaris/c+UPmsAO2UyQ1At1PcDsW0A4XD/RJsWpecQlsDdctqqWN/ANg54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790811861; c=relaxed/simple;
	bh=i5b34WeCKHJ3Hc4w52yC9849E5NxXauh/8UuehANYqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8eVOYZefU6hpV8E6vvsvEFVqLuKOXOFRi6TrVO5JK8FJZCXZl3Sr7mwLXT61sbwI+yagJ/R4NTd7nReEcoNgsJR2iThN6JCBQcvo7+KIw1zb4kapkGvpV1wn5LKCTy5uHSCmlKcghRy2JT/kyqPDcURp80g0ZozdrkRBcfIDT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bUKIZfxY; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bUKIZfxY"
Received: (qmail 8216 invoked by uid 106); 30 Sep 2026 23:44:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=i5b34WeCKHJ3Hc4w52yC9849E5NxXauh/8UuehANYqI=; b=bUKIZfxYDllrM3weetuHB52ASFmC8wDo6L/wx8TuSf1tUV+ekwxdYXpoGMQegV7rTEtfoBQgOpDU/QPKHigDj+RgQICyGEW4GAC+2b7lJCpOgbnjiUqS05L67sI8iiFSaNFFqWE035FYd+YiIr3oSzZ9Zd/M8Ef5KJ1n3U0HakIWgpatMxVwPa1ORYNmiClfIjqntXJ1QyaJKoIJC65En7HiR0je2JqvaNbc/nPVe7TuycRDIN98Yk3yJPCgZPxEi78UA1XEnuddEMCbYGSkpCzUPLO1CEcL2hqudcqBNWqq9zAPfeHhIWM039CPiLUtKEZwNVNGJtocg99vELt2Tw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 23:44:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20852 invoked by uid 111); 30 Sep 2026 23:44:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 19:44:21 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 19:44:18 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 6/7] merge-ll: handle external driver status before
 reading result
Message-ID: <20260930234418.GF1347555@coredump.intra.peff.net>
References: <20260930234348.GA1340390@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260930234348.GA1340390@coredump.intra.peff.net>

After running an external merge driver, ll_ext_merge() reads its output
and cleans up the temporary files before converting the exit status to
an ll_merge_result.

Move that conversion immediately after run_command(). This will let us
override the result if reading the output fails, without having to fake
an exit status. No behavior change yet.

It is tempting to only call read_mmfile() when we have LL_MERGE_OK, but
callers do care about the result even with LL_MERGE_CONFLICT (e.g., the
output may contain a partial). I think we could safely skip it for
LL_MERGE_ERROR, but that's a rare case and not worth complicating the
code for.

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 7fab7c5438..4d82836bc5 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -240,20 +240,20 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
 	child.use_shell = 1;
 	strvec_push(&child.args, cmd.buf);
 	status = run_command(&child);
-
-	/* We can ignore errors; result is left NULL/0 in that case. */
-	read_mmfile(result, temp[1]);
-
-	for (i = 0; i < 3; i++)
-		unlink_or_warn(temp[i]);
-	strbuf_release(&cmd);
 	if (!status)
 		ret = LL_MERGE_OK;
 	else if (status <= 128)
 		ret = LL_MERGE_CONFLICT;
 	else
 		/* died due to a signal: WTERMSIG(status) + 128 */
 		ret = LL_MERGE_ERROR;
+
+	/* We can ignore errors; result is left NULL/0 in that case. */
+	read_mmfile(result, temp[1]);
+
+	for (i = 0; i < 3; i++)
+		unlink_or_warn(temp[i]);
+	strbuf_release(&cmd);
 	return ret;
 }
 
-- 
2.56.0.354.gb6b32d5be5

