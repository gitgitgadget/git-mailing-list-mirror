Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0D1A1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439354AbfJRE7S (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:59:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:51734 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2395281AbfJRE7R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:59:17 -0400
Received: (qmail 9480 invoked by uid 109); 18 Oct 2019 04:59:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:59:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14397 invoked by uid 111); 18 Oct 2019 05:02:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:02:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:59:15 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 15/23] fsck: don't require an object struct for report()
Message-ID: <20191018045915.GO17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The report() function really only cares about the oid and type of the
object, not the full object struct. Let's convert it to take those two
items separately, which gives our callers more flexibility.

This makes some already-long lines even longer. I've mostly left them,
as our eventual goal is to shrink these down as we continue refactoring
(e.g., "&item->object" becomes "&item->object.oid, item->object.type",
but will eventually shrink down to "oid, type").

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 128 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 69 insertions(+), 59 deletions(-)

diff --git a/fsck.c b/fsck.c
index 2309c40a11..465247be71 100644
--- a/fsck.c
+++ b/fsck.c
@@ -283,9 +283,10 @@ static int object_on_skiplist(struct fsck_options *opts,
 	return opts && oid && oidset_contains(&opts->skiplist, oid);
 }
 
-__attribute__((format (printf, 4, 5)))
-static int report(struct fsck_options *options, struct object *object,
-	enum fsck_msg_id id, const char *fmt, ...)
+__attribute__((format (printf, 5, 6)))
+static int report(struct fsck_options *options,
+		  const struct object_id *oid, enum object_type object_type,
+		  enum fsck_msg_id id, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
@@ -294,7 +295,7 @@ static int report(struct fsck_options *options, struct object *object,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (object_on_skiplist(options, &object->oid))
+	if (object_on_skiplist(options, oid))
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -306,7 +307,7 @@ static int report(struct fsck_options *options, struct object *object,
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-	result = options->error_func(options, &object->oid, object->type,
+	result = options->error_func(options, oid, object_type,
 				     msg_type, sb.buf);
 	strbuf_release(&sb);
 	va_end(ap);
@@ -585,7 +586,7 @@ static int fsck_tree(struct tree *item,
 	const char *o_name;
 
 	if (init_tree_desc_gently(&desc, buffer, size)) {
-		retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 		return retval;
 	}
 
@@ -611,13 +612,14 @@ static int fsck_tree(struct tree *item,
 			if (!S_ISLNK(mode))
 				oidset_insert(&gitmodules_found, oid);
 			else
-				retval += report(options, &item->object,
+				retval += report(options,
+						 &item->object.oid, item->object.type,
 						 FSCK_MSG_GITMODULES_SYMLINK,
 						 ".gitmodules is a symbolic link");
 		}
 
 		if (update_tree_entry_gently(&desc)) {
-			retval += report(options, &item->object, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
+			retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_TREE, "cannot be parsed as a tree");
 			break;
 		}
 
@@ -662,25 +664,25 @@ static int fsck_tree(struct tree *item,
 	}
 
 	if (has_null_sha1)
-		retval += report(options, &item->object, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_NULL_SHA1, "contains entries pointing to null sha1");
 	if (has_full_path)
-		retval += report(options, &item->object, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_FULL_PATHNAME, "contains full pathnames");
 	if (has_empty_name)
-		retval += report(options, &item->object, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_EMPTY_NAME, "contains empty pathname");
 	if (has_dot)
-		retval += report(options, &item->object, FSCK_MSG_HAS_DOT, "contains '.'");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOT, "contains '.'");
 	if (has_dotdot)
-		retval += report(options, &item->object, FSCK_MSG_HAS_DOTDOT, "contains '..'");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOTDOT, "contains '..'");
 	if (has_dotgit)
-		retval += report(options, &item->object, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_HAS_DOTGIT, "contains '.git'");
 	if (has_zero_pad)
-		retval += report(options, &item->object, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_ZERO_PADDED_FILEMODE, "contains zero-padded file modes");
 	if (has_bad_modes)
-		retval += report(options, &item->object, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_BAD_FILEMODE, "contains bad file modes");
 	if (has_dup_entries)
-		retval += report(options, &item->object, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_DUPLICATE_ENTRIES, "contains duplicate file entries");
 	if (not_properly_sorted)
-		retval += report(options, &item->object, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
+		retval += report(options, &item->object.oid, item->object.type, FSCK_MSG_TREE_NOT_SORTED, "not properly sorted");
 	return retval;
 }
 
@@ -693,7 +695,7 @@ static int verify_headers(const void *data, unsigned long size,
 	for (i = 0; i < size; i++) {
 		switch (buffer[i]) {
 		case '\0':
-			return report(options, obj,
+			return report(options, &obj->oid, obj->type,
 				FSCK_MSG_NUL_IN_HEADER,
 				"unterminated header: NUL at offset %ld", i);
 		case '\n':
@@ -711,7 +713,7 @@ static int verify_headers(const void *data, unsigned long size,
 	if (size && buffer[size - 1] == '\n')
 		return 0;
 
-	return report(options, obj,
+	return report(options, &obj->oid, obj->type,
 		FSCK_MSG_UNTERMINATED_HEADER, "unterminated header");
 }
 
@@ -725,28 +727,28 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 		(*ident)++;
 
 	if (*p == '<')
-		return report(options, obj, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_NAME_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p += strcspn(p, "<>\n");
 	if (*p == '>')
-		return report(options, obj, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_NAME, "invalid author/committer line - bad name");
 	if (*p != '<')
-		return report(options, obj, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_EMAIL, "invalid author/committer line - missing email");
 	if (p[-1] != ' ')
-		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_SPACE_BEFORE_EMAIL, "invalid author/committer line - missing space before email");
 	p++;
 	p += strcspn(p, "<>\n");
 	if (*p != '>')
-		return report(options, obj, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_EMAIL, "invalid author/committer line - bad email");
 	p++;
 	if (*p != ' ')
-		return report(options, obj, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_MISSING_SPACE_BEFORE_DATE, "invalid author/committer line - missing space before date");
 	p++;
 	if (*p == '0' && p[1] != ' ')
-		return report(options, obj, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
-		return report(options, obj, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
 	if ((end == p || *end != ' '))
-		return report(options, obj, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
 	if ((*p != '+' && *p != '-') ||
 	    !isdigit(p[1]) ||
@@ -754,7 +756,7 @@ static int fsck_ident(const char **ident, struct object *obj, struct fsck_option
 	    !isdigit(p[3]) ||
 	    !isdigit(p[4]) ||
 	    (p[5] != '\n'))
-		return report(options, obj, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
+		return report(options, &obj->oid, obj->type, FSCK_MSG_BAD_TIMEZONE, "invalid author/committer line - bad time zone");
 	p += 6;
 	return 0;
 }
@@ -772,16 +774,16 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 		return -1;
 
 	if (!skip_prefix(buffer, "tree ", &buffer))
-		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
+		return report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
 	if (parse_oid_hex(buffer, &tree_oid, &p) || *p != '\n') {
-		err = report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
+		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
 		if (err)
 			return err;
 	}
 	buffer = p + 1;
 	while (skip_prefix(buffer, "parent ", &buffer)) {
 		if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
-			err = report(options, &commit->object, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
+			err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_BAD_PARENT_SHA1, "invalid 'parent' line format - bad sha1");
 			if (err)
 				return err;
 		}
@@ -795,18 +797,18 @@ static int fsck_commit(struct commit *commit, const char *buffer,
 			return err;
 	}
 	if (author_count < 1)
-		err = report(options, &commit->object, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
+		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_AUTHOR, "invalid format - expected 'author' line");
 	else if (author_count > 1)
-		err = report(options, &commit->object, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
+		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MULTIPLE_AUTHORS, "invalid format - multiple 'author' lines");
 	if (err)
 		return err;
 	if (!skip_prefix(buffer, "committer ", &buffer))
-		return report(options, &commit->object, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
+		return report(options, &commit->object.oid, commit->object.type, FSCK_MSG_MISSING_COMMITTER, "invalid format - expected 'committer' line");
 	err = fsck_ident(&buffer, &commit->object, options);
 	if (err)
 		return err;
 	if (memchr(buffer_begin, '\0', size)) {
-		err = report(options, &commit->object, FSCK_MSG_NUL_IN_COMMIT,
+		err = report(options, &commit->object.oid, commit->object.type, FSCK_MSG_NUL_IN_COMMIT,
 			     "NUL byte in the commit object body");
 		if (err)
 			return err;
@@ -828,45 +830,46 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 		goto done;
 
 	if (!skip_prefix(buffer, "object ", &buffer)) {
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_OBJECT, "invalid format - expected 'object' line");
 		goto done;
 	}
 	if (parse_oid_hex(buffer, &oid, &p) || *p != '\n') {
-		ret = report(options, &tag->object, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_BAD_OBJECT_SHA1, "invalid 'object' line format - bad sha1");
 		if (ret)
 			goto done;
 	}
 	buffer = p + 1;
 
 	if (!skip_prefix(buffer, "type ", &buffer)) {
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TYPE_ENTRY, "invalid format - expected 'type' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TYPE, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	if (type_from_string_gently(buffer, eol - buffer, 1) < 0)
-		ret = report(options, &tag->object, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_BAD_TYPE, "invalid 'type' value");
 	if (ret)
 		goto done;
 	buffer = eol + 1;
 
 	if (!skip_prefix(buffer, "tag ", &buffer)) {
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAG_ENTRY, "invalid format - expected 'tag' line");
 		goto done;
 	}
 	eol = strchr(buffer, '\n');
 	if (!eol) {
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAG, "invalid format - unexpected end after 'type' line");
 		goto done;
 	}
 	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
 	if (check_refname_format(sb.buf, 0)) {
-		ret = report(options, &tag->object, FSCK_MSG_BAD_TAG_NAME,
-			   "invalid 'tag' name: %.*s",
-			   (int)(eol - buffer), buffer);
+		ret = report(options, &tag->object.oid, tag->object.type,
+			     FSCK_MSG_BAD_TAG_NAME,
+			     "invalid 'tag' name: %.*s",
+			     (int)(eol - buffer), buffer);
 		if (ret)
 			goto done;
 	}
@@ -874,7 +877,7 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 
 	if (!skip_prefix(buffer, "tagger ", &buffer)) {
 		/* early tags do not contain 'tagger' lines; warn only */
-		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
+		ret = report(options, &tag->object.oid, tag->object.type, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
 		if (ret)
 			goto done;
 	}
@@ -905,19 +908,22 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 
 	name = xmemdupz(subsection, subsection_len);
 	if (check_submodule_name(name) < 0)
-		data->ret |= report(data->options, data->obj,
+		data->ret |= report(data->options,
+				    &data->obj->oid, data->obj->type,
 				    FSCK_MSG_GITMODULES_NAME,
 				    "disallowed submodule name: %s",
 				    name);
 	if (!strcmp(key, "url") && value &&
 	    looks_like_command_line_option(value))
-		data->ret |= report(data->options, data->obj,
+		data->ret |= report(data->options,
+				    &data->obj->oid, data->obj->type,
 				    FSCK_MSG_GITMODULES_URL,
 				    "disallowed submodule url: %s",
 				    value);
 	if (!strcmp(key, "path") && value &&
 	    looks_like_command_line_option(value))
-		data->ret |= report(data->options, data->obj,
+		data->ret |= report(data->options,
+				    &data->obj->oid, data->obj->type,
 				    FSCK_MSG_GITMODULES_PATH,
 				    "disallowed submodule path: %s",
 				    value);
@@ -945,7 +951,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		 * blob too gigantic to load into memory. Let's just consider
 		 * that an error.
 		 */
-		return report(options, &blob->object,
+		return report(options, &blob->object.oid, blob->object.type,
 			      FSCK_MSG_GITMODULES_LARGE,
 			      ".gitmodules too large to parse");
 	}
@@ -956,7 +962,7 @@ static int fsck_blob(struct blob *blob, const char *buf,
 	config_opts.error_action = CONFIG_ERROR_SILENT;
 	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 				".gitmodules", buf, size, &data, &config_opts))
-		data.ret |= report(options, &blob->object,
+		data.ret |= report(options, &blob->object.oid, blob->object.type,
 				   FSCK_MSG_GITMODULES_PARSE,
 				   "could not parse gitmodules blob");
 
@@ -967,7 +973,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 	struct fsck_options *options)
 {
 	if (!obj)
-		return report(options, obj, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
+		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
 		return fsck_blob((struct blob *)obj, data, size, options);
@@ -980,8 +986,10 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 		return fsck_tag((struct tag *) obj, (const char *) data,
 			size, options);
 
-	return report(options, obj, FSCK_MSG_UNKNOWN_TYPE, "unknown type '%d' (internal fsck error)",
-			  obj->type);
+	return report(options, &obj->oid, obj->type,
+		      FSCK_MSG_UNKNOWN_TYPE,
+		      "unknown type '%d' (internal fsck error)",
+		      obj->type);
 }
 
 int fsck_error_function(struct fsck_options *o,
@@ -1016,7 +1024,7 @@ int fsck_finish(struct fsck_options *options)
 		blob = lookup_blob(the_repository, oid);
 		if (!blob) {
 			struct object *obj = lookup_unknown_object(oid);
-			ret |= report(options, obj,
+			ret |= report(options, &obj->oid, obj->type,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
 			continue;
@@ -1026,7 +1034,8 @@ int fsck_finish(struct fsck_options *options)
 		if (!buf) {
 			if (is_promisor_object(&blob->object.oid))
 				continue;
-			ret |= report(options, &blob->object,
+			ret |= report(options,
+				      &blob->object.oid, blob->object.type,
 				      FSCK_MSG_GITMODULES_MISSING,
 				      "unable to read .gitmodules blob");
 			continue;
@@ -1035,7 +1044,8 @@ int fsck_finish(struct fsck_options *options)
 		if (type == OBJ_BLOB)
 			ret |= fsck_blob(blob, buf, size, options);
 		else
-			ret |= report(options, &blob->object,
+			ret |= report(options,
+				      &blob->object.oid, blob->object.type,
 				      FSCK_MSG_GITMODULES_BLOB,
 				      "non-blob found at .gitmodules");
 		free(buf);
-- 
2.23.0.1228.gee29b05929

