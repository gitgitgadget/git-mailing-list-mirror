From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/2] Use xmemdup in many places.
Date: Sun, 16 Sep 2007 00:32:36 +0200
Message-ID: <20070917161142.D3C9A344A49@madism.org>
References: <20070917161113.GB460@artemis.corp>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 17 18:11:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXJCQ-00052A-TQ
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 18:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXIQQLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 12:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751991AbXIQQLq
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 12:11:46 -0400
Received: from pan.madism.org ([88.191.52.104]:48342 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751984AbXIQQLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 12:11:44 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 29FBD205CB;
	Mon, 17 Sep 2007 18:11:43 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id D3C9A344A49; Mon, 17 Sep 2007 18:11:42 +0200 (CEST)
In-Reply-To: <20070917161113.GB460@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58457>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 attr.c                  |    7 +------
 builtin-add.c           |    8 ++------
 builtin-apply.c         |   11 ++---------
 builtin-fetch--tool.c   |    6 +-----
 builtin-fmt-merge-msg.c |   17 ++++++-----------
 builtin-for-each-ref.c  |   40 +++++++++-------------------------------
 builtin-log.c           |   12 ++----------
 builtin-ls-files.c      |    9 +--------
 builtin-mv.c            |    5 +----
 builtin-revert.c        |    4 +---
 builtin-shortlog.c      |   11 ++---------
 commit.c                |   16 ++++++----------
 connect.c               |    4 +---
 convert.c               |    7 +------
 diff.c                  |   13 ++-----------
 diffcore-order.c        |    7 ++-----
 fast-import.c           |    4 +---
 http-push.c             |    9 ++-------
 imap-send.c             |   20 +++++---------------
 merge-recursive.c       |   19 ++++---------------
 refs.c                  |   12 ++++--------
 sha1_file.c             |   12 +++---------
 tag.c                   |    4 +---
 23 files changed, 60 insertions(+), 197 deletions(-)

diff --git a/attr.c b/attr.c
index 1293993..fbfc2eb 100644
--- a/attr.c
+++ b/attr.c
@@ -160,12 +160,7 @@ static const char *parse_attr(const char *src, int lineno, const char *cp,
 		else if (!equals)
 			e->setto = ATTR__TRUE;
 		else {
-			char *value;
-			int vallen = ep - equals;
-			value = xmalloc(vallen);
-			memcpy(value, equals+1, vallen-1);
-			value[vallen-1] = 0;
-			e->setto = value;
+			e->setto = xmemdup(equals + 1, ep - equals - 1);
 		}
 		e->attr = git_attr(cp, len);
 	}
diff --git a/builtin-add.c b/builtin-add.c
index 0d7d0ce..55eedd8 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -71,12 +71,8 @@ static void fill_directory(struct dir_struct *dir, const char **pathspec,
 	baselen = common_prefix(pathspec);
 	path = ".";
 	base = "";
-	if (baselen) {
-		char *common = xmalloc(baselen + 1);
-		memcpy(common, *pathspec, baselen);
-		common[baselen] = 0;
-		path = base = common;
-	}
+	if (baselen)
+		path = base = xmemdup(*pathspec, baselen);
 
 	/* Read the directory and prune it */
 	read_directory(dir, path, base, baselen, pathspec);
diff --git a/builtin-apply.c b/builtin-apply.c
index 05011bb..900d0a7 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -293,11 +293,7 @@ static char *find_name(const char *line, char *def, int p_value, int terminate)
 			return def;
 	}
 
-	name = xmalloc(len + 1);
-	memcpy(name, start, len);
-	name[len] = 0;
-	free(def);
-	return name;
+	return xmemdup(start, len);
 }
 
 static int count_slashes(const char *cp)
@@ -687,10 +683,7 @@ static char *git_header_name(char *line, int llen)
 					break;
 			}
 			if (second[len] == '\n' && !memcmp(name, second, len)) {
-				char *ret = xmalloc(len + 1);
-				memcpy(ret, name, len);
-				ret[len] = 0;
-				return ret;
+				return xmemdup(name, len);
 			}
 		}
 	}
diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 514a3cc..327f555 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -222,19 +222,15 @@ static char *find_local_name(const char *remote_name, const char *refs,
 		}
 		if (!strncmp(remote_name, ref, len) && ref[len] == ':') {
 			const char *local_part = ref + len + 1;
-			char *ret;
 			int retlen;
 
 			if (!next)
 				retlen = strlen(local_part);
 			else
 				retlen = next - local_part;
-			ret = xmalloc(retlen + 1);
-			memcpy(ret, local_part, retlen);
-			ret[retlen] = 0;
 			*force_p = single_force;
 			*not_for_merge_p = not_for_merge;
-			return ret;
+			return xmemdup(local_part, retlen);
 		}
 		ref = next;
 	}
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index ae60fcc..6dd217a 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -140,12 +140,10 @@ static int handle_line(char *line)
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
 		int len = strlen(origin);
 		if (origin[0] == '\'' && origin[len - 1] == '\'') {
-			char *new_origin = xmalloc(len - 1);
-			memcpy(new_origin, origin + 1, len - 2);
-			new_origin[len - 2] = 0;
-			origin = new_origin;
-		} else
+			origin = xmemdup(origin + 1, len - 2);
+		} else {
 			origin = xstrdup(origin);
+		}
 	} else {
 		char *new_origin = xmalloc(strlen(origin) + strlen(src) + 5);
 		sprintf(new_origin, "%s of %s", origin, src);
@@ -211,14 +209,11 @@ static void shortlog(const char *name, unsigned char *sha1,
 
 		bol += 2;
 		eol = strchr(bol, '\n');
-
 		if (eol) {
-			int len = eol - bol;
-			oneline = xmalloc(len + 1);
-			memcpy(oneline, bol, len);
-			oneline[len] = 0;
-		} else
+			oneline = xmemdup(bol, eol - bol);
+		} else {
 			oneline = xstrdup(bol);
+		}
 		append_to_list(&subjects, oneline, NULL);
 	}
 
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 0afa1c5..287d52a 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -87,7 +87,6 @@ static int used_atom_cnt, sort_atom_limit, need_tagged;
 static int parse_atom(const char *atom, const char *ep)
 {
 	const char *sp;
-	char *n;
 	int i, at;
 
 	sp = atom;
@@ -120,10 +119,7 @@ static int parse_atom(const char *atom, const char *ep)
 			     (sizeof *used_atom) * used_atom_cnt);
 	used_atom_type = xrealloc(used_atom_type,
 				  (sizeof(*used_atom_type) * used_atom_cnt));
-	n = xmalloc(ep - atom + 1);
-	memcpy(n, atom, ep - atom);
-	n[ep-atom] = 0;
-	used_atom[at] = n;
+	used_atom[at] = xmemdup(atom, ep - atom);
 	used_atom_type[at] = valid_atom[i].cmp_type;
 	return at;
 }
