Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C810D3C0C
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894702; cv=none; b=Mv1uigaCDdAMBrWU/L8QW4qyxzbSFwE/CcuCWNL6hakJ8fkyG6weFK1NYMeBHn4LhKxmPF4zcpzIGXvrC0YnEPGHa0YtjZYRbYHwDbBJmhIKQ6JSLJDXcBvXpa0WR1BhEQinbmOTazcpSZvzHAluaZn46uK7DFRnHaiEj9SS8Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894702; c=relaxed/simple;
	bh=t8QFfpaac3Mnegb7iHyYPUlXYopYf6eM/rZITzBchho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdciqroDa+Aou28F9Letx7i/pGYv2JziELg5dykeWuht+W50I9wT1zQPF7eGAlsNN1e72tuYV86Qf010ApRsDWei0ZQBoPRBUewtt/4O4udgCfX0QUN0PNOGyijTfAM0pxVwtcvA4qGZ6m4p2P8Lt/fe/bg3KLkSavY6UR+ASKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5646 invoked by uid 109); 20 Mar 2024 00:31:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:31:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13376 invoked by uid 111); 20 Mar 2024 00:31:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:31:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:31:39 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 4/6] log: do not set up extra_headers for non-email formats
Message-ID: <20240320003139.GD904136@coredump.intra.peff.net>
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

The commit pretty-printer code has an "after_subject" parameter which it
uses to insert extra headers into the email format. In show_log() we set
this by calling log_write_email_headers() if we are using an email
format, but otherwise default the variable to the rev_info.extra_headers
variable.

Since the pretty-printer code will ignore after_subject unless we are
using an email format, this default is pointless. We can just set
after_subject directly, eliminating an extra variable.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is enabled by the previous commits. And after this now both
callers of log_write_email_headers() directly pass in "after_subject",
which makes the next steps easy.

 log-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index c27240a533..a50f79ec60 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -678,7 +678,6 @@ void show_log(struct rev_info *opt)
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : the_hash_algo->hexsz;
-	const char *extra_headers = opt->extra_headers;
 	struct pretty_print_context ctx = {0};
 
 	opt->loginfo = NULL;
@@ -739,7 +738,7 @@ void show_log(struct rev_info *opt)
 	 */
 
 	if (cmit_fmt_is_mail(opt->commit_format)) {
-		log_write_email_headers(opt, commit, &extra_headers,
+		log_write_email_headers(opt, commit, &ctx.after_subject,
 					&ctx.need_8bit_cte, 1);
 		ctx.rev = opt;
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
@@ -807,7 +806,6 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.date_mode_explicit = opt->date_mode_explicit;
 	ctx.abbrev = opt->diffopt.abbrev;
-	ctx.after_subject = extra_headers;
 	ctx.preserve_subject = opt->preserve_subject;
 	ctx.encode_email_headers = opt->encode_email_headers;
 	ctx.reflog_info = opt->reflog_info;
-- 
2.44.0.643.g35f318e502

