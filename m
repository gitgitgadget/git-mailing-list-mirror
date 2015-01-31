From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 02/19] fsck: Introduce identifiers for fsck messages
Date: Sat, 31 Jan 2015 22:04:49 +0100
Organization: gmx
Message-ID: <50f28536d4f68766fb293cd07d2ca655c380e7db.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfE7-0003vi-VY
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbbAaVFC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:05:02 -0500
Received: from mout.gmx.net ([212.227.17.22]:57232 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754216AbbAaVFA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:05:00 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MVvDo-1YB3UJ15IG-00X8Bm; Sat, 31 Jan 2015 22:04:51
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:4hYvuRGWd17cgpxeUJa5QCIhrNnyGVJ6goCtkMxbaFlVd2H1pzB
 AA4/8lNXx9XSY3F5NGnjJMsYWLFAWzyauPxD8IjM1+sbS3BLv/+xZ7UYaeZAVebgTtDD1+y
 2oYvbqSn8G/1Et/NF9ZscVD11msDC9S8cmvtp1GGN+qRx+laMhiXlbRSaGhHeu0+lYgOTCa
 2c0FpM2m+S/fKW9eQ/Ewg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263212>

Instead of specifying whether a message by the fsck machinery constitutes
an error or a warning, let's specify an identifier relating to the
concrete problem that was encountered. This is necessary for upcoming
support to be able to demote certain errors to warnings.

In the process, simplify the requirements on the calling code: instead of
having to handle full-blown varargs in every callback, we now send a
string buffer ready to be used by the callback.

We could use a simple enum for the message IDs here, but we want to
guarantee that the enum values are associated with the appropriate
severity levels. Besides, we want to introduce a parser in the next commit
that maps the string representation to the enum value, hence we use the
slightly ugly preprocessor construct that is extensible for use with said
parser.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/fsck.c |  24 ++-----
 fsck.c         | 201 +++++++++++++++++++++++++++++++++++++++++----------------
 fsck.h         |   5 +-
 3 files changed, 153 insertions(+), 77 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 0d03c15..1f7944c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -47,32 +47,22 @@ static int show_dangling = 1;
 #endif
 
 static void objreport(struct object *obj, const char *severity,
-                      const char *err, va_list params)
+                      const char *err)
 {
-	fprintf(stderr, "%s in %s %s: ",
-	        severity, typename(obj->type), sha1_to_hex(obj->sha1));
-	vfprintf(stderr, err, params);
-	fputs("\n", stderr);
+	fprintf(stderr, "%s in %s %s: %s\n",
+	        severity, typename(obj->type), sha1_to_hex(obj->sha1), err);
 }
 
-__attribute__((format (printf, 2, 3)))
-static int objerror(struct object *obj, const char *err, ...)
+static int objerror(struct object *obj, const char *err)
 {
-	va_list params;
-	va_start(params, err);
 	errors_found |= ERROR_OBJECT;
-	objreport(obj, "error", err, params);
-	va_end(params);
+	objreport(obj, "error", err);
 	return -1;
 }
 
-__attribute__((format (printf, 3, 4)))
-static int fsck_error_func(struct object *obj, int type, const char *err, ...)
+static int fsck_error_func(struct object *obj, int type, const char *message)
 {
-	va_list params;
-	va_start(params, err);
-	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", err, params);
-	va_end(params);
+	objreport(obj, (type == FSCK_WARN) ? "warning" : "error", message);
 	return (type == FSCK_WARN) ? 0 : 1;
 }
 
diff --git a/fsck.c b/fsck.c
index d83b811..30f7a48 100644
--- a/fsck.c
+++ b/fsck.c
@@ -9,6 +9,98 @@
 #include "refs.h"
 #include "utf8.h"
 
