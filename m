Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2A931F462
	for <e@80x24.org>; Tue,  4 Jun 2019 23:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfFDXuW (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 19:50:22 -0400
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:52710 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfFDXuV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 4 Jun 2019 19:50:21 -0400
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-05v.sys.comcast.net with ESMTP
        id YISxhxSC9F9fpYJC8hJQMQ; Tue, 04 Jun 2019 23:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559692220;
        bh=zFyMdLGfALRBQbhyBI9UGwBTI01TG+wBgdwBVNWY6tM=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=x6MLL+YTR/HO8wqrNZpSkI4nRPn9ayDpJ1DSEY4RurNdusi7ZMt+bacYbAqXa9U+K
         qpH/I7pDrbvJgpKTxbtt+HYlxS8ZFYz3WnznccJCXGzj0WOiLgFmn0vIqaF4veCzsn
         SFqowmaUuL/ngld0NT1lOS1FgBQ+z2rQEVL6BOLUTNGXoMP3wb+81tl11NKJSIpiNB
         SGAgx7h0ua6a/TblcmBmBCek66pQ7ICYswjQr4NUUFe0+R5PAKeA3kWt4qKi5MzJ4R
         GM8n3bq+rwnnJv82wm1kem/xSJsSpYH5DqZje2ownbGYK2giV3suF94lIa+fMMO+4T
         l0rDUlJ3bJ2lQ==
Received: from comcast.net ([IPv6:2620:15c:2ce:200:414a:968a:2dbf:4ae5])
        by resomta-po-12v.sys.comcast.net with ESMTPSA
        id YJBfhbCQ1T55RYJBkhVIov; Tue, 04 Jun 2019 23:50:18 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Tue, 4 Jun 2019 16:49:51 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff King <peff@peff.net>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH v1 3/5] list-objects-filter: implement composite filters
Message-ID: <20190604234951.GB43275@comcast.net>
References: <20190531204821.GC4641@comcast.net>
 <20190531211041.GA19792@sigill.intra.peff.net>
 <20190601001231.GF4641@comcast.net>
 <20190603123435.GA18953@sigill.intra.peff.net>
 <20190603222247.GG4641@comcast.net>
 <20190604161332.GA29603@sigill.intra.peff.net>
 <20190604171952.GI4641@comcast.net>
 <20190604185108.GA14738@sigill.intra.peff.net>
 <20190604225921.GA43275@comcast.net>
 <20190604231418.GA12501@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604231418.GA12501@sigill.intra.peff.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 04, 2019 at 07:14:18PM -0400, Jeff King wrote:
> Right, that has to be a real colon because it's syntactically
> significant (but a colon in the username _must_ be encoded). That strbuf
> function doesn't really understand whole URLs, and it's up to the caller
> to assemble the parts.
> 
> Anyway, we've veered off of your patch series enough. Yeah, it sounds
> like using strbuf's url-encoding is not quite what you want.

I tried to do it anyway :) I think this makes the strbuf API a bit easier to
reason about, and strbuf.h is a bit more self-documenting. WDYT?

