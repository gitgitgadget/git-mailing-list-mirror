Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDC31860
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894439; cv=none; b=smA2126IGsVljCYjw/zRPlYpbDltuTRaDWpQ0tVTt32Rj8Ml2GhnoccdFuOnGL/3cEpkFWdB7BS5UlSMR2f36rMUu0QS/cCF9m+vfPBqDlSynaycjKMly/zcOvnYp5cEsOnDafuUKRkxrqYY++ZhG+D2r9Q9APqTg/FfQM1lFbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894439; c=relaxed/simple;
	bh=gdK8oHsPPDrTwT0C8oMeT/YQEOGL0EuoXkw7aCnqoUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgrJ0Vo/LAniROx8F35eeSari/qc/9xIgGViuzApdJH091CtfOX01ukitANjmdPXqQ3U+NoZT8zw19Q2WkR26MEBkXDlvHG2fbGWxRfSkTAhes5LLGami/eXm4oIeQ7zevz8JGNuX6+VnulpfE6tGSf6WYQESbwCopWGvhAByns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5628 invoked by uid 109); 20 Mar 2024 00:27:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:27:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13325 invoked by uid 111); 20 Mar 2024 00:27:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:27:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:27:16 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 1/6] shortlog: stop setting pp.print_email_subject
Message-ID: <20240320002716.GA904136@coredump.intra.peff.net>
References: <20240320002555.GB903718@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320002555.GB903718@coredump.intra.peff.net>

When shortlog processes a commit using its internal traversal, it may
pretty-print the subject line for the summary view. When we do so, we
set the "print_email_subject" flag in the pretty-print context. But this
flag does nothing! Since we are using CMIT_FMT_USERFORMAT, we skip most
of the usual formatting code entirely.

This flag is there due to commit 6d167fd7cc (pretty: use
fmt_output_email_subject(), 2017-03-01). But that just switched us away
from setting an empty "subject" header field, which was similarly
useless. That was added by dd2e794a21 (Refactor pretty_print_commit
arguments into a struct, 2009-10-19). Before using the struct, we had to
pass _something_ as the argument, so we passed the empty string (a NULL
would have worked equally well).

So this setting has never done anything, and we can drop the line. That
shortens the code, but more importantly, makes it easier to reason about
and refactor the other users of this flag.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/shortlog.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1307ed2b88..3c7cd2d6ef 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -245,7 +245,6 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 
 	ctx.fmt = CMIT_FMT_USERFORMAT;
 	ctx.abbrev = log->abbrev;
-	ctx.print_email_subject = 1;
 	ctx.date_mode = log->date_mode;
 	ctx.output_encoding = get_log_output_encoding();
 
-- 
2.44.0.643.g35f318e502

