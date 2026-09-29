Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B182C347FC0
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 20:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790714604; cv=none; b=ll0ZIGq4lTTbX8bQIKSc6BXvlwJLskDzZKheqrg+4189yx40VREJyrh0tMGKD5UIii2rxEQp6vHDCutWpwRuGn9n9yM+W0s+DfXl1KAwz4y4k/2yeWZAsztl3jbKRxcWC22+IBi7y4TvIMsr6ReT0czlgkY3bdgoP4xDnX9f2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790714604; c=relaxed/simple;
	bh=dfMxzZ7llhlbx0tVodbe54MfqUE/6TcZ6qYz/NlX12U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNCbOLGmWKcaeHvKpHI+PXBBrxP507auN/srBMNsvpI1qVdeTdeu2804LpXLcTB3mgeXoZUkxhC2gaZ/5f2Bhk0/v2GLDhXakUvOOQer8RtMcLXOQ+4qkEouJNreJXwFVr23BpXfjfjxLE6abN8TxSG2QRW/m4C4TAjJa7O1OwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UzTdI0Wc; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UzTdI0Wc"
Received: (qmail 1410 invoked by uid 106); 29 Sep 2026 20:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dfMxzZ7llhlbx0tVodbe54MfqUE/6TcZ6qYz/NlX12U=; b=UzTdI0WcXbUhUNEHnbK/F24clKpRTNrWnEDuKhoTktZlDWdHn9YcHdGI7gg57fKGKwYxLUiROMckG8TiR2jOV+s/q2Ixyr8fVUN9aDc03euhSpjt1Je5sojPjs+hEkbr/8sO27fStgikn9zeEYkXfP+m96jkoow+bilM8XucCybGz19A5Osea5UmzgkYPt8EgCzXUrVLoOeYWSLrtcbxJCVTfyxqrJ2E63NvDe08mLMnvn8HW0dd2avZKvnRV7MmVWVwIayKvKMScek6r0qI9wsjD71zKbBQ18RvzWvB+H+HB/q8LE/NPOqOiWrVK+fo/RnmmnO2jjTdY2Y5TKO4ag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 29 Sep 2026 20:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3675 invoked by uid 111); 29 Sep 2026 20:43:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Sep 2026 16:43:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 29 Sep 2026 16:43:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH 6/5] merge-ll: handle external driver status before reading
 result
Message-ID: <20260929204320.GA1734030@coredump.intra.peff.net>
References: <20260929204157.GA1733321@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260929204157.GA1733321@coredump.intra.peff.net>

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
2.56.0.325.g545d7e68bc

