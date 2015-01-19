From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 00/18] Introduce an internal API to interact with the  fsck machinery
Date: Mon, 19 Jan 2015 16:49:55 +0100
Organization: gmx
Message-ID: <cover.1421682369.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Jan 19 17:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDEkC-0006R4-4O
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 17:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886AbbASP7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 10:59:52 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:35068 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751374AbbASP7t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 10:59:49 -0500
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Jan 2015 10:59:22 EST
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0JFntxN026195;
	Mon, 19 Jan 2015 16:49:55 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0JFnt5t026194;
	Mon, 19 Jan 2015 16:49:55 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262629>

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

Interdiff vs v1 below the diffstat. Sorry for the size; the comments I
received for v1 made it necessary to change the patch series rather
extensively (I rebased the branch twenty-five times since sending off
the first version of the patch series, which might also serve as an apology
for not getting v2 out sooner).

Johannes Schindelin (19):
  fsck: Introduce fsck options
  fsck: Introduce identifiers for fsck messages
  fsck: Provide a function to parse fsck message IDs
  fsck: Offer a function to demote fsck errors to warnings
  fsck: Allow demoting errors to warnings via receive.fsck.warn = <key>
  fsck: Report the ID of the error/warning
  fsck: Make fsck_ident() warn-friendly
  fsck: Make fsck_commit() warn-friendly
  fsck: Handle multiple authors in commits specially
  fsck: Make fsck_tag() warn-friendly
  fsck: Add a simple test for receive.fsck.*
  fsck: Disallow demoting grave fsck errors to warnings
  fsck: Optionally ignore specific fsck issues completely
  fsck: Allow upgrading fsck warnings to errors
  fsck: Document the new receive.fsck.* options.
  fsck: Support demoting errors to warnings
  fsck: Introduce `git fsck --quick`
  fsck: git receive-pack: support excluding objects from fsck'ing

 Documentation/config.txt        |  38 +++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  66 +++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  35 ++-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 525 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  27 ++-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  46 ++++
 11 files changed, 648 insertions(+), 164 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4f86d3f..0daba8a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1209,14 +1209,14 @@ filter.<driver>.smudge::
 	linkgit:gitattributes[5] for details.
 
 fsck.*::
-	With these options, fsck errors can be switched to warnings and
-	vice versa by setting e.g. `fsck.bad-name` to `warn` or `error`
-	(or `ignore` to hide those errors completely). For convenience,
-	fsck prefixes the error/warning with the name of the option, e.g.
-	"missing-email: invalid author/committer line - missing email"
-	means that setting `fsck.missing-email` to `ignore` will hide that
-	issue.  For convenience, camelCased options are accepted, too (e.g.
-	`fsck.missingEmail`).
+	The `fsck.error`, `fsck.warn` and `fsck.ignore` settings specify
+	comma-separated lists of fsck message IDs which should trigger
+	fsck to error out, to print the message and continue, or to ignore
+	said messages, respectively.
++
+For convenience, fsck prefixes the error/warning with the name of the option,
+e.g.  "missing-email: invalid author/committer line - missing email" means
+that setting `fsck.ignore = missing-email` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
@@ -2144,18 +2144,29 @@ receive.fsckObjects::
 	is used instead.
 
 receive.fsck.*::