@@ -305,46 +301,28 @@ static const char *find_wholine(const char *who, int wholen, const char *buf, un
 static const char *copy_line(const char *buf)
 {
 	const char *eol = strchr(buf, '\n');
-	char *line;
-	int len;
 	if (!eol)
 		return "";
-	len = eol - buf;
-	line = xmalloc(len + 1);
-	memcpy(line, buf, len);
-	line[len] = 0;
-	return line;
+	return xmemdup(buf, eol - buf);
 }
 
 static const char *copy_name(const char *buf)
 {
-	const char *eol = strchr(buf, '\n');
-	const char *eoname = strstr(buf, " <");
-	char *line;
-	int len;
-	if (!(eoname && eol && eoname < eol))
-		return "";
-	len = eoname - buf;
-	line = xmalloc(len + 1);
-	memcpy(line, buf, len);
-	line[len] = 0;
-	return line;
+	const char *cp;
+	for (cp = buf; *cp != '\n'; cp++) {
+		if (!strncmp(cp, " <", 2))
+			return xmemdup(buf, cp - buf);
+	}
+	return "";
 }
 
 static const char *copy_email(const char *buf)
 {
 	const char *email = strchr(buf, '<');
 	const char *eoemail = strchr(email, '>');
-	char *line;
-	int len;
 	if (!email || !eoemail)
 		return "";
-	eoemail++;
-	len = eoemail - email;
-	line = xmalloc(len + 1);
-	memcpy(line, email, len);
-	line[len] = 0;
-	return line;
+	return xmemdup(email, eoemail + 1 - email);
 }
 
 static void grab_date(const char *buf, struct atom_value *v)
diff --git a/builtin-log.c b/builtin-log.c
index 60819d1..f61a568 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -441,8 +441,6 @@ static const char *clean_message_id(const char *msg_id)
 {
 	char ch;
 	const char *a, *z, *m;
-	char *n;
-	size_t len;
 
 	m = msg_id;
 	while ((ch = *m) && (isspace(ch) || (ch == '<')))
@@ -458,11 +456,7 @@ static const char *clean_message_id(const char *msg_id)
 		die("insane in-reply-to: %s", msg_id);
 	if (++z == m)
 		return a;
-	len = z - a;
-	n = xmalloc(len + 1);
-	memcpy(n, a, len);
-	n[len] = 0;
-	return n;
+	return xmemdup(a, z - a);
 }
 
 int cmd_format_patch(int argc, const char **argv, const char *prefix)
@@ -541,9 +535,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			endpos = strchr(committer, '>');
 			if (!endpos)
 				die("bogos committer info %s\n", committer);
-			add_signoff = xmalloc(endpos - committer + 2);
-			memcpy(add_signoff, committer, endpos - committer + 1);
-			add_signoff[endpos - committer + 1] = 0;
+			add_signoff = xmemdup(committer, endpos - committer + 1);
 		}
 		else if (!strcmp(argv[i], "--attach")) {
 			rev.mime_boundary = git_version_string;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 6c1db86..64f0011 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -299,7 +299,6 @@ static void prune_cache(const char *prefix)
 static const char *verify_pathspec(const char *prefix)
 {
 	const char **p, *n, *prev;
-	char *real_prefix;
 	unsigned long max;
 
 	prev = NULL;
@@ -326,14 +325,8 @@ static const char *verify_pathspec(const char *prefix)
 	if (prefix_offset > max || memcmp(prev, prefix, prefix_offset))
 		die("git-ls-files: cannot generate relative filenames containing '..'");
 
-	real_prefix = NULL;
 	prefix_len = max;
-	if (max) {
-		real_prefix = xmalloc(max + 1);
-		memcpy(real_prefix, prev, max);
-		real_prefix[max] = 0;
-	}
-	return real_prefix;
+	return max ? xmemdup(prev, max) : NULL;
 }
 
 /*
diff --git a/builtin-mv.c b/builtin-mv.c
index b95b7d2..9dacc95 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -22,10 +22,7 @@ static const char **copy_pathspec(const char *prefix, const char **pathspec,
 	for (i = 0; i < count; i++) {
 		int length = strlen(result[i]);
 		if (length > 0 && result[i][length - 1] == '/') {
-			char *without_slash = xmalloc(length);
-			memcpy(without_slash, result[i], length - 1);
-			without_slash[length - 1] = '\0';
-			result[i] = without_slash;
+			result[i] = xmemdup(result[i], length - 1);
 		}
 		if (base_name) {
 			const char *last_slash = strrchr(result[i], '/');
diff --git a/builtin-revert.c b/builtin-revert.c
index 499bbe7..4d96d3f 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -168,9 +168,7 @@ static void set_author_ident_env(const char *message)
 			char *line, *pend, *email, *timestamp;
 
 			p += 7;
-			line = xmalloc(eol + 1 - p);
-			memcpy(line, p, eol - p);
-			line[eol - p] = '\0';
+			line = xmemdup(p, eol - p);
 			email = strchr(line, '<');
 			if (!email)
 				die ("Could not extract author email from %s",
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 16af619..a6cbe39 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -39,10 +39,7 @@ static void insert_author_oneline(struct path_list *list,
 	while (authorlen > 0 && isspace(author[authorlen - 1]))
 		authorlen--;
 
-	buffer = xmalloc(authorlen + 1);
-	memcpy(buffer, author, authorlen);
-	buffer[authorlen] = '\0';
-
+	buffer = xmemdup(author, authorlen);
 	item = path_list_insert(buffer, list);
 	if (item->util == NULL)
 		item->util = xcalloc(1, sizeof(struct path_list));
@@ -66,13 +63,9 @@ static void insert_author_oneline(struct path_list *list,
 		oneline++;
 		onelinelen--;
 	}
-
 	while (onelinelen > 0 && isspace(oneline[onelinelen - 1]))
 		onelinelen--;
-
-	buffer = xmalloc(onelinelen + 1);
-	memcpy(buffer, oneline, onelinelen);
-	buffer[onelinelen] = '\0';
+	buffer = xmemdup(oneline, onelinelen);
 
 	if (dot3) {
 		int dot3len = strlen(dot3);
diff --git a/commit.c b/commit.c
index 85889f9..2778621 100644
--- a/commit.c
+++ b/commit.c
@@ -628,11 +628,7 @@ static char *get_header(const struct commit *commit, const char *key)
 		if (eol - line > key_len &&
 		    !strncmp(line, key, key_len) &&
 		    line[key_len] == ' ') {
-			int len = eol - line - key_len;
-			char *ret = xmalloc(len);
-			memcpy(ret, line + key_len + 1, len - 1);
-			ret[len - 1] = '\0';
-			return ret;
+			return xmemdup(line + key_len + 1, eol - line - key_len - 1);
 		}
 		line = next;
 	}
@@ -709,7 +705,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	start = end + 1;
 	while (end > 0 && isspace(msg[end - 1]))
 		end--;
-	table[0].value = xstrndup(msg, end);
+	table[0].value = xmemdup(msg, end);
 
 	if (start >= len)
 		return;
@@ -721,7 +717,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (end >= len)
 		return;
 
-	table[1].value = xstrndup(msg + start, end - start);
+	table[1].value = xmemdup(msg + start, end - start);
 
 	/* parse date */
 	for (start = end + 1; start < len && isspace(msg[start]); start++)
@@ -732,7 +728,7 @@ static void fill_person(struct interp *table, const char *msg, int len)
 	if (msg + start == ep)
 		return;
 
-	table[5].value = xstrndup(msg + start, ep - (msg + start));
+	table[5].value = xmemdup(msg + start, ep - (msg + start));
 
 	/* parse tz */
 	for (start = ep - msg + 1; start < len && isspace(msg[start]); start++)
@@ -859,7 +855,7 @@ void format_commit_message(const struct commit *commit,
 			; /* do nothing */
 
 		if (state == SUBJECT) {
-			table[ISUBJECT].value = xstrndup(msg + i, eol - i);
+			table[ISUBJECT].value = xmemdup(msg + i, eol - i);
 			i = eol;
 		}
 		if (i == eol) {
@@ -875,7 +871,7 @@ void format_commit_message(const struct commit *commit,
 					msg + i + 10, eol - i - 10);
 		else if (!prefixcmp(msg + i, "encoding "))
 			table[IENCODING].value =
-				xstrndup(msg + i + 9, eol - i - 9);
+				xmemdup(msg + i + 9, eol - i - 9);
 		i = eol;
 	}
 	if (msg[i])
diff --git a/connect.c b/connect.c
index 8b1e993..779de85 100644
--- a/connect.c
+++ b/connect.c
@@ -393,9 +393,7 @@ static int git_proxy_command_options(const char *var, const char *value)
 			if (matchlen == 4 &&
 			    !memcmp(value, "none", 4))
 				matchlen = 0;
-			git_proxy_command = xmalloc(matchlen + 1);
-			memcpy(git_proxy_command, value, matchlen);
-			git_proxy_command[matchlen] = 0;
+			git_proxy_command = xmemdup(value, matchlen);
 		}
 		return 0;
 	}
