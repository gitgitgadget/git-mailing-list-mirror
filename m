From: Jeff King <peff@peff.net>
Subject: [PATCH 3/9] grep: refactor the concept of "grep source" into an
 object
Date: Thu, 2 Feb 2012 03:19:28 -0500
Message-ID: <20120202081928.GC6786@sigill.intra.peff.net>
References: <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 09:19:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsrtJ-0000Dp-1Z
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 09:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab2BBITc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 03:19:32 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52857
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753981Ab2BBITb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 03:19:31 -0500
Received: (qmail 17826 invoked by uid 107); 2 Feb 2012 08:26:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Feb 2012 03:26:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2012 03:19:28 -0500
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189595>

The main interface to the low-level grep code is
grep_buffer, which takes a pointer to a buffer and a size.
This is convenient and flexible (we use it to grep commit
bodies, files on disk, and blobs by sha1), but it makes it
hard to pass extra information about what we are grepping
(either for correctness, like overriding binary
auto-detection, or for optimizations, like lazily loading
blob contents).

Instead, let's encapsulate the idea of a "grep source",
including the buffer, its size, and where the data is coming
from. This is similar to the diff_filespec structure used by
the diff code (unsurprising, since future patches will
implement some of the same optimizations found there).

The diffstat is slightly scarier than the actual patch
content. Most of the modified lines are simply replacing
access to raw variables with their counterparts that are now
in a "struct grep_source". Most of the added lines were
taken from builtin/grep.c, which partially abstracted the
idea of grep sources (for file vs sha1 sources).

Instead of dropping the now-redundant code, this patch
leaves builtin/grep.c using the traditional grep_buffer
interface (which now wraps the grep_source interface). That
makes it easy to test that there is no change of behavior
(yet).

Signed-off-by: Jeff King <peff@peff.net>
---
 grep.c |  198 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 grep.h |   22 +++++++
 2 files changed, 186 insertions(+), 34 deletions(-)

diff --git a/grep.c b/grep.c
index db58a29..8204ca2 100644
--- a/grep.c
+++ b/grep.c
@@ -837,13 +837,13 @@ pthread_mutex_t grep_read_mutex;
 #define grep_attr_unlock()
 #endif
 
