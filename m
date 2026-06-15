Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FE740FD86
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 16:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542418; cv=none; b=sHy3ne84Ts7RUFMLhLnDur3j2kSkVuG5vHIU3xSTI9FeoAlpKYwsWlJBFUbXV4FKbriNcBnKz36yjrzLMuJ76uKt8dbvTMIqSsps7dZN1EngaryUMBD+xMk2STWpmgDkeRmIjM2kk9Y+JvF1Wduh0ozmB+UCE8QMOYJEvrTMRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542418; c=relaxed/simple;
	bh=nufY0y73GDdLn6YV3u/l7mWQl3IzD7gAu1AWMgdIkzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJO5KUDQHPHSar/zlkb6T6nASIC28pYaMQHw088B3rWjCN/kh63b+glZsGGlJqSzJwBlT0vyq6mpKWvQfKyrkU5Nh/GtaBaxHwuQjrR2AsWXCXtErY2cNAvX79mmy8rgKccPLIlPxaysZX13cadkLVd4l9MUY+rC+NNAorR0DBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JztOCdsb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JztOCdsb"
Received: (qmail 144180 invoked by uid 106); 15 Jun 2026 16:53:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=nufY0y73GDdLn6YV3u/l7mWQl3IzD7gAu1AWMgdIkzY=; b=JztOCdsbLq/EO3uroOj7brB7koA/GxJ+9iUBhcmk/uHpC8QuiG9x52EZ6UN07BxW2eksEBPpn6PJCqq8xFXRKUgcZtZ+uUMMr9NGTUMh3sP4stWC4jMbgxSyVZjrwa/OUBkzrz/SZtV1tM6/b1EPjc8h8NVrjvqa1QKkDGIFlMT3q3SGU0LoG1mpzGRpfJ/ERWCQqhSGYB7SK8kdx61zyGdZoxdjseM45rIoFbXyiLr+Rl8Ki5RIG87pfukvxZZg16Q+1seyKuS4iI+HOq8y2dWb649KlOjTtIe03uv1zK993RGixhi7ZmihWj+17tbUU0I4vHOld6D7iD6Sf4f63Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jun 2026 16:53:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 394227 invoked by uid 111); 15 Jun 2026 16:53:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jun 2026 12:53:28 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jun 2026 12:53:26 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
Message-ID: <20260615165326.GA91269@coredump.intra.peff.net>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>

On Sun, Jun 14, 2026 at 06:28:34PM +0200, René Scharfe wrote:

> eb54a3391b (cat-file: skip expanding default format, 2022-03-15) added
> special handling for the default batch format.  In the meantime it has
> fallen behind the code path for handling arbitrary formats.  Bring it up
> to speed by using the new and more efficient strbuf_add_oid_hex() and
> strbuf_add_uint() instead of strbuf_addf():
> 
> Benchmark 1: ./git_main cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
>   Time (mean ± σ):      1.051 s ±  0.003 s    [User: 1.027 s, System: 0.023 s]
>   Range (min … max):    1.049 s …  1.058 s    10 runs
> 
> Benchmark 2: ./git_main cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
>   Time (mean ± σ):      1.012 s ±  0.002 s    [User: 0.988 s, System: 0.023 s]
>   Range (min … max):    1.010 s …  1.018 s    10 runs
> 
> Benchmark 3: ./git cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
>   Time (mean ± σ):     979.0 ms ±   1.1 ms    [User: 954.1 ms, System: 23.2 ms]
>   Range (min … max):   977.7 ms … 980.8 ms    10 runs

Interesting that it was actually slower than a custom format.  Using the
default format saves the cost of strbuf_expand(), but it was paying the
price of strbuf_addf(), which the custom path no longer used. So the
cost of strbuf_addf() is more than strbuf_expand(), which is not all
that surprising.

Your patch seems obviously right, and everything below is idle
speculation / nerd-sniping.

I have long wondered if we could do better with a separate initial parse
step, which would let us walk the parse tree for each object. In theory
that tree is more compact.

I think it would be a huge improvement for ref-filter, whose parser is
complicated and slow (though its biggest sin is that it allocates a
separate string for each atom before assembling the final output). But
could it help even cat-file, which is using a pretty tight loop over
strbuf_expand()? I sketched out a rough draft below.

It uses per-atom callback functions which is nice and clean, though we
might be able to do even better with a big ugly switch() statement.

