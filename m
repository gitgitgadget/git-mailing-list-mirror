Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3BFF20193
	for <e@80x24.org>; Wed,  2 Nov 2016 13:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752352AbcKBNGt (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 09:06:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:37454 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751722AbcKBNGs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 09:06:48 -0400
Received: (qmail 22635 invoked by uid 109); 2 Nov 2016 13:06:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 13:06:46 +0000
Received: (qmail 2690 invoked by uid 111); 2 Nov 2016 13:07:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 09:07:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 09:06:44 -0400
Date:   Wed, 2 Nov 2016 09:06:44 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/5] attr: convert "macro_ok" into a flags field
Message-ID: <20161102130644.4qwr4xr2ahljuny7@sigill.intra.peff.net>
References: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102130432.d3zprdul4sqgcfwu@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
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
index 1fcf042b8..79bd89226 100644
--- a/attr.c
+++ b/attr.c
@@ -151,6 +151,9 @@ struct match_attr {
 
 static const char blank[] = " \t\r\n";
 
+/* Flags usable in read_attr() and parse_attr_line() family of functions. */
+#define READ_ATTR_MACRO_OK (1<<0)
+
 /*
  * Parse a whitespace-delimited attribute state (i.e., "attr",
  * "-attr", "!attr", or "attr=value") from the string starting at src.
@@ -200,7 +203,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 }
 
 static struct match_attr *parse_attr_line(const char *line, const char *src,
-					  int lineno, int macro_ok)
+					  int lineno, unsigned flags)
 {
 	int namelen;
 	int num_attr, i;
@@ -215,7 +218,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
 	namelen = strcspn(name, blank);
 	if (strlen(ATTRIBUTE_MACRO_PREFIX) < namelen &&
 	    starts_with(name, ATTRIBUTE_MACRO_PREFIX)) {
-		if (!macro_ok) {
+		if (!(flags & READ_ATTR_MACRO_OK)) {
 			fprintf(stderr, "%s not allowed: %s:%d\n",
 				name, src, lineno);
 			return NULL;
@@ -339,11 +342,11 @@ static void handle_attr_line(struct attr_stack *res,
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
@@ -358,14 +361,15 @@ static struct attr_stack *read_attr_from_array(const char **list)
 
 	res = xcalloc(1, sizeof(*res));
 	while ((line = *(list++)) != NULL)
-		handle_attr_line(res, line, "[builtin]", ++lineno, 1);
+		handle_attr_line(res, line, "[builtin]", ++lineno,
+				 READ_ATTR_MACRO_OK);
 	return res;
 }
 
 static enum git_attr_direction direction;
 static struct index_state *use_index;
 
-static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_file(const char *path, unsigned flags)
 {
 	FILE *fp = fopen(path, "r");
 	struct attr_stack *res;
@@ -382,13 +386,13 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 		char *bufp = buf;
 		if (!lineno)
 			skip_utf8_bom(&bufp, strlen(bufp));
-		handle_attr_line(res, bufp, path, ++lineno, macro_ok);
+		handle_attr_line(res, bufp, path, ++lineno, flags);
 	}
 	fclose(fp);
 	return res;
 }
 
-static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
+static struct attr_stack *read_attr_from_index(const char *path, unsigned flags)
 {
 	struct attr_stack *res;
 	char *buf, *sp;
@@ -406,34 +410,34 @@ static struct attr_stack *read_attr_from_index(const char *path, int macro_ok)
 			;
 		more = (*ep == '\n');
 		*ep = '\0';
-		handle_attr_line(res, sp, path, ++lineno, macro_ok);
+		handle_attr_line(res, sp, path, ++lineno, flags);
 		sp = ep + more;
 	}
 	free(buf);
 	return res;
 }
 
-static struct attr_stack *read_attr(const char *path, int macro_ok)
+static struct attr_stack *read_attr(const char *path, unsigned flags)
 {
 	struct attr_stack *res;
 
 	if (direction == GIT_ATTR_CHECKOUT) {
-		res = read_attr_from_index(path, macro_ok);
+		res = read_attr_from_index(path, flags);
 		if (!res)
-			res = read_attr_from_file(path, macro_ok);
+			res = read_attr_from_file(path, flags);
 	}
 	else if (direction == GIT_ATTR_CHECKIN) {
-		res = read_attr_from_file(path, macro_ok);
+		res = read_attr_from_file(path, flags);
 		if (!res)
 			/*
 			 * There is no checked out .gitattributes file there, but
 			 * we might have it in the index.  We allow operation in a
 			 * sparsely checked out work tree, so read from it.
 			 */
-			res = read_attr_from_index(path, macro_ok);
+			res = read_attr_from_index(path, flags);
 	}
 	else
-		res = read_attr_from_index(path, macro_ok);
+		res = read_attr_from_index(path, flags);
 	if (!res)
 		res = xcalloc(1, sizeof(*res));
 	return res;
@@ -493,6 +497,7 @@ static GIT_PATH_FUNC(git_path_info_attributes, INFOATTRIBUTES_FILE)
 static void bootstrap_attr_stack(void)
 {
 	struct attr_stack *elem;
+	unsigned flags = READ_ATTR_MACRO_OK;
 
 	if (attr_stack)
 		return;
@@ -503,7 +508,7 @@ static void bootstrap_attr_stack(void)
 	attr_stack = elem;
 
 	if (git_attr_system()) {
-		elem = read_attr_from_file(git_etc_gitattributes(), 1);
+		elem = read_attr_from_file(git_etc_gitattributes(), flags);
 		if (elem) {
 			elem->origin = NULL;
 			elem->prev = attr_stack;
@@ -514,7 +519,7 @@ static void bootstrap_attr_stack(void)
 	if (!git_attributes_file)
 		git_attributes_file = xdg_config_home("attributes");
 	if (git_attributes_file) {
-		elem = read_attr_from_file(git_attributes_file, 1);
+		elem = read_attr_from_file(git_attributes_file, flags);
 		if (elem) {
 			elem->origin = NULL;
 			elem->prev = attr_stack;
@@ -523,7 +528,7 @@ static void bootstrap_attr_stack(void)
 	}
 
 	if (!is_bare_repository() || direction == GIT_ATTR_INDEX) {
-		elem = read_attr(GITATTRIBUTES_FILE, 1);
+		elem = read_attr(GITATTRIBUTES_FILE, flags);
 		elem->origin = xstrdup("");
 		elem->originlen = 0;
 		elem->prev = attr_stack;
@@ -532,7 +537,7 @@ static void bootstrap_attr_stack(void)
 	}
 
 	if (startup_info->have_repository)
-		elem = read_attr_from_file(git_path_info_attributes(), 1);
+		elem = read_attr_from_file(git_path_info_attributes(), flags);
 	else
 		elem = NULL;
 
-- 
2.11.0.rc0.258.gf434c15

