Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B16EDC
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 00:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894936; cv=none; b=QLzMqCxE4xg+0kgQ9/e4TIo1GGnQmBTYWwSbgJdzq9MV0XWTGovIPjE5XfjWB5WT67f3N4EaDk/1iMt3esmlteVs9I6vYZR5sDPHulySfCiJlBTfBO5LtCA5Ds24hbVeou6BdURGJxKa5xjGQCBNHls5t7UuaI0MzxzAucD5qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894936; c=relaxed/simple;
	bh=Lc7zjMG18QUtINWLTm7ypNluCwlQXuSBqdp8awCRo5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mq2vC/m2yYrIVVvxsliGjmA3JbLr4fadyaJuOMT0wRiVozb0SNwMpvvpURxK6emn/Kx7WDn2lJTcpiLJBcJzC6FKLlLOV6yrLFiVi5sTx3nuZqAu+bfLXPzWAQILpu86/oMvlLw0IdsZNbhGIIFgKtkhSIG/jrudJraucMFqMTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5655 invoked by uid 109); 20 Mar 2024 00:35:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Mar 2024 00:35:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13430 invoked by uid 111); 20 Mar 2024 00:35:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Mar 2024 20:35:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Mar 2024 20:35:33 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org
Subject: [PATCH 5/6] format-patch: return an allocated string from
 log_write_email_headers()
Message-ID: <20240320003533.GE904136@coredump.intra.peff.net>
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

When pretty-printing a commit in the email format, we have to fill in
the "after subject" field of the pretty_print_context with any extra
headers the user provided (e.g., from "--to" or "--cc" options) plus any
special MIME headers.

We return an out-pointer that sometimes points to a newly heap-allocated
string and sometimes not. To avoid leaking, we store the allocated
version in a buffer with static lifetime, which is ugly. Worse, as we
extend the header feature, we'll end up having to repeat this ugly
pattern.

Instead, let's have our out-pointer pass ownership back to the caller,
and duplicate the string when necessary. This does mean one extra
allocation per commit when you use extra headers, but in the context of
format-patch which is showing diffs, I don't think that's even
measurable.

Signed-off-by: Jeff King <peff@peff.net>
---
I don't think the extra allocation is a big deal, but if we do, there
are some other options:

  - instead of an out-pointer we could take a strbuf, and the caller
    could reset and reuse a strbuf for each commit

  - the after_subject stuff could become a callback; we discussed this a
    long time ago (I had no recollection of the thread until finding it
    in the archive just now):

      https://lore.kernel.org/git/20170325211149.yyvocmdfw4zbjyoi@sigill.intra.peff.net/

  - this log_write_email_headers() function prints part of its output to
    stdout, and shoves part of it into the after_subject field to be
    shown by the pretty-printer. I wonder if it could just format the
    subject itself (though that would make "rev-list --format=email"
    even more awkward, I guess).

 builtin/log.c |  1 +
 log-tree.c    | 11 ++++++-----
 log-tree.h    |  2 +-
 pretty.h      |  2 +-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 071a7f3131..c0a8bb95e9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1370,6 +1370,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			   encoding, need_8bit_cte);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
+	free(pp.after_subject);
 	strbuf_release(&sb);
 
 	shortlog_init(&log);
diff --git a/log-tree.c b/log-tree.c
index a50f79ec60..5092a75958 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -470,11 +470,11 @@ void fmt_output_email_subject(struct strbuf *sb, struct rev_info *opt)
 }
 
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart)
 {
-	const char *extra_headers = opt->extra_headers;
+	char *extra_headers = xstrdup_or_null(opt->extra_headers);
 	const char *name = oid_to_hex(opt->zero_commit ?
 				      null_oid() : &commit->object.oid);
 
@@ -496,12 +496,11 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 		graph_show_oneline(opt->graph);
 	}
 	if (opt->mime_boundary && maybe_multipart) {
-		static struct strbuf subject_buffer = STRBUF_INIT;
+		struct strbuf subject_buffer = STRBUF_INIT;
 		static struct strbuf buffer = STRBUF_INIT;
 		struct strbuf filename =  STRBUF_INIT;
 		*need_8bit_cte_p = -1; /* NEVER */
 
-		strbuf_reset(&subject_buffer);
 		strbuf_reset(&buffer);
 
 		strbuf_addf(&subject_buffer,
@@ -519,7 +518,8 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 			 extra_headers ? extra_headers : "",
 			 mime_boundary_leader, opt->mime_boundary,
 			 mime_boundary_leader, opt->mime_boundary);
-		extra_headers = subject_buffer.buf;
+		free(extra_headers);
+		extra_headers = strbuf_detach(&subject_buffer, NULL);
 
 		if (opt->numbered_files)
 			strbuf_addf(&filename, "%d", opt->nr);
@@ -854,6 +854,7 @@ void show_log(struct rev_info *opt)
 
 	strbuf_release(&msgbuf);
 	free(ctx.notes_message);
+	free(ctx.after_subject);
 
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->idiff_oid1) {
 		struct diff_queue_struct dq;
diff --git a/log-tree.h b/log-tree.h
index 41c776fea5..94978e2c83 100644
--- a/log-tree.h
+++ b/log-tree.h
@@ -29,7 +29,7 @@ void format_decorations(struct strbuf *sb, const struct commit *commit,
 			int use_color, const struct decoration_options *opts);
 void show_decorations(struct rev_info *opt, struct commit *commit);
 void log_write_email_headers(struct rev_info *opt, struct commit *commit,
-			     const char **extra_headers_p,
+			     char **extra_headers_p,
 			     int *need_8bit_cte_p,
 			     int maybe_multipart);
 void load_ref_decorations(struct decoration_filter *filter, int flags);
diff --git a/pretty.h b/pretty.h
index 021bc1d658..9cc9e5d42b 100644
--- a/pretty.h
+++ b/pretty.h
@@ -35,7 +35,7 @@ struct pretty_print_context {
 	 */
 	enum cmit_fmt fmt;
 	int abbrev;
-	const char *after_subject;
+	char *after_subject;
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-- 
2.44.0.643.g35f318e502

