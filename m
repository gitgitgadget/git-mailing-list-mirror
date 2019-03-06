Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C1B820248
	for <e@80x24.org>; Wed,  6 Mar 2019 21:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfCFVtR (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 16:49:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:41514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726127AbfCFVtQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 16:49:16 -0500
Received: (qmail 924 invoked by uid 109); 6 Mar 2019 21:49:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 06 Mar 2019 21:49:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17900 invoked by uid 111); 6 Mar 2019 21:49:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 06 Mar 2019 16:49:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2019 16:49:13 -0500
Date:   Wed, 6 Mar 2019 16:49:13 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, hi-angel@yandex.ru,
        ramsay@ramsayjones.plus.com, sunshine@sunshineco.com,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 1/2] refs.c: refactor check_refname_component()
Message-ID: <20190306214912.GA32630@sigill.intra.peff.net>
References: <20190226105851.32273-1-pclouds@gmail.com>
 <20190305120834.7284-1-pclouds@gmail.com>
 <20190305120834.7284-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190305120834.7284-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 05, 2019 at 07:08:33PM +0700, Nguyễn Thái Ngọc Duy wrote:

> @@ -71,11 +82,15 @@ static unsigned char refname_disposition[256] = {
>   * - it ends with a "/", or
>   * - it ends with ".lock", or
>   * - it contains a "@{" portion
> + *
> + * in which case cp_out points to the beginning of the illegal part.
>   */
> -static int check_refname_component(const char *refname, int *flags)
> +static enum refname_check_code do_check_refname_component(
> +	const char *refname, int *flags, const char **cp_out)

Hmm, OK, so we get to know what type of problem, but also the exact
character where we found it. And then we just keep mutating that char
until we have something that passes.

I can't think of any reason that wouldn't work. As you note, it's
possibly quadratic, though that might be OK for our purposes.

I had envisioned just sanitizing each character into an output buffer as
we did the checks. It does introduce some complexities, though, because
now the checking function is doing the replacement (so it has to know
the right sanitizing rule for each case).

The patch below is a rough cut at that, just for discussion.  You can
ignore the check-ref-format bits; they were just to make poking at it
easier, though perhaps we'd want something like that in the long run.

I suspect check_refname_component() could be made a bit more readable by
reordering a few bits. E.g., why do we check for a leading "." at the
_end_, after having parsed the entire rest of the component for errors?

I dunno. I think I can live with what you've got in your series, but I
figured I'd share this for the sake of completeness. If you really love
it, feel free to adapt it.

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index bc67d3f0a8..41b5434be2 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -56,6 +56,7 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	int i;
 	int normalize = 0;
 	int flags = 0;
+	int sanitize = 0;
 	const char *refname;
 
 	if (argc == 2 && !strcmp(argv[1], "-h"))
@@ -73,13 +74,22 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 			flags &= ~REFNAME_ALLOW_ONELEVEL;
 		else if (!strcmp(argv[i], "--refspec-pattern"))
 			flags |= REFNAME_REFSPEC_PATTERN;
+		else if (!strcmp(argv[i], "--sanitize"))
+			sanitize = 1;
 		else
 			usage(builtin_check_ref_format_usage);
 	}
 	if (! (i == argc - 1))
 		usage(builtin_check_ref_format_usage);
 
 	refname = argv[i];
+	if (sanitize) {
+		struct strbuf out = STRBUF_INIT;
+		sanitize_refname(refname, &out);
+		printf("%s\n", out.buf);
+		strbuf_release(&out);
+		return 0;
+	}
 	if (normalize)
 		refname = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