-	When `receive.fsckObjects is set to true, errors can be switched
-	to warnings and vice versa by setting e.g. `receive.fsck.bad-name`
-	to `warn` or `error` (or `ignore` to hide those errors
-	completely). For convenience, fsck prefixes the error/warning
-	with the name of the option, e.g. "missing-email: invalid
-	author/committer line - missing email" means that setting
-	`receive.fsck.missing-email` to `ignore` will hide that issue.
-	For convenience, camelCased options are accepted, too (e.g.
-	`receive.fsck.missingEmail`).
+	When `receive.fsckObjects` is set to true, errors can be switched
+	to warnings and vice versa by configuring the `receive.fsck.*`
+	settings. These settings contain comma-separated lists of fsck
+	message IDs. For convenience, fsck prefixes the error/warning with
+	the message ID, e.g. "missing-email: invalid author/committer line
+	- missing email" means that setting `receive.fsck.ignore =
+	missing-email` will hide that issue.
++
+--
+	error::
+		a comma-separated list of fsck message IDs that should be
+		trigger fsck to error out.
+	warn::
+		a comma-separated list of fsck message IDs that should be
+		displayed, but fsck should continue to error out.
+	ignore::
+		a comma-separated list of fsck message IDs that should be
+		ignored completely.
 +
 This feature is intended to support working with legacy repositories
-which would not pass pushing when `receive.fsckObjects = true`.
+which would not pass pushing when `receive.fsckObjects = true`, allowing
+the host to accept repositories certain known issues but still catch
+other issues.
 
 receive.unpackLimit::
 	If the number of objects received in a push is below this
diff --git a/builtin/fsck.c b/builtin/fsck.c
index dcea9b0..c767909 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -51,8 +51,8 @@ static int fsck_config(const char *var, const char *value, void *cb)
 {
 	if (starts_with(var, "fsck.")) {
 		struct strbuf sb = STRBUF_INIT;
-		strbuf_addf(&sb, "%s=%s", var + 5, value ? value : "error");
-		fsck_strict_mode(&fsck_obj_options, sb.buf);
+		strbuf_addf(&sb, "%s=%s", var + 5, value);
+		fsck_set_severity(&fsck_obj_options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
 	}
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2efcb6d..f464ca0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1568,7 +1568,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (starts_with(arg, "--strict=")) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_strict_mode(&fsck_options, arg + 9);
+				fsck_set_severity(&fsck_options, arg + 9);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 86bcda2..40514c2 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -36,7 +36,7 @@ static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
-static struct strbuf fsck_strict_mode = STRBUF_INIT;
+static struct strbuf fsck_severity = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
@@ -116,20 +116,19 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (starts_with(var, "receive.fsck.skip-list")) {
+	if (starts_with(var, "receive.fsck.skiplist")) {
 		const char *path = is_absolute_path(value) ?
 			value : git_path("%s", value);
-		if (fsck_strict_mode.len)
-			strbuf_addch(&fsck_strict_mode, ',');
-		strbuf_addf(&fsck_strict_mode, "skip-list=%s", path);
+		if (fsck_severity.len)
+			strbuf_addch(&fsck_severity, ',');
+		strbuf_addf(&fsck_severity, "skiplist=%s", path);
 		return 0;
 	}
 
 	if (starts_with(var, "receive.fsck.")) {
-		if (fsck_strict_mode.len)
-			strbuf_addch(&fsck_strict_mode, ',');
-		strbuf_addf(&fsck_strict_mode,
-			"%s=%s", var + 13, value ? value : "error");
+		if (fsck_severity.len)
+			strbuf_addch(&fsck_severity, ',');
+		strbuf_addf(&fsck_severity, "%s=%s", var + 13, value);
 		return 0;
 	}
 
@@ -1489,9 +1488,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		if (quiet)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects) {
-			if (fsck_strict_mode.len)
+			if (fsck_severity.len)
 				argv_array_pushf(&child.args, "--strict=%s",
-					fsck_strict_mode.buf);
+					fsck_severity.buf);
 			else
 				argv_array_push(&child.args, "--strict");
 		}
@@ -1512,9 +1511,9 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 		argv_array_pushl(&child.args, "index-pack",
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects) {
-			if (fsck_strict_mode.len)
+			if (fsck_severity.len)
 				argv_array_pushf(&child.args, "--strict=%s",
-					fsck_strict_mode.buf);
+					fsck_severity.buf);
 			else
 				argv_array_push(&child.args, "--strict");
 		}
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 179a960..82f2d62 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -532,7 +532,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 			}
 			if (starts_with(arg, "--strict=")) {
 				strict = 1;
-				fsck_strict_mode(&fsck_options, arg + 9);
+				fsck_set_severity(&fsck_options, arg + 9);
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
diff --git a/fsck.c b/fsck.c
index 4f8a754..dbf9fa1 100644
--- a/fsck.c
+++ b/fsck.c
@@ -10,121 +10,126 @@
 #include "utf8.h"
 #include "sha1-array.h"
 
+#define FSCK_FATAL -1
+#define FSCK_INFO -2
+
 #define FOREACH_MSG_ID(FUNC) \
 	/* fatal errors */ \
-	FUNC(NUL_IN_HEADER) \
-	FUNC(UNTERMINATED_HEADER) \
+	FUNC(NUL_IN_HEADER, FATAL) \
+	FUNC(UNTERMINATED_HEADER, FATAL) \
 	/* errors */ \
-	FUNC(BAD_DATE) \
-	FUNC(BAD_EMAIL) \
-	FUNC(BAD_NAME) \
-	FUNC(BAD_PARENT_SHA1) \
-	FUNC(BAD_TIMEZONE) \
-	FUNC(BAD_TREE_SHA1) \
-	FUNC(DATE_OVERFLOW) \
-	FUNC(DUPLICATE_ENTRIES) \
-	FUNC(INVALID_OBJECT_SHA1) \
-	FUNC(INVALID_TAG_OBJECT) \
-	FUNC(INVALID_TREE) \
-	FUNC(INVALID_TYPE) \
-	FUNC(MISSING_AUTHOR) \
-	FUNC(MISSING_COMMITTER) \
-	FUNC(MISSING_EMAIL) \
-	FUNC(MISSING_GRAFT) \
-	FUNC(MISSING_NAME_BEFORE_EMAIL) \
-	FUNC(MISSING_OBJECT) \
-	FUNC(MISSING_PARENT) \
-	FUNC(MISSING_SPACE_BEFORE_DATE) \
-	FUNC(MISSING_SPACE_BEFORE_EMAIL) \
-	FUNC(MISSING_TAG) \
-	FUNC(MISSING_TAG_ENTRY) \
-	FUNC(MISSING_TAG_OBJECT) \
-	FUNC(MISSING_TREE) \
-	FUNC(MISSING_TYPE) \
-	FUNC(MISSING_TYPE_ENTRY) \
-	FUNC(MULTIPLE_AUTHORS) \
-	FUNC(NOT_SORTED) \
-	FUNC(TAG_OBJECT_NOT_TAG) \
-	FUNC(UNKNOWN_TYPE) \
-	FUNC(ZERO_PADDED_DATE) \
+	FUNC(BAD_DATE, ERROR) \
+	FUNC(BAD_EMAIL, ERROR) \
+	FUNC(BAD_NAME, ERROR) \
+	FUNC(BAD_PARENT_SHA1, ERROR) \
+	FUNC(BAD_TIMEZONE, ERROR) \
+	FUNC(BAD_TREE_SHA1, ERROR) \
+	FUNC(DATE_OVERFLOW, ERROR) \
+	FUNC(DUPLICATE_ENTRIES, ERROR) \
+	FUNC(INVALID_OBJECT_SHA1, ERROR) \
+	FUNC(INVALID_TAG_OBJECT, ERROR) \
+	FUNC(INVALID_TREE, ERROR) \
+	FUNC(INVALID_TYPE, ERROR) \
+	FUNC(MISSING_AUTHOR, ERROR) \
+	FUNC(MISSING_COMMITTER, ERROR) \
+	FUNC(MISSING_EMAIL, ERROR) \
+	FUNC(MISSING_GRAFT, ERROR) \
+	FUNC(MISSING_NAME_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_OBJECT, ERROR) \
+	FUNC(MISSING_PARENT, ERROR) \
+	FUNC(MISSING_SPACE_BEFORE_DATE, ERROR) \
+	FUNC(MISSING_SPACE_BEFORE_EMAIL, ERROR) \
+	FUNC(MISSING_TAG, ERROR) \
+	FUNC(MISSING_TAG_ENTRY, ERROR) \
+	FUNC(MISSING_TAG_OBJECT, ERROR) \
+	FUNC(MISSING_TREE, ERROR) \
+	FUNC(MISSING_TYPE, ERROR) \
+	FUNC(MISSING_TYPE_ENTRY, ERROR) \
+	FUNC(MULTIPLE_AUTHORS, ERROR) \
+	FUNC(NOT_SORTED, ERROR) \
+	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
+	FUNC(UNKNOWN_TYPE, ERROR) \
+	FUNC(ZERO_PADDED_DATE, ERROR) \
 	/* warnings */ \
-	FUNC(BAD_FILEMODE) \
-	FUNC(EMPTY_NAME) \
-	FUNC(FULL_PATHNAME) \
-	FUNC(HAS_DOT) \
-	FUNC(HAS_DOTDOT) \
-	FUNC(HAS_DOTGIT) \
-	FUNC(NULL_SHA1) \
-	FUNC(ZERO_PADDED_FILEMODE) \
+	FUNC(BAD_FILEMODE, WARN) \
+	FUNC(EMPTY_NAME, WARN) \
+	FUNC(FULL_PATHNAME, WARN) \
+	FUNC(HAS_DOT, WARN) \
+	FUNC(HAS_DOTDOT, WARN) \
+	FUNC(HAS_DOTGIT, WARN) \
+	FUNC(NULL_SHA1, WARN) \
+	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
-	FUNC(INVALID_TAG_NAME) \
-	FUNC(MISSING_TAGGER_ENTRY) \
-	/* special value */ \
-	FUNC(SKIP_LIST)
-
-#define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
-#define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
-#define FIRST_INFO FSCK_MSG_INVALID_TAG_NAME
+	FUNC(INVALID_TAG_NAME, INFO) \
+	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
-#define MSG_ID(x) FSCK_MSG_##x,
+#define MSG_ID(id, severity) FSCK_MSG_##id,
 enum fsck_msg_id {
 	FOREACH_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
 };
+#undef MSG_ID
 
 #define STR(x) #x
-#define MSG_ID_STR(x) STR(x),
-static const char *msg_id_str[FSCK_MSG_MAX + 1] = {
-	FOREACH_MSG_ID(MSG_ID_STR)
-	NULL
+#define MSG_ID(id, severity) { STR(id), FSCK_##severity },
+static struct {
+	const char *id_string;
+	int severity;
+} msg_id_info[FSCK_MSG_MAX + 1] = {
+	FOREACH_MSG_ID(MSG_ID)
+	{ NULL, -1 }
 };
+#undef MSG_ID
 
 static int parse_msg_id(const char *text, int len)
 {
 	int i, j;
 
 	for (i = 0; i < FSCK_MSG_MAX; i++) {
-		const char *key = msg_id_str[i];
-		/* msg_id_str is upper-case, with underscores */
+		const char *key = msg_id_info[i].id_string;
+		/* id_string is upper-case, with underscores */
 		for (j = 0; j < len; j++) {
 			char c = *(key++);
-			if (c == '_') {
-				if (isalpha(text[j]))
-					c = *(key++);
-				else if (text[j] != '_')
-					c = '-';
-			}
-			if (toupper(text[j]) != c)
+			if (c == '_')
+				c = '-';
+			if (text[j] != tolower(c))
 				break;
 		}
 		if (j == len && !*key)
 			return i;
 	}
 
-	die("Unhandled type: %.*s", len, text);
+	die("Unhandled message id: %.*s", len, text);
 }
 
-int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
+static int fsck_msg_severity(enum fsck_msg_id msg_id,
+	struct fsck_options *options)
 {
-	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
-		return options->strict_mode[msg_id];
-	if (options->strict)
-		return msg_id < FIRST_INFO ? FSCK_ERROR : FSCK_WARN;
-	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
+	int severity;
+
+	if (options->msg_severity && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
+		severity = options->msg_severity[msg_id];
+	else {
+		severity = msg_id_info[msg_id].severity;
+		if (options->strict && severity == FSCK_WARN)
+			severity = FSCK_ERROR;
+	}
+
+	return severity;
 }
 
-static void init_skip_list(struct fsck_options *options, const char *path)
+static void init_skiplist(struct fsck_options *options, const char *path)
 {
-	static struct sha1_array skip_list = SHA1_ARRAY_INIT;
+	static struct sha1_array skiplist = SHA1_ARRAY_INIT;
 	int sorted, fd;
 	char buffer[41];
 	unsigned char sha1[20];
 
-	if (options->skip_list)
-		sorted = options->skip_list->sorted;
+	if (options->skiplist)
+		sorted = options->skiplist->sorted;
 	else {
 		sorted = 1;
-		options->skip_list = &skip_list;
+		options->skiplist = &skiplist;
 	}
 
 	fd = open(path, O_RDONLY);
@@ -138,16 +143,16 @@ static void init_skip_list(struct fsck_options *options, const char *path)
 			break;
 		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
 			die("Invalid SHA-1: %s", buffer);
-		sha1_array_append(&skip_list, sha1);
-		if (sorted && skip_list.nr > 1 &&
-				hashcmp(skip_list.sha1[skip_list.nr - 2],
+		sha1_array_append(&skiplist, sha1);
+		if (sorted && skiplist.nr > 1 &&
+				hashcmp(skiplist.sha1[skiplist.nr - 2],
 					sha1) > 0)
 			sorted = 0;
 	}
 	close(fd);
 
 	if (sorted)
-		skip_list.sorted = 1;
+		skiplist.sorted = 1;
 }
 
 static inline int substrcmp(const char *string, int len, const char *match)
@@ -158,16 +163,16 @@ static inline int substrcmp(const char *string, int len, const char *match)
 	return memcmp(string, match, len);
 }
 
-void fsck_strict_mode(struct fsck_options *options, const char *mode)
+void fsck_set_severity(struct fsck_options *options, const char *mode)
 {
-	int type = FSCK_ERROR;
+	int severity = FSCK_ERROR;
 
-	if (!options->strict_mode) {
+	if (!options->msg_severity) {
 		int i;
-		int *strict_mode = malloc(sizeof(int) * FSCK_MSG_MAX);
+		int *msg_severity = malloc(sizeof(int) * FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			strict_mode[i] = fsck_msg_type(i, options);
-		options->strict_mode = strict_mode;
+			msg_severity[i] = fsck_msg_severity(i, options);
+		options->msg_severity = msg_severity;
 	}
 
 	while (*mode) {
@@ -182,35 +187,36 @@ void fsck_strict_mode(struct fsck_options *options, const char *mode)
 			if (mode[equal] == '=')
 				break;
 
-		msg_id = parse_msg_id(mode, equal);
-		if (msg_id == FSCK_MSG_SKIP_LIST) {
-			char *path = xstrndup(mode + equal + 1, len - equal - 1);
-
-			if (equal == len)
-				die("skip-list requires a path");
-			init_skip_list(options, path);
-			free(path);
-			mode += len;
-			continue;
-		}
-
 		if (equal < len) {
-			const char *type_str = mode + equal + 1;
-			int type_len = len - equal - 1;
-			if (!substrcmp(type_str, type_len, "error"))
-				type = FSCK_ERROR;
-			else if (!substrcmp(type_str, type_len, "warn"))
-				type = FSCK_WARN;
-			else if (!substrcmp(type_str, type_len, "ignore"))
-				type = FSCK_IGNORE;
+			if (!substrcmp(mode, equal, "error"))
+				severity = FSCK_ERROR;
+			else if (!substrcmp(mode, equal, "warn"))
+				severity = FSCK_WARN;
+			else if (!substrcmp(mode, equal, "ignore"))
+				severity = FSCK_IGNORE;
+			else if (!substrcmp(mode, equal, "skiplist")) {
+				char *path = xstrndup(mode + equal + 1,
+					len - equal - 1);
+
+				if (equal == len)
+					die("skiplist requires a path");
+				init_skiplist(options, path);
+				free(path);
+				mode += len;
+				continue;
+			}
 			else
-				die("Unknown fsck message type: '%.*s'",
-					len - equal - 1, type_str);
+				die("Unknown fsck message severity: '%.*s'",
+					equal, mode);
+			mode += equal + 1;
+			len -= equal + 1;
 		}
 
-		if (type != FSCK_ERROR && msg_id < FIRST_NON_FATAL_ERROR)
+		msg_id = parse_msg_id(mode, len);
+		if (severity != FSCK_ERROR &&
+				msg_id_info[msg_id].severity == FSCK_FATAL)
 			die("Cannot demote %.*s", len, mode);
-		options->strict_mode[msg_id] = type;
+		options->msg_severity[msg_id] = severity;
 		mode += len;
 	}
 }
@@ -238,16 +244,21 @@ static int report(struct fsck_options *options, struct object *object,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(id, options), result;
+	int msg_severity = fsck_msg_severity(id, options), result;
 
-	if (msg_type == FSCK_IGNORE)
+	if (msg_severity == FSCK_IGNORE)
 		return 0;
 
-	append_msg_id(&sb, msg_id_str[id]);
+	if (msg_severity == FSCK_FATAL)
+		msg_severity = FSCK_ERROR;
+	else if (msg_severity == FSCK_INFO)
+		msg_severity = FSCK_WARN;
+
+	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(object, msg_type, sb.buf);
+	result = options->error_func(object, msg_severity, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -606,8 +617,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 		if (err)
 			return err;
-		/* require_end_of_header() ensured that there is a newline */
-		buffer = strchr(buffer, '\n') + 1;
+		err = fsck_ident(&buffer, &commit->object, options);
+		if (err)
+			return err;
 	}
 	if (!skip_prefix(buffer, "committer ", &buffer))
 		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
@@ -737,8 +749,8 @@ static int fsck_tag(struct tag *tag, const char *data,
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
-	if (options->skip_list &&
-			sha1_array_lookup(options->skip_list, obj->sha1) >= 0)
+	if (options->skiplist &&
+			sha1_array_lookup(options->skiplist, obj->sha1) >= 0)
 		return 0;
 
 	if (!obj)
@@ -759,9 +771,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 			  obj->type);
 }
 
-int fsck_error_function(struct object *obj, int type, const char *message)
+int fsck_error_function(struct object *obj, int severity, const char *message)
 {
-	if (type == FSCK_WARN) {
+	if (severity == FSCK_WARN) {
 		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
 		return 0;
 	}
diff --git a/fsck.h b/fsck.h
index 74d11cd..5397fbd 100644
--- a/fsck.h
+++ b/fsck.h
@@ -7,7 +7,7 @@
 
 struct fsck_options;
 
-void fsck_strict_mode(struct fsck_options *options, const char *mode);
+void fsck_set_severity(struct fsck_options *options, const char *mode);
 
 /*
  * callback function for fsck_walk
@@ -27,10 +27,9 @@ int fsck_error_function(struct object *obj, int type, const char *message);
 struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
-	int strict:1;
-	int *strict_mode;
-	/* TODO: consider reading into a hashmap */
-	struct sha1_array *skip_list;
+	unsigned strict:1;
+	int *msg_severity;
+	struct sha1_array *skiplist;
 };
 
 #define FSCK_OPTIONS_DEFAULT { NULL, fsck_error_function, 0, NULL }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 3054113..1c624a3 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: invalid-tag-name: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missing-tagger-entry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
@@ -295,7 +295,7 @@ test_expect_success 'force fsck to ignore double author' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck &&
-	git -c fsck.multiple-authors=ignore fsck
+	git -c fsck.ignore=multiple-authors fsck
 '
 
 _bz='\0'
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index cf6cd5d..21fa9c8 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -123,42 +123,42 @@ committer Bugs Bunny <bugs@bun.ni> 1234567890 +0000
 This commit object intentionally broken
 EOF
 
-test_expect_success 'push with receive.fsck.skip-list' '
+test_expect_success 'push with receive.fsck.skiplist' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
-	git --git-dir=dst/.git config receive.fsck.skip-list SKIP &&
+	git --git-dir=dst/.git config receive.fsck.skiplist SKIP &&
 	echo $commit > dst/.git/SKIP &&
 	git push --porcelain dst bogus
 '
 
-test_expect_success 'push with receive.fsck.missing-mail = warn' '
+test_expect_success 'push with receive.fsck.warn = missing-email' '
 	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
-	git --git-dir=dst/.git config receive.fsck.missing-email warn &&
+	git --git-dir=dst/.git config receive.fsck.warn missing-email &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	grep "missing-email" act &&
 	git --git-dir=dst/.git branch -D bogus &&
-	git  --git-dir=dst/.git config receive.fsck.missing-email ignore &&
-	git  --git-dir=dst/.git config receive.fsck.bad-date warn &&
+	git  --git-dir=dst/.git config receive.fsck.ignore missing-email &&
+	git  --git-dir=dst/.git config receive.fsck.warn bad-date &&
 	git push --porcelain dst bogus >act 2>&1 &&
 	test_must_fail grep "missing-email" act
 '
 
-test_expect_success 'receive.fsck.unterminated-header = warn triggers error' '
+test_expect_success 'receive.fsck.warn = unterminated-header triggers error' '
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
-	git --git-dir=dst/.git config receive.fsck.unterminated-header warn &&
+	git --git-dir=dst/.git config receive.fsck.warn unterminated-header &&
 	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
-	grep "Cannot demote unterminated-header=warn" act
+	grep "Cannot demote unterminated-header" act
 '
 
 test_done
-- 
2.0.0.rc3.9669.g840d1f9
