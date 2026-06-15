Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D37A40E8D8
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 17:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781543216; cv=none; b=ekb9Q5KqjSn8CdAy2NKW5h7I5JWrfiLoFzDUvhBo+hvmSv47cMq3zoEGfIvcBgLtKMvDN6egHF67rMsKdm+RA/09f4YXyMA32JC8/JhTgxPVb57BR/Q6j6kuJUfj74ZfFzXPfgCU+83Nu932K+/KNnqY/N6VoSt63Q7b2dxdRHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781543216; c=relaxed/simple;
	bh=X/Q1xR1avxPpgjtwsSsntrSxuw5/EH3BY7ATn8fbpoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2+zXG2i+QXL/z85eUSR97XX89QVOs8sEfqlyLvoeDBA7nbkve71QiNQBA+0to7b9bn1BXbzyGKlSKbr6SzF8m+tvG6WyRP99FLO8psX4D2hrOu6G6GjKWYVRBsdXvxLfKoGfICDccRa6Un7lEirVV6SlLIpKGI2MuUJ3cawd4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ems0VX8H; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ems0VX8H"
Received: (qmail 144211 invoked by uid 106); 15 Jun 2026 17:06:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=X/Q1xR1avxPpgjtwsSsntrSxuw5/EH3BY7ATn8fbpoo=; b=Ems0VX8H4J1JNxHzeYu9rdJls5ZYlW2A9klM40u72u60COlt54xtdw43unzY9vqJDwT9fXHEgJ4S1aFXlcRjCdRW0aCaa5w2KLQBO5Sjjm+5tggx8ijz8gkHI+stXfQAhfWew4maTeZZDo+nPYRe2nm4bDHyoTYtLZ1E9SD/SMv7s4zzcJ3dQWkkWKqb7UclAadPv+iYrSVvsdCQJeFbXdXAhiqdiRNG5bqAGpyZDuVYk8cj/NZ8x0Zd1aEwVY5PAgpUBXfjgRuXu7c4KxKIKBfxoURFauYyWu8Rm9NEQif5o6TkfrMekksDftBBwslrEkP1qmcXLeoXFLIc5m1d5w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jun 2026 17:06:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 394325 invoked by uid 111); 15 Jun 2026 17:06:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jun 2026 13:06:54 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jun 2026 13:06:52 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] cat-file: speed up default format
Message-ID: <20260615170652.GB91269@coredump.intra.peff.net>
References: <5a7ed929-6fe0-496c-83bd-65dee57c2241@web.de>
 <20260615165326.GA91269@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615165326.GA91269@coredump.intra.peff.net>

On Mon, Jun 15, 2026 at 12:53:26PM -0400, Jeff King wrote:

> It uses per-atom callback functions which is nice and clean, though we
> might be able to do even better with a big ugly switch() statement.

Being the curious sort, I swapped it out for a big switch statement.
Patch below, but it does not seem to be any faster.

So the bottom line is I think you could gain a little bit of performance
by pre-parsing (versus strbuf_expand() on each object). Around 3% for
something that actually looks at the objects, though more like 15% if
for just dumping the objectnames.

IMHO that is probably not worth it for a custom parsing system just for
cat-file.  But if we were to finally unify ref-filter and cat-file (and
even --pretty=format) then it would probably worth doing this kind of
pre-parsing.