The timings I got are below (git.old is master with your patch here
applied, and git.new is my patch on top). It looks like it does make a
custom format ~3% faster. But it's still a shade slower than the default
format. Not sure if it's the extra function calls, or if the static
print_default_format() function gives the compiler more opportunities
for optimization.

  Benchmark 1: ./git.old cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
    Time (mean ± σ):     580.2 ms ±   5.0 ms    [User: 558.7 ms, System: 21.5 ms]
    Range (min … max):   569.9 ms … 585.6 ms    10 runs
  
  Benchmark 2: ./git.new cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
    Time (mean ± σ):     580.4 ms ±   5.1 ms    [User: 562.7 ms, System: 17.8 ms]
    Range (min … max):   571.8 ms … 587.0 ms    10 runs
  
  Benchmark 3: ./git.old cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
    Time (mean ± σ):     618.6 ms ±   5.0 ms    [User: 598.9 ms, System: 19.7 ms]
    Range (min … max):   613.6 ms … 628.3 ms    10 runs
  
  Benchmark 4: ./git.new cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
    Time (mean ± σ):     600.2 ms ±   4.2 ms    [User: 581.2 ms, System: 19.0 ms]
    Range (min … max):   595.2 ms … 608.8 ms    10 runs
  
  Summary
    ./git.old cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)' ran
      1.00 ± 0.01 times faster than ./git.new cat-file --batch-all-objects --batch-check='%(objectname) %(objecttype) %(objectsize)'
      1.03 ± 0.01 times faster than ./git.new cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'
      1.07 ± 0.01 times faster than ./git.old cat-file --batch-all-objects --batch-check='%(objectname)-%(objecttype)-%(objectsize)'

Patch below, only lightly tested.

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index d7f7895e30..9cc7ec7a6f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -36,6 +36,8 @@ enum batch_mode {
 	BATCH_MODE_QUEUE_AND_DISPATCH,
 };
 
