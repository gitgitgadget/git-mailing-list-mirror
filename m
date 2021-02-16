Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACB5C433DB
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E399A64E02
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhBPOpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:45:16 -0500
Received: from cloud.peff.net ([104.130.231.41]:34186 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhBPOpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:45:09 -0500
Received: (qmail 13389 invoked by uid 109); 16 Feb 2021 14:44:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:44:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24735 invoked by uid 111); 16 Feb 2021 14:44:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:44:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:44:25 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: [PATCH 2/6] attr: convert "macro_ok" into a flags field
Message-ID: <YCvaSeHIEF3yNkVI@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The attribute code can have a rather deep callstack, through
which we have to pass the "macro_ok" flag. In anticipation
of adding other flags, let's convert this to a generic
bit-field.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/attr.c b/attr.c
index 4ef85d668b..7b0cab085f 100644
--- a/attr.c
+++ b/attr.c
@@ -278,6 +278,9 @@ struct match_attr {
 
 static const char blank[] = " \t\r\n";
 
+/* Flags usable in read_attr() and parse_attr_line() family of functions. */
+#define READ_ATTR_MACRO_OK (1<<0)
+
 /*
  * Parse a whitespace-delimited attribute state (i.e., "attr",
  * "-attr", "!attr", or "attr=value") from the string starting at src.
@@ -331,7 +334,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 }
 
 static struct match_attr *parse_attr_line(const char *line, const char *src,
-					  int lineno, int macro_ok)
+					  int lineno, unsigned flags)
 {
 	int namelen;
 	int num_attr, i;
@@ -355,7 +358,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
-		if (!macro_ok) {
+		if (!(flags & READ_ATTR_MACRO_OK)) {
 			fprintf_ln(stderr, _("%s not allowed: %s:%d"),
 				   name, src, lineno);
 			goto fail_return;
@@ -653,11 +656,11 @@ static void handle_attr_line(struct attr_stack *res,
 			     const char *line,
 			     const char *src,
 			     int lineno,
-			     int macro_ok)
+			     unsigned flags)
 {
 	struct match_attr *a;
 
-	a = parse_attr_line(line, src, lineno, macro_ok);
+	a = parse_attr_line(line, src, lineno, flags);
 	if (!a)
 		return;
 	ALLOC_GROW(res->attrs, res->num_matches + 1, res->alloc);
@@ -672,7 +675,8 @@ static struct attr_stack *read_attr_from_array(const char **list)
 
 	res = xcalloc(1, sizeof(*res));
 	while ((line = *(list++)) != NULL)
-		handle_attr_line(res, line, "[builtin]", ++lineno, 1);
+		handle_attr_line(res, line, "[builtin]", ++lineno,
+				 READ_ATTR_MACRO_OK);
 	return res;
 }
 
@@ -698,7 +702,7 @@ void git_attr_set_direction(enum git_attr_direction new_direction)
 	direction = new_direction;
 }
 
-static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 {
 	FILE *fp = fopen_or_warn(path, "r");
 	struct attr_stack *res;
@@ -712,15 +716,15 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 		char *bufp = buf;
 		if (!lineno)
 			skip_utf8_bom(&bufp, strlen(bufp));
-		handle_attr_line(res, bufp, path, ++lineno, macro_ok);
+		handle_attr_line(res, bufp, path, ++lineno, flags);
 	}
 	fclose(fp);
 	return res;
 }
 
 static struct attr_stack *read_attr_from_index(const struct index_state *istate,
 					       const char *path,
-					       int macro_ok)
+					       unsigned flags)
 {
 	struct attr_stack *res;
 	char *buf, *sp;
@@ -741,35 +745,35 @@ static struct attr_stack *read_attr_from_index(const struct index_state *istate,
 		ep = strchrnul(sp, '\n');
 		more = (*ep == '\n');
 		*ep = '\0';
-		handle_attr_line(res, sp, path, ++lineno, macro_ok);
+		handle_attr_line(res, sp, path, ++lineno, flags);
 		sp = ep + more;
 	}
 	free(buf);
 	return res;
 }
 
 static struct attr_stack *read_attr(const struct index_state *istate,
-				    const char *path, int macro_ok)
+				    const char *path, unsigned flags)
 {
 	struct attr_stack *res = NULL;
 
 	if (direction == GIT_ATTR_INDEX) {
-		res = read_attr_from_index(istate, path, macro_ok);
+		res = read_attr_from_index(istate, path, flags);
 	} else if (!is_bare_repository()) {
 		if (direction == GIT_ATTR_CHECKOUT) {
-			res = read_attr_from_index(istate, path, macro_ok);
+			res = read_attr_from_index(istate, path, flags);
 			if (!res)
-				res = read_attr_from_file(path, macro_ok);
+				res = read_attr_from_file(path, flags);
 		} else if (direction == GIT_ATTR_CHECKIN) {
-			res = read_attr_from_file(path, macro_ok);
+			res = read_attr_from_file(path, flags);
 			if (!res)
 				/*
 				 * There is no checked out .gitattributes file
 				 * there, but we might have it in the index.
 				 * We allow operation in a sparsely checked out
 				 * work tree, so read from it.
 				 */
-				res = read_attr_from_index(istate, path, macro_ok);
+				res = read_attr_from_index(istate, path, flags);
 		}
 	}
 
@@ -844,6 +848,7 @@ static void bootstrap_attr_stack(const struct index_state *istate,
 				 struct attr_stack **stack)
 {
 	struct attr_stack *e;
+	unsigned flags = READ_ATTR_MACRO_OK;
 
 	if (*stack)
 		return;
@@ -854,23 +859,23 @@ static void bootstrap_attr_stack(const struct index_state *istate,
 
 	/* system-wide frame */
 	if (git_attr_system()) {
-		e = read_attr_from_file(git_etc_gitattributes(), 1);
+		e = read_attr_from_file(git_etc_gitattributes(), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
 	/* home directory */
 	if (get_home_gitattributes()) {
-		e = read_attr_from_file(get_home_gitattributes(), 1);
+		e = read_attr_from_file(get_home_gitattributes(), flags);
 		push_stack(stack, e, NULL, 0);
 	}
 
 	/* root directory */
-	e = read_attr(istate, GITATTRIBUTES_FILE, 1);
+	e = read_attr(istate, GITATTRIBUTES_FILE, flags);
 	push_stack(stack, e, xstrdup(""), 0);
 
 	/* info frame */
 	if (startup_info->have_repository)
-		e = read_attr_from_file(git_path_info_attributes(), 1);
+		e = read_attr_from_file(git_path_info_attributes(), flags);
 	else
 		e = NULL;
 	if (!e)
-- 
2.30.1.986.gd86016a168