diff --git a/convert.c b/convert.c
index 508d30b..3a0a9ed 100644
--- a/convert.c
+++ b/convert.c
@@ -323,13 +323,8 @@ static int read_convert_config(const char *var, const char *value)
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
 	if (!drv) {
-		char *namebuf;
 		drv = xcalloc(1, sizeof(struct convert_driver));
-		namebuf = xmalloc(namelen + 1);
-		memcpy(namebuf, name, namelen);
-		namebuf[namelen] = 0;
-		drv->name = namebuf;
-		drv->next = NULL;
+		drv->name = xmemdup(name, namelen);
 		*user_convert_tail = drv;
 		user_convert_tail = &(drv->next);
 	}
diff --git a/diff.c b/diff.c
index a5b69ed..f2e9a44 100644
--- a/diff.c
+++ b/diff.c
@@ -83,13 +83,8 @@ static int parse_lldiff_command(const char *var, const char *ep, const char *val
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
 	if (!drv) {
-		char *namebuf;
 		drv = xcalloc(1, sizeof(struct ll_diff_driver));
-		namebuf = xmalloc(namelen + 1);
-		memcpy(namebuf, name, namelen);
-		namebuf[namelen] = 0;
-		drv->name = namebuf;
-		drv->next = NULL;
+		drv->name = xmemdup(name, namelen);
 		if (!user_diff_tail)
 			user_diff_tail = &user_diff;
 		*user_diff_tail = drv;
@@ -126,12 +121,8 @@ static int parse_funcname_pattern(const char *var, const char *ep, const char *v
 		if (!strncmp(pp->name, name, namelen) && !pp->name[namelen])
 			break;
 	if (!pp) {
-		char *namebuf;
 		pp = xcalloc(1, sizeof(*pp));
-		namebuf = xmalloc(namelen + 1);
-		memcpy(namebuf, name, namelen);
-		namebuf[namelen] = 0;
-		pp->name = namebuf;
+		pp->name = xmemdup(name, namelen);
 		pp->next = funcname_pattern_list;
 		funcname_pattern_list = pp;
 	}
diff --git a/diffcore-order.c b/diffcore-order.c
index 2a4bd82..e20ab98 100644
--- a/diffcore-order.c
+++ b/diffcore-order.c
@@ -48,11 +48,8 @@ static void prepare_order(const char *orderfile)
 				if (*ep == '\n') {
 					*ep = 0;
 					order[cnt] = cp;
-				}
-				else {
-					order[cnt] = xmalloc(ep-cp+1);
-					memcpy(order[cnt], cp, ep-cp);
-					order[cnt][ep-cp] = 0;
+				} else {
+					order[cnt] = xmemdup(cp, ep - cp);
 				}
 				cnt++;
 			}
diff --git a/fast-import.c b/fast-import.c
index e2a4834..d5e4b1d 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1864,9 +1864,7 @@ static void file_change_cr(struct branch *b, int rename)
 		endp = strchr(s, ' ');
 		if (!endp)
 			die("Missing space after source: %s", command_buf.buf);
-		s_uq = xmalloc(endp - s + 1);
-		memcpy(s_uq, s, endp - s);
-		s_uq[endp - s] = 0;
+		s_uq = xmemdup(s, endp - s);
 	}
 	s = s_uq;
 
diff --git a/http-push.c b/http-push.c
index 7c3720f..f5e4266 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1271,10 +1271,7 @@ xml_cdata(void *userData, const XML_Char *s, int len)
 {
 	struct xml_ctx *ctx = (struct xml_ctx *)userData;
 	free(ctx->cdata);
-	ctx->cdata = xmalloc(len + 1);
-	/* NB: 's' is not null-terminated, can not use strlcpy here */
-	memcpy(ctx->cdata, s, len);
-	ctx->cdata[len] = '\0';
+	ctx->cdata = xmemdup(s, len);
 }
 
 static struct remote_lock *lock_remote(const char *path, long timeout)
@@ -2172,9 +2169,7 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
 
 	/* If it's a symref, set the refname; otherwise try for a sha1 */
 	if (!prefixcmp((char *)buffer.buffer, "ref: ")) {
-		*symref = xmalloc(buffer.posn - 5);
-		memcpy(*symref, (char *)buffer.buffer + 5, buffer.posn - 6);
-		(*symref)[buffer.posn - 6] = '\0';
+		*symref = xmemdup(buffer.buffer + 5, buffer.posn - 6);
 	} else {
 		get_sha1_hex(buffer.buffer, sha1);
 	}
diff --git a/imap-send.c b/imap-send.c
index 86e4a0f..b07decc 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -623,9 +623,7 @@ parse_imap_list_l( imap_t *imap, char **sp, list_t **curp, int level )
 					goto bail;
 			cur->len = s - p;
 			s++;
-			cur->val = xmalloc( cur->len + 1 );
-			memcpy( cur->val, p, cur->len );
-			cur->val[cur->len] = 0;
+			cur->val = xmemdup(p, cur->len);
 		} else {
 			/* atom */
 			p = s;
@@ -633,12 +631,10 @@ parse_imap_list_l( imap_t *imap, char **sp, list_t **curp, int level )
 				if (level && *s == ')')
 					break;
 			cur->len = s - p;
-			if (cur->len == 3 && !memcmp ("NIL", p, 3))
+			if (cur->len == 3 && !memcmp ("NIL", p, 3)) {
 				cur->val = NIL;
-			else {
-				cur->val = xmalloc( cur->len + 1 );
-				memcpy( cur->val, p, cur->len );
-				cur->val[cur->len] = 0;
+			} else {
+				cur->val = xmemdup(p, cur->len);
 			}
 		}
 
@@ -1221,13 +1217,7 @@ split_msg( msg_data_t *all_msgs, msg_data_t *msg, int *ofs )
 	if (p)
 		msg->len = &p[1] - data;
 
-	msg->data = xmalloc( msg->len + 1 );
-	if (!msg->data)
-		return 0;
-
-	memcpy( msg->data, data, msg->len );
-	msg->data[ msg->len ] = 0;
-
+	msg->data = xmemdup(data, msg->len);
 	*ofs += msg->len;
 	return 1;
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index 19d5f3b..e38011b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -432,19 +432,15 @@ static int update_stages(const char *path, struct diff_filespec *o,
 
 static int remove_path(const char *name)
 {
-	int ret, len;
+	int ret;
 	char *slash, *dirs;
 
 	ret = unlink(name);
 	if (ret)
 		return ret;
-	len = strlen(name);
-	dirs = xmalloc(len+1);
-	memcpy(dirs, name, len);
-	dirs[len] = '\0';
+	dirs = xstrdup(name);
 	while ((slash = strrchr(name, '/'))) {
 		*slash = '\0';
-		len = slash - name;
 		if (rmdir(name) != 0)
 			break;
 	}
@@ -578,9 +574,7 @@ static void update_file_flags(const unsigned char *sha,
 			flush_buffer(fd, buf, size);
 			close(fd);
 		} else if (S_ISLNK(mode)) {
-			char *lnk = xmalloc(size + 1);
-			memcpy(lnk, buf, size);
-			lnk[size] = '\0';
+			char *lnk = xmemdup(buf, size);
 			mkdir_p(path, 0777);
 			unlink(path);
 			symlink(lnk, path);
@@ -872,14 +866,9 @@ static int read_merge_config(const char *var, const char *value)
 		if (!strncmp(fn->name, name, namelen) && !fn->name[namelen])
 			break;
 	if (!fn) {
-		char *namebuf;
 		fn = xcalloc(1, sizeof(struct ll_merge_driver));
-		namebuf = xmalloc(namelen + 1);
-		memcpy(namebuf, name, namelen);
-		namebuf[namelen] = 0;
-		fn->name = namebuf;
+		fn->name = xmemdup(name, namelen);
 		fn->fn = ll_ext_merge;
-		fn->next = NULL;
 		*ll_user_merge_tail = fn;
 		ll_user_merge_tail = &(fn->next);
 	}
diff --git a/refs.c b/refs.c
index 7fb3350..64363ce 100644
--- a/refs.c
+++ b/refs.c
@@ -1246,15 +1246,11 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 static char *ref_msg(const char *line, const char *endp)
 {
 	const char *ep;
-	char *msg;
-
 	line += 82;
-	for (ep = line; ep < endp && *ep != '\n'; ep++)
-		;
-	msg = xmalloc(ep - line + 1);
-	memcpy(msg, line, ep - line);
-	msg[ep - line] = 0;
-	return msg;
+	ep = memchr(line, '\n', endp - line);
+	if (!ep)
+		ep = endp;
+	return xmemdup(line, ep - line);
 }
 
 int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *sha1, char **msg, unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt)
diff --git a/sha1_file.c b/sha1_file.c
index 59325d4..135bc02 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1491,11 +1491,8 @@ found_cache_entry:
 		ent->lru.next->prev = ent->lru.prev;
 		ent->lru.prev->next = ent->lru.next;
 		delta_base_cached -= ent->size;
-	}
-	else {
-		ret = xmalloc(ent->size + 1);
-		memcpy(ret, ent->data, ent->size);
-		((char *)ret)[ent->size] = 0;
+	} else {
+		ret = xmemdup(ent->data, ent->size);
 	}
 	*type = ent->type;
 	*base_size = ent->size;
@@ -1872,12 +1869,9 @@ void *read_sha1_file(const unsigned char *sha1, enum object_type *type,
 
 	co = find_cached_object(sha1);
 	if (co) {
-		buf = xmalloc(co->size + 1);
-		memcpy(buf, co->buf, co->size);
-		((char*)buf)[co->size] = 0;
 		*type = co->type;
 		*size = co->size;
-		return buf;
+		return xmemdup(co->buf, co->size);
 	}
 
 	buf = read_packed_sha1(sha1, type, size);
diff --git a/tag.c b/tag.c
index bbacd59..f82a668 100644
--- a/tag.c
+++ b/tag.c
@@ -68,9 +68,7 @@ int parse_tag_buffer(struct tag *item, void *data, unsigned long size)
 	memcpy(type, type_line + 5, typelen);
 	type[typelen] = '\0';
 	taglen = sig_line - tag_line - strlen("tag \n");
-	item->tag = xmalloc(taglen + 1);
-	memcpy(item->tag, tag_line + 4, taglen);
-	item->tag[taglen] = '\0';
+	item->tag = xmemdup(tag_line + 4, taglen);
 
 	if (!strcmp(type, blob_type)) {
 		item->tagged = &lookup_blob(sha1)->object;
-- 
1.5.3.1
