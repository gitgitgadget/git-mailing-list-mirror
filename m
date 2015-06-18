From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 00/19] Introduce an internal API to interact with the
 fsck machinery
Date: Thu, 18 Jun 2015 22:07:10 +0200
Organization: gmx
Message-ID: <cover.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:07:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g67-0001wL-TI
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756552AbbFRUHf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:07:35 -0400
Received: from mout.gmx.net ([212.227.15.15]:63341 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398AbbFRUHc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:07:32 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ln8Tl-1Ye42W3GEH-00hR90; Thu, 18 Jun 2015 22:07:13
 +0200
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:sY8WPiZq/WjRgUb4HH6MG2Vi3s+dFh4Lsx7PToG4q68oAB8qzmH
 s06QabZ+aALrAXmPyrJTq48T3NSEkGHLtI/EztMCL3i3w2CyQYYv9var3QWnK+L3VwD+t54
 5ywwR1/UZGprBx1tvatg3AdV1SqAoheAcE9tNXgATTRog7n3KxBJHB0Shxmr0o0tMrw0WeA
 fKhN7NkkOZ1Cx1Bzd1NpA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WQKUI01ufU4=:dcQngsKP/brhJvjPuPz4PB
 gu9Y/VcjtNvoXzkLoo6fIaxY3kuKdohPgw4WMjlJt53C+Bw24hbiK1dWrTv2lyY/g4emYVP++
 1z2jq7w/OUZmXcdoXhZlYdDgNg2Pj2R8fXe0r3b7zEK9X+XJsik3zIV1V3BwIjRxXSsXg2B4A
 w2Dna9VaK7Gl730SBcfqMO0L3ZDa+/rp1XjINyuFcPSUpgpLeDHizJ8AGdL7PsXppB7ndAcyi
 qdQLIZXTOVFJrRz4ITGISsXLJwSt2+qa5H/XEZ+8vDyzuJNVv6t/8GuL1coY81AxxdhRJjvWb
 VL7LpbQsT3z992nCQ3I+VAUxj+cePqxiSMJgviWqR+MoGYt3rx8giB+Miim6Dmre5ImU3kUK9
 dlDlv7eqHQyOuIlj43KsSJkqFEWnezsi3zp8rHI+OIcANGF2HMm6/AsRErdombNwVVGxfx1RQ
 N2QsawlehAgrLH6UWBZT9F2v+upJ3A8a+bhxKBm4yylAqN+e0/RF1KnP3gomcfsL1xmPcni2U
 m2bDKWQ0FlcxSRzsdCtyO1zxtcmjnKOlXWuvK2zKmIYYp2hfM6dFrtN1KxbsO2AJD0Nct1Kew
 lRiw6W3vrBMGOiJbWuZr1JmyQOTEeNnMPUZlraCP/9vVbdhmYe6iSEYb7bnonEpUcoNgzXJA/
 1kULoxGP+ROuHL9/lUxT478ogJtE2KqtUTlKnaKm/Gm77xpcMn8uCMU/Z3odfra6vy28=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272042>

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

Changes since v4 (sorry for the long delay):

- the config settings' convention changed as discussed. Example:
  `fsck.severity.warn = missing-author` is now
  `fsck.missingAuthor = warn` (or `fsck.missingauthor = warn` because
  config settings are traditionally case-insensitive). As a consequence,
  the command-line parameter passed on to `index-pack` and
  `unpack-objects` also uses camelCased values.

- previously, we errored out when encountering an unknown message id,
  now we warn instead.

- I now use `msg_type` consistently where I used `severity` before because
  it appears clearer to me

- the skiplist handling is now done only in the error case, for enhanced
  performance. While at it, a potential segmentation fault was fixed when
  a NULL object was dereferenced to be looked up in the skiplist.

Interdiff below the diffstat. It's huge. Sorry.

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
  fsck: Introduce `git fsck --quick`
  fsck: git receive-pack: support excluding objects from fsck'ing
  fsck: support ignoring objects in `git fsck` via fsck.skiplist

 Documentation/config.txt        |  39 +++
 Documentation/git-fsck.txt      |   7 +-
 builtin/fsck.c                  |  75 ++++--
 builtin/index-pack.c            |  13 +-
 builtin/receive-pack.c          |  25 +-
 builtin/unpack-objects.c        |  16 +-
 fsck.c                          | 553 +++++++++++++++++++++++++++++++---------
 fsck.h                          |  31 ++-
 t/t1450-fsck.sh                 |  37 ++-
 t/t5302-pack-index.sh           |   2 +-
 t/t5504-fetch-receive-strict.sh |  51 ++++
 11 files changed, 686 insertions(+), 163 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b5b1a22..5aba63a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1250,14 +1250,13 @@ filter.<driver>.smudge::
 	object to a worktree file upon checkout.  See
 	linkgit:gitattributes[5] for details.
 
-fsck.severity::
-	A comma-separated lists of of the form `<id>=<level>` where `<id>`
-	denotes a fsck message ID such as `missing-email` and `<level>` is
-	one of `error`, `warn` and `ignore`.
+fsck.<msg-id>::
+	Allows overriding the message type (error, warn or ignore) of a
+	specific message ID such as `missingemail`.
 +
 For convenience, fsck prefixes the error/warning with the message ID,
-e.g.  "missing-email: invalid author/committer line - missing email" means
-that setting `fsck.severity = missing-email=ignore` will hide that issue.
+e.g.  "missingemail: invalid author/committer line - missing email" means
+that setting `fsck.missingemail = ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
@@ -2224,15 +2223,14 @@ receive.fsckObjects::
 	Defaults to false. If not set, the value of `transfer.fsckObjects`
 	is used instead.
 
-receive.fsck.severity::
+receive.fsck.<msg-id>::
 	When `receive.fsckObjects` is set to true, errors can be switched
-	to warnings and vice versa by configuring the `receive.fsck.severity`
-	setting. These settings contain comma-separated lists of the form
-	`<id>=<level>` where the `<id>` is the fsck message ID and the level
+	to warnings and vice versa by configuring the `receive.fsck.<msg-id>`
+	setting where the `<msg-id>` is the fsck message ID and the value
 	is one of `error`, `warn` or `ignore`. For convenience, fsck prefixes
-	the error/warning with the message ID, e.g. "missing-email: invalid
+	the error/warning with the message ID, e.g. "missingemail: invalid
 	author/committer line - missing email" means that setting
-	`receive.fsck.severity = missing-email=ignore` will hide that issue.
+	`receive.fsck.missingemail = ignore` will hide that issue.
 +
 This feature is intended to support working with legacy repositories
 which would not pass pushing when `receive.fsckObjects = true`, allowing
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 32e476a..ce538ac 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,8 +49,8 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
-	if (strcmp(var, "fsck.severity") == 0) {
-		fsck_set_severity(&fsck_obj_options, value);
+	if (skip_prefix(var, "fsck.", &var)) {
+		fsck_set_msg_type(&fsck_obj_options, var, -1, value, -1);
 		return 0;
 	}
 
@@ -59,7 +59,7 @@ static int fsck_config(const char *var, const char *value, void *cb)
 			value : git_path("%s", value);
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "skiplist=%s", path);
-		fsck_set_severity(&fsck_obj_options, sb.buf);
+		fsck_set_msg_types(&fsck_obj_options, sb.buf);
 		strbuf_release(&sb);
 		return 0;
 	}
@@ -67,11 +67,11 @@ static int fsck_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void objreport(struct object *obj, const char *severity,
-                      const char *err)
+static void objreport(struct object *obj, const char *msg_type,
+			const char *err)
 {
 	fprintf(stderr, "%s in %s %s: %s\n",
-	        severity, typename(obj->type), sha1_to_hex(obj->sha1), err);
+		msg_type, typename(obj->type), sha1_to_hex(obj->sha1), err);
 }
 
 static int objerror(struct object *obj, const char *err)
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 94c64ab..98e14fe 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1636,7 +1636,7 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 			} else if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
 				do_fsck_object = 1;
-				fsck_set_severity(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_options, arg);
 			} else if (!strcmp(arg, "--check-self-contained-and-connected")) {
 				strict = 1;
 				check_self_contained_and_connected = 1;
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 4cbeb14..80574f9 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -19,6 +19,7 @@
 #include "tag.h"
 #include "gpg-interface.h"
 #include "sigchain.h"
+#include "fsck.h"
 
 static const char receive_pack_usage[] = "git receive-pack <git-dir>";
 
@@ -36,7 +37,7 @@ static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
 static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
 static int receive_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
-static struct strbuf fsck_severity = STRBUF_INIT;
+static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int receive_unpack_limit = -1;
 static int transfer_unpack_limit = -1;
 static int advertise_atomic_push = 1;
@@ -116,17 +117,20 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	if (strcmp(var, "receive.fsck.severity") == 0) {
-		strbuf_addf(&fsck_severity, "%c%s",
-			fsck_severity.len ? ',' : '=', value);
-		return 0;
-	}
-
 	if (strcmp(var, "receive.fsck.skiplist") == 0) {
 		const char *path = is_absolute_path(value) ?
 			value : git_path("%s", value);
-		strbuf_addf(&fsck_severity, "%cskiplist=%s",
-			fsck_severity.len ? ',' : '=', path);
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			fsck_msg_types.len ? ',' : '=', path);
+		return 0;
+	}
+
+	if (skip_prefix(var, "receive.fsck.", &var)) {
+		if (is_valid_msg_type(var, value))
+			strbuf_addf(&fsck_msg_types, "%c%s=%s",
+				fsck_msg_types.len ? ',' : '=', var, value);
+		else
+			warning("Skipping unknown msg id '%s'", var);
 		return 0;
 	}
 
@@ -1506,7 +1510,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 			argv_array_push(&child.args, "-q");
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
-				fsck_severity.buf);
+				fsck_msg_types.buf);
 		child.no_stdout = 1;
 		child.err = err_fd;
 		child.git_cmd = 1;
@@ -1525,7 +1529,7 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 				 "--stdin", hdr_arg, keep_arg, NULL);
 		if (fsck_objects)
 			argv_array_pushf(&child.args, "--strict%s",
-				fsck_severity.buf);
+				fsck_msg_types.buf);
 		if (fix_thin)
 			argv_array_push(&child.args, "--fix-thin");
 		child.out = -1;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index fe9117c..7cc086f 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -532,7 +532,7 @@ int cmd_unpack_objects(int argc, const char **argv, const char *prefix)
 			}
 			if (skip_prefix(arg, "--strict=", &arg)) {
 				strict = 1;
-				fsck_set_severity(&fsck_options, arg);
+				fsck_set_msg_types(&fsck_options, arg);
 				continue;
 			}
 			if (starts_with(arg, "--pack_header=")) {
diff --git a/fsck.c b/fsck.c
index 046af02..9b8981e 100644
--- a/fsck.c
+++ b/fsck.c
@@ -63,7 +63,7 @@
 	FUNC(INVALID_TAG_NAME, INFO) \
 	FUNC(MISSING_TAGGER_ENTRY, INFO)
 
-#define MSG_ID(id, severity) FSCK_MSG_##id,
+#define MSG_ID(id, msg_type) FSCK_MSG_##id,
 enum fsck_msg_id {
 	FOREACH_MSG_ID(MSG_ID)
 	FSCK_MSG_MAX
@@ -71,10 +71,10 @@ enum fsck_msg_id {
 #undef MSG_ID
 
 #define STR(x) #x
-#define MSG_ID(id, severity) { STR(id), FSCK_##severity },
+#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
 static struct {
 	const char *id_string;
-	int severity;
+	int msg_type;
 } msg_id_info[FSCK_MSG_MAX + 1] = {
 	FOREACH_MSG_ID(MSG_ID)
 	{ NULL, -1 }
@@ -85,39 +85,42 @@ static int parse_msg_id(const char *text, int len)
 {
 	int i, j;
 
+	if (len < 0)
+		len = strlen(text);
+
 	for (i = 0; i < FSCK_MSG_MAX; i++) {
 		const char *key = msg_id_info[i].id_string;
-		/* id_string is upper-case, with underscores */
+		/* match id_string case-insensitively, without underscores. */
 		for (j = 0; j < len; j++) {
 			char c = *(key++);
 			if (c == '_')
-				c = '-';
-			if (text[j] != tolower(c))
+				c = *(key++);
+			if (toupper(text[j]) != c)
 				break;
 		}
 		if (j == len && !*key)
 			return i;
 	}
 
-	die("Unhandled message id: %.*s", len, text);
+	return -1;
 }
 
-static int fsck_msg_severity(enum fsck_msg_id msg_id,
+static int fsck_msg_type(enum fsck_msg_id msg_id,
 	struct fsck_options *options)
 {
-	int severity;
+	int msg_type;
 
 	assert(msg_id >= 0 && msg_id < FSCK_MSG_MAX);
 
-	if (options->msg_severity)
-		severity = options->msg_severity[msg_id];
+	if (options->msg_type)
+		msg_type = options->msg_type[msg_id];
 	else {
-		severity = msg_id_info[msg_id].severity;
-		if (options->strict && severity == FSCK_WARN)
-			severity = FSCK_ERROR;
+		msg_type = msg_id_info[msg_id].msg_type;
+		if (options->strict && msg_type == FSCK_WARN)
+			msg_type = FSCK_ERROR;
 	}
 
-	return severity;
+	return msg_type;
 }
 
 static void init_skiplist(struct fsck_options *options, const char *path)
@@ -165,66 +168,87 @@ static inline int substrcmp(const char *string, int len, const char *match)
 	return memcmp(string, match, len);
 }
 
-void fsck_set_severity(struct fsck_options *options, const char *mode)
+static int parse_msg_type(const char *str, int len)
+{
+	if (len < 0)
+		len = strlen(str);
+
+	if (!substrcmp(str, len, "error"))
+		return FSCK_ERROR;
+	else if (!substrcmp(str, len, "warn"))
+		return FSCK_WARN;
+	else if (!substrcmp(str, len, "ignore"))
+		return FSCK_IGNORE;
+	else
+		die("Unknown fsck message type: '%.*s'",
+				len, str);
+}
+
+int is_valid_msg_type(const char *msg_id, const char *msg_type)
 {
-	int severity = FSCK_ERROR;
+	if (parse_msg_id(msg_id, -1) < 0)
+		return 0;
+	parse_msg_type(msg_type, -1);
+	return 1;
+}
+
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, int msg_id_len,
+		const char *msg_type, int msg_type_len)
+{
+	int id = parse_msg_id(msg_id, msg_id_len), type;
+
+	if (id < 0)
+		die("Unhandled message id: %.*s", msg_id_len, msg_id);
+	type = parse_msg_type(msg_type, msg_type_len);
 
-	if (!options->msg_severity) {
+	if (type != FSCK_ERROR && msg_id_info[id].msg_type == FSCK_FATAL)
+		die("Cannot demote %.*s to %.*s", msg_id_len, msg_id,
+				msg_type_len, msg_type);
+
+	if (!options->msg_type) {
 		int i;
-		int *msg_severity = xmalloc(sizeof(int) * FSCK_MSG_MAX);
+		int *msg_type = xmalloc(sizeof(int) * FSCK_MSG_MAX);
 		for (i = 0; i < FSCK_MSG_MAX; i++)
-			msg_severity[i] = fsck_msg_severity(i, options);
-		options->msg_severity = msg_severity;
+			msg_type[i] = fsck_msg_type(i, options);
+		options->msg_type = msg_type;
 	}
 
-	while (*mode) {
-		int len = strcspn(mode, " ,|"), equal, msg_id;
+	options->msg_type[id] = type;
+}
+
+void fsck_set_msg_types(struct fsck_options *options, const char *values)
+{
+	while (*values) {
+		int len = strcspn(values, " ,|"), equal;
 
 		if (!len) {
-			mode++;
+			values++;
 			continue;
 		}
 
 		for (equal = 0; equal < len; equal++)
-			if (mode[equal] == '=' || mode[equal] == ':')
+			if (values[equal] == '=' || values[equal] == ':')
 				break;
 
-		if (!substrcmp(mode, equal, "skiplist")) {
-			char *path = xstrndup(mode + equal + 1,
+		if (!substrcmp(values, equal, "skiplist")) {
+			char *path = xstrndup(values + equal + 1,
 				len - equal - 1);
 
 			if (equal == len)
 				die("skiplist requires a path");
 			init_skiplist(options, path);
 			free(path);
-			mode += len;
+			values += len;
 			continue;
 		}
 
-		msg_id = parse_msg_id(mode, equal);
-
 		if (equal == len)
-			severity = FSCK_ERROR;
-		else {
-			const char *p = mode + equal + 1;
-			int len2 = len - equal - 1;
-
-			if (!substrcmp(p, len2, "error"))
-				severity = FSCK_ERROR;
-			else if (!substrcmp(p, len2, "warn"))
-				severity = FSCK_WARN;
-			else if (!substrcmp(p, len2, "ignore"))
-				severity = FSCK_IGNORE;
-			else
-				die("Unknown fsck message severity: '%.*s'",
-					len2, p);
-		}
+			die("Missing '=': '%.*s'", len, values);
 
-		if (severity != FSCK_ERROR &&
-				msg_id_info[msg_id].severity == FSCK_FATAL)
-			die("Cannot demote %.*s", len, mode);
-		options->msg_severity[msg_id] = severity;
-		mode += len;
+		fsck_set_msg_type(options, values, equal,
+				values + equal + 1, len - equal - 1);
+		values += len;
 	}
 }
 
@@ -235,11 +259,8 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 
 		if (!c)
 			break;
-		if (c == '_')
-			c = '-';
-		else
-			c = tolower(c);
-		strbuf_addch(sb, c);
+		if (c != '_')
+			strbuf_addch(sb, tolower(c));
 	}
 
 	strbuf_addstr(sb, ": ");
@@ -251,21 +272,25 @@ static int report(struct fsck_options *options, struct object *object,
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_severity = fsck_msg_severity(id, options), result;
+	int msg_type = fsck_msg_type(id, options), result;
+
+	if (msg_type == FSCK_IGNORE)
+		return 0;
 
-	if (msg_severity == FSCK_IGNORE)
+	if (options->skiplist && object &&
+			sha1_array_lookup(options->skiplist, object->sha1) >= 0)
 		return 0;
 
-	if (msg_severity == FSCK_FATAL)
-		msg_severity = FSCK_ERROR;
-	else if (msg_severity == FSCK_INFO)
-		msg_severity = FSCK_WARN;
+	if (msg_type == FSCK_FATAL)
+		msg_type = FSCK_ERROR;
+	else if (msg_type == FSCK_INFO)
+		msg_type = FSCK_WARN;
 
 	append_msg_id(&sb, msg_id_info[id].id_string);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(object, msg_severity, sb.buf);
+	result = options->error_func(object, msg_type, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
 
@@ -756,10 +781,6 @@ static int fsck_tag(struct tag *tag, const char *data,
 int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
-	if (options->skiplist &&
-			sha1_array_lookup(options->skiplist, obj->sha1) >= 0)
-		return 0;
-
 	if (!obj)
 		return report(options, obj, FSCK_MSG_INVALID_OBJECT_SHA1, "no valid object to fsck");
 
@@ -778,9 +799,9 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 			  obj->type);
 }
 
-int fsck_error_function(struct object *obj, int severity, const char *message)
+int fsck_error_function(struct object *obj, int msg_type, const char *message)
 {
-	if (severity == FSCK_WARN) {
+	if (msg_type == FSCK_WARN) {
 		warning("object %s: %s", sha1_to_hex(obj->sha1), message);
 		return 0;
 	}
diff --git a/fsck.h b/fsck.h
index cae280e..cab9c65 100644
--- a/fsck.h
+++ b/fsck.h
@@ -7,7 +7,11 @@
 
 struct fsck_options;
 
-void fsck_set_severity(struct fsck_options *options, const char *mode);
+void fsck_set_msg_type(struct fsck_options *options,
+		const char *msg_id, int msg_id_len,
+		const char *msg_type, int msg_type_len);
+void fsck_set_msg_types(struct fsck_options *options, const char *values);
+int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
 /*
  * callback function for fsck_walk
@@ -28,7 +32,7 @@ struct fsck_options {
 	fsck_walk_func walk;
 	fsck_error error_func;
 	unsigned strict:1;
-	int *msg_severity;
+	int *msg_type;
 	struct sha1_array *skiplist;
 };
 
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index b32afaf..471e2ea 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid-tag-name: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: missing-tagger-entry: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: invalidtagname: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
@@ -295,7 +295,7 @@ test_expect_success 'force fsck to ignore double author' '
 	git update-ref refs/heads/bogus "$new" &&
 	test_when_finished "git update-ref -d refs/heads/bogus" &&
 	test_must_fail git fsck &&
-	git -c fsck.severity=multiple-authors=ignore fsck
+	git -c fsck.multipleauthors=ignore fsck
 '
 
 _bz='\0'
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 7881e17..1ada54c 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -124,44 +124,46 @@ This commit object intentionally broken
 EOF
 
 test_expect_success 'push with receive.fsck.skiplist' '
-	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config receive.fsck.skiplist SKIP &&
-	echo $commit > dst/.git/SKIP &&
+	echo $commit >dst/.git/SKIP &&
 	git push --porcelain dst bogus
 '
 
-test_expect_success 'push with receive.fsck.severity = missing-email=warn' '
-	commit="$(git hash-object -t commit -w --stdin < bogus-commit)" &&
+test_expect_success 'push with receive.fsck.missingemail=warn' '
+	commit="$(git hash-object -t commit -w --stdin <bogus-commit)" &&
 	git push . $commit:refs/heads/bogus &&
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	test_must_fail git push --porcelain dst bogus &&
 	git --git-dir=dst/.git config \
-		receive.fsck.severity missing-email=warn &&
+		receive.fsck.missingemail warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	grep "missing-email" act &&
+	grep "missingemail" act &&
 	git --git-dir=dst/.git branch -D bogus &&
 	git  --git-dir=dst/.git config --add \
-		receive.fsck.severity missing-email=ignore,bad-date=warn &&
+		receive.fsck.missingemail ignore &&
+	git  --git-dir=dst/.git config --add \
+		receive.fsck.baddate warn &&
 	git push --porcelain dst bogus >act 2>&1 &&
-	test_must_fail grep "missing-email" act
+	test_must_fail grep "missingemail" act
 '
 
 test_expect_success \
-	'receive.fsck.severity = unterminated-header=warn triggers error' '
+	'receive.fsck.unterminatedheader=warn triggers error' '
 	rm -rf dst &&
 	git init dst &&
 	git --git-dir=dst/.git config receive.fsckobjects true &&
 	git --git-dir=dst/.git config \
-		receive.fsck.severity unterminated-header=warn &&
+		receive.fsck.unterminatedheader warn &&
 	test_must_fail git push --porcelain dst HEAD >act 2>&1 &&
-	grep "Cannot demote unterminated-header" act
+	grep "Cannot demote unterminatedheader" act
 '
 
 test_done

-- 
2.3.1.windows.1.9.g8c01ab4
