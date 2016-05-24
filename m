From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 08/49] builtin/apply: introduce 'struct apply_state' to start libifying
Date: Tue, 24 May 2016 10:10:45 +0200
Message-ID: <20160524081126.16973-9-chriscool@tuxfamily.org>
References: <20160524081126.16973-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 10:12:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b57Rl-0000iU-2D
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 10:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbcEXIMF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 04:12:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34331 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcEXIL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 04:11:59 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so3657064wmn.1
        for <git@vger.kernel.org>; Tue, 24 May 2016 01:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W2rMevzjZMSeMGY2Dp/0nHAn9NGV+vxB+w1vHSKqRkw=;
        b=rr8jLQmo8V1jnugC+Z4eRX0cDO3G57Q9bX/egxKrLwHj55agFXBc9iiHHAHggdQbWv
         vhhWpjdSJfa5rn4mHIeNgfujGo46SCIOtosZHASvVnUlIaKvbOcjf2yrG3+AG6OuteIW
         GGtQxU3kmyTR+JMgwh/6KMxj5VzS8Ij0brLMbca5ZO50jf7H5lM/VmlaJP5lIbZ6MRLR
         Q3JVwFWuzjMsm+alj/6LOWbKb5JtM7YUur2qxM7mu9+OBx41Q0kf0lRcy3J1Svo5311v
         5N210gXYNvj0DmcI3hWgcu/RWE+WPjS/z9BGkhH8UWEwyQfUl+TqOgM9bTLUkARd0AC/
         CZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W2rMevzjZMSeMGY2Dp/0nHAn9NGV+vxB+w1vHSKqRkw=;
        b=WVGEU5U3pu6AyxKpN4Wkh9kSmul+u+7h6iFF0SIewZaGToEn0HJuCZ2nd5xPQnkw9l
         SgMUrf0LReLUXG2/CF2JgcnWShP3FFd+uEQsLaVtEjv65aoavxV7bV0otwbOdH8XcU9Q
         iudA/Pzzt9Qt4j5UkuTuoBPU1bELXq2wBy+Xgxw6GwJIq1bg9UWrNWBTw7YFfGdHNmJK
         tYtNpn7+wJuWtYZXk3NseGtA2hxG41iuORsean8kQUNFsVGSGcFqtGhxUpAAtstUMSJz
         C5RP+u3Z5hzpRuWSq15CSPhXtyMQ+dtn4zP3lOXx+zwgOLYrkZqRgbkaKsHNDZecnRNN
         r+2w==
X-Gm-Message-State: AOPr4FX1llR42TomyvFi0PD39ovfxqhgdL9XezSTaZPI1Ay7nOHV8xQ9RKudKrpAGNj2lA==
X-Received: by 10.28.150.211 with SMTP id y202mr21853020wmd.41.1464077517457;
        Tue, 24 May 2016 01:11:57 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 131sm2258044wmu.17.2016.05.24.01.11.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 May 2016 01:11:56 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.3.443.gaeee61e
In-Reply-To: <20160524081126.16973-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295430>

Currently commands that want to use the apply functionality have to launch
a "git apply" process which can be bad for performance.

Let's start libifying the apply functionality and to do that we first need
to get rid of the global variables in "builtin/apply.c".

This patch introduces "struct apply_state" into which all the previously
global variables will be moved. A new parameter called "state" that is a
pointer to the "apply_state" structure will come at the beginning of the
helper functions that need it and will be passed around the call chain.

To start let's move the "prefix" and "prefix_length" global variables into
"struct apply_state".

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 94 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c911e4e..ae068e7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -21,6 +21,11 @@
 #include "ll-merge.h"
 #include "rerere.h"
 
+struct apply_state {
+	const char *prefix;
+	int prefix_length;
+};
+
 /*
  *  --check turns on checking that the working tree matches the
  *    files that are being modified, but doesn't apply the patch
@@ -30,8 +35,6 @@
  *  --index updates the cache as well.
  *  --cached updates only the cache without ever touching the working tree.
  */
