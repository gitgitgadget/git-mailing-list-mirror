From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v7 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Mon, 22 Jun 2015 17:24:45 +0200
Organization: gmx
Message-ID: <cover.1434986506.git.johannes.schindelin@gmx.de>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jun 22 17:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z73av-0006Gv-FV
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 17:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbbFVPZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 11:25:04 -0400
Received: from mout.gmx.net ([212.227.15.15]:59886 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752154AbbFVPZB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 11:25:01 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MIdTM-1Z4qf82PVo-002JdR; Mon, 22 Jun 2015 17:24:46
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9OMRMZ/geMEfYfSY6jMkqF8T8EVwv9PtIPQzvpWYhInYgUGp5sN
 rqfZnpWHX1SDEgxdmaI+gOJpUnfjxqJnNFetP8AoLLShUj3Uai1PvXmHAWq3K1NFr9KzkPV
 qL9I726BhAfAFOQ0Y2x/46jhkehB1MkAwZNym00twHz1xLmhVubEos9XH4iRV8j2ZomXy++
 T++bf0HoWqKMHV3st6FWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MXndS5L+ycM=:wo4tY2DwC92/xnY0xMSpnM
 Z2jDYkpLroRG0MrhzjlcE7UwqmqAWRkaN8Ir1ncoOzJmzjqT55GLI82DV6QhJwMr9YM31RVnk
 vQ87O87YBJJVAK9KO6rSiOxPjU+MGPChLfm1wIUoWwu5GvCVrXrPfqCdneWpcOOilEN7Y8Yzq
 a7hab43dpHG9WV/oNXyXbN7CjVsDXTbyhBE5LGCaEs7aYxsKt4ze2aSMdTo3CDXmW2N+eXP2t
 GsK+0Je5BVT3TDhNqEfAJXcdnY5QqIUUveUDGF+Pv2FWp2CJ0ZhUNJFlqY51+5ycjozH9iGm5
 HnwjDgdyOpRLOWVmtTs63XipcbWOYtLfVv/TXTY5vTCdU2T37CWThmQ7Pbj3fRtCHqWNctlLg
 M/2lOhSf02XYM9l4AboZMzK3A4vfGvLDvkTn5M1DDC4DQq7m3NRkm84I2jwixrYq+n8ZtzU+V
 RMb/dGFg5gpqJiX4cHDGtDTDM13M3lLLZ80MzqueC8RSdA3KkhTVRzgrGTWYEnj5lHLN51aVt
 T+3MUQ1JHPyW1fi6sRFVLbDnz6BWQ3gzZjAs/f5PD86748Mm16G4sULwfc46wb/SKLRCyerud
 rXp9N6y6UOoxwCWKQ2yogHkLak/bqNY2rKiDklpBsMwcoEgbua5JTDUXE4TBO4s3qyjWIOGf7
 Fi+gkOATvunYKKgbs6GFV6UoTQPjmc3+Px27fVNPNwX6OY8qnc3JM2P0Ll04tdgukxEI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272371>

At the moment, the git-fsck's integrity checks are targeted toward the
end user, i.e. the error messages are really just messages, intended for
human consumption.

Under certain circumstances, some of those errors should be allowed to
be turned into mere warnings, though, because the cost of fixing the
issues might well be larger than the cost of carrying those flawed
objects. For example, when an already-public repository contains a
commit object with two authors for years, it does not make sense to
force the maintainer to rewrite the history, affecting all contributors
negatively by forcing them to update.

This branch introduces an internal fsck API to be able to turn some of
the errors into warnings, and to make it easier to call the fsck
machinery from elsewhere in general.

I am proud to report that this work has been sponsored by GitHub.

Changes since v6:

- camelCased message IDs

- multiple author checking now as suggested by Junio

- renamed `--quick` to `--connectivity-only`, better commit message

- `fsck.skipList` is now handled correctly (and not mistaken for a message
  type setting)

- `fsck.skipList` can handle user paths now

- index-pack configures the walk function in a more logical place now

- simplified code by avoiding working on partial strings (i.e. removed
  `substrcmp()`). This saves 10 lines. To accomodate parsing config
  variables directly, we now work on lowercased message IDs; unfortunately
  this means that we cannot use them in append_msg_id() because that
  function wants to append camelCased message IDs.

Interdiff below diffstat.

Johannes Schindelin (19):
  fsck: Introduce fsck options
  fsck: Introduce identifiers for fsck messages
  fsck: Provide a function to parse fsck message IDs
  fsck: Offer a function to demote fsck errors to warnings
  fsck (receive-pack): Allow demoting errors to warnings
  fsck: Report the ID of the error/warning
  fsck: Make fsck_ident() warn-friendly
  fsck: Make fsck_commit() warn-friendly
  fsck: Handle multiple authors in commits specially
  fsck: Make fsck_tag() warn-friendly
  fsck: Add a simple test for receive.fsck.<msg-id>
  fsck: Disallow demoting grave fsck errors to warnings
  fsck: Optionally ignore specific fsck issues completely
  fsck: Allow upgrading fsck warnings to errors
  fsck: Document the new receive.fsck.<msg-id> options
  fsck: Support demoting errors to warnings
  fsck: Introduce `git fsck --connectivity-only`
  fsck: git receive-pack: support excluding objects from fsck'ing
  fsck: support ignoring objects in `git fsck` via fsck.skiplist

 Documentation/config.txt        |  41 +++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  78 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  28 +-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 554 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  30 ++-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  51 ++++
 11 files changed, 692 insertions(+), 165 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5aba63a..69dda93 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1252,11 +1252,11 @@ filter.<driver>.smudge::
 
 fsck.<msg-id>::
 	Allows overriding the message type (error, warn or ignore) of a
-	specific message ID such as `missingemail`.
+	specific message ID such as `missingEmail`.
 +
 For convenience, fsck prefixes the error/warning with the message ID,
-e.g.  "missingemail: invalid author/committer line - missing email" means
-that setting `fsck.missingemail = ignore` will hide that issue.
+e.g.  "missingEmail: invalid author/committer line - missing email" means
+that setting `fsck.missingEmail = ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
@@ -1267,6 +1267,7 @@ fsck.skipList::
 	be ignored. This feature is useful when an established project
 	should be accepted despite early commits containing errors that
 	can be safely ignored such as invalid committer email addresses.
+	Note: corrupt objects cannot be skipped with this setting.
 
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
@@ -2228,9 +2229,9 @@ receive.fsck.<msg-id>::
 	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
 	setting where the `<msg-id>` is the fsck message ID and the value
 	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
-	the error/warning with the message ID, e.g. "missingemail: invalid
+	the error/warning with the message ID, e.g. "missingEmail: invalid
 	author/committer line - missing email" means that setting
-	`receive.fsck.missingemail = ignore` will hide that issue.
+	`receive.fsck.missingEmail = ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which would not pass pushing when `receive.fsckObjects = true`, allowing
@@ -2243,6 +2244,7 @@ receive.fsck.skipList::
 	be ignored. This feature is useful when an established project
 	should be accepted despite early commits containing errors that
 	can be safely ignored such as invalid committer email addresses.
+	Note: corrupt objects cannot be skipped with this setting.
 
 receive.unpackLimit::
 	If the number of objects received in a push is below this
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index b98fb43..84ee92e 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -10,8 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
-	 [--[no-]full] [--quick] [--strict] [--verbose] [--lost-found]
-	 [--[no-]dangling] [--[no-]progress] [<object>*]
+	 [--[no-]full] [--strict] [--verbose] [--lost-found]
+	 [--[no-]dangling] [--[no-]progress] [--connectivity-only] [<object>*]
 
 DESCRIPTION
 -----------
@@ -60,10 +60,10 @@ index file, all SHA-1 references in `refs` namespace, and all reflogs
 	object pools.  This is now default; you can turn it off
 	with --no-full.
 
---quick::
+--connectivity-only::
 	Check only the connectivity of tags, commits and tree objects. By
 	avoiding to unpack blobs, this speeds up the operation, at the
-	expense of missing corrupt objects.
+	expense of missing corrupt objects or other problematic issues.
 
 --strict::
 	Enable more strict checking, namely to catch a file mode
diff --git a/builtin/fsck.c b/builtin/fsck.c
index ce538ac..7e3df20 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -23,7 +23,7 @@ static int show_tags;
 static int show_unreachable;
 static int include_reflogs = 1;
 static int check_full = 1;
-static int quick;
+static int connectivity_only;
 static int check_strict;
 static int keep_cache_objects;
 static struct fsck_options fsck_walk_options = FSCK_OPTIONS_DEFAULT;
@@ -49,21 +49,24 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (skip_prefix(var, "fsck.", &var)) {
-		fsck_set_msg_type(&fsck_obj_options, var, -1, value, -1);
-		return 0;
-	}
-
 	if (strcmp(var, "fsck.skiplist") == 0) {
-		const char *path = is_absolute_path(value) ?
-			value : git_path("%s", value);
+		const char *path;
 		struct strbuf sb = STRBUF_INIT;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
 		strbuf_addf(&sb, "skiplist=%s", path);
+		free((char *) path);
 		fsck_set_msg_types(&fsck_obj_options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
 	}
 
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(&fsck_obj_options, var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -192,7 +195,7 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->sha1))
 			return; /* it is in pack - forget about it */
-		if (quick && has_sha1_file(obj->sha1))
+		if (connectivity_only && has_sha1_file(obj->sha1))
 			return;
 		printf("missing %s %s\n", typename(obj->type), sha1_to_hex(obj->sha1));
 		errors_found |= ERROR_REACHABLE;
@@ -636,7 +639,7 @@ static struct option fsck_opts[] = {
 	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
 	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
 	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
-	OPT_BOOL(0, "quick", &quick, N_("check only connectivity")),
+	OPT_BOOL(0, "connectivity-only", &connectivity_only, N_("check only connectivity")),
 	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
 	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
@@ -673,7 +676,7 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	git_config(fsck_config, NULL);
 
 	fsck_head_link();
-	if (!quick)
+	if (!connectivity_only)
 		fsck_object_dir(get_object_directory());
 
 	prepare_alt_odb();
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 98e14fe..f0d283b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -841,7 +841,6 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 			if (do_fsck_object &&
 			    fsck_object(obj, buf, size, &fsck_options))
 				die(_("Error in object"));
-			fsck_options.walk = mark_link;
 			if (fsck_walk(obj, NULL, &fsck_options))
 				die(_("Not all child objects of %s are reachable"), sha1_to_hex(obj->sha1));
 
@@ -1616,6 +1615,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 
 	check_replace_refs = 0;
+	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
 	git_config(git_index_pack_config, &opts);
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 80574f9..3fbed23 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -118,10 +118,13 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 	}
 
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
-		const char *path = is_absolute_path(value) ?
-			value : git_path("%s", value);
+		const char *path;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
 		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
 			fsck_msg_types.len ? ',' : '=', path);
