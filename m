Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D551AB500
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989769; cv=none; b=CAhzkU4P4EQ3l72TobXsVDbvuB6tou+QgGxcTorRmjtrHihAb/S1pVKuLY3OOd7wRSd5jBTvprxnqbE9APwWX3Pc/GLOzEJWjkSn7hSP2RhPowp/fkIgoWvL83h8yX/6Ey3dha+31P5HtANDiAC9cQawSitXiGQp4t3N1UMb7y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989769; c=relaxed/simple;
	bh=F94Fh+XJA+DYvsJ9sSxKltS9TMX7yI12PU7GW7NH/Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBeDkCCUIVmNnc56HhQERhyvNOBRc7OjWTypEwjZVzTitMzmovbH7b4AITFbZ+yhSk2JHdvsU4iRgPCz3Oqxae2V5Pj/0IHVPvcdnSQRk9cNRoXCMcEr4mTyDxFAH43uTG1FQvUeEKWoSEU5uAkGNqSKmLd0ZxqmAtROBqN9uxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=O1Bn5Uj1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="O1Bn5Uj1"
Received: (qmail 19351 invoked by uid 109); 3 Oct 2024 21:09:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F94Fh+XJA+DYvsJ9sSxKltS9TMX7yI12PU7GW7NH/Ds=; b=O1Bn5Uj13GZI3B4S2QaBP5Huuw5aMA+y9M9Gt5u47Z28n5KERJ6UpuLEpdxfQ/TGRaKVJJKw6BwFC5Nmao/uguaG9DJQLAsv4zP/hgOxJUpre8ev6gfKkqiLiro2G+aPPiJS7MBjHiXmzAGQZlx+T7TZbKBAAnnOteU8kqsVfEZ9Jsw0epFJtEIAHyBO9TQh4GnCpe02JBoYJTpV+tC+z1tTiiIjQHsJxdYiba0zfCIIEvH3OQ1J+ZKKvt8CiY6DwyiGHzBfi97Nq2hZ3/57q16BmLS0IT4ytI22p8Ul/fA2v9Xvilw2Tn3jhSNPQMCB/KEdgZLJ6hWQRRxIA/Pwlg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 03 Oct 2024 21:09:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21784 invoked by uid 111); 3 Oct 2024 21:09:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 03 Oct 2024 17:09:25 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 3 Oct 2024 17:09:24 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im
Subject: [PATCH 3/5] diff: return const char from output_prefix callback
Message-ID: <20241003210924.GC11328@coredump.intra.peff.net>
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

The diff_options structure has an output_prefix callback for returning a
prefix string, but it does so by returning a pointer to a strbuf.

This makes the interface awkward. There's no reason the callback should
need to use a strbuf, and it creates questions about whether the
ownership of the resulting buffer should be transferred to the caller
(it should not be, but a recent attempt to clean up this code led to a
double-free in some cases).

The one advantage we get is that the strbuf contains a ptr/len pair, so
we could in theory have a prefix with embedded NULs. But we can observe
that none of the existing callbacks would ever produce such a NUL (they
are usually just indentation or graph symbols, and even the
"--line-prefix" option takes a NUL-terminated string).

And anyway, only one caller (the one in log_tree_diff_flush) actually
looks at the strbuf length. In every other case we use a helper function
which discards the length and just returns the NUL-terminated string.

So let's just have the callback return a "const char *" pointer. It's up
to the callbacks themselves if they want to use a strbuf under the hood.
And now the caller in log_tree_diff_flush() can just use the helper
function along with everybody else. That lets us even simplify out the
function pointer check, since the helper returns an empty string
(technically this does mean we'll sometimes issue an empty fputs() call,
but I don't think this code path is hot enough to care about that).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff-lib.c   | 4 ++--
 diff.c       | 9 +++------
 diff.h       | 2 +-
 graph.c      | 4 ++--
 log-tree.c   | 7 +------
 range-diff.c | 4 ++--
 6 files changed, 11 insertions(+), 19 deletions(-)

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
index 858e001993..6c96154fed 100644
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
index ea3634106d..5c8de79535 100644
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
index 2cee47294f..c046f6285d 100644
--- a/graph.c
+++ b/graph.c
@@ -311,7 +311,7 @@ struct git_graph {
 	unsigned short default_column_color;
 };
 
-static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void *data)
+static const char *diff_output_prefix_callback(struct diff_options *opt, void *data)
 {
 	struct git_graph *graph = data;
 	static struct strbuf msgbuf = STRBUF_INIT;
@@ -323,7 +323,7 @@ static struct strbuf *diff_output_prefix_callback(struct diff_options *opt, void
 		strbuf_addstr(&msgbuf, opt->line_prefix);
 	if (graph)
 		graph_padding_line(graph, &msgbuf);
-	return &msgbuf;
+	return msgbuf.buf;
 }
 
 static const struct diff_options *default_diffopt;
diff --git a/log-tree.c b/log-tree.c
index 3758e0d3b8..33eb96b50c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -922,12 +922,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 			 * diff/diffstat output for readability.
 			 */
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
-			if (opt->diffopt.output_prefix) {
-				struct strbuf *msg = NULL;
-				msg = opt->diffopt.output_prefix(&opt->diffopt,
-					opt->diffopt.output_prefix_data);
-				fwrite(msg->buf, msg->len, 1, opt->diffopt.file);
-			}
+			fputs(diff_line_prefix(&opt->diffopt), opt->diffopt.file);
 
 			/*
 			 * We may have shown three-dashes line early
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
-- 
2.47.0.rc1.384.g9f398d04fd

