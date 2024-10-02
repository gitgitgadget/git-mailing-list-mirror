Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3A14B972
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727913404; cv=none; b=ff4AKX9eno42aVW8Jf89SEKusXaZ8xO+lR1xvLOHIa8/CB39fsYSioRCrKLWSVRTJPOksAUU8gT+XVlWt1nQjn94c+94fV99Mn3WQR8GO3kYUyxjl+QaWamp5g9J3j4AzAJKjzRGuFSkVY6MNPI+XHLmWVLFPkVwp9reTdvMmZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727913404; c=relaxed/simple;
	bh=EcGxYkvfEPFPMDJUZnokfG5a6cOniTkl099aSQIRneY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsH1wBLggrv3IasVBdIMJKYQMrvJoUikNEnQhb75kLMLLW36KWuDNaK1WDfuBnYmMoRA2cU0g4Ca0xg2kPzQUyd6mE23lBDHDqqs4VMo2ovYBOqqA33HViFRj44DhxoMvBNPeckR2urJqF+iOcuJrsYatlORhShvgG6yfclV/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IFD9kg/o; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IFD9kg/o"
Received: (qmail 10805 invoked by uid 109); 2 Oct 2024 23:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EcGxYkvfEPFPMDJUZnokfG5a6cOniTkl099aSQIRneY=; b=IFD9kg/oCdgGM+XzDxq7kaJxNlbARkZ+kZcNc5jFp1Ej7MK94kdaPagFoB98uyoiXMwZy05jEnDoCX47vGJX1JDSqpegMBCNJVanAqff4R9EguIFVT8WuEnOwLk7lARTvlhZrz/VcdJgo9AYD6EfU3XpJUU2+mZYYSKZ9W5B8jP1tHmurHpmUuHLX0vz2K/rs++DHXo4n8avpAbN1paOFCIUZ+TFFUjxFjpXtJqWBFFUoioEtTTJx/1pFI4yKWnzox3SuFSCBjC/KHNoSu2jIFZAHx6/cncggo5VmKXgYJoemNdLfLEZUFAgiWNdJ+fSlAqh1WgiHlW91ng4jWCdUg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Oct 2024 23:56:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10820 invoked by uid 111); 2 Oct 2024 23:56:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Oct 2024 19:56:39 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 2 Oct 2024 19:56:39 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] line-log: protect inner strbuf from free
Message-ID: <20241002235639.GB3455554@coredump.intra.peff.net>
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>

On Wed, Oct 02, 2024 at 04:07:04PM +0000, Derrick Stolee via GitGitGadget wrote:

> The output_prefix() method in line-log.c may call a function pointer via
> the diff_options struct. This function pointer returns a strbuf struct
> and then its buffer is passed back. However, that implies that the
> consumer is responsible to free the string. This is especially true
> because the default behavior is to duplicate the empty string.
> 
> The existing functions used in the output_prefix pointer include:
> 
>  1. idiff_prefix_cb() in diff-lib.c. This returns the data pointer, so
>     the value exists across multiple calls.
> 
>  2. diff_output_prefix_callback() in graph.c. This uses a static strbuf
>     struct, so it reuses buffers across calls. These should not be
>     freed.
> 
>  3. output_prefix_cb() in range-diff.c. This is similar to the
>     diff-lib.c case.
> 
> In each case, we should not be freeing this buffer. We can convert the
> output_prefix() function to return a const char pointer and stop freeing
> the result.
> 
> This choice is essentially the opposite of what was done in 394affd46d
> (line-log: always allocate the output prefix, 2024-06-07).
> 
> This was discovered via 'valgrind' while investigating a public report
> of a bug in 'git log --graph -L' [1].

Good catch. Your analysis looks correct, though I had two questions I
managed to answer myself:

  1. This seems like an obvious use-after-free problem. Why didn't we
     catch it sooner? I think the answer is that most uses of the
     output_prefix callback happen via diff_line_prefix(), which was not
     broken by 394affd46d. It's only line-log that was affected.

     Building with ASan and running:

       ./git log --graph -L :diff_line_prefix:diff.c

     shows the problem immediately (and that your patch fixes it).
     Should we include a new test in this patch?

  2. If the caller isn't freeing it, then who does? Should diffopt
     cleanup do so? The answer is "no", the pointer is not owned by that
     struct. In your cases (1) and (3), the caller does so after
     finishing with the diffopt struct. In case (2) it is effectively
     "leaked", but still reachable by the static strbuf. That's not
     great, and is a problem for eventual libification. But for now, we
     can ignore it as it won't trigger the leak-checker.

     It does make me wonder what leak Patrick saw that caused him to
     write 394affd46d, and whether we're now leaking in some case that
     I'm missing.