+		free((char *) path);
 		return 0;
 	}
 
diff --git a/fsck.c b/fsck.c
index f80b508..a677b50 100644
--- a/fsck.c
+++ b/fsck.c
@@ -71,37 +71,42 @@ enum fsck_msg_id {
 #undef MSG_ID
 
 #define STR(x) #x
-#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
+#define MSG_ID(id, msg_type) { STR(id), NULL, FSCK_##msg_type },
 static struct {
 	const char *id_string;
+	const char *lowercased;
 	int msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
-	{ NULL, -1 }
+	{ NULL, NULL, -1 }
 };
 #undef MSG_ID
 
-static int parse_msg_id(const char *text, int len)
+static int parse_msg_id(const char *text)
 {
-	int i, j;
-
-	if (len < 0)
-		len = strlen(text);
-
-	for (i = 0; i < FSCK_MSG_MAX; i++) {
-		const char *key = msg_id_info[i].id_string;
-		/* match id_string case-insensitively, without underscores. */
-		for (j = 0; j < len; j++) {
-			char c = *(key++);
-			if (c == '_')
-				c = *(key++);
-			if (toupper(text[j]) != c)
-				break;
+	int i;
+
+	if (!msg_id_info[0].lowercased) {
+		/* convert id_string to lower case, without underscores. */
+		for (i = 0; i < FSCK_MSG_MAX; i++) {
+			const char *p = msg_id_info[i].id_string;
+			int len = strlen(p);
+			char *q = xmalloc(len);
+
+			msg_id_info[i].lowercased = q;
+			while (*p)
+				if (*p == '_')
+					p++;
+				else
+					*(q)++ = tolower(*(p)++);
+			*q = '\0';
 		}
-		if (j == len && !*key)
-			return i;
 	}
 
+	for (i = 0; i < FSCK_MSG_MAX; i++)
+		if (!strcmp(text, msg_id_info[i].lowercased))
+			return i;
+
 	return -1;
 }
 
@@ -160,51 +165,37 @@ static void init_skiplist(struct fsck_options *options, const char *path)
 		skiplist.sorted = 1;
 }
 
-static inline int substrcmp(const char *string, int len, const char *match)
-{
-	int match_len = strlen(match);
-	if (match_len != len)
-		return -1;
-	return memcmp(string, match, len);
-}
-
-static int parse_msg_type(const char *str, int len)
+static int parse_msg_type(const char *str)
 {
-	if (len < 0)
-		len = strlen(str);
-
-	if (!substrcmp(str, len, "error"))
+	if (!strcmp(str, "error"))
 		return FSCK_ERROR;
-	else if (!substrcmp(str, len, "warn"))
+	else if (!strcmp(str, "warn"))
 		return FSCK_WARN;
-	else if (!substrcmp(str, len, "ignore"))
+	else if (!strcmp(str, "ignore"))
 		return FSCK_IGNORE;
 	else
-		die("Unknown fsck message type: '%.*s'",
-				len, str);
+		die("Unknown fsck message type: '%s'", str);
 }
 
 int is_valid_msg_type(const char *msg_id, const char *msg_type)
 {
-	if (parse_msg_id(msg_id, -1) < 0)
+	if (parse_msg_id(msg_id) < 0)
 		return 0;
-	parse_msg_type(msg_type, -1);
+	parse_msg_type(msg_type);
 	return 1;
 }
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, int msg_id_len,
-		const char *msg_type, int msg_type_len)
+		const char *msg_id, const char *msg_type)
 {
-	int id = parse_msg_id(msg_id, msg_id_len), type;
+	int id = parse_msg_id(msg_id), type;
 
 	if (id < 0)
-		die("Unhandled message id: %.*s", msg_id_len, msg_id);
-	type = parse_msg_type(msg_type, msg_type_len);
+		die("Unhandled message id: %s", msg_id);
+	type = parse_msg_type(msg_type);
 
 	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
-		die("Cannot demote %.*s to %.*s", msg_id_len, msg_id,
-				msg_type_len, msg_type);
+		die("Cannot demote %s to %s", msg_id, msg_type);
 
 	if (!options->msg_type) {
 		int i;
@@ -219,37 +210,39 @@ void fsck_set_msg_type(struct fsck_options *options,
 
 void fsck_set_msg_types(struct fsck_options *options, const char *values)
 {
-	while (*values) {
-		int len = strcspn(values, " ,|"), equal;
+	char *buf = xstrdup(values), *to_free = buf;
+	int done = 0;
 
+	while (!done) {
+		int len = strcspn(buf, " ,|"), equal;
+
+		done = !buf[len];
 		if (!len) {
-			values++;
+			buf++;
 			continue;
 		}
+		buf[len] = '\0';
 
-		for (equal = 0; equal < len; equal++)
-			if (values[equal] == '=' || values[equal] == ':')
-				break;
-
-		if (!substrcmp(values, equal, "skiplist")) {
-			char *path = xstrndup(values + equal + 1,
-				len - equal - 1);
+		for (equal = 0; equal < len &&
+				buf[equal] != '=' && buf[equal] != ':'; equal++)
+			buf[equal] = tolower(buf[equal]);
+		buf[equal] = '\0';
 
+		if (!strcmp(buf, "skiplist")) {
 			if (equal == len)
 				die("skiplist requires a path");
-			init_skiplist(options, path);
-			free(path);
-			values += len;
+			init_skiplist(options, buf + equal + 1);
+			buf += len + 1;
 			continue;
 		}
 
 		if (equal == len)
-			die("Missing '=': '%.*s'", len, values);
+			die("Missing '=': '%s'", buf);
 
-		fsck_set_msg_type(options, values, equal,
-				values + equal + 1, len - equal - 1);
-		values += len;
+		fsck_set_msg_type(options, buf, buf + equal + 1);
+		buf += len + 1;
 	}
+	free(to_free);
 }
 
 static void append_msg_id(struct strbuf *sb, const char *msg_id)
@@ -261,6 +254,10 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 			break;
 		if (c != '_')
 			strbuf_addch(sb, tolower(c));
+		else {
+			assert(*msg_id);
+			strbuf_addch(sb, *(msg_id)++);
+		}
 	}
 
 	strbuf_addstr(sb, ": ");
@@ -600,7 +597,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 {
 	unsigned char tree_sha1[20], sha1[20];
 	struct commit_graft *graft;
-	unsigned parent_count, parent_line_count = 0;
+	unsigned parent_count, parent_line_count = 0, author_count;
 	int err;
 
 	if (require_end_of_header(buffer, size, &commit->object, options))
@@ -640,19 +637,19 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 				return err;
 		}
 	}
-	if (!skip_prefix(buffer, "author ", &buffer))
-		return report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
-	err = fsck_ident(&buffer, &commit->object, options);
-	if (err)
-		return err;
+	author_count = 0;
 	while (skip_prefix(buffer, "author ", &buffer)) {
-		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
-		if (err)
-			return err;
+		author_count++;
 		err = fsck_ident(&buffer, &commit->object, options);
 		if (err)
 			return err;
 	}
+	if (author_count < 1)
+		err = report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+	else if (author_count > 1)
+		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+	if (err)
+		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
diff --git a/fsck.h b/fsck.h
index cab9c65..dded84b 100644
--- a/fsck.h
+++ b/fsck.h
@@ -8,8 +8,7 @@
 struct fsck_options;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, int msg_id_len,
-		const char *msg_type, int msg_type_len);
+		const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 2863a8a..956673b 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: badtagname: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: badTagName: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missingTaggerEntry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
@@ -295,7 +295,7 @@ test_expect_success 'force fsck to ignore double author' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck &&
-	git -c fsck.multipleauthors=ignore fsck
+	git -c fsck.multipleAuthors=ignore fsck
 '
 
 _bz='\0'
@@ -431,11 +431,11 @@ test_expect_success 'fsck notices ref pointing to missing tag' '
 	test_must_fail git -C missing fsck
 '
 
-test_expect_success 'fsck --quick' '
-	rm -rf quick &&
-	git init quick &&
+test_expect_success 'fsck --connectivity-only' '
+	rm -rf connectivity-only &&
+	git init connectivity-only &&
 	(
-		cd quick &&
+		cd connectivity-only &&
 		touch empty &&
 		git add empty &&
 		test_commit empty &&
@@ -443,13 +443,13 @@ test_expect_success 'fsck --quick' '
 		rm -f $empty &&
 		echo invalid >$empty &&
 		test_must_fail git fsck --strict &&
-		git fsck --strict --quick &&
+		git fsck --strict --connectivity-only &&
 		tree=$(git rev-parse HEAD:) &&
 		suffix=${tree#??} &&
 		tree=.git/objects/${tree%$suffix}/$suffix &&
 		rm -f $tree &&
 		echo invalid >$tree &&
-		test_must_fail git fsck --strict --quick
+		test_must_fail git fsck --strict --connectivity-only
 	)
 '
 
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 1ada54c..6a1f89e 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,19 +123,19 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
-test_expect_success 'push with receive.fsck.skiplist' '
+test_expect_success 'push with receive.fsck.skipList' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
-	git --git-dir=dst/.git config receive.fsckobjects true &&
+	git --git-dir=dst/.git config receive.fsckObjects true &&
 	test_must_fail git push --porcelain dst bogus &&
-	git --git-dir=dst/.git config receive.fsck.skiplist SKIP &&
+	git --git-dir=dst/.git config receive.fsck.skipList SKIP &&
 	echo $commit >dst/.git/SKIP &&
 	git push --porcelain dst bogus
 '
 
-test_expect_success 'push with receive.fsck.missingemail=warn' '
+test_expect_success 'push with receive.fsck.missingEmail=warn' '
 	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
@@ -143,20 +143,20 @@ test_expect_success 'push with receive.fsck.missingemail=warn' '
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config \
-		receive.fsck.missingemail warn &&
+		receive.fsck.missingEmail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missingemail" act &&
+	grep "missingEmail" act &&
 	git --git-dir=dst/.git branch -D bogus &&
 	git  --git-dir=dst/.git config --add \
-		receive.fsck.missingemail ignore &&
+		receive.fsck.missingEmail ignore &&
 	git  --git-dir=dst/.git config --add \
-		receive.fsck.baddate warn &&
+		receive.fsck.badDate warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	test_must_fail grep "missingemail" act
+	test_must_fail grep "missingEmail" act
 '
 
 test_expect_success \
-	'receive.fsck.unterminatedheader=warn triggers error' '
+	'receive.fsck.unterminatedHeader=warn triggers error' '
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
-- 
2.3.1.windows.1.9.g8c01ab4
