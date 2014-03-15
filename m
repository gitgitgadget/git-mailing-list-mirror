From: Shubham Chaudhary <shubham.chaudhary@kdemail.net>
Subject: [PATCH] [GSoC] Use strchrnul to save additional scan of string
Date: Sat, 15 Mar 2014 06:19:08 +0530
Message-ID: <CACqsmRbYwEKrF2+NbpLLnx2zrovwFV+OQe64Zpzg5WGpRqGfJw@mail.gmail.com>
Reply-To: shubham.chaudhary@kdemail.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 01:49:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOcmq-0008Oe-09
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 01:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404AbaCOAtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 20:49:10 -0400
Received: from mail-qa0-f49.google.com ([209.85.216.49]:54433 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbaCOAtJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 20:49:09 -0400
Received: by mail-qa0-f49.google.com with SMTP id j7so3224167qaq.22
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 17:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:sender:date:message-id:subject:from:to
         :content-type;
        bh=Sb+lYIvroVuPu7HJrwlIc4JDIs1KMuxC7PKJK+uovoI=;
        b=QWOwd0pqgCjy9O/L57tMFN9rmVy9jwtaMnwIhY8jDxDDIa73yqsWM49nam2iN8g8Pc
         6fJJHnhnUgQ+Bb4e3E8vrhEtw/7Yh52fHCiqIUOMo12FKfKh8RcXTBNeuDsUh1FiCg2T
         TLS/5p1kT0LKkk1asIVpqEHDhn+QrtNU1HTtytGKNiCyyfKvaSnagu496bKWVGaCuf2W
         dIrB0nbiZxnl40WAPCck8Av0khV0W4blxgCe6T/wdyYkuIijNbRJ1blmGL5e2MkW2dpY
         vp/K0TKHDGAWedLpv0phC2/ebINhyy5QJbH+GScQ/pWnWj2iq6mzQov+GTzYOM5xYd+L
         rpyg==
X-Received: by 10.140.33.136 with SMTP id j8mr6206906qgj.97.1394844548559;
 Fri, 14 Mar 2014 17:49:08 -0700 (PDT)
Received: by 10.96.236.68 with HTTP; Fri, 14 Mar 2014 17:49:08 -0700 (PDT)
X-Google-Sender-Auth: fni8n-p8RzJI50g1rq4YoYFe4JE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244130>

>From c422507408824403ed18e89ec0bbc32b8764e09c Mon Sep 17 00:00:00 2001
From: Shubham Chaudhary <shubham.chaudhary@kdemail.net>
Date: Sat, 15 Mar 2014 05:56:18 +0530
Subject: [PATCH] [GSoC] Use strchrnul to save additional scan of string

Some strings are scanned twice unnecessarily, once with strchr() and
then with strlen().
I rewrote these sites using strchrnul() when appropriate.

Signed-off-by: Shubham Chaudhary <shubham.chaudhary@kdemail.net>
---
 archive.c                              |  4 ++--
 builtin/blame.c                        |  7 ++-----
 builtin/fmt-merge-msg.c                |  8 ++++----
 builtin/mailinfo.c                     |  8 ++------
 builtin/reset.c                        |  4 ++--
 builtin/shortlog.c                     | 10 +++-------
 cache-tree.c                           |  9 +++------
 contrib/examples/builtin-fetch--tool.c |  3 +--
 daemon.c                               |  4 +---
 diff.c                                 |  7 ++-----
 fast-import.c                          | 17 ++++-------------
 match-trees.c                          |  9 +++------
 parse-options.c                        |  5 +----
 pretty.c                               |  5 ++---
 remote-testsvn.c                       |  4 ++--
 ws.c                                   |  7 ++-----
 16 files changed, 36 insertions(+), 75 deletions(-)

diff --git a/archive.c b/archive.c
index 346f3b2..d196215 100644
--- a/archive.c
+++ b/archive.c
@@ -259,8 +259,8 @@ static void parse_treeish_arg(const char **argv,
 	/* Remotes are only allowed to fetch actual refs */
 	if (remote) {
 		char *ref = NULL;
-		const char *colon = strchr(name, ':');
-		int refnamelen = colon ? colon - name : strlen(name);
+		const char *colon = strchrnul(name, ':');
+		int refnamelen = colon - name;

 		if (!dwim_ref(name, refnamelen, sha1, &ref))
 			die("no such ref: %.*s", refnamelen, name);
diff --git a/builtin/blame.c b/builtin/blame.c
index e5b5d71..24c9676 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1332,11 +1332,8 @@ static void get_ac_line(const char *inbuf,
const char *what,
 	if (!tmp)
 		goto error_out;
 	tmp += strlen(what);
-	endp = strchr(tmp, '\n');
-	if (!endp)
-		len = strlen(tmp);
-	else
-		len = endp - tmp;
+	endp = strchrnul(tmp, '\n');
+	len = endp - tmp;

 	if (split_ident_line(&ident, tmp, len)) {
 	error_out:
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 3906eda..9e8da5b 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -539,12 +539,12 @@ static void find_merge_parents(struct
merge_parents *result,
 	while (pos < in->len) {
 		int len;
 		char *p = in->buf + pos;
-		char *newline = strchr(p, '\n');
+		char *newline = strchrnul(p, '\n');
 		unsigned char sha1[20];
 		struct commit *parent;
 		struct object *obj;

-		len = newline ? newline - p : strlen(p);
+		len = newline - p;
 		pos += len + !!newline;

 		if (len < 43 ||
@@ -615,8 +615,8 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		int len;
 		char *newline, *p = in->buf + pos;

-		newline = strchr(p, '\n');
-		len = newline ? newline - p : strlen(p);
+		newline = strchrnul(p, '\n');
+		len = newline - p;
 		pos += len + !!newline;
 		i++;
 		p[len] = 0;
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c3cd8e..f901cf3 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -902,12 +902,8 @@ static void output_header_lines(FILE *fout, const
char *hdr, const struct strbuf
 {
 	const char *sp = data->buf;
 	while (1) {
-		char *ep = strchr(sp, '\n');
-		int len;
-		if (!ep)
-			len = strlen(sp);
-		else
-			len = ep - sp;
+		char *ep = strchrnul(sp, '\n');
+		int len = ep - sp;
 		fprintf(fout, "%s: %.*s\n", hdr, len, sp);
 		if (!ep)
 			break;
diff --git a/builtin/reset.c b/builtin/reset.c
index 4fd1c6c..fa0ecf5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -103,8 +103,8 @@ static void print_new_head_line(struct commit *commit)
 		const char *eol;
 		size_t len;
 		body += 2;
-		eol = strchr(body, '\n');
-		len = eol ? eol - body : strlen(body);
+		eol = strchrnul(body, '\n');
+		len = eol - body;
 		printf(" %.*s\n", (int) len, body);
 	}
 	else
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4b7e536..f03174f 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -62,9 +62,7 @@ static void insert_one_record(struct shortlog *log,
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
 		oneline++;
-	eol = strchr(oneline, '\n');
-	if (!eol)
-		eol = oneline + strlen(oneline);
+	eol = strchrnul(oneline, '\n');
 	if (starts_with(oneline, "[PATCH")) {
 		char *eob = strchr(oneline, ']');
 		if (eob && (!eol || eob < eol))
@@ -116,11 +114,9 @@ void shortlog_add_commit(struct shortlog *log,
struct commit *commit)
 	pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
 	buffer = buf.buf;
 	while (*buffer && *buffer != '\n') {
-		const char *eol = strchr(buffer, '\n');
+		const char *eol = strchrnul(buffer, '\n');

-		if (eol == NULL)
-			eol = buffer + strlen(buffer);
-		else
+		if (*eol)
 			eol++;

 		if (starts_with(buffer, "author "))
diff --git a/cache-tree.c b/cache-tree.c
index 0bbec43..a658e36 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -121,11 +121,11 @@ void cache_tree_invalidate_path(struct
cache_tree *it, const char *path)

 	if (!it)
 		return;
-	slash = strchr(path, '/');
+	slash = strchrnul(path, '/');
+	namelen = slash - path;
 	it->entry_count = -1;
 	if (!slash) {
 		int pos;
-		namelen = strlen(path);
 		pos = subtree_pos(it, path, namelen);
 		if (0 <= pos) {
 			cache_tree_free(&it->down[pos]->cache_tree);
@@ -143,7 +143,6 @@ void cache_tree_invalidate_path(struct cache_tree
*it, const char *path)
 		}
 		return;
 	}
-	namelen = slash - path;
 	down = find_subtree(it, path, namelen, 0);
 	if (down)
 		cache_tree_invalidate_path(down->cache_tree, slash + 1);
@@ -554,9 +553,7 @@ static struct cache_tree *cache_tree_find(struct
cache_tree *it, const char *pat
 		const char *slash;
 		struct cache_tree_sub *sub;

-		slash = strchr(path, '/');
-		if (!slash)
-			slash = path + strlen(path);
+		slash = strchrnul(path, '/');
 		/* between path and slash is the name of the
 		 * subtree to look for.
 		 */
diff --git a/contrib/examples/builtin-fetch--tool.c
b/contrib/examples/builtin-fetch--tool.c
index 8bc8c75..1664a29 100644
--- a/contrib/examples/builtin-fetch--tool.c
+++ b/contrib/examples/builtin-fetch--tool.c
@@ -382,8 +382,7 @@ static int expand_refs_wildcard(const char
*ls_remote_result, int numrefs,

 			while (*ls && isspace(*ls))
 				ls++;
-			next = strchr(ls, '\n');
-			eol = !next ? (ls + strlen(ls)) : next;
+			eol = next = strchrnul(ls, '\n');
 			if (!memcmp("^{}", eol-3, 3))
 				continue;
 			if (eol - ls < 40)
diff --git a/daemon.c b/daemon.c
index eba1255..f0100ad 100644
--- a/daemon.c
+++ b/daemon.c
@@ -131,9 +131,7 @@ static const char *path_ok(char *directory)
 			 * "~alice/%s/foo".
 			 */
 			int namlen, restlen = strlen(dir);
-			char *slash = strchr(dir, '/');
-			if (!slash)
-				slash = dir + restlen;
+			char *slash = strchrnul(dir, '/');
 			namlen = slash - dir;
 			restlen -= namlen;
 			loginfo("userpath <%s>, request <%s>, namlen %d, restlen %d, slash
<%s>", user_path, dir, namlen, restlen, slash);
diff --git a/diff.c b/diff.c
index 7c59bfe..d3c3176 100644
--- a/diff.c
+++ b/diff.c
@@ -3365,11 +3365,8 @@ static int opt_arg(const char *arg, int
arg_short, const char *arg_long, int *va
 	if (c != '-')
 		return 0;
 	arg++;
-	eq = strchr(arg, '=');
-	if (eq)
-		len = eq - arg;
-	else
-		len = strlen(arg);
+	eq = strchrnul(arg, '=');
+	len = eq - arg;
 	if (!len || strncmp(arg, arg_long, len))
 		return 0;
 	if (eq) {
diff --git a/fast-import.c b/fast-import.c
index 4fd18a3..fbdac17 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1485,11 +1485,8 @@ static int tree_content_set(
 	unsigned int i, n;
 	struct tree_entry *e;

-	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	slash1 = strchrnul(p, '/');
+	n = slash1 - p;
 	if (!n)
 		die("Empty path component found in input");
 	if (!slash1 && !S_ISDIR(mode) && subtree)
@@ -1577,10 +1574,7 @@ static int tree_content_remove(
 	struct tree_entry *e;

 	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	n = slash1 - p;

 	if (!root->tree)
 		load_tree(root);
@@ -1645,10 +1639,7 @@ static int tree_content_get(
 	struct tree_entry *e;

 	slash1 = strchr(p, '/');
-	if (slash1)
-		n = slash1 - p;
-	else
-		n = strlen(p);
+	n = slash1 - p;
 	if (!n && !allow_root)
 		die("Empty path component found in input");

diff --git a/match-trees.c b/match-trees.c
index 7873cde..4ac5c3e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -182,13 +182,10 @@ static int splice_tree(const unsigned char *hash1,
 	enum object_type type;
 	int status;

-	subpath = strchr(prefix, '/');
-	if (!subpath)
-		toplen = strlen(prefix);
-	else {
-		toplen = subpath - prefix;
+	subpath = strchrnul(prefix, '/');
+	toplen = subpath - prefix;
+	if (subpath)
 		subpath++;
-	}

 	buf = read_sha1_file(hash1, &type, &sz);
 	if (!buf)
diff --git a/parse-options.c b/parse-options.c
index 7b8d3fa..a5fa0b8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -223,13 +223,10 @@ static int parse_long_opt(struct parse_opt_ctx_t
*p, const char *arg,
                           const struct option *options)
 {
 	const struct option *all_opts = options;
-	const char *arg_end = strchr(arg, '=');
+	const char *arg_end = strchrnul(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
 	int abbrev_flags = 0, ambiguous_flags = 0;

-	if (!arg_end)
-		arg_end = arg + strlen(arg);
-
 	for (; options->type != OPTION_END; options++) {
 		const char *rest, *long_name = options->long_name;
 		int flags = 0, opt_flags = 0;
diff --git a/pretty.c b/pretty.c
index 87db08b..75aad57 100644
--- a/pretty.c
+++ b/pretty.c
@@ -549,14 +549,13 @@ static char *get_header(const struct commit
*commit, const char *msg,
 	const char *line = msg;

 	while (line) {
-		const char *eol = strchr(line, '\n'), *next;
+		const char *eol = strchrnul(line, '\n'), *next;

 		if (line == eol)
 			return NULL;
-		if (!eol) {
+		if (*eol != '\n') {
 			warning("malformed commit (header is missing newline): %s",
 				sha1_to_hex(commit->object.sha1));
-			eol = line + strlen(line);
 			next = NULL;
 		} else
 			next = eol + 1;
diff --git a/remote-testsvn.c b/remote-testsvn.c
index 078f1ff..6be55cb 100644
--- a/remote-testsvn.c
+++ b/remote-testsvn.c
@@ -78,8 +78,8 @@ static int parse_rev_note(const char *msg, struct
rev_note *res)
 	size_t len;

 	while (*msg) {
-		end = strchr(msg, '\n');
-		len = end ? end - msg : strlen(msg);
+		end = strchrnul(msg, '\n');
+		len = end - msg;

 		key = "Revision-number: ";
 		if (starts_with(msg, key)) {
diff --git a/ws.c b/ws.c
index b498d75..ea4b2b1 100644
--- a/ws.c
+++ b/ws.c
@@ -33,11 +33,8 @@ unsigned parse_whitespace_rule(const char *string)
 		int negated = 0;

 		string = string + strspn(string, ", \t\n\r");
-		ep = strchr(string, ',');
-		if (!ep)
-			len = strlen(string);
-		else
-			len = ep - string;
+		ep = strchrnul(string, ',');
+		len = ep - string;

 		if (*string == '-') {
 			negated = 1;
-- 
1.8.3.2



-- 
Regards,
Shubham Chaudhary (UTC +05:30)
http://www.shubhamchaudhary.in