I do think this would have been a harder mistake to make if the callback
simply returned a "const char *" pointer. We'd lose the ability to show
prefixes with embedded NULs, but I'm not sure that's a big deal. It
would also help for line-log to use the existing helper rather than
inventing its own. So together on top something like this (which I'd
probably turn into two patches if this seems to others like it's
valuable and not just churn):

 diff-lib.c   |  4 ++--
 diff.c       |  9 +++------
 diff.h       |  2 +-
 graph.c      |  4 ++--
 line-log.c   | 14 ++------------
 log-tree.c   |  7 +++----
 range-diff.c |  4 ++--
 7 files changed, 15 insertions(+), 29 deletions(-)

diff --git a/diff-lib.c b/diff-lib.c
index a680768ee7..6b14b95962 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -701,7 +701,7 @@ int index_differs_from(struct repository *r,
 	return (has_changes != 0);
 }
 
-static struct strbuf *idiff_prefix_cb(struct diff_options *opt UNUSED, void *data)
+static const char *idiff_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
@@ -716,7 +716,7 @@ void show_interdiff(const struct object_id *oid1, const struct object_id *oid2,
 	opts.output_format = DIFF_FORMAT_PATCH;
 	opts.output_prefix = idiff_prefix_cb;
 	strbuf_addchars(&prefix, ' ', indent);
-	opts.output_prefix_data = &prefix;
+	opts.output_prefix_data = prefix.buf;
 	diff_setup_done(&opts);
 
 	diff_tree_oid(oid1, oid2, "", &opts);
diff --git a/diff.c b/diff.c
index 173cbe2bed..efde65feef 100644
--- a/diff.c
+++ b/diff.c
@@ -2317,12 +2317,9 @@ const char *diff_get_color(int diff_use_color, enum color_diff ix)
 
 const char *diff_line_prefix(struct diff_options *opt)
 {
-	struct strbuf *msgbuf;
-	if (!opt->output_prefix)
-		return "";
-
-	msgbuf = opt->output_prefix(opt, opt->output_prefix_data);
-	return msgbuf->buf;
+	return opt->output_prefix ?
+		opt->output_prefix(opt, opt->output_prefix_data) :
+		"";
 }
 
 static unsigned long sane_truncate_line(char *line, unsigned long len)
diff --git a/diff.h b/diff.h
index 0cde3b34e2..2a9c9191c1 100644
--- a/diff.h
+++ b/diff.h
@@ -94,7 +94,7 @@ typedef void (*add_remove_fn_t)(struct diff_options *options,
 typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 		struct diff_options *options, void *data);
 
-typedef struct strbuf *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
+typedef const char *(*diff_prefix_fn_t)(struct diff_options *opt, void *data);
 
 #define DIFF_FORMAT_RAW		0x0001
 #define DIFF_FORMAT_DIFFSTAT	0x0002
diff --git a/graph.c b/graph.c
index 091c14cf4f..ebb7d1e66f 100644
--- a/graph.c
+++ b/graph.c
@@ -314,7 +314,7 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
-static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
+static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
@@ -327,7 +327,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 			   opt->line_prefix_length);
 	if (graph)
 		graph_padding_line(graph, &msgbuf);
-	return &msgbuf;
+	return msgbuf.buf;
 }
 
 static const struct diff_options *default_diffopt;
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
 
diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8..1b80abe7d5 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -923,10 +923,9 @@ int log_tree_diff_flush(struct rev_info *opt)
 			 */
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if (opt->diffopt.output_prefix) {
-				struct strbuf *msg = NULL;
-				msg = opt->diffopt.output_prefix(&opt->diffopt,
-					opt->diffopt.output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, opt->diffopt.file);
+				fputs(opt->diffopt.output_prefix(&opt->diffopt,
+								 opt->diffopt.output_prefix_data),
+				      opt->diffopt.file);
 			}
 
 			/*
diff --git a/range-diff.c b/range-diff.c
index bbb0952264..10885ba301 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -480,7 +480,7 @@ static void patch_diff(const char *a, const char *b,
 	diff_flush(diffopt);
 }
 
-static struct strbuf *output_prefix_cb(struct diff_options *opt UNUSED, void *data)
+static const char *output_prefix_cb(struct diff_options *opt UNUSED, void *data)
 {
 	return data;
 }
@@ -508,7 +508,7 @@ static void output(struct string_list *a, struct string_list *b,
 	opts.flags.suppress_hunk_header_line_count = 1;
 	opts.output_prefix = output_prefix_cb;
 	strbuf_addstr(&indent, "    ");
-	opts.output_prefix_data = &indent;
+	opts.output_prefix_data = indent.buf;
 	diff_setup_done(&opts);
 
 	/*
