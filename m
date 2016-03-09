From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 06/48] builtin/apply: introduce 'struct apply_state' to start libifying
Date: Wed,  9 Mar 2016 18:48:34 +0100
Message-ID: <1457545756-20616-7-git-send-email-chriscool@tuxfamily.org>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 18:52:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiHZ-0007Yw-U2
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 18:52:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933665AbcCIRwU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 12:52:20 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38534 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933645AbcCIRwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 12:52:16 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so81964751wml.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 09:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qK5PdWLf6pwKPonPr5LkSNly2HWgqagxJOioVIrrdNA=;
        b=bMwojE4WpOQ0IZSS0HyJvQGksLQVFsc32Vio0UKQEcQ3YZtFqw2N+kI3XqpRe18hhV
         7+JoOa6txhYmQV9gBZyYfP5oD1+ua8hZl06Lp7fCBfZNrNFbwUOHmdTmyNP99/nWVKgw
         Mti0Q+uOhPeEhzBuY8qcm/1w/lvM+zlxVlx9Ohj2vNjGtr8L8t1dH/N3s0fJqTAegTpA
         NJnROxPqKwr3pMbIjwW2yO5gNGWoimfV295N7xDT56lzLv7CSJeaoEtTLWjhJjIgkAqw
         q58lhVZ/zma8MMgsAQWvstGeDS6tvjOlTjF6nlNlQtv5f8a/p/iK5OVjdmpg7+3G8REX
         GPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qK5PdWLf6pwKPonPr5LkSNly2HWgqagxJOioVIrrdNA=;
        b=k4oqWWx7QFn3ZCFQTDn1HWIWFGefrjyQvfGVWrYjbedFUlNqK+wy/oOcI7n97M7sFb
         eRa9MFnBQzJfGHAWPxvOi4Kc/pPLufwg5ce7jh4w03JOB9Whm89jM96OmRguH1edOEUS
         /o5fuuyUTK+P5x23AzqQhdHZjpzPDW34cD/bYdTcLqVOFuTnuiPvdecX8Uid8Iy2V2lB
         JNLoqIRJVOeqE/sFKSYTJGH2d44TSCVpmUCMUMzEjzPlepEES30lkztLqYFqDvZBer10
         +BthI/A68ZKTSOn0otHOAyUjOg8uougJGPWwRumGAioqVENAtFQQ9LGeC+/9fHNEX+7s
         iKIQ==
X-Gm-Message-State: AD7BkJJOxFulNjlTw5BQHnpOz2E98/UjJTA2Rhjd3rvxZq3YtfWaNXwMRI/CgyV3AcOuhA==
X-Received: by 10.28.221.9 with SMTP id u9mr21237257wmg.92.1457545934976;
        Wed, 09 Mar 2016 09:52:14 -0800 (PST)
Received: from localhost.localdomain ([80.215.161.239])
        by smtp.gmail.com with ESMTPSA id e127sm24975419wma.20.2016.03.09.09.52.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Mar 2016 09:52:14 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.0.rc1.49.gca61272
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288495>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 94 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 838e46a..462e28f 100644
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
@@ -749,7 +752,7 @@ static int count_slashes(const char *cp)
  * Given the string after "--- " or "+++ ", guess the appropriate
  * p_value for the given patch.
  */
-static int guess_p_value(const char *nameline)
+static int guess_p_value(struct apply_state *state, const char *nameline)
 {
 	char *name, *cp;
 	int val = -1;
@@ -762,17 +765,17 @@ static int guess_p_value(const char *nameline)
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
@@ -859,7 +862,10 @@ static int has_epoch_timestamp(const char *nameline)
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
 
@@ -867,8 +873,8 @@ static void parse_traditional_patch(const char *first, const char *second, struc
 	second += 4;	/* skip "+++ " */
 	if (!p_value_known) {
 		int p, q;
-		p = guess_p_value(first);
-		q = guess_p_value(second);
+		p = guess_p_value(state, first);
+		q = guess_p_value(state, second);
 		if (p < 0) p = q;
 		if (0 <= p && p == q) {
 			p_value = p;
@@ -1439,7 +1445,11 @@ static int parse_fragment_header(const char *line, int len, struct fragment *fra
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
 
@@ -1516,7 +1526,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
 			continue;
 
 		/* Ok, we'll consider it a patch */
-		parse_traditional_patch(line, line+len, patch);
+		parse_traditional_patch(state, line, line+len, patch);
 		*hdrsize = len + nextlen;
 		linenr += 2;
 		return offset;
@@ -1918,21 +1928,21 @@ static int parse_binary(char *buffer, unsigned long size, struct patch *patch)
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
@@ -1949,16 +1959,16 @@ static void add_name_limit(const char *name, int exclude)
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
 
@@ -1985,17 +1995,17 @@ static int use_patch(struct patch *p)
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
@@ -4371,7 +4381,10 @@ static struct lock_file lock_file;
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
@@ -4388,12 +4401,12 @@ static int apply_patch(int fd, const char *filename, int options)
 		patch = xcalloc(1, sizeof(*patch));
 		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
 		patch->recount =  !!(options & RECOUNT);
-		nr = parse_chunk(buf.buf + offset, buf.len - offset, patch);
+		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0)
 			break;
 		if (apply_in_reverse)
 			reverse_patches(patch);
-		if (use_patch(patch)) {
+		if (use_patch(state, patch)) {
 			patch_stats(patch);
 			*listp = patch;
 			listp = &patch->next;
@@ -4516,6 +4529,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int is_not_gitdir = !startup_info->have_repository;
 	int force_apply = 0;
 	int options = 0;
+	struct apply_state state;
 
 	const char *whitespace_option = NULL;
 
@@ -4588,15 +4602,17 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
@@ -4627,23 +4643,25 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
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
2.8.0.rc1.49.gca61272
