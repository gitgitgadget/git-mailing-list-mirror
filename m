From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/12] attr: rename function and struct related to checking attributes
Date: Mon, 16 May 2016 14:05:41 -0700
Message-ID: <20160516210545.6591-9-gitster@pobox.com>
References: <20160516210545.6591-1-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 23:06:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2PiU-0001LI-U1
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 23:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbcEPVGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 17:06:10 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751184AbcEPVGI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 17:06:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EAB2D1C749;
	Mon, 16 May 2016 17:06:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=vtAr
	n2QmKLLEQTFpL2v2dWG3KZY=; b=CG0C1C67aHpxGYmNeG7ijXx+HdiII8farOtJ
	q9OFWDUSbhRT9AcgYYSrF/IbUM2jHbR1gnEr8E5Jm+Wi8lRA6nrbaNd5EzH8na+j
	qMemDOFeeuj8NaJ00QJ3G8fcb/MvjE28a8gWgkmfJd3d/eSybmAsXV8bOSkXuXX6
	uYOHumk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=VoxS/6
	KPX5E07sWIhFpHofi4nR9gWQsN69Tlvw3KEi6rk+6sXXPHUC5FNXpLqGvqyeF5mS
	fVdoj/I05k92y7Fo0e4PJhgtcys1mPWCr0xrWs24T69+i9Wty0y5KKT5qrusHnGp
	ozWBZopfGz7/8sR0C7L8T4IUotHphzzWi2Nxw=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E3C1B1C748;
	Mon, 16 May 2016 17:06:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 351941C747;
	Mon, 16 May 2016 17:06:06 -0400 (EDT)
X-Mailer: git-send-email 2.8.2-755-g8847aff
In-Reply-To: <20160516210545.6591-1-gitster@pobox.com>
X-Pobox-Relay-ID: 0157C03E-1BAA-11E6-BF63-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294793>

The traditional API to check attributes is to prepare an N-element
array of "struct git_attr_check" and pass N and the array to the
function "git_check_attr()" as arguments.

In preparation to revamp the API to pass a single structure, in
which these N elements are held, rename the type used for these
individual array elements to "struct git_attr_check_elem" and rename
the function to "git_check_attrs()".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 archive.c              |  6 +++---
 attr.c                 | 12 ++++++------
 attr.h                 |  8 ++++----
 builtin/check-attr.c   | 19 ++++++++++---------
 builtin/pack-objects.c |  6 +++---
 convert.c              | 12 ++++++------
 ll-merge.c             | 10 +++++-----
 userdiff.c             |  4 ++--
 ws.c                   |  6 +++---
 9 files changed, 42 insertions(+), 41 deletions(-)

diff --git a/archive.c b/archive.c
index 5d735ae..0f6acc5 100644
--- a/archive.c
+++ b/archive.c
@@ -87,7 +87,7 @@ void *sha1_file_to_archive(const struct archiver_args *args,
 	return buffer;
 }
 
-static void setup_archive_check(struct git_attr_check *check)
+static void setup_archive_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_export_ignore;
 	static struct git_attr *attr_export_subst;
@@ -123,7 +123,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	struct archiver_context *c = context;
 	struct archiver_args *args = c->args;
 	write_archive_entry_fn_t write_entry = c->write_entry;
-	struct git_attr_check check[2];
+	struct git_attr_check_elem check[2];
 	const char *path_without_prefix;
 	int err;
 
@@ -138,7 +138,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
 	path_without_prefix = path.buf + args->baselen;
 
 	setup_archive_check(check);