+struct format_item;
+
 struct batch_options {
 	struct list_objects_filter_options objects_filter;
 	int enabled;
@@ -48,6 +50,7 @@ struct batch_options {
 	char input_delim;
 	char output_delim;
 	const char *format;
+	struct format_item *parsed_format;
 };
 
 static const char *force_path;
@@ -294,12 +297,6 @@ struct expand_data {
 	const char *rest;
 	struct object_id delta_base_oid;
 
-	/*
-	 * If mark_query is true, we do not expand anything, but rather
-	 * just mark the object_info with items we wish to query.
-	 */
-	int mark_query;
-
 	/*
 	 * Whether to split the input on whitespace before feeding it to
 	 * get_sha1; this is decided during the mark_query phase based on
@@ -323,65 +320,152 @@ struct expand_data {
 };
 #define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
+struct format_item {
+	void (*add)(struct format_item *item, struct strbuf *sb, struct expand_data *data);
+	union {
+		struct {
+			const char *p;
+			size_t len;
+		} literal;
+	} u;
+	/*
+	 * We could make a true tree here with child/next pointers, which would
+	 * be necessary if we had recursive formats, like %(if). But for our
+	 * simple formats for now it is enough to have a linear set of items,
+	 * so we'll just allocate an array and terminate it with a NULL entry.
+	 */
+};
+
+static void objectname_add(struct format_item *item UNUSED,
+			   struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_add_oid_hex(sb, &data->oid);
+}
+
+static void objecttype_add(struct format_item *item UNUSED,
+			   struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_addstr(sb, type_name(data->type));
+}
+
+static void objectsize_add(struct format_item *item UNUSED,
+			   struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_add_uint(sb, data->size);
+}
+
+static void objectsize_disk_add(struct format_item *item UNUSED,
+				struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_add_uint(sb, data->disk_size);
+}
+
+static void rest_add(struct format_item *item UNUSED,
+		     struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_addstr(sb, data->rest);
+}
+
+static void deltabase_add(struct format_item *item UNUSED,
+			  struct strbuf *sb, struct expand_data *data)
+{
+	strbuf_add_oid_hex(sb, &data->delta_base_oid);
+}
+
+static void objectmode_add(struct format_item *item UNUSED,
+			   struct strbuf *sb, struct expand_data *data)
+{
+	if (data->mode != S_IFINVALID)
+		strbuf_addf(sb, "%06o", data->mode);
+}
+
+static void literal_add(struct format_item *item,
+			struct strbuf *sb, struct expand_data *data UNUSED)
+{
+	strbuf_add(sb, item->u.literal.p, item->u.literal.len);
+}
+
 static int is_atom(const char *atom, const char *s, int slen)
 {
 	int alen = strlen(atom);
 	return alen == slen && !memcmp(atom, s, alen);
 }
 
-static int expand_atom(struct strbuf *sb, const char *atom, int len,
-		       struct expand_data *data)
+static int parse_atom(struct format_item *fmt, const char *atom, int len,
+		      struct expand_data *data)
 {
 	if (is_atom("objectname", atom, len)) {
-		if (!data->mark_query)
-			strbuf_add_oid_hex(sb, &data->oid);
+		fmt->add = objectname_add;
 	} else if (is_atom("objecttype", atom, len)) {
-		if (data->mark_query)
-			data->info.typep = &data->type;
-		else
-			strbuf_addstr(sb, type_name(data->type));
+		data->info.typep = &data->type;
+		fmt->add = objecttype_add;
 	} else if (is_atom("objectsize", atom, len)) {
-		if (data->mark_query)
-			data->info.sizep = &data->size;
-		else
-			strbuf_add_uint(sb, data->size);
+		data->info.sizep = &data->size;
+		fmt->add = objectsize_add;
 	} else if (is_atom("objectsize:disk", atom, len)) {
-		if (data->mark_query)
-			data->info.disk_sizep = &data->disk_size;
-		else
-			strbuf_add_uint(sb, data->disk_size);
+		data->info.disk_sizep = &data->disk_size;
+		fmt->add = objectsize_disk_add;
 	} else if (is_atom("rest", atom, len)) {
-		if (data->mark_query)
-			data->split_on_whitespace = 1;
-		else if (data->rest)
-			strbuf_addstr(sb, data->rest);
+		data->split_on_whitespace = 1;
+		fmt->add = rest_add;
 	} else if (is_atom("deltabase", atom, len)) {
-		if (data->mark_query)
-			data->info.delta_base_oid = &data->delta_base_oid;
-		else
-			strbuf_add_oid_hex(sb, &data->delta_base_oid);
+		data->info.delta_base_oid = &data->delta_base_oid;
+		fmt->add = deltabase_add;
 	} else if (is_atom("objectmode", atom, len)) {
-		if (!data->mark_query && !(S_IFINVALID == data->mode))
-			strbuf_addf(sb, "%06o", data->mode);
+		fmt->add = objectmode_add;
 	} else
 		return 0;
 	return 1;
 }
 
-static void expand_format(struct strbuf *sb, const char *start,
-			  struct expand_data *data)
+static struct format_item *parse_format(const char *start,
+					struct expand_data *data)
 {
-	while (strbuf_expand_step(sb, &start)) {
+	struct format_item *ret = NULL;
+	size_t nr = 0, alloc = 0;
+
+	while (1) {
+		const char *percent = strchrnul(start, '%');
 		const char *end;
 
-		if (skip_prefix(start, "%", &start) || *start != '(')
-			strbuf_addch(sb, '%');
-		else if ((end = strchr(start + 1, ')')) &&
-			 expand_atom(sb, start + 1, end - start - 1, data))
+		if (percent != start) {
+			ALLOC_GROW(ret, nr + 1, alloc);
+			ret[nr].add = literal_add;
+			ret[nr].u.literal.p = start;
+			ret[nr].u.literal.len = percent - start;
+			nr++;
+		}
+
+		if (!*percent)
+			break;
+
+		start = percent + 1;
+
+		ALLOC_GROW(ret, nr + 1, alloc);
+		if (skip_prefix(start, "%", &start) || *start != '(') {
+			ret[nr].add = literal_add;
+			ret[nr].u.literal.p = "%";
+			ret[nr].u.literal.len = 1;
+		} else if ((end = strchr(start + 1, ')')) &&
+			   parse_atom(&ret[nr], start + 1, end - start - 1, data)) {
 			start = end + 1;
-		else
+		} else {
 			strbuf_expand_bad_format(start, "cat-file");
+		}
+		nr++;
 	}
+
+	ALLOC_GROW(ret, nr + 1, alloc);
+	ret[nr].add = NULL;
+
+	return ret;
+}
+
+static void expand_format(struct strbuf *sb, struct format_item *fmt,
+			  struct expand_data *data)
+{
+	for (; fmt->add; fmt++)
+		fmt->add(fmt, sb, data);
 }
 
 static void batch_write(struct batch_options *opt, const void *data, int len)
@@ -568,7 +652,7 @@ static void batch_object_write(const char *obj_name,
 	if (!opt->format) {
 		print_default_format(scratch, data, opt);
 	} else {
-		expand_format(scratch, opt->format, data);
+		expand_format(scratch, opt->parsed_format, data);
 		strbuf_addch(scratch, opt->output_delim);
 	}
 
@@ -936,17 +1020,9 @@ static int batch_objects(struct batch_options *opt)
 	int save_warning;
 	int retval = 0;
 
-	/*
-	 * Expand once with our special mark_query flag, which will prime the
-	 * object_info to be handed to odb_read_object_info_extended for each
-	 * object.
-	 */
-	data.mark_query = 1;
-	expand_format(&output,
-		      opt->format ? opt->format : DEFAULT_FORMAT,
-		      &data);
-	data.mark_query = 0;
-	strbuf_release(&output);
+	opt->parsed_format = parse_format(opt->format ?
+					  opt->format : DEFAULT_FORMAT,
+					  &data);
 	if (opt->transform_mode)
 		data.split_on_whitespace = 1;
 
