From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/5] Rework unquote_c_style to work on a strbuf.
Date: Tue, 18 Sep 2007 23:22:47 +0200
Message-ID: <20070918224121.24C3B344AB3@madism.org>
References: <20070918223947.GB4535@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlli-0007mW-LF
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbXIRWl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 18:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbXIRWlZ
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:41:25 -0400
Received: from pan.madism.org ([88.191.52.104]:54831 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753748AbXIRWlW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 18:41:22 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 87B1E20A22;
	Wed, 19 Sep 2007 00:41:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 24C3B344AB3; Wed, 19 Sep 2007 00:41:21 +0200 (CEST)
In-Reply-To: <20070918223947.GB4535@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58651>

If the gain is not obvious in the diffstat, the resulting code is more
readable, _and_ in checkout-index/update-index we now reuse the same buffer
to unquote strings instead of always freeing/mallocing.

This also is more coherent with the next patch that reworks quoting
functions.

The quoting function is also made more efficient scanning for backslashes
and treating portions of strings without a backslash at once.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-apply.c          |  125 +++++++++++++++++++++++-----------------------
 builtin-checkout-index.c |   27 +++++-----
 builtin-update-index.c   |   51 ++++++++++---------
 fast-import.c            |   47 ++++++++---------
 mktree.c                 |   25 +++++----
 quote.c                  |   92 ++++++++++++++++------------------
 quote.h                  |    2 +-
 7 files changed, 184 insertions(+), 185 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 6a5e389..cffbe52 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -231,35 +231,33 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 {
 	int len;
 	const char *start = line;
-	char *name;
 
 	if (*line == '"') {
+		struct strbuf name;
+
 		/* Proposed "new-style" GNU patch/diff format; see
 		 * http://marc.theaimsgroup.com/?l=git&m=112927316408690&w=2
 		 */
-		name = unquote_c_style(line, NULL);
-		if (name) {
-			char *cp = name;
-			while (p_value) {
-				cp = strchr(name, '/');
+		strbuf_init(&name, 0);
+		if (!unquote_c_style(&name, line, NULL)) {
+			char *cp;
+
+			for (cp = name.buf; p_value; p_value--) {
+				cp = strchr(name.buf, '/');
 				if (!cp)
 					break;
 				cp++;
-				p_value--;
 			}
 			if (cp) {
 				/* name can later be freed, so we need
 				 * to memmove, not just return cp
 				 */
-				memmove(name, cp, strlen(cp) + 1);
+				strbuf_remove(&name, 0, cp - name.buf);
 				free(def);
-				return name;
-			}
-			else {
-				free(name);
-				name = NULL;
+				return name.buf;
 			}
 		}
+		strbuf_release(&name);
 	}
 
 	for (;;) {
@@ -566,29 +564,30 @@ static const char *stop_at_slash(const char *line, int llen)
  */
 static char *git_header_name(char *line, int llen)
 {
-	int len;
 	const char *name;
 	const char *second = NULL;
+	size_t len;
 
 	line += strlen("diff --git ");
 	llen -= strlen("diff --git ");
 
 	if (*line == '"') {
 		const char *cp;
-		char *first = unquote_c_style(line, &second);
-		if (!first)
-			return NULL;
+		struct strbuf first;
+		struct strbuf sp;
+
+		strbuf_init(&first, 0);
+		strbuf_init(&sp, 0);
+
+		if (unquote_c_style(&first, line, &second))
+			goto free_and_fail1;
 
 		/* advance to the first slash */
-		cp = stop_at_slash(first, strlen(first));
-		if (!cp || cp == first) {
-			/* we do not accept absolute paths */
-		free_first_and_fail:
-			free(first);
-			return NULL;
-		}
-		len = strlen(cp+1);
-		memmove(first, cp+1, len+1); /* including NUL */
+		cp = stop_at_slash(first.buf, first.len);
+		/* we do not accept absolute paths */
+		if (!cp || cp == first.buf)
+			goto free_and_fail1;
+		strbuf_remove(&first, 0, cp + 1 - first.buf);
 
 		/* second points at one past closing dq of name.
 		 * find the second name.
@@ -597,40 +596,40 @@ static char *git_header_name(char *line, int llen)
 			second++;
 
 		if (line + llen <= second)
-			goto free_first_and_fail;
+			goto free_and_fail1;
 		if (*second == '"') {
-			char *sp = unquote_c_style(second, NULL);
-			if (!sp)
-				goto free_first_and_fail;
-			cp = stop_at_slash(sp, strlen(sp));
-			if (!cp || cp == sp) {
-			free_both_and_fail:
-				free(sp);
-				goto free_first_and_fail;
-			}
+			if (unquote_c_style(&sp, second, NULL))
+				goto free_and_fail1;
+			cp = stop_at_slash(sp.buf, sp.len);
+			if (!cp || cp == sp.buf)
+				goto free_and_fail1;
 			/* They must match, otherwise ignore */
-			if (strcmp(cp+1, first))
-				goto free_both_and_fail;
-			free(sp);
-			return first;
+			if (strcmp(cp + 1, first.buf))
+				goto free_and_fail1;
+			strbuf_release(&sp);
+			return first.buf;
 		}
 
 		/* unquoted second */
 		cp = stop_at_slash(second, line + llen - second);
 		if (!cp || cp == second)
-			goto free_first_and_fail;
+			goto free_and_fail1;
 		cp++;
-		if (line + llen - cp != len + 1 ||
-		    memcmp(first, cp, len))
-			goto free_first_and_fail;
-		return first;
+		if (line + llen - cp != first.len + 1 ||
+		    memcmp(first.buf, cp, first.len))
+			goto free_and_fail1;
+		return first.buf;
+
+	free_and_fail1:
+		strbuf_release(&first);
+		strbuf_release(&sp);
+		return NULL;
 	}
 
 	/* unquoted first name */
 	name = stop_at_slash(line, llen);
 	if (!name || name == line)
 		return NULL;
-
 	name++;
 
 	/* since the first name is unquoted, a dq if exists must be
@@ -638,28 +637,30 @@ static char *git_header_name(char *line, int llen)
 	 */
 	for (second = name; second < line + llen; second++) {
 		if (*second == '"') {
-			const char *cp = second;
+			struct strbuf sp;
 			const char *np;
-			char *sp = unquote_c_style(second, NULL);
-
-			if (!sp)
-				return NULL;
-			np = stop_at_slash(sp, strlen(sp));
-			if (!np || np == sp) {
-			free_second_and_fail:
-				free(sp);
-				return NULL;
-			}
+
+			strbuf_init(&sp, 0);
+			if (unquote_c_style(&sp, second, NULL))
+				goto free_and_fail2;
+
+			np = stop_at_slash(sp.buf, sp.len);
+			if (!np || np == sp.buf)
+				goto free_and_fail2;
 			np++;
-			len = strlen(np);
-			if (len < cp - name &&
+
+			len = sp.buf + sp.len - np;
+			if (len < second - name &&
 			    !strncmp(np, name, len) &&
 			    isspace(name[len])) {
 				/* Good */
-				memmove(sp, np, len + 1);
-				return sp;
+				strbuf_remove(&sp, 0, np - sp.buf);
+				return sp.buf;
 			}
-			goto free_second_and_fail;
+
+		free_and_fail2:
+			strbuf_release(&sp);
+			return NULL;
 		}
 	}
 
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index a18ecc4..e6264c4 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -270,26 +270,27 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (read_from_stdin) {
-		struct strbuf buf;
+		struct strbuf buf, nbuf;
+
 		if (all)
 			die("git-checkout-index: don't mix '--all' and '--stdin'");
+
 		strbuf_init(&buf, 0);
-		while (1) {
-			char *path_name;
+		strbuf_init(&nbuf, 0);
+		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 			const char *p;
-			if (strbuf_getline(&buf, stdin, line_termination) == EOF)
-				break;
-			if (line_termination && buf.buf[0] == '"')
-				path_name = unquote_c_style(buf.buf, NULL);
-			else
-				path_name = buf.buf;
-			p = prefix_path(prefix, prefix_length, path_name);
+			if (line_termination && buf.buf[0] == '"') {
+				strbuf_reset(&nbuf);
+				if (unquote_c_style(&nbuf, buf.buf, NULL))
+					die("line is badly quoted");
+				strbuf_swap(&buf, &nbuf);
+			}
+			p = prefix_path(prefix, prefix_length, buf.buf);
 			checkout_file(p, prefix_length);
-			if (p < path_name || p > path_name + strlen(path_name))
+			if (p < buf.buf || p > buf.buf + buf.len)
 				free((char *)p);
-			if (path_name != buf.buf)
-				free(path_name);
 		}
+		strbuf_release(&nbuf);
 		strbuf_release(&buf);
 	}
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index acd5ab5..c76879e 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -295,8 +295,11 @@ static void update_one(const char *path, const char *prefix, int prefix_length)
 static void read_index_info(int line_termination)
 {
 	struct strbuf buf;
+	struct strbuf uq;
+
 	strbuf_init(&buf, 0);
-	while (1) {
+	strbuf_init(&uq, 0);
+	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
 		unsigned char sha1[20];
@@ -320,9 +323,6 @@ static void read_index_info(int line_termination)
 		 * This format is to put higher order stages into the
 		 * index file and matches git-ls-files --stage output.
 		 */
-		if (strbuf_getline(&buf, stdin, line_termination) == EOF)
-			break;
-
 		errno = 0;
 		ul = strtoul(buf.buf, &ptr, 8);
 		if (ptr == buf.buf || *ptr != ' '
@@ -347,15 +347,17 @@ static void read_index_info(int line_termination)
 		if (get_sha1_hex(tab - 40, sha1) || tab[-41] != ' ')
 			goto bad_line;
 
-		if (line_termination && ptr[0] == '"')
-			path_name = unquote_c_style(ptr, NULL);
-		else
-			path_name = ptr;
+		path_name = ptr;
+		if (line_termination && path_name[0] == '"') {
+			strbuf_reset(&uq);
+			if (unquote_c_style(&uq, path_name, NULL)) {
+				die("git-update-index: bad quoting of path name");
+			}
+			path_name = uq.buf;
+		}
 
 		if (!verify_path(path_name)) {
 			fprintf(stderr, "Ignoring path %s\n", path_name);
-			if (path_name != ptr)
-				free(path_name);
 			continue;
 		}
 
@@ -383,6 +385,7 @@ static void read_index_info(int line_termination)
 		die("malformed index info %s", buf.buf);
 	}
 	strbuf_release(&buf);
+	strbuf_release(&uq);
 }
 
 static const char update_index_usage[] =
@@ -705,26 +708,26 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			free((char*)p);
 	}
 	if (read_from_stdin) {
-		struct strbuf buf;
+		struct strbuf buf, nbuf;
+
 		strbuf_init(&buf, 0);
-		while (1) {
-			char *path_name;
+		strbuf_init(&nbuf, 0);
+		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
 			const char *p;
-			if (strbuf_getline(&buf, stdin, line_termination) == EOF)
-				break;
-			if (line_termination && buf.buf[0] == '"')
-				path_name = unquote_c_style(buf.buf, NULL);
-			else
-				path_name = buf.buf;
-			p = prefix_path(prefix, prefix_length, path_name);
+			if (line_termination && buf.buf[0] == '"') {
+				strbuf_reset(&nbuf);
+				if (unquote_c_style(&nbuf, buf.buf, NULL))
+					die("line is badly quoted");
+				strbuf_swap(&buf, &nbuf);
+			}
+			p = prefix_path(prefix, prefix_length, buf.buf);
 			update_one(p, NULL, 0);
 			if (set_executable_bit)
 				chmod_path(set_executable_bit, p);
-			if (p < path_name || p > path_name + strlen(path_name))
-				free((char*) p);
-			if (path_name != buf.buf)
-				free(path_name);
+			if (p < buf.buf || p > buf.buf + buf.len)
+				free((char *)p);
 		}
+		strbuf_release(&nbuf);
 		strbuf_release(&buf);
 	}
 
diff --git a/fast-import.c b/fast-import.c
index eddae22..a870a44 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1759,7 +1759,7 @@ static void load_branch(struct branch *b)
 static void file_change_m(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
-	char *p_uq;
+	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 	struct object_entry *oe = oe;
 	unsigned char sha1[20];
@@ -1797,18 +1797,20 @@ static void file_change_m(struct branch *b)
 	if (*p++ != ' ')
 		die("Missing space after SHA1: %s", command_buf.buf);
 
-	p_uq = unquote_c_style(p, &endp);
-	if (p_uq) {
+	strbuf_reset(&uq);
+	if (!unquote_c_style(&uq, p, &endp)) {
 		if (*endp)
 			die("Garbage after path in: %s", command_buf.buf);
-		p = p_uq;
+		p = uq.buf;
 	}
 
 	if (inline_data) {
 		static struct strbuf buf = STRBUF_INIT;
 
-		if (!p_uq)
-			p = p_uq = xstrdup(p);
+		if (p != uq.buf) {
+			strbuf_addstr(&uq, p);
+			p = uq.buf;
+		}
 		read_next_command();
 		cmd_data(&buf);
 		store_object(OBJ_BLOB, &buf, &last_blob, sha1, 0);
@@ -1826,56 +1828,54 @@ static void file_change_m(struct branch *b)
 	}
 
 	tree_content_set(&b->branch_tree, p, sha1, S_IFREG | mode, NULL);
-	free(p_uq);
 }
 
 static void file_change_d(struct branch *b)
 {
 	const char *p = command_buf.buf + 2;
-	char *p_uq;
+	static struct strbuf uq = STRBUF_INIT;
 	const char *endp;
 
-	p_uq = unquote_c_style(p, &endp);
-	if (p_uq) {
+	strbuf_reset(&uq);
+	if (!unquote_c_style(&uq, p, &endp)) {
 		if (*endp)
 			die("Garbage after path in: %s", command_buf.buf);
-		p = p_uq;
+		p = uq.buf;
 	}
 	tree_content_remove(&b->branch_tree, p, NULL);
-	free(p_uq);
 }
 
 static void file_change_cr(struct branch *b, int rename)
 {
 	const char *s, *d;
-	char *s_uq, *d_uq;
+	static struct strbuf s_uq = STRBUF_INIT;
+	static struct strbuf d_uq = STRBUF_INIT;
 	const char *endp;
 	struct tree_entry leaf;
 
 	s = command_buf.buf + 2;
-	s_uq = unquote_c_style(s, &endp);
-	if (s_uq) {
+	strbuf_reset(&s_uq);
+	if (!unquote_c_style(&s_uq, s, &endp)) {
 		if (*endp != ' ')
 			die("Missing space after source: %s", command_buf.buf);
-	}
-	else {
+	} else {
 		endp = strchr(s, ' ');
 		if (!endp)
 			die("Missing space after source: %s", command_buf.buf);
-		s_uq = xmemdupz(s, endp - s);
+		strbuf_add(&s_uq, s, endp - s);
 	}
-	s = s_uq;
+	s = s_uq.buf;
 
 	endp++;
 	if (!*endp)
 		die("Missing dest: %s", command_buf.buf);
 
 	d = endp;
-	d_uq = unquote_c_style(d, &endp);
-	if (d_uq) {
+	strbuf_reset(&d_uq);
+	if (!unquote_c_style(&d_uq, d, &endp)) {
 		if (*endp)
 			die("Garbage after dest in: %s", command_buf.buf);
-		d = d_uq;
+		d = d_uq.buf;
 	}
 
 	memset(&leaf, 0, sizeof(leaf));
@@ -1889,9 +1889,6 @@ static void file_change_cr(struct branch *b, int rename)
 		leaf.versions[1].sha1,
 		leaf.versions[1].mode,
 		leaf.tree);
-
-	free(s_uq);
-	free(d_uq);
 }
 
 static void file_change_deleteall(struct branch *b)
diff --git a/mktree.c b/mktree.c
index 9c137de..e0da110 100644
--- a/mktree.c
+++ b/mktree.c
@@ -66,6 +66,7 @@ static const char mktree_usage[] = "git-mktree [-z]";
 int main(int ac, char **av)
 {
 	struct strbuf sb;
+	struct strbuf p_uq;
 	unsigned char sha1[20];
 	int line_termination = '\n';
 
@@ -82,14 +83,13 @@ int main(int ac, char **av)
 	}
 
 	strbuf_init(&sb, 0);
-	while (1) {
+	strbuf_init(&p_uq, 0);
+	while (strbuf_getline(&sb, stdin, line_termination) != EOF) {
 		char *ptr, *ntr;
 		unsigned mode;
 		enum object_type type;
 		char *path;
 
-		if (strbuf_getline(&sb, stdin, line_termination) == EOF)
-			break;
 		ptr = sb.buf;
 		/* Input is non-recursive ls-tree output format
 		 * mode SP type SP sha1 TAB name
@@ -109,18 +109,21 @@ int main(int ac, char **av)
 		*ntr++ = 0; /* now at the beginning of SHA1 */
 		if (type != type_from_string(ptr))
 			die("object type %s mismatch (%s)", ptr, typename(type));
-		ntr += 41; /* at the beginning of name */
-		if (line_termination && ntr[0] == '"')
-			path = unquote_c_style(ntr, NULL);
-		else
-			path = ntr;
 
-		append_to_tree(mode, sha1, path);
+		path = ntr + 41;  /* at the beginning of name */
+		if (line_termination && path[0] == '"') {
+			strbuf_reset(&p_uq);
+			if (unquote_c_style(&p_uq, path, NULL)) {
+				die("invalid quoting");
+			}
+			path = p_uq.buf;
+		}
 
-		if (path != ntr)
-			free(path);
+		append_to_tree(mode, sha1, path);
 	}
+	strbuf_release(&p_uq);
 	strbuf_release(&sb);
+
 	write_tree(sha1);
 	puts(sha1_to_hex(sha1));
 	exit(0);
diff --git a/quote.c b/quote.c
index 4df3262..67c6527 100644
--- a/quote.c
+++ b/quote.c
@@ -201,68 +201,62 @@ int quote_c_style(const char *name, char *outbuf, FILE *outfp, int no_dq)
  * should free when done.  Updates endp pointer to point at
  * one past the ending double quote if given.
  */
-
-char *unquote_c_style(const char *quoted, const char **endp)
+int unquote_c_style(struct strbuf *sb, const char *quoted, const char **endp)
 {
-	const char *sp;
-	char *name = NULL, *outp = NULL;
-	int count = 0, ch, ac;
-
-#undef EMIT
-#define EMIT(c) (outp ? (*outp++ = (c)) : (count++))
+	size_t oldlen = sb->len, len;
+	int ch, ac;
 
 	if (*quoted++ != '"')
-		return NULL;
+		return -1;
+
+	for (;;) {
+		len = strcspn(quoted, "\"\\");
+		strbuf_add(sb, quoted, len);
+		quoted += len;
+
+		switch (*quoted++) {
+		  case '"':
+			if (endp)
+				*endp = quoted + 1;
+			return 0;
+		  case '\\':
+			break;
+		  default:
+			goto error;
+		}
+
+		switch ((ch = *quoted++)) {
+		case 'a': ch = '\a'; break;
+		case 'b': ch = '\b'; break;
+		case 'f': ch = '\f'; break;
+		case 'n': ch = '\n'; break;
+		case 'r': ch = '\r'; break;
+		case 't': ch = '\t'; break;
+		case 'v': ch = '\v'; break;
 
-	while (1) {
-		/* first pass counts and allocates, second pass fills */
-		for (sp = quoted; (ch = *sp++) != '"'; ) {
-			if (ch == '\\') {
-				switch (ch = *sp++) {
-				case 'a': ch = '\a'; break;
-				case 'b': ch = '\b'; break;
-				case 'f': ch = '\f'; break;
-				case 'n': ch = '\n'; break;
-				case 'r': ch = '\r'; break;
-				case 't': ch = '\t'; break;
-				case 'v': ch = '\v'; break;
-
-				case '\\': case '"':
-					break; /* verbatim */
-
-				case '0':
-				case '1':
-				case '2':
-				case '3':
-				case '4':
-				case '5':
-				case '6':
-				case '7':
-					/* octal */
+		case '\\': case '"':
+			break; /* verbatim */
+
+		/* octal values with first digit over 4 overflow */
+		case '0': case '1': case '2': case '3':
 					ac = ((ch - '0') << 6);
-					if ((ch = *sp++) < '0' || '7' < ch)
-						return NULL;
+			if ((ch = *quoted++) < '0' || '7' < ch)
+				goto error;
 					ac |= ((ch - '0') << 3);
-					if ((ch = *sp++) < '0' || '7' < ch)
-						return NULL;
+			if ((ch = *quoted++) < '0' || '7' < ch)
+				goto error;
 					ac |= (ch - '0');
 					ch = ac;
 					break;
 				default:
-					return NULL; /* malformed */
-				}
+			goto error;
 			}
-			EMIT(ch);
+		strbuf_addch(sb, ch);
 		}
 
-		if (name) {
-			*outp = 0;
-			if (endp)
-				*endp = sp;
-			return name;
-		}
-		outp = name = xmalloc(count + 1);
-	}
+  error:
+	strbuf_setlen(sb, oldlen);
+	return -1;
 }
 
 void write_name_quoted(const char *prefix, int prefix_len,
diff --git a/quote.h b/quote.h
index 78e8d3e..6407c4d 100644
--- a/quote.h
+++ b/quote.h
@@ -40,9 +40,9 @@ extern void sq_quote_argv(struct strbuf *, const char **argv, int count,
  */
 extern char *sq_dequote(char *);
 
+extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
 extern int quote_c_style(const char *name, char *outbuf, FILE *outfp,
 			 int nodq);
-extern char *unquote_c_style(const char *quoted, const char **endp);
 
 extern void write_name_quoted(const char *prefix, int prefix_len,
 			      const char *name, int quote, FILE *out);
-- 
1.5.3.1