-static int match_funcname(struct grep_opt *opt, const char *name, char *bol, char *eol)
+static int match_funcname(struct grep_opt *opt, struct grep_source *gs, char *bol, char *eol)
 {
 	xdemitconf_t *xecfg = opt->priv;
 	if (xecfg && !xecfg->find_func) {
 		struct userdiff_driver *drv;
 		grep_attr_lock();
-		drv = userdiff_find_by_path(name);
+		drv = userdiff_find_by_path(gs->name);
 		grep_attr_unlock();
 		if (drv && drv->funcname.pattern) {
 			const struct userdiff_funcname *pe = &drv->funcname;
@@ -866,33 +866,33 @@ static int match_funcname(struct grep_opt *opt, const char *name, char *bol, cha
 	return 0;
 }
 
-static void show_funcname_line(struct grep_opt *opt, const char *name,
-			       char *buf, char *bol, unsigned lno)
+static void show_funcname_line(struct grep_opt *opt, struct grep_source *gs,
+			       char *bol, unsigned lno)
 {
-	while (bol > buf) {
+	while (bol > gs->buf) {
 		char *eol = --bol;
 
-		while (bol > buf && bol[-1] != '\n')
+		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
 		lno--;
 
 		if (lno <= opt->last_shown)
 			break;
 
-		if (match_funcname(opt, name, bol, eol)) {
-			show_line(opt, bol, eol, name, lno, '=');
+		if (match_funcname(opt, gs, bol, eol)) {
+			show_line(opt, bol, eol, gs->name, lno, '=');
 			break;
 		}
 	}
 }
 
-static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
+static void show_pre_context(struct grep_opt *opt, struct grep_source *gs,
 			     char *bol, char *end, unsigned lno)
 {
 	unsigned cur = lno, from = 1, funcname_lno = 0;
 	int funcname_needed = !!opt->funcname;
 
-	if (opt->funcbody && !match_funcname(opt, name, bol, end))
+	if (opt->funcbody && !match_funcname(opt, gs, bol, end))
 		funcname_needed = 2;
 
 	if (opt->pre_context < lno)
@@ -901,14 +901,14 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 		from = opt->last_shown + 1;
 
 	/* Rewind. */
-	while (bol > buf &&
+	while (bol > gs->buf &&
 	       cur > (funcname_needed == 2 ? opt->last_shown + 1 : from)) {
 		char *eol = --bol;
 
-		while (bol > buf && bol[-1] != '\n')
+		while (bol > gs->buf && bol[-1] != '\n')
 			bol--;
 		cur--;
-		if (funcname_needed && match_funcname(opt, name, bol, eol)) {
+		if (funcname_needed && match_funcname(opt, gs, bol, eol)) {
 			funcname_lno = cur;
 			funcname_needed = 0;
 		}
@@ -916,7 +916,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 
 	/* We need to look even further back to find a function signature. */
 	if (opt->funcname && funcname_needed)
-		show_funcname_line(opt, name, buf, bol, cur);
+		show_funcname_line(opt, gs, bol, cur);
 
 	/* Back forward. */
 	while (cur < lno) {
@@ -924,7 +924,7 @@ static void show_pre_context(struct grep_opt *opt, const char *name, char *buf,
 
 		while (*eol != '\n')
 			eol++;
-		show_line(opt, bol, eol, name, cur, sign);
+		show_line(opt, bol, eol, gs->name, cur, sign);
 		bol = eol + 1;
 		cur++;
 	}
@@ -991,11 +991,10 @@ static void std_output(struct grep_opt *opt, const void *buf, size_t size)
 	fwrite(buf, size, 1, stdout);
 }
 
-static int grep_buffer_1(struct grep_opt *opt, const char *name,
-			 char *buf, unsigned long size, int collect_hits)
+static int grep_source_1(struct grep_opt *opt, struct grep_source *gs, int collect_hits)
 {
-	char *bol = buf;
-	unsigned long left = size;
+	char *bol;
+	unsigned long left;
 	unsigned lno = 1;
 	unsigned last_hit = 0;
 	int binary_match_only = 0;
@@ -1023,13 +1022,16 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	}
 	opt->last_shown = 0;
 
+	if (grep_source_load(gs) < 0)
+		return 0;
+
 	switch (opt->binary) {
 	case GREP_BINARY_DEFAULT:
-		if (buffer_is_binary(buf, size))
+		if (buffer_is_binary(gs->buf, gs->size))
 			binary_match_only = 1;
 		break;
 	case GREP_BINARY_NOMATCH:
-		if (buffer_is_binary(buf, size))
+		if (buffer_is_binary(gs->buf, gs->size))
 			return 0; /* Assume unmatch */
 		break;
 	case GREP_BINARY_TEXT:
@@ -1043,6 +1045,8 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 
 	try_lookahead = should_lookahead(opt);
 
+	bol = gs->buf;
+	left = gs->size;
 	while (left) {
 		char *eol, ch;
 		int hit;
@@ -1091,14 +1095,14 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			if (opt->status_only)
 				return 1;
 			if (opt->name_only) {
-				show_name(opt, name);
+				show_name(opt, gs->name);
 				return 1;
 			}
 			if (opt->count)
 				goto next_line;
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
-				output_color(opt, name, strlen(name),
+				output_color(opt, gs->name, strlen(gs->name),
 					     opt->color_filename);
 				opt->output(opt, " matches\n", 9);
 				return 1;
@@ -1107,23 +1111,23 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 			 * pre-context lines, we would need to show them.
 			 */
 			if (opt->pre_context || opt->funcbody)
-				show_pre_context(opt, name, buf, bol, eol, lno);
+				show_pre_context(opt, gs, bol, eol, lno);
 			else if (opt->funcname)
-				show_funcname_line(opt, name, buf, bol, lno);
-			show_line(opt, bol, eol, name, lno, ':');
+				show_funcname_line(opt, gs, bol, lno);
+			show_line(opt, bol, eol, gs->name, lno, ':');
 			last_hit = lno;
 			if (opt->funcbody)
 				show_function = 1;
 			goto next_line;
 		}
-		if (show_function && match_funcname(opt, name, bol, eol))
+		if (show_function && match_funcname(opt, gs, bol, eol))
 			show_function = 0;
 		if (show_function ||
 		    (last_hit && lno <= last_hit + opt->post_context)) {
 			/* If the last hit is within the post context,
 			 * we need to show this line.
 			 */
-			show_line(opt, bol, eol, name, lno, '-');
+			show_line(opt, bol, eol, gs->name, lno, '-');
 		}
 
 	next_line:
@@ -1141,7 +1145,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 		return 0;
 	if (opt->unmatch_name_only) {
 		/* We did not see any hit, so we want to show this */
-		show_name(opt, name);
+		show_name(opt, gs->name);
 		return 1;
 	}
 
@@ -1155,7 +1159,7 @@ static int grep_buffer_1(struct grep_opt *opt, const char *name,
 	 */
 	if (opt->count && count) {
 		char buf[32];
-		output_color(opt, name, strlen(name), opt->color_filename);
+		output_color(opt, gs->name, strlen(gs->name), opt->color_filename);
 		output_sep(opt, ':');
 		snprintf(buf, sizeof(buf), "%u\n", count);
 		opt->output(opt, buf, strlen(buf));
@@ -1190,23 +1194,149 @@ static int chk_hit_marker(struct grep_expr *x)
 	}
 }
 
-int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+int grep_source(struct grep_opt *opt, struct grep_source *gs)
 {
 	/*
 	 * we do not have to do the two-pass grep when we do not check
 	 * buffer-wide "all-match".
 	 */
 	if (!opt->all_match)
-		return grep_buffer_1(opt, name, buf, size, 0);
+		return grep_source_1(opt, gs, 0);
 
 	/* Otherwise the toplevel "or" terms hit a bit differently.
 	 * We first clear hit markers from them.
 	 */
 	clr_hit_marker(opt->pattern_expression);
-	grep_buffer_1(opt, name, buf, size, 1);
+	grep_source_1(opt, gs, 1);
 
 	if (!chk_hit_marker(opt->pattern_expression))
 		return 0;
 
-	return grep_buffer_1(opt, name, buf, size, 0);
+	return grep_source_1(opt, gs, 0);
+}
+
+int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size)
+{
+	struct grep_source gs;
+	int r;
+
+	grep_source_init(&gs, GREP_SOURCE_BUF, name, NULL);
+	gs.buf = buf;
+	gs.size = size;
+
+	r = grep_source(opt, &gs);
+
+	grep_source_clear(&gs);
+	return r;
+}
+
+void grep_source_init(struct grep_source *gs, enum grep_source_type type,
+		      const char *name, const void *identifier)
+{
+	gs->type = type;
+	gs->name = name ? xstrdup(name) : NULL;
+	gs->buf = NULL;
+	gs->size = 0;
+
+	switch (type) {
+	case GREP_SOURCE_FILE:
+		gs->identifier = xstrdup(identifier);
+		break;
+	case GREP_SOURCE_SHA1:
+		gs->identifier = xmalloc(20);
+		memcpy(gs->identifier, identifier, 20);
+		break;
+	case GREP_SOURCE_BUF:
+		gs->identifier = NULL;
+	}
+}
+
+void grep_source_clear(struct grep_source *gs)
+{
+	free(gs->name);
+	gs->name = NULL;
+	free(gs->identifier);
+	gs->identifier = NULL;
+	grep_source_clear_data(gs);
+}
+
+void grep_source_clear_data(struct grep_source *gs)
+{
+	switch (gs->type) {
+	case GREP_SOURCE_FILE:
+	case GREP_SOURCE_SHA1:
+		free(gs->buf);
+		gs->buf = NULL;
+		gs->size = 0;
+		break;
+	case GREP_SOURCE_BUF:
+		/* leave user-provided buf intact */
+		break;
+	}
+}
+
+static int grep_source_load_sha1(struct grep_source *gs)
+{
+	enum object_type type;
+
+	grep_read_lock();
+	gs->buf = read_sha1_file(gs->identifier, &type, &gs->size);
+	grep_read_unlock();
+
+	if (!gs->buf)
+		return error(_("'%s': unable to read %s"),
+			     gs->name,
+			     sha1_to_hex(gs->identifier));
+	return 0;
+}
+
+static int grep_source_load_file(struct grep_source *gs)
+{
+	const char *filename = gs->identifier;
+	struct stat st;
+	char *data;
+	size_t size;
+	int i;
+
+	if (lstat(filename, &st) < 0) {
+	err_ret:
+		if (errno != ENOENT)
+			error(_("'%s': %s"), filename, strerror(errno));
+		return -1;
+	}
+	if (!S_ISREG(st.st_mode))
+		return -1;
+	size = xsize_t(st.st_size);
+	i = open(filename, O_RDONLY);
+	if (i < 0)
+		goto err_ret;
+	data = xmalloc(size + 1);
+	if (st.st_size != read_in_full(i, data, size)) {
+		error(_("'%s': short read %s"), filename, strerror(errno));
+		close(i);
+		free(data);
+		return -1;
+	}
+	close(i);
+	data[size] = 0;
+
+	gs->buf = data;
+	gs->size = size;
+	return 0;
+}
+
+int grep_source_load(struct grep_source *gs)
+{
+	if (gs->buf)
+		return 0;
+
+	switch (gs->type) {
+	case GREP_SOURCE_FILE:
+		return grep_source_load_file(gs);
+	case GREP_SOURCE_SHA1:
+		return grep_source_load_sha1(gs);
+	case GREP_SOURCE_BUF:
+		return gs->buf ? 0 : -1;
+	}
+	die("BUG: invalid grep_source type");
 }
diff --git a/grep.h b/grep.h
index 4f1b025..e386ca4 100644
--- a/grep.h
+++ b/grep.h
@@ -129,6 +129,28 @@ extern void compile_grep_patterns(struct grep_opt *opt);
 extern void free_grep_patterns(struct grep_opt *opt);
 extern int grep_buffer(struct grep_opt *opt, const char *name, char *buf, unsigned long size);
 
+struct grep_source {
+	char *name;
+
+	enum grep_source_type {
+		GREP_SOURCE_SHA1,
+		GREP_SOURCE_FILE,
+		GREP_SOURCE_BUF,
+	} type;
+	void *identifier;
+
+	char *buf;
+	unsigned long size;
+};
+
+void grep_source_init(struct grep_source *gs, enum grep_source_type type,
+		      const char *name, const void *identifier);
+int grep_source_load(struct grep_source *gs);
+void grep_source_clear_data(struct grep_source *gs);
+void grep_source_clear(struct grep_source *gs);
+
+int grep_source(struct grep_opt *opt, struct grep_source *gs);
+
 extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
 extern int grep_threads_ok(const struct grep_opt *opt);
 
-- 
1.7.9.3.gc3fce1.dirty