-static const char *prefix;
-static int prefix_length = -1;
 static int newfd = -1;
 
 static int unidiff_zero;
@@ -748,7 +751,7 @@ static int count_slashes(const char *cp)
  * Given the string after "--- " or "+++ ", guess the appropriate
  * p_value for the given patch.
  */
-static int guess_p_value(const char *nameline)
+static int guess_p_value(struct apply_state *state, const char *nameline)
 {
 	char *name, *cp;
 	int val = -1;
@@ -761,17 +764,17 @@ static int guess_p_value(const char *nameline)
 	cp = strchr(name, '/');
 	if (!cp)
 		val = 0;
-	else if (prefix) {
+	else if (state->prefix) {
 		/*
 		 * Does it begin with "a/$our-prefix" and such?  Then this is
 		 * very likely to apply to our directory.
 		 */
-		if (!strncmp(name, prefix, prefix_length))
-			val = count_slashes(prefix);
+		if (!strncmp(name, state->prefix, state->prefix_length))
+			val = count_slashes(state->prefix);
 		else {
 			cp++;
-			if (!strncmp(cp, prefix, prefix_length))
-				val = count_slashes(prefix) + 1;
+			if (!strncmp(cp, state->prefix, state->prefix_length))
+				val = count_slashes(state->prefix) + 1;
 		}
 	}
 	free(name);
@@ -858,7 +861,10 @@ static int has_epoch_timestamp(const char *nameline)
  * files, we can happily check the index for a match, but for creating a
  * new file we should try to match whatever "patch" does. I have no idea.
  */
-static void parse_traditional_patch(const char *first, const char *second, struct patch *patch)
+static void parse_traditional_patch(struct apply_state *state,
+				    const char *first,
+				    const char *second,
+				    struct patch *patch)
 {
 	char *name;
 
@@ -866,8 +872,8 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 	second += 4;	/* skip "+++ " */
 	if (!p_value_known) {
 		int p, q;
-		p = guess_p_value(first);
-		q = guess_p_value(second);
+		p = guess_p_value(state, first);
+		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
 			state_p_value = p;
@@ -1429,7 +1435,11 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
 	return offset;
 }
 
-static int find_header(const char *line, unsigned long size, int *hdrsize, struct patch *patch)
+static int find_header(struct apply_state *state,
+		       const char *line,
+		       unsigned long size,
+		       int *hdrsize,
+		       struct patch *patch)
 {
 	unsigned long offset, len;
 
@@ -1506,7 +1516,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		parse_traditional_patch(line, line+len, patch);
+		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
 		state_linenr += 2;
 		return offset;
@@ -1913,21 +1923,21 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
 	return used;
 }
 
-static void prefix_one(char **name)
+static void prefix_one(struct apply_state *state, char **name)
 {
 	char *old_name = *name;
 	if (!old_name)
 		return;
-	*name = xstrdup(prefix_filename(prefix, prefix_length, *name));
+	*name = xstrdup(prefix_filename(state->prefix, state->prefix_length, *name));
 	free(old_name);
 }
 
-static void prefix_patch(struct patch *p)
+static void prefix_patch(struct apply_state *state, struct patch *p)
 {
-	if (!prefix || p->is_toplevel_relative)
+	if (!state->prefix || p->is_toplevel_relative)
 		return;
-	prefix_one(&p->new_name);
-	prefix_one(&p->old_name);
+	prefix_one(state, &p->new_name);
+	prefix_one(state, &p->old_name);
 }
 
 /*
@@ -1944,16 +1954,16 @@ static void add_name_limit(const char *name, int exclude)
 	it->util = exclude ? NULL : (void *) 1;
 }
 
-static int use_patch(struct patch *p)
+static int use_patch(struct apply_state *state, struct patch *p)
 {
 	const char *pathname = p->new_name ? p->new_name : p->old_name;
 	int i;
 
 	/* Paths outside are not touched regardless of "--include" */
-	if (0 < prefix_length) {
+	if (0 < state->prefix_length) {
 		int pathlen = strlen(pathname);
-		if (pathlen <= prefix_length ||
-		    memcmp(prefix, pathname, prefix_length))
+		if (pathlen <= state->prefix_length ||
+		    memcmp(state->prefix, pathname, state->prefix_length))
 			return 0;
 	}
 
@@ -1980,17 +1990,17 @@ static int use_patch(struct patch *p)
  * Return the number of bytes consumed, so that the caller can call us
  * again for the next patch.
  */
-static int parse_chunk(char *buffer, unsigned long size, struct patch *patch)
+static int parse_chunk(struct apply_state *state, char *buffer, unsigned long size, struct patch *patch)
 {
 	int hdrsize, patchsize;
-	int offset = find_header(buffer, size, &hdrsize, patch);
+	int offset = find_header(state, buffer, size, &hdrsize, patch);
 
 	if (offset < 0)
 		return offset;
 
-	prefix_patch(patch);
+	prefix_patch(state, patch);
 
-	if (!use_patch(patch))
+	if (!use_patch(state, patch))
 		patch->ws_rule = 0;
 	else
 		patch->ws_rule = whitespace_rule(patch->new_name
@@ -4367,7 +4377,10 @@ static struct lock_file lock_file;
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
-static int apply_patch(int fd, const char *filename, int options)
+static int apply_patch(struct apply_state *state,
+		       int fd,
+		       const char *filename,
+		       int options)
 {
 	size_t offset;
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
@@ -4384,14 +4397,14 @@ static int apply_patch(int fd, const char *filename, int options)
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
 		patch->recount =  !!(options & RECOUNT);
-		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
+		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
 			break;
 		}
 		if (apply_in_reverse)
 			reverse_patches(patch);
-		if (use_patch(patch)) {
+		if (use_patch(state, patch)) {
 			patch_stats(patch);
 			*listp = patch;
 			listp = &patch->next;
@@ -4517,6 +4530,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int force_apply = 0;
 	int options = 0;
 	int read_stdin = 1;
+	struct apply_state state;
 
 	const char *whitespace_option = NULL;
 
@@ -4589,15 +4603,17 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		OPT_END()
 	};
 
-	prefix = prefix_;
-	prefix_length = prefix ? strlen(prefix) : 0;
+	memset(&state, 0, sizeof(state));
+	state.prefix = prefix_;
+	state.prefix_length = state.prefix ? strlen(state.prefix) : 0;
+
 	git_apply_config();
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(apply_default_ignorewhitespace);
 
-	argc = parse_options(argc, argv, prefix, builtin_apply_options,
+	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
 	if (apply_with_reject && threeway)
@@ -4628,23 +4644,25 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(0, "<stdin>", options);
+			errs |= apply_patch(&state, 0, "<stdin>", options);
 			read_stdin = 0;
 			continue;
-		} else if (0 < prefix_length)
-			arg = prefix_filename(prefix, prefix_length, arg);
+		} else if (0 < state.prefix_length)
+			arg = prefix_filename(state.prefix,
+					      state.prefix_length,
+					      arg);
 
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(whitespace_option);
-		errs |= apply_patch(fd, arg, options);
+		errs |= apply_patch(&state, fd, arg, options);
 		close(fd);
 	}
 	set_default_whitespace_mode(whitespace_option);
 	if (read_stdin)
-		errs |= apply_patch(0, "<stdin>", options);
+		errs |= apply_patch(&state, 0, "<stdin>", options);
 	if (whitespace_error) {
 		if (squelch_whitespace_errors &&
 		    squelch_whitespace_errors < whitespace_error) {
-- 
2.8.3.443.gaeee61e