diff --git a/credential-store.c b/credential-store.c
index ac295420dd..c010497cb2 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -65,29 +65,30 @@ static void rewrite_credential_file(const char *fn, struct credential *c,
 	parse_credential_file(fn, c, NULL, print_line);
 	if (commit_lock_file(&credential_lock) < 0)
 		die_errno("unable to write credential store");
 }
 
 static void store_credential_file(const char *fn, struct credential *c)
 {
 	struct strbuf buf = STRBUF_INIT;
 
 	strbuf_addf(&buf, "%s://", c->protocol);
-	strbuf_addstr_urlencode(&buf, c->username, 1);
+	strbuf_addstr_urlencode(&buf, c->username, is_rfc3986_unreserved);
 	strbuf_addch(&buf, ':');
-	strbuf_addstr_urlencode(&buf, c->password, 1);
+	strbuf_addstr_urlencode(&buf, c->password, is_rfc3986_unreserved);
 	strbuf_addch(&buf, '@');
 	if (c->host)
-		strbuf_addstr_urlencode(&buf, c->host, 1);
+		strbuf_addstr_urlencode(&buf, c->host, is_rfc3986_unreserved);
 	if (c->path) {
 		strbuf_addch(&buf, '/');
-		strbuf_addstr_urlencode(&buf, c->path, 0);
+		strbuf_addstr_urlencode(&buf, c->path,
+					is_rfc3986_reserved_or_unreserved);
 	}
 
 	rewrite_credential_file(fn, c, &buf);
 	strbuf_release(&buf);
 }
 
 static void store_credential(const struct string_list *fns, struct credential *c)
 {
 	struct string_list_item *fn;
 
diff --git a/http.c b/http.c
index 27aa0a3192..938b9e55af 100644
--- a/http.c
+++ b/http.c
@@ -506,23 +506,25 @@ static void var_override(const char **var, char *value)
 static void set_proxyauth_name_password(CURL *result)
 {
 #if LIBCURL_VERSION_NUM >= 0x071301
 		curl_easy_setopt(result, CURLOPT_PROXYUSERNAME,
 			proxy_auth.username);
 		curl_easy_setopt(result, CURLOPT_PROXYPASSWORD,
 			proxy_auth.password);
 #else
 		struct strbuf s = STRBUF_INIT;
 
-		strbuf_addstr_urlencode(&s, proxy_auth.username, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.username,
+					is_rfc3986_unreserved);
 		strbuf_addch(&s, ':');
-		strbuf_addstr_urlencode(&s, proxy_auth.password, 1);
+		strbuf_addstr_urlencode(&s, proxy_auth.password,
+					is_rfc3986_unreserved);
 		curl_proxyuserpwd = strbuf_detach(&s, NULL);
 		curl_easy_setopt(result, CURLOPT_PROXYUSERPWD, curl_proxyuserpwd);
 #endif
 }
 
 static void init_curl_proxy_auth(CURL *result)
 {
 	if (proxy_auth.username) {
 		if (!proxy_auth.password)
 			credential_fill(&proxy_auth);
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 6b206dc58b..9a5677c2c8 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -167,30 +167,25 @@ static int parse_combine_filter(
 
 cleanup:
 	strbuf_list_free(subspecs);
 	if (result) {
 		list_objects_filter_release(filter_options);
 		memset(filter_options, 0, sizeof(*filter_options));
 	}
 	return result;
 }
 
-static void add_url_encoded(struct strbuf *dest, const char *s)
+static int allow_unencoded(char ch)
 {
-	while (*s) {
-		if (*s <= ' ' || strchr(RESERVED_NON_WS, *s) ||
-			*s == '%' || *s == '+')
-			strbuf_addf(dest, "%%%02X", (int)*s);
-		else
-			strbuf_addf(dest, "%c", *s);
-		s++;
-	}
+	if (ch <= ' ' || ch == '%' || ch == '+')
+		return 0;
+	return !strchr(RESERVED_NON_WS, ch);
 }
 
 /*
  * Changes filter_options into an equivalent LOFC_COMBINE filter options
  * instance. Does not do anything if filter_options is already LOFC_COMBINE.
  */
 static void transform_to_combine_type(
 	struct list_objects_filter_options *filter_options)
 {
 	assert(filter_options->choice);
@@ -202,22 +197,23 @@ static void transform_to_combine_type(
 			xcalloc(initial_sub_alloc, sizeof(*sub_array));
 		sub_array[0] = *filter_options;
 		memset(filter_options, 0, sizeof(*filter_options));
 		filter_options->sub = sub_array;
 		filter_options->sub_alloc = initial_sub_alloc;
 	}
 	filter_options->sub_nr = 1;
 	filter_options->choice = LOFC_COMBINE;
 	strbuf_init(&filter_options->filter_spec, 0);
 	strbuf_addstr(&filter_options->filter_spec, "combine:");
-	add_url_encoded(&filter_options->filter_spec,
-			filter_options->sub[0].filter_spec.buf);
+	strbuf_addstr_urlencode(&filter_options->filter_spec,
+				filter_options->sub[0].filter_spec.buf,
+				allow_unencoded);
 	/*
 	 * We don't need the filter_spec strings for subfilter specs, only the
 	 * top level.
 	 */
 	strbuf_release(&filter_options->sub[0].filter_spec);
 }
 
 void list_objects_filter_die_if_populated(
 	struct list_objects_filter_options *filter_options)
 {
@@ -239,21 +235,22 @@ void parse_list_objects_filter(
 		parse_error = gently_parse_list_objects_filter(
 			filter_options, arg, &errbuf);
 	} else {
 		/*
 		 * Make filter_options an LOFC_COMBINE spec so we can trivially
 		 * add subspecs to it.
 		 */
 		transform_to_combine_type(filter_options);
 
 		strbuf_addstr(&filter_options->filter_spec, "+");
-		add_url_encoded(&filter_options->filter_spec, arg);
+		strbuf_addstr_urlencode(&filter_options->filter_spec, arg,
+					allow_unencoded);
 		trace_printf("Generated composite filter-spec: %s\n",
 			     filter_options->filter_spec.buf);
 		ALLOC_GROW_BY(filter_options->sub, filter_options->sub_nr, 1,
 			      filter_options->sub_alloc);
 
 		parse_error = gently_parse_list_objects_filter(
 			&filter_options->sub[filter_options->sub_nr - 1], arg,
 			&errbuf);
 	}
 	if (parse_error)
diff --git a/strbuf.c b/strbuf.c
index 0e18b259ce..60ab5144f2 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -767,55 +767,56 @@ void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
 		case '&':
 			strbuf_addstr(buf, "&amp;");
 			break;
 		case 0:
 			return;
 		}
 		s++;
 	}
 }
 
-static int is_rfc3986_reserved(char ch)
+int is_rfc3986_reserved_or_unreserved(char ch)
 {
+	if (is_rfc3986_unreserved(ch))
+		return 1;
 	switch (ch) {
 		case '!': case '*': case '\'': case '(': case ')': case ';':
 		case ':': case '@': case '&': case '=': case '+': case '$':
 		case ',': case '/': case '?': case '#': case '[': case ']':
 			return 1;
 	}
 	return 0;
 }
 
-static int is_rfc3986_unreserved(char ch)
+int is_rfc3986_unreserved(char ch)
 {
 	return isalnum(ch) ||
 		ch == '-' || ch == '_' || ch == '.' || ch == '~';
 }
 
 static void strbuf_add_urlencode(struct strbuf *sb, const char *s, size_t len,
-				 int reserved)
+				 char_predicate allow_unencoded_fn)
 {
 	strbuf_grow(sb, len);
 	while (len--) {
 		char ch = *s++;
-		if (is_rfc3986_unreserved(ch) ||
-		    (!reserved && is_rfc3986_reserved(ch)))
+		if (allow_unencoded_fn(ch))
 			strbuf_addch(sb, ch);
 		else
 			strbuf_addf(sb, "%%%02x", (unsigned char)ch);
 	}
 }
 
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
-			     int reserved)
+			     char_predicate allow_unencoded_fn)
 {
-	strbuf_add_urlencode(sb, s, strlen(s), reserved);
+	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
 void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
 {
 	if (bytes > 1 << 30) {
 		strbuf_addf(buf, "%u.%2.2u GiB",
 			    (unsigned)(bytes >> 30),
 			    (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
 	} else if (bytes > 1 << 20) {
 		unsigned x = bytes + 5243;  /* for rounding */
diff --git a/strbuf.h b/strbuf.h
index c8d98dfb95..346d722492 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -659,22 +659,27 @@ void strbuf_branchname(struct strbuf *sb, const char *name,
 		       unsigned allowed);
 
 /*
  * Like strbuf_branchname() above, but confirm that the result is
  * syntactically valid to be used as a local branch name in refs/heads/.
  *
  * The return value is "0" if the result is valid, and "-1" otherwise.
  */
 int strbuf_check_branch_ref(struct strbuf *sb, const char *name);
 
+typedef int (*char_predicate)(char ch);
+
+int is_rfc3986_unreserved(char ch);
+int is_rfc3986_reserved_or_unreserved(char ch);
+
 void strbuf_addstr_urlencode(struct strbuf *sb, const char *name,
-			     int reserved);
+			     char_predicate allow_unencoded_fn);
 
 __attribute__((format (printf,1,2)))
 int printf_ln(const char *fmt, ...);
 __attribute__((format (printf,2,3)))
 int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
 char *xstrdup_toupper(const char *);
 
 /**