-	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
+	if (!git_check_attrs(path_without_prefix, ARRAY_SIZE(check), check)) {
 		if (ATTR_TRUE(check[0].value))
 			return 0;
 		args->convert = ATTR_TRUE(check[1].value);
diff --git a/attr.c b/attr.c
index 7bfeef3..8aa346c 100644
--- a/attr.c
+++ b/attr.c
@@ -40,7 +40,7 @@ struct git_attr {
 static int attr_nr;
 static int cannot_trust_maybe_real;
 
-static struct git_attr_check *check_all_attr;
+static struct git_attr_check_elem *check_all_attr;
 static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 char *git_attr_name(struct git_attr *attr)
@@ -661,7 +661,7 @@ static int macroexpand_one(int attr_nr, int rem);
 
 static int fill_one(const char *what, struct match_attr *a, int rem)
 {
-	struct git_attr_check *check = check_all_attr;
+	struct git_attr_check_elem *check = check_all_attr;
 	int i;
 
 	for (i = a->num_attr - 1; 0 < rem && 0 <= i; i--) {
@@ -726,7 +726,7 @@ static int macroexpand_one(int nr, int rem)
  * collected. Otherwise all attributes are collected.
  */
 static void collect_some_attrs(const char *path, int num,
-			       struct git_attr_check *check)
+			       struct git_attr_check_elem *check)
 
 {
 	struct attr_stack *stk;
@@ -754,7 +754,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = 0;
 		for (i = 0; i < num; i++) {
 			if (!check[i].attr->maybe_real) {
-				struct git_attr_check *c;
+				struct git_attr_check_elem *c;
 				c = check_all_attr + check[i].attr->attr_nr;
 				c->value = ATTR__UNSET;
 				rem++;
@@ -769,7 +769,7 @@ static void collect_some_attrs(const char *path, int num,
 		rem = fill(path, pathlen, basename_offset, stk, rem);
 }
 
-int git_check_attr(const char *path, int num, struct git_attr_check *check)
+int git_check_attrs(const char *path, int num, struct git_attr_check_elem *check)
 {
 	int i;
 
@@ -785,7 +785,7 @@ int git_check_attr(const char *path, int num, struct git_attr_check *check)
 	return 0;
 }
 
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check)
+int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check)
 {
 	int i, count, j;
 
diff --git a/attr.h b/attr.h
index 8b08d33..cab82ec 100644
--- a/attr.h
+++ b/attr.h
@@ -20,11 +20,11 @@ extern const char git_attr__false[];
 #define ATTR_UNSET(v) ((v) == NULL)
 
 /*
- * Send one or more git_attr_check to git_check_attr(), and
+ * Send one or more git_attr_check to git_check_attrs(), and
  * each 'value' member tells what its value is.
  * Unset one is returned as NULL.
  */
-struct git_attr_check {
+struct git_attr_check_elem {
 	struct git_attr *attr;
 	const char *value;
 };
@@ -36,7 +36,7 @@ struct git_attr_check {
  */
 char *git_attr_name(struct git_attr *);
 
-int git_check_attr(const char *path, int, struct git_attr_check *);
+int git_check_attrs(const char *path, int, struct git_attr_check_elem *);
 
 /*
  * Retrieve all attributes that apply to the specified path.  *num
@@ -45,7 +45,7 @@ int git_check_attr(const char *path, int, struct git_attr_check *);
  * objects describing the attributes and their values.  *check must be
  * free()ed by the caller.
  */
-int git_all_attrs(const char *path, int *num, struct git_attr_check **check);
+int git_all_attrs(const char *path, int *num, struct git_attr_check_elem **check);
 
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 53a5a18..97e3837 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -24,8 +24,8 @@ static const struct option check_attr_options[] = {
 	OPT_END()
 };
 
-static void output_attr(int cnt, struct git_attr_check *check,
-	const char *file)
+static void output_attr(int cnt, struct git_attr_check_elem *check,
+			const char *file)
 {
 	int j;
 	for (j = 0; j < cnt; j++) {
@@ -51,14 +51,15 @@ static void output_attr(int cnt, struct git_attr_check *check,
 	}
 }
 
-static void check_attr(const char *prefix, int cnt,
-	struct git_attr_check *check, const char *file)
+static void check_attr(const char *prefix,
+		       int cnt, struct git_attr_check_elem *check,
+		       const char *file)
 {
 	char *full_path =
 		prefix_path(prefix, prefix ? strlen(prefix) : 0, file);
 	if (check != NULL) {
-		if (git_check_attr(full_path, cnt, check))
-			die("git_check_attr died");
+		if (git_check_attrs(full_path, cnt, check))
+			die("git_check_attrs died");
 		output_attr(cnt, check, file);
 	} else {
 		if (git_all_attrs(full_path, &cnt, &check))
@@ -69,8 +70,8 @@ static void check_attr(const char *prefix, int cnt,
 	free(full_path);
 }
 
-static void check_attr_stdin_paths(const char *prefix, int cnt,
-	struct git_attr_check *check)
+static void check_attr_stdin_paths(const char *prefix,
+				   int cnt, struct git_attr_check_elem *check)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf unquoted = STRBUF_INIT;
@@ -99,7 +100,7 @@ static NORETURN void error_with_usage(const char *msg)
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
-	struct git_attr_check *check;
+	struct git_attr_check_elem *check;
 	int cnt, i, doubledash, filei;
 
 	if (!is_bare_repository())
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a27de5b..167c301 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -886,7 +886,7 @@ static void write_pack_file(void)
 			written, nr_result);
 }
 
-static void setup_delta_attr_check(struct git_attr_check *check)
+static void setup_delta_attr_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_delta;
 
@@ -898,10 +898,10 @@ static void setup_delta_attr_check(struct git_attr_check *check)
 
 static int no_try_delta(const char *path)
 {
-	struct git_attr_check check[1];
+	struct git_attr_check_elem check[1];
 
 	setup_delta_attr_check(check);
-	if (git_check_attr(path, ARRAY_SIZE(check), check))
+	if (git_check_attrs(path, ARRAY_SIZE(check), check))
 		return 0;
 	if (ATTR_FALSE(check->value))
 		return 1;
diff --git a/convert.c b/convert.c
index f524b8d..058da86 100644
--- a/convert.c
+++ b/convert.c
@@ -703,7 +703,7 @@ static int ident_to_worktree(const char *path, const char *src, size_t len,
 	return 1;
 }
 
-static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
+static enum crlf_action git_path_check_crlf(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -720,7 +720,7 @@ static enum crlf_action git_path_check_crlf(struct git_attr_check *check)
 	return CRLF_UNDEFINED;
 }
 
-static enum eol git_path_check_eol(struct git_attr_check *check)
+static enum eol git_path_check_eol(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -733,7 +733,7 @@ static enum eol git_path_check_eol(struct git_attr_check *check)
 	return EOL_UNSET;
 }
 
-static struct convert_driver *git_path_check_convert(struct git_attr_check *check)
+static struct convert_driver *git_path_check_convert(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 	struct convert_driver *drv;
@@ -746,7 +746,7 @@ static struct convert_driver *git_path_check_convert(struct git_attr_check *chec
 	return NULL;
 }
 
-static int git_path_check_ident(struct git_attr_check *check)
+static int git_path_check_ident(struct git_attr_check_elem *check)
 {
 	const char *value = check->value;
 
@@ -768,7 +768,7 @@ static const char *conv_attr_name[] = {
 static void convert_attrs(struct conv_attrs *ca, const char *path)
 {
 	int i;
-	static struct git_attr_check ccheck[NUM_CONV_ATTRS];
+	static struct git_attr_check_elem ccheck[NUM_CONV_ATTRS];
 
 	if (!ccheck[0].attr) {
 		for (i = 0; i < NUM_CONV_ATTRS; i++)
@@ -777,7 +777,7 @@ static void convert_attrs(struct conv_attrs *ca, const char *path)
 		git_config(read_convert_config, NULL);
 	}
 
-	if (!git_check_attr(path, NUM_CONV_ATTRS, ccheck)) {
+	if (!git_check_attrs(path, NUM_CONV_ATTRS, ccheck)) {
 		ca->crlf_action = git_path_check_crlf(ccheck + 4);
 		if (ca->crlf_action == CRLF_UNDEFINED)
 			ca->crlf_action = git_path_check_crlf(ccheck + 0);
diff --git a/ll-merge.c b/ll-merge.c
index ff4a43a..772b14e 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -334,13 +334,13 @@ static const struct ll_merge_driver *find_ll_merge_driver(const char *merge_attr
 	return &ll_merge_drv[LL_TEXT_MERGE];
 }
 
-static int git_path_check_merge(const char *path, struct git_attr_check check[2])
+static int git_path_check_merge(const char *path, struct git_attr_check_elem check[2])
 {
 	if (!check[0].attr) {
 		check[0].attr = git_attr("merge");
 		check[1].attr = git_attr("conflict-marker-size");
 	}
-	return git_check_attr(path, 2, check);
+	return git_check_attrs(path, 2, check);
 }
 
 static void normalize_file(mmfile_t *mm, const char *path)
@@ -360,7 +360,7 @@ int ll_merge(mmbuffer_t *result_buf,
 	     mmfile_t *theirs, const char *their_label,
 	     const struct ll_merge_options *opts)
 {
-	static struct git_attr_check check[2];
+	static struct git_attr_check_elem check[2];
 	static const struct ll_merge_options default_opts;
 	const char *ll_driver_name = NULL;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
@@ -392,12 +392,12 @@ int ll_merge(mmbuffer_t *result_buf,
 
 int ll_merge_marker_size(const char *path)
 {
-	static struct git_attr_check check;
+	static struct git_attr_check_elem check;
 	int marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
 
 	if (!check.attr)
 		check.attr = git_attr("conflict-marker-size");
-	if (!git_check_attr(path, 1, &check) && check.value) {
+	if (!git_check_attrs(path, 1, &check) && check.value) {
 		marker_size = atoi(check.value);
 		if (marker_size <= 0)
 			marker_size = DEFAULT_CONFLICT_MARKER_SIZE;
diff --git a/userdiff.c b/userdiff.c
index 6bf2505..3560024 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -251,7 +251,7 @@ struct userdiff_driver *userdiff_find_by_name(const char *name) {
 struct userdiff_driver *userdiff_find_by_path(const char *path)
 {
 	static struct git_attr *attr;
-	struct git_attr_check check;
+	struct git_attr_check_elem check;
 
 	if (!attr)
 		attr = git_attr("diff");
@@ -259,7 +259,7 @@ struct userdiff_driver *userdiff_find_by_path(const char *path)
 
 	if (!path)
 		return NULL;
-	if (git_check_attr(path, 1, &check))
+	if (git_check_attrs(path, 1, &check))
 		return NULL;
 
 	if (ATTR_TRUE(check.value))
diff --git a/ws.c b/ws.c
index ea4b2b1..7350905 100644
--- a/ws.c
+++ b/ws.c
@@ -71,7 +71,7 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-static void setup_whitespace_attr_check(struct git_attr_check *check)
+static void setup_whitespace_attr_check(struct git_attr_check_elem *check)
 {
 	static struct git_attr *attr_whitespace;
 
@@ -82,10 +82,10 @@ static void setup_whitespace_attr_check(struct git_attr_check *check)
 
 unsigned whitespace_rule(const char *pathname)
 {
-	struct git_attr_check attr_whitespace_rule;
+	struct git_attr_check_elem attr_whitespace_rule;
 
 	setup_whitespace_attr_check(&attr_whitespace_rule);
-	if (!git_check_attr(pathname, 1, &attr_whitespace_rule)) {
+	if (!git_check_attrs(pathname, 1, &attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule.value;
-- 
2.8.2-748-gfb85f76
