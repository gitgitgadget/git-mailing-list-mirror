Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A791920254
	for <e@80x24.org>; Sat, 25 Feb 2017 20:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbdBYUNG (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 15:13:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:34123 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751434AbdBYUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 15:13:06 -0500
Received: (qmail 2843 invoked by uid 109); 25 Feb 2017 20:11:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 20:11:26 +0000
Received: (qmail 15058 invoked by uid 111); 25 Feb 2017 20:11:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 15:11:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 25 Feb 2017 15:11:23 -0500
Date:   Sat, 25 Feb 2017 15:11:23 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH] strbuf: add strbuf_add_real_path()
Message-ID: <20170225201123.ozrrfgim2rdctczv@sigill.intra.peff.net>
References: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d191b86-d36c-e3ec-99c6-d15baa6b659a@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 25, 2017 at 05:00:33PM +0100, René Scharfe wrote:

> Add a function for appending the canonized absolute pathname of a given
> path to a strbuf.  It keeps the existing contents intact, as expected of
> a function of the strbuf_add() family, while avoiding copying the result
> if the given strbuf is empty.  It's more consistent with the rest of the
> strbuf API than strbuf_realpath(), which it's wrapping.
> 
> Also add a semantic patch demonstrating its intended usage and apply it
> to the current tree.  Using strbuf_add_real_path() instead of calling
> strbuf_addstr() and real_path() avoids an extra copy to a static buffer.

It's also re-entrant, which real_path() is not.

> +void strbuf_add_real_path(struct strbuf *sb, const char *path)
> +{
> +	if (sb->len) {
> +		struct strbuf resolved = STRBUF_INIT;
> +		strbuf_realpath(&resolved, path, 1);
> +		strbuf_addbuf(sb, &resolved);
> +		strbuf_release(&resolved);
> +	} else
> +		strbuf_realpath(sb, path, 1);
> +}

The wrapping here seems a little backwards. If strbuf_add_real_path()
were the inner one, then we would not need this extra allocation. I know
that the reasons are historical, but I don't think it would be
impossible to teach the realpath code to do it.

OTOH, it may not be worth the effort. It's not like strbuf_realpath()
doesn't allocate secondary strbufs for its work already, so dropping one
more is probably not that exciting. And certainly think your patch is an
incremental improvement.

Out of curiosity, I took a stab at the patch, which is below. Only
lightly tested by me, and it does make the logic a bit more complicated
to read, as you have to adjust for the original "base" in several
places.

diff --git a/abspath.c b/abspath.c
index 2f0c26e0e..286072f48 100644
--- a/abspath.c
+++ b/abspath.c
@@ -12,9 +12,9 @@ int is_directory(const char *path)
 }
 
 /* removes the last path component from 'path' except if 'path' is root */
-static void strip_last_component(struct strbuf *path)
+static void strip_last_component(struct strbuf *path, size_t base)
 {
-	size_t offset = offset_1st_component(path->buf);
+	size_t offset = base + offset_1st_component(path->buf + base);
 	size_t len = path->len;
 
 	/* Find start of the last component */
@@ -49,14 +49,15 @@ static void get_next_component(struct strbuf *next, struct strbuf *remaining)
 }
 
 /* copies root part from remaining to resolved, canonicalizing it on the way */
-static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
+static void get_root_part(struct strbuf *resolved, struct strbuf *remaining,
+			  size_t base)
 {
 	int offset = offset_1st_component(remaining->buf);
 
-	strbuf_reset(resolved);
+	strbuf_setlen(resolved, base);
 	strbuf_add(resolved, remaining->buf, offset);
 #ifdef GIT_WINDOWS_NATIVE
-	convert_slashes(resolved->buf);
+	convert_slashes(resolved->buf + base);
 #endif
 	strbuf_remove(remaining, 0, offset);
 }
@@ -78,8 +79,8 @@ static void get_root_part(struct strbuf *resolved, struct strbuf *remaining)
  * informative error message if there is a problem.  Otherwise, return
  * NULL on errors (without generating any output).
  */
-char *strbuf_realpath(struct strbuf *resolved, const char *path,
-		      int die_on_error)
+char *strbuf_add_real_path(struct strbuf *resolved, const char *path,
+			   int die_on_error)
 {
 	struct strbuf remaining = STRBUF_INIT;
 	struct strbuf next = STRBUF_INIT;
@@ -87,6 +88,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	char *retval = NULL;
 	int num_symlinks = 0;
 	struct stat st;
+	size_t base = resolved->len;
 
 	if (!*path) {
 		if (die_on_error)
@@ -96,9 +98,9 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	}
 
 	strbuf_addstr(&remaining, path);
-	get_root_part(resolved, &remaining);
+	get_root_part(resolved, &remaining, base);
 
-	if (!resolved->len) {
+	if (resolved->len == base) {
 		/* relative path; can use CWD as the initial resolved path */
 		if (strbuf_getcwd(resolved)) {
 			if (die_on_error)
@@ -118,7 +120,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			continue; /* '.' component */
 		} else if (next.len == 2 && !strcmp(next.buf, "..")) {
 			/* '..' component; strip the last path component */
-			strip_last_component(resolved);
+			strip_last_component(resolved, base);
 			continue;
 		}
 
@@ -127,12 +129,12 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 			strbuf_addch(resolved, '/');
 		strbuf_addbuf(resolved, &next);
 
-		if (lstat(resolved->buf, &st)) {
+		if (lstat(resolved->buf + base, &st)) {
 			/* error out unless this was the last component */
 			if (errno != ENOENT || remaining.len) {
 				if (die_on_error)
 					die_errno("Invalid path '%s'",
-						  resolved->buf);
+						  resolved->buf + base);
 				else
 					goto error_out;
 			}
@@ -150,7 +152,7 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 					goto error_out;
 			}
 
-			len = strbuf_readlink(&symlink, resolved->buf,
+			len = strbuf_readlink(&symlink, resolved->buf + base,
 					      st.st_size);
 			if (len < 0) {
 				if (die_on_error)
@@ -162,14 +164,14 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 
 			if (is_absolute_path(symlink.buf)) {
 				/* absolute symlink; set resolved to root */
-				get_root_part(resolved, &symlink);
+				get_root_part(resolved, &symlink, base);
 			} else {
 				/*
 				 * relative symlink
 				 * strip off the last component since it will
 				 * be replaced with the contents of the symlink
 				 */
-				strip_last_component(resolved);
+				strip_last_component(resolved, base);
 			}
 
 			/*
@@ -202,6 +204,12 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
+char *strbuf_realpath(struct strbuf *sb, const char *path, int die_on_error)
+{
+	strbuf_reset(sb);
+	return strbuf_add_real_path(sb, path, die_on_error);
+}
+
 const char *real_path(const char *path)
 {
 	static struct strbuf realpath = STRBUF_INIT;