+#define FOREACH_MSG_ID(FUNC) \
+	/* errors */ \
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
+	FUNC(NOT_SORTED, ERROR) \
+	FUNC(NUL_IN_HEADER, ERROR) \
+	FUNC(TAG_OBJECT_NOT_TAG, ERROR) \
+	FUNC(UNKNOWN_TYPE, ERROR) \
+	FUNC(UNTERMINATED_HEADER, ERROR) \
+	FUNC(ZERO_PADDED_DATE, ERROR) \
+	/* warnings */ \
+	FUNC(BAD_FILEMODE, WARN) \
+	FUNC(EMPTY_NAME, WARN) \
+	FUNC(FULL_PATHNAME, WARN) \
+	FUNC(HAS_DOT, WARN) \
+	FUNC(HAS_DOTDOT, WARN) \
+	FUNC(HAS_DOTGIT, WARN) \
+	FUNC(INVALID_TAG_NAME, WARN) \
+	FUNC(MISSING_TAGGER_ENTRY, WARN) \
+	FUNC(NULL_SHA1, WARN) \
+	FUNC(ZERO_PADDED_FILEMODE, WARN)
+
+#define MSG_ID(id, severity) FSCK_MSG_##id,
+enum fsck_msg_id {
+	FOREACH_MSG_ID(MSG_ID)
+	FSCK_MSG_MAX
+};
+#undef MSG_ID
+
+#define MSG_ID(id, severity) { FSCK_##severity },
+static struct {
+	int severity;
+} msg_id_info[FSCK_MSG_MAX + 1] = {
+	FOREACH_MSG_ID(MSG_ID)
+	{ -1 }
+};
+#undef MSG_ID
+
+static int fsck_msg_severity(enum fsck_msg_id msg_id,
+	struct fsck_options *options)
+{
+	int severity;
+
+	severity = msg_id_info[msg_id].severity;
+	if (options->strict && severity == FSCK_WARN)
+		severity = FSCK_ERROR;
+
+	return severity;
+}
+
+__attribute__((format (printf, 4, 5)))
+static int report(struct fsck_options *options, struct object *object,
+	enum fsck_msg_id id, const char *fmt, ...)
+{
+	va_list ap;
+	struct strbuf sb = STRBUF_INIT;
+	int msg_severity = fsck_msg_severity(id, options), result;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	result = options->error_func(object, msg_severity, sb.buf);
+	strbuf_release(&sb);
+	va_end(ap);
+
+	return result;
+}
+
 static int fsck_walk_tree(struct tree *tree, void *data, struct fsck_options *options)
 {
 	struct tree_desc desc;
@@ -219,25 +311,25 @@ static int fsck_tree(struct tree *item, struct fsck_options *options)
 
 	retval = 0;
 	if (has_null_sha1)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains entries pointing to null sha1");
+		retval += report(options, &item->object, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains full pathnames");
+		retval += report(options, &item->object, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
 	if (has_empty_name)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains empty pathname");
+		retval += report(options, &item->object, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
 	if (has_dot)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains '.'");
+		retval += report(options, &item->object, FSCK_MSG_HAS_DOT, "contains '.'");
 	if (has_dotdot)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains '..'");
+		retval += report(options, &item->object, FSCK_MSG_HAS_DOTDOT, "contains '..'");
 	if (has_dotgit)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains '.git'");
+		retval += report(options, &item->object, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
 	if (has_zero_pad)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains zero-padded file modes");
+		retval += report(options, &item->object, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += options->error_func(&item->object, FSCK_WARN, "contains bad file modes");
+		retval += report(options, &item->object, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
 	if (has_dup_entries)
-		retval += options->error_func(&item->object, FSCK_ERROR, "contains duplicate file entries");
+		retval += report(options, &item->object, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += options->error_func(&item->object, FSCK_ERROR, "not properly sorted");
+		retval += report(options, &item->object, FSCK_MSG_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
@@ -250,15 +342,17 @@ static int require_end_of_header(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return options->error_func(obj, FSCK_ERROR,
-				"unterminated header: NUL at offset %d", i);
+			return report(options, obj,
+				FSCK_MSG_NUL_IN_HEADER,
+				"unterminated header: NUL at offset %ld", i);
 		case '\n':
 			if (i + 1 < size && buffer[i + 1] == '\n')
 				return 0;
 		}
 	}
 
-	return options->error_func(obj, FSCK_ERROR, "unterminated header");
+	return report(options, obj,
+		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
 static int fsck_ident(const char **ident, struct object *obj, struct fsck_options *options)
@@ -266,28 +360,28 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	char *end;
 
 	if (**ident == '<')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	*ident += strcspn(*ident, "<>\n");
 	if (**ident == '>')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad name");
+		return report(options, obj, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
 	if (**ident != '<')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing email");
+		return report(options, obj, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
 	if ((*ident)[-1] != ' ')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before email");
+		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	(*ident)++;
 	*ident += strcspn(*ident, "<>\n");
 	if (**ident != '>')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad email");
+		return report(options, obj, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
 	(*ident)++;
 	if (**ident != ' ')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - missing space before date");
+		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	(*ident)++;
 	if (**ident == '0' && (*ident)[1] != ' ')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - zero-padded date");
+		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(strtoul(*ident, &end, 10)))
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - date causes integer overflow");
+		return report(options, obj, FSCK_MSG_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if (end == *ident || *end != ' ')
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad date");
+		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	*ident = end + 1;
 	if ((**ident != '+' && **ident != '-') ||
 	    !isdigit((*ident)[1]) ||
@@ -295,7 +389,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	    !isdigit((*ident)[3]) ||
 	    !isdigit((*ident)[4]) ||
 	    ((*ident)[5] != '\n'))
-		return options->error_func(obj, FSCK_ERROR, "invalid author/committer line - bad time zone");
+		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
 	(*ident) += 6;
 	return 0;
 }
@@ -312,13 +406,13 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
-		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
+		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
-		return options->error_func(&commit->object, FSCK_ERROR, "invalid 'tree' line format - bad sha1");
+		return report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 	buffer += 41;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n')
-			return options->error_func(&commit->object, FSCK_ERROR, "invalid 'parent' line format - bad sha1");
+			return report(options, &commit->object, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 		buffer += 41;
 		parent_line_count++;
 	}
@@ -328,23 +422,23 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
 		if (graft->nr_parent == -1 && !parent_count)
 			; /* shallow commit */
 		else if (graft->nr_parent != parent_count)
-			return options->error_func(&commit->object, FSCK_ERROR, "graft objects missing");
+			return report(options, &commit->object, FSCK_MSG_MISSING_GRAFT, "graft objects missing");
 	} else {
 		if (parent_count != parent_line_count)
-			return options->error_func(&commit->object, FSCK_ERROR, "parent objects missing");
+			return report(options, &commit->object, FSCK_MSG_MISSING_PARENT, "parent objects missing");
 	}
 	if (!skip_prefix(buffer, "author ", &buffer))
-		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'author' line");
+		return report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-		return options->error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'committer' line");
+		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
 	if (!commit->tree)
-		return options->error_func(&commit->object, FSCK_ERROR, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
+		return report(options, &commit->object, FSCK_MSG_INVALID_TREE, "could not load commit's tree %s", sha1_to_hex(tree_sha1));
 
 	return 0;
 }
@@ -376,11 +470,13 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		buffer = to_free =
 			read_sha1_file(tag->object.sha1, &type, &size);
 		if (!buffer)
-			return options->error_func(&tag->object, FSCK_ERROR,
+			return report(options, &tag->object,
+				FSCK_MSG_MISSING_TAG_OBJECT,
 				"cannot read tag object");
 
 		if (type != OBJ_TAG) {
-			ret = options->error_func(&tag->object, FSCK_ERROR,
+			ret = report(options, &tag->object,
+				FSCK_MSG_TAG_OBJECT_NOT_TAG,
 				"expected tag got %s",
 			    typename(type));
 			goto done;
@@ -391,48 +487,49 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'object' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (get_sha1_hex(buffer, sha1) || buffer[40] != '\n') {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid 'object' line format - bad sha1");
+		ret = report(options, &tag->object, FSCK_MSG_INVALID_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		goto done;
 	}
 	buffer += 41;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'type' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid 'type' value");
+		ret = report(options, &tag->object, FSCK_MSG_INVALID_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tag ", &buffer)) {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - expected 'tag' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = options->error_func(&tag->object, FSCK_ERROR, "invalid format - unexpected end after 'type' line");
+		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0))
-		options->error_func(&tag->object, FSCK_WARN, "invalid 'tag' name: %.*s",
+		report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME,
+			   "invalid 'tag' name: %.*s",
 			   (int)(eol - buffer), buffer);
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tagger ", &buffer))
 		/* early tags do not contain 'tagger' lines; warn only */
-		options->error_func(&tag->object, FSCK_WARN, "invalid format - expected 'tagger' line");
+		report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
 	else
 		ret = fsck_ident(&buffer, &tag->object, options);
 
@@ -448,7 +545,7 @@ static int fsck_tag(struct tag *tag, const char *data,
 	struct object *tagged = tag->tagged;
 
 	if (!tagged)
-		return options->error_func(&tag->object, FSCK_ERROR, "could not load tagged object");
+		return report(options, &tag->object, FSCK_MSG_INVALID_TAG_OBJECT, "could not load tagged object");
 
 	return fsck_tag_buffer(tag, data, size, options);
 }
@@ -457,7 +554,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
 	if (!obj)
-		return options->error_func(obj, FSCK_ERROR, "no valid object to fsck");
+		return report(options, obj, FSCK_MSG_INVALID_OBJECT_SHA1, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
 		return 0;
@@ -470,22 +567,12 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 		return fsck_tag((struct tag *) obj, (const char *) data,
 			size, options);
 
-	return options->error_func(obj, FSCK_ERROR, "unknown type '%d' (internal fsck error)",
+	return report(options, obj, FSCK_MSG_UNKNOWN_TYPE, "unknown type '%d' (internal fsck error)",
 			  obj->type);
 }
 
-int fsck_error_function(struct object *obj, int type, const char *fmt, ...)
+int fsck_error_function(struct object *obj, int severity, const char *message)
 {
-	va_list ap;
-	struct strbuf sb = STRBUF_INIT;
-
-	strbuf_addf(&sb, "object %s:", sha1_to_hex(obj->sha1));
-
-	va_start(ap, fmt);
-	strbuf_vaddf(&sb, fmt, ap);
-	va_end(ap);
-
-	error("%s", sb.buf);
-	strbuf_release(&sb);
+	error("object %s: %s", sha1_to_hex(obj->sha1), message);
 	return 1;
 }
diff --git a/fsck.h b/fsck.h
index 07d0ab2..f6f268a 100644
--- a/fsck.h
+++ b/fsck.h
@@ -17,10 +17,9 @@ struct fsck_options;
 typedef int (*fsck_walk_func)(struct object *obj, int type, void *data, struct fsck_options *options);
 
 /* callback for fsck_object, type is FSCK_ERROR or FSCK_WARN */
-typedef int (*fsck_error)(struct object *obj, int type, const char *err, ...);
+typedef int (*fsck_error)(struct object *obj, int type, const char *message);
 
-__attribute__((format (printf, 3, 4)))
-int fsck_error_function(struct object *obj, int type, const char *fmt, ...);
+int fsck_error_function(struct object *obj, int type, const char *message);
 
 struct fsck_options {
 	fsck_walk_func walk;
-- 
2.2.0.33.gc18b867
