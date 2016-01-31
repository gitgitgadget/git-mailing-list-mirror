From: Jeff King <peff@peff.net>
Subject: [PATCH 1/6] give "nbuf" strbuf a more meaningful name
Date: Sun, 31 Jan 2016 06:25:26 -0500
Message-ID: <20160131112526.GA5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:25:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPq8L-0003tv-En
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334AbcAaLZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:25:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:35045 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757287AbcAaLZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:25:28 -0500
Received: (qmail 7247 invoked by uid 102); 31 Jan 2016 11:25:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:25:29 -0500
Received: (qmail 15657 invoked by uid 107); 31 Jan 2016 11:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:25:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:25:26 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285135>

It's a common pattern in our code to read paths from stdin,
separated either by newlines or NULs, and unquote as
necessary. In each of these five cases we use "nbuf" to
temporarily store the unquoted value. Let's give it the more
meaningful name "unquoted", which makes it easier to
understand the purpose of the variable.

While we're at it, let's also static-initialize all of our
strbufs. It's not wrong to call strbuf_init, but it
increases the cognitive load on the reader, who might wonder
"do we sometimes avoid initializing them?  why?".

Signed-off-by: Jeff King <peff@peff.net>
---
For those seeing this patch for the first time, I'll copy my
regrets from the earlier posting:

> It's a shame that we can't just factor out this common
> code, but I don't think it's quite long enough to merit
> the boilerplate. The interesting part of each function
> happens inside the loop. If C had lambdas, we could do
> something like:
> 
>   foreach_path_from(stdin, nul_term_line) {
>         /* now do something interesting with "buf"
>            and some other local variables */
>   }
>
> but using function pointers for this kind of iteration is
> pretty awful (define the two-line loop body as a separate
> function, stuff any local variables into a struct and pass
> it as "void *", etc). You can overcome that with macros
> and make the above code work if you don't mind creating an
> undebuggable mess. :)

 builtin/check-attr.c     | 13 ++++++-------
 builtin/check-ignore.c   | 13 ++++++-------
 builtin/checkout-index.c | 11 ++++++-----
 builtin/hash-object.c    | 11 ++++++-----
 builtin/update-index.c   | 11 ++++++-----
 5 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 087325e..53a5a18 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -72,24 +72,23 @@ static void check_attr(const char *prefix, int cnt,
 static void check_attr_stdin_paths(const char *prefix, int cnt,
 	struct git_attr_check *check)
 {
-	struct strbuf buf, nbuf;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
 	strbuf_getline_fn getline_fn;
 
 	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-	strbuf_init(&buf, 0);
-	strbuf_init(&nbuf, 0);
 	while (getline_fn(&buf, stdin) != EOF) {
 		if (!nul_term_line && buf.buf[0] == '"') {
-			strbuf_reset(&nbuf);
-			if (unquote_c_style(&nbuf, buf.buf, NULL))
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
 				die("line is badly quoted");
-			strbuf_swap(&buf, &nbuf);
+			strbuf_swap(&buf, &unquoted);
 		}
 		check_attr(prefix, cnt, check, buf.buf);
 		maybe_flush_or_die(stdout, "attribute to stdout");
 	}
 	strbuf_release(&buf);
-	strbuf_release(&nbuf);
+	strbuf_release(&unquoted);
 }
 
 static NORETURN void error_with_usage(const char *msg)
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 4f0b09e..1d73d3c 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -115,20 +115,19 @@ static int check_ignore(struct dir_struct *dir,
 
 static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 {
-	struct strbuf buf, nbuf;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
 	char *pathspec[2] = { NULL, NULL };
 	strbuf_getline_fn getline_fn;
 	int num_ignored = 0;
 
 	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
-	strbuf_init(&buf, 0);
-	strbuf_init(&nbuf, 0);
 	while (getline_fn(&buf, stdin) != EOF) {
 		if (!nul_term_line && buf.buf[0] == '"') {
-			strbuf_reset(&nbuf);
-			if (unquote_c_style(&nbuf, buf.buf, NULL))
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
 				die("line is badly quoted");
-			strbuf_swap(&buf, &nbuf);
+			strbuf_swap(&buf, &unquoted);
 		}
 		pathspec[0] = buf.buf;
 		num_ignored += check_ignore(dir, prefix,
@@ -136,7 +135,7 @@ static int check_ignore_stdin_paths(struct dir_struct *dir, const char *prefix)
 		maybe_flush_or_die(stdout, "check-ignore to stdout");
 	}
 	strbuf_release(&buf);
-	strbuf_release(&nbuf);
+	strbuf_release(&unquoted);
 	return num_ignored;
 }
 
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index ed888a5..d8d7bd3 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -251,7 +251,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
-		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
+		struct strbuf unquoted = STRBUF_INIT;
 		strbuf_getline_fn getline_fn;
 
 		if (all)
@@ -261,16 +262,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
-				strbuf_reset(&nbuf);
-				if (unquote_c_style(&nbuf, buf.buf, NULL))
+				strbuf_reset(&unquoted);
+				if (unquote_c_style(&unquoted, buf.buf, NULL))
 					die("line is badly quoted");
-				strbuf_swap(&buf, &nbuf);
+				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			checkout_file(p, prefix);
 			free(p);
 		}
-		strbuf_release(&nbuf);
+		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 3bc5ec1..d3cb4e5 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -58,20 +58,21 @@ static void hash_object(const char *path, const char *type, const char *vpath,
 static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 			     int literally)
 {
-	struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
 
 	while (strbuf_getline_lf(&buf, stdin) != EOF) {
 		if (buf.buf[0] == '"') {
-			strbuf_reset(&nbuf);
-			if (unquote_c_style(&nbuf, buf.buf, NULL))
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
 				die("line is badly quoted");
-			strbuf_swap(&buf, &nbuf);
+			strbuf_swap(&buf, &unquoted);
 		}
 		hash_object(buf.buf, type, no_filters ? NULL : buf.buf, flags,
 			    literally);
 	}
 	strbuf_release(&buf);
-	strbuf_release(&nbuf);
+	strbuf_release(&unquoted);
 }
 
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7c5c143..f052faf 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1075,16 +1075,17 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
-		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
+		struct strbuf unquoted = STRBUF_INIT;
 
 		setup_work_tree();
 		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
 			if (!nul_term_line && buf.buf[0] == '"') {
-				strbuf_reset(&nbuf);
-				if (unquote_c_style(&nbuf, buf.buf, NULL))
+				strbuf_reset(&unquoted);
+				if (unquote_c_style(&unquoted, buf.buf, NULL))
 					die("line is badly quoted");
-				strbuf_swap(&buf, &nbuf);
+				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
 			update_one(p);
@@ -1092,7 +1093,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 				chmod_path(set_executable_bit, p);
 			free(p);
 		}
-		strbuf_release(&nbuf);
+		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
 
-- 
2.7.0.489.g6faad84
