Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B18041D11C
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 17:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789146704; cv=none; b=Aa5sVNg3WBTvrlMhUjL/77V7xHpxtCF6FjlUb6qEv7uQz7N86vMYGqiDbz3E11HbH8V4G43r4PfGThke+YKAvrznmwtP97q/lxv8jEHEKZcTfalmPa52EBn5QIh92xIX9wU9zlZRoYWT6d6ODW3BRqkqlrBYV3Gio3gwooeqT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789146704; c=relaxed/simple;
	bh=SQZlPT6lL1OkTSb11JZFSOOnp5N8EN6N/eCCQSbbzUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgAJnH/Q8oRwjryw3pEqhG5Hck+LWZ8nw7AznQIOTUfjfolGsqKUXacfWqMovAIB1IvPhJAM4vBpNQjoT0TI6XggFK2+Omm/X625NiaI4FYifos3vODVIBKxmZOK5PFbCHeQQjZiytdJf8X9aaPmqOzsxJK/bKxG14Io7p/gUc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=bWgs/83W; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="bWgs/83W"
Received: (qmail 34672 invoked by uid 106); 11 Sep 2026 17:11:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SQZlPT6lL1OkTSb11JZFSOOnp5N8EN6N/eCCQSbbzUM=; b=bWgs/83W//2EGGBVEQkF5wHjXLyq5RNeuznQfYOnCLuSTWdOYovEsqAeRxh3UFXNPPV2OTlyODiPwir0tNl79zJr0SbTftgHsvUWPWYvWoUBOTInry6m80WOsVto43SFzoz2JdBv9MMIeSICKjhOBayUxXDLTH2nkmHXO1MSwfDtwapveaG4C90WxlA3IRCQMxUE1/unTZS8oaCPUBCgfF4M6NUJbh1IDhkKtLa6uV4nNwSWRPw8ocKJD2yTbWkx8Xub+UR3IvF0/kLBxqqbx0Txai/UtUe7rMpccmwC4VHbVZZ8oB5ZsifeSWuRf/1FhCww0pbibej4eKbVVan+zQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Sep 2026 17:11:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 173834 invoked by uid 111); 11 Sep 2026 17:11:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Sep 2026 13:11:40 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Sep 2026 13:11:39 -0400
From: Jeff King <peff@peff.net>
To: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc: git@vger.kernel.org, Jean Delvare <jdelvare@suse.de>,
	Elijah Newren <newren@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v2 2/3] merge-ll: catch close() errors when writing external
 tempfiles
Message-ID: <20260911171139.GB1610200@coredump.intra.peff.net>
References: <20260911171044.GA1609692@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260911171044.GA1609692@coredump.intra.peff.net>

When writing out tempfiles for an external merge driver, we catch the
case that write() fails, but not the follow-up close(). This close()
would usually succeed, but the system could report a delayed write error
(e.g., on a network file system).

Signed-off-by: Jeff King <peff@peff.net>
---
 merge-ll.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/merge-ll.c b/merge-ll.c
index 5b6af15e23..5a11a9613b 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -180,9 +180,9 @@ static void create_temp(mmfile_t *src, char *path, size_t len)
 
 	xsnprintf(path, len, ".merge_file_XXXXXX");
 	fd = xmkstemp(path);
-	if (write_in_full(fd, src->ptr, src->size) < 0)
+	if (write_in_full(fd, src->ptr, src->size) < 0 ||
+	    close(fd) < 0)
 		die_errno("unable to write temp-file");
-	close(fd);
 }
 
 /*
-- 
2.56.0.rc0.314.g7a874b6915