---
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9cc7ec7a6f..da6ecc61f9 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -321,7 +321,17 @@ struct expand_data {
 #define EXPAND_DATA_INIT  { .mode = S_IFINVALID }
 
 struct format_item {
-	void (*add)(struct format_item *item, struct strbuf *sb, struct expand_data *data);
+	enum {
+		FORMAT_TYPE_END = 0,
+		FORMAT_TYPE_LITERAL,
+		FORMAT_TYPE_OBJECTNAME,
+		FORMAT_TYPE_OBJECTTYPE,
+		FORMAT_TYPE_OBJECTSIZE,
+		FORMAT_TYPE_OBJECTSIZE_DISK,
+		FORMAT_TYPE_REST,
+		FORMAT_TYPE_DELTABASE,
+		FORMAT_TYPE_OBJECTMODE,
+	} type;
 	union {
 		struct {
 			const char *p;
@@ -336,55 +346,6 @@ struct format_item {
 	 */
 };
 
-static void objectname_add(struct format_item *item UNUSED,
-			   struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_add_oid_hex(sb, &data->oid);
-}
-
-static void objecttype_add(struct format_item *item UNUSED,
-			   struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_addstr(sb, type_name(data->type));
-}
-
-static void objectsize_add(struct format_item *item UNUSED,
-			   struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_add_uint(sb, data->size);
-}
-
-static void objectsize_disk_add(struct format_item *item UNUSED,
-				struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_add_uint(sb, data->disk_size);
-}
-
-static void rest_add(struct format_item *item UNUSED,
-		     struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_addstr(sb, data->rest);
-}
-
-static void deltabase_add(struct format_item *item UNUSED,
-			  struct strbuf *sb, struct expand_data *data)
-{
-	strbuf_add_oid_hex(sb, &data->delta_base_oid);
-}
-
-static void objectmode_add(struct format_item *item UNUSED,
-			   struct strbuf *sb, struct expand_data *data)
-{
-	if (data->mode != S_IFINVALID)
-		strbuf_addf(sb, "%06o", data->mode);
-}
-
-static void literal_add(struct format_item *item,
-			struct strbuf *sb, struct expand_data *data UNUSED)
-{
-	strbuf_add(sb, item->u.literal.p, item->u.literal.len);
-}
-
 static int is_atom(const char *atom, const char *s, int slen)
 {
 	int alen = strlen(atom);
@@ -395,24 +356,24 @@ static int parse_atom(struct format_item *fmt, const char *atom, int len,
 		      struct expand_data *data)
 {
 	if (is_atom("objectname", atom, len)) {
-		fmt->add = objectname_add;
+		fmt->type = FORMAT_TYPE_OBJECTNAME;
 	} else if (is_atom("objecttype", atom, len)) {
 		data->info.typep = &data->type;
-		fmt->add = objecttype_add;
+		fmt->type = FORMAT_TYPE_OBJECTTYPE;
 	} else if (is_atom("objectsize", atom, len)) {
 		data->info.sizep = &data->size;
-		fmt->add = objectsize_add;
+		fmt->type = FORMAT_TYPE_OBJECTSIZE;
 	} else if (is_atom("objectsize:disk", atom, len)) {
 		data->info.disk_sizep = &data->disk_size;
-		fmt->add = objectsize_disk_add;
+		fmt->type = FORMAT_TYPE_OBJECTSIZE_DISK;
 	} else if (is_atom("rest", atom, len)) {
 		data->split_on_whitespace = 1;
-		fmt->add = rest_add;
+		fmt->type = FORMAT_TYPE_REST;
 	} else if (is_atom("deltabase", atom, len)) {
 		data->info.delta_base_oid = &data->delta_base_oid;
-		fmt->add = deltabase_add;
+		fmt->type = FORMAT_TYPE_DELTABASE;
 	} else if (is_atom("objectmode", atom, len)) {
-		fmt->add = objectmode_add;
+		fmt->type = FORMAT_TYPE_OBJECTMODE;
 	} else
 		return 0;
 	return 1;
@@ -430,7 +391,7 @@ static struct format_item *parse_format(const char *start,
 
 		if (percent != start) {
 			ALLOC_GROW(ret, nr + 1, alloc);
-			ret[nr].add = literal_add;
+			ret[nr].type = FORMAT_TYPE_LITERAL;
 			ret[nr].u.literal.p = start;
 			ret[nr].u.literal.len = percent - start;
 			nr++;
@@ -443,7 +404,7 @@ static struct format_item *parse_format(const char *start,
 
 		ALLOC_GROW(ret, nr + 1, alloc);
 		if (skip_prefix(start, "%", &start) || *start != '(') {
-			ret[nr].add = literal_add;
+			ret[nr].type = FORMAT_TYPE_LITERAL;
 			ret[nr].u.literal.p = "%";
 			ret[nr].u.literal.len = 1;
 		} else if ((end = strchr(start + 1, ')')) &&
@@ -456,16 +417,44 @@ static struct format_item *parse_format(const char *start,
 	}
 
 	ALLOC_GROW(ret, nr + 1, alloc);
-	ret[nr].add = NULL;
+	ret[nr].type = FORMAT_TYPE_END;
 
 	return ret;
 }
 
 static void expand_format(struct strbuf *sb, struct format_item *fmt,
 			  struct expand_data *data)
 {
-	for (; fmt->add; fmt++)
-		fmt->add(fmt, sb, data);
+	for (; fmt->type; fmt++)
+		switch (fmt->type) {
+		case FORMAT_TYPE_END:
+			BUG("we should have already left the loop!");
+			break;
+		case FORMAT_TYPE_OBJECTNAME:
+			strbuf_add_oid_hex(sb, &data->oid);
+			break;
+		case FORMAT_TYPE_OBJECTTYPE:
+			strbuf_addstr(sb, type_name(data->type));
+			break;
+		case FORMAT_TYPE_OBJECTSIZE:
+			strbuf_add_uint(sb, data->size);
+			break;
+		case FORMAT_TYPE_OBJECTSIZE_DISK:
+			strbuf_add_uint(sb, data->disk_size);
+			break;
+		case FORMAT_TYPE_REST:
+			strbuf_addstr(sb, data->rest);
+			break;
+		case FORMAT_TYPE_DELTABASE:
+			strbuf_add_oid_hex(sb, &data->delta_base_oid);
+			break;
+		case FORMAT_TYPE_OBJECTMODE:
+			if (data->mode != S_IFINVALID)
+				strbuf_addf(sb, "%06o", data->mode);
+			break;
+		case FORMAT_TYPE_LITERAL:
+			strbuf_add(sb, fmt->u.literal.p, fmt->u.literal.len);
+		}
 }
 
 static void batch_write(struct batch_options *opt, const void *data, int len)