diff --git a/refs.c b/refs.c
index 142888a40a..2a0c0c6338 100644
--- a/refs.c
+++ b/refs.c
@@ -72,30 +72,58 @@ static unsigned char refname_disposition[256] = {
  * - it ends with ".lock", or
  * - it contains a "@{" portion
  */
-static int check_refname_component(const char *refname, int *flags)
+static int check_refname_component(const char *refname, int *flags,
+				   struct strbuf *sanitized)
 {
 	const char *cp;
 	char last = '\0';
+	size_t component_start;
+
+	if (sanitized)
+		component_start = sanitized->len;
 
 	for (cp = refname; ; cp++) {
 		int ch = *cp & 255;
 		unsigned char disp = refname_disposition[ch];
+
+		if (sanitized && disp != 1)
+			strbuf_addch(sanitized, ch);
+
 		switch (disp) {
 		case 1:
 			goto out;
 		case 2:
-			if (last == '.')
-				return -1; /* Refname contains "..". */
+			if (last == '.') {
+				/* Refname contains "..". */
+				if (sanitized)
+					sanitized->len--; /* collapse ".." to single "." */
+				else
+					return -1;
+			}
 			break;
 		case 3:
-			if (last == '@')
-				return -1; /* Refname contains "@{". */
+			if (last == '@') {
+				/* Refname contains "@{". */
+				if (sanitized)
+					sanitized->buf[sanitized->len-1] = '-';
+				else
+					return -1;
+			}
 			break;
 		case 4:
-			return -1;
+			/* forbidden char */
+			if (sanitized)
+				sanitized->buf[sanitized->len-1] = '-';
+			else
+				return -1;
+			break;
 		case 5:
-			if (!(*flags & REFNAME_REFSPEC_PATTERN))
-				return -1; /* refspec can't be a pattern */
+			if (!(*flags & REFNAME_REFSPEC_PATTERN)) {
+				if (sanitized)
+					sanitized->buf[sanitized->len-1] = '-';
+				else
+					return -1; /* refspec can't be a pattern */
+			}
 
 			/*
 			 * Unset the pattern flag so that we only accept
@@ -109,26 +137,48 @@ static int check_refname_component(const char *refname, int *flags)
 out:
 	if (cp == refname)
 		return 0; /* Component has zero length. */
-	if (refname[0] == '.')
-		return -1; /* Component starts with '.'. */
+
+	if (refname[0] == '.') {
+		/* Component starts with '.'. */
+		if (sanitized)
+			sanitized->buf[component_start] = '-';
+		else
+			return -1;
+	}
 	if (cp - refname >= LOCK_SUFFIX_LEN &&
-	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN))
-		return -1; /* Refname ends with ".lock". */
+	    !memcmp(cp - LOCK_SUFFIX_LEN, LOCK_SUFFIX, LOCK_SUFFIX_LEN)) {
+		/* Refname ends with ".lock". */
+		if (sanitized)
+			strbuf_strip_suffix(sanitized, LOCK_SUFFIX);
+		else
+			return -1;
+	}
 	return cp - refname;
 }
 
-int check_refname_format(const char *refname, int flags)
+static int check_or_sanitize_refname(const char *refname, int flags,
+				     struct strbuf *sanitized)
 {
 	int component_len, component_count = 0;
 
-	if (!strcmp(refname, "@"))
+	if (!strcmp(refname, "@")) {
 		/* Refname is a single character '@'. */
-		return -1;
+		if (sanitized)
+			strbuf_addch(sanitized, '-');
+		else
+			return -1;
+	}
 
 	while (1) {
+		if (sanitized && sanitized->len)
+			strbuf_complete(sanitized, '/');
+
 		/* We are at the start of a path component. */
-		component_len = check_refname_component(refname, &flags);
-		if (component_len <= 0)
+		component_len = check_refname_component(refname, &flags,
+							sanitized);
+		if (sanitized && component_len == 0)
+			; /* OK, omit empty component */
+		else if (component_len <= 0)
 			return -1;
 
 		component_count++;
@@ -138,13 +188,29 @@ int check_refname_format(const char *refname, int flags)
 		refname += component_len + 1;
 	}
 
-	if (refname[component_len - 1] == '.')
-		return -1; /* Refname ends with '.'. */
+	if (refname[component_len - 1] == '.') {
+		/* Refname ends with '.'. */
+		if (sanitized)
+			; /* omit ending dot */
+		else
+			return -1;
+	}
 	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
 
+int check_refname_format(const char *refname, int flags)
+{
+	return check_or_sanitize_refname(refname, flags, NULL);
+}
+
+void sanitize_refname(const char *refname, struct strbuf *out)
+{
+	if (check_or_sanitize_refname(refname, 0, out))
+		BUG("sanitizing refname check returned error");
+}
+
 int refname_is_safe(const char *refname)
 {
 	const char *rest;
diff --git a/refs.h b/refs.h
index 308fa1f03b..b99c309dd9 100644
--- a/refs.h
+++ b/refs.h
@@ -460,6 +460,12 @@ int for_each_reflog(each_ref_fn fn, void *cb_data);
  */
 int check_refname_format(const char *refname, int flags);
 
+/*
+ * Apply the rules from check_refname_format, but mutate the result until it
+ * is acceptable, and place the result in "out".
+ */
+void sanitize_refname(const char *refname, struct strbuf *out);
+
 const char *prettify_refname(const char *refname);
 
 char *shorten_unambiguous_ref(const char *refname, int strict);
