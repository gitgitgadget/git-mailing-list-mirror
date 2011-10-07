From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fmt-merge-msg: use branch.$name.description
Date: Thu, 06 Oct 2011 23:57:51 -0700
Message-ID: <7vobxtwaog.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 07 08:58:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC4Nc-0001nC-2v
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 08:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757266Ab1JGG5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 02:57:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44531 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756962Ab1JGG5y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 02:57:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD4C3AC6;
	Fri,  7 Oct 2011 02:57:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=z
	qawGrD77TPS7ya1Iws2QTazmT4=; b=rjXDnPxEUZaMZUvzdAvHX/6BhlIsZSzc6
	hguelswgjXoW06xPX8PLjMWDxrGgtWDnmpjnv84UT5Yg5aau/BLeJ8Cfo7N2423Q
	/fstmRdH6i+FiK0Iu1bZmdu1KE4Wiaci7OPJlO9Qhnb/vayeHyORE4lT2MFc0iwW
	KFaV49Vva4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=VHt
	DStRVT2j4kzkCgWjIM3f1HTXo4j5xFsY6wph5j+GGm2uZ42M0aGLkaFl4XGSk2un
	UYKKQUEt7t5xVp3Qhyu6HW1Kwl7kcvXOc9zIBdsZjJwlBbExvihI6XrNX2OcCzTG
	Crpa2eqTxxCQSWgcc3NfyVQ987HCd44uMVbmxsJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4EB73AC5;
	Fri,  7 Oct 2011 02:57:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5C9E3AC4; Fri,  7 Oct 2011
 02:57:52 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD5274FC-F0B1-11E0-B6C1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183061>

This teaches "merge --log" and fmt-merge-msg to use branch description
information when merging a local topic branch into the mainline. The
description goes between the branch name label and the list of commit
titles.

The refactoring to share the common configuration parsing between
merge and fmt-merge-msg needs to be made into a separate patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is a follow-up to the branch.$name.description series that has
   been queued in 'pu' (jc/request-pull-show-head-4). The two commands
   join the family of commands that are aware of the branch description,
   i.e. format-patch (cover letter), request-pull.

 Makefile                |    1 +
 builtin/fmt-merge-msg.c |   63 ++++++++++++++++++++++++++++++++++++++--------
 builtin/merge.c         |   16 +++++------
 fmt-merge-msg.h         |    6 ++++
 4 files changed, 66 insertions(+), 20 deletions(-)
 create mode 100644 fmt-merge-msg.h

diff --git a/Makefile b/Makefile
index 8d6d451..b499049 100644
--- a/Makefile
+++ b/Makefile
@@ -527,6 +527,7 @@ LIB_H += diffcore.h
 LIB_H += diff.h
 LIB_H += dir.h
 LIB_H += exec_cmd.h
+LIB_H += fmt-merge-msg.h
 LIB_H += fsck.h
 LIB_H += gettext.h
 LIB_H += git-compat-util.h
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 7581632..21efd25 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -5,6 +5,8 @@
 #include "revision.h"
 #include "tag.h"
 #include "string-list.h"
+#include "branch.h"
+#include "fmt-merge-msg.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]",
@@ -12,8 +14,9 @@ static const char * const fmt_merge_msg_usage[] = {
 };
 
 static int shortlog_len;
+static int use_branch_desc;
 
-static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
+int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
 	if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
 		int is_bool;
@@ -22,6 +25,8 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 			return error("%s: negative length %s", key, value);
 		if (is_bool && shortlog_len)
 			shortlog_len = DEFAULT_MERGE_LOG_LEN;
+	} else if (!strcmp(key, "merge.branchdesc")) {
+		use_branch_desc = git_config_bool(key, value);
 	}
 	return 0;
 }
@@ -31,6 +36,11 @@ struct src_data {
 	int head_status;
 };
 
+struct origin_data {
+	unsigned char sha1[20];
+	int is_local_branch:1;
+};
+
 static void init_src_data(struct src_data *data)
 {
 	data->branch.strdup_strings = 1;
@@ -45,7 +55,7 @@ static struct string_list origins = STRING_LIST_INIT_DUP;
 static int handle_line(char *line)
 {
 	int i, len = strlen(line);
-	unsigned char *sha1;
+	struct origin_data *origin_data;
 	char *src, *origin;
 	struct src_data *src_data;
 	struct string_list_item *item;
@@ -61,11 +71,13 @@ static int handle_line(char *line)
 		return 2;
 
 	line[40] = 0;
-	sha1 = xmalloc(20);
-	i = get_sha1(line, sha1);
+	origin_data = xcalloc(1, sizeof(struct origin_data));
+	i = get_sha1(line, origin_data->sha1);
 	line[40] = '\t';
-	if (i)
+	if (i) {
+		free(origin_data);
 		return 3;
+	}
 
 	if (line[len - 1] == '\n')
 		line[len - 1] = 0;
@@ -93,6 +105,7 @@ static int handle_line(char *line)
 		origin = src;
 		src_data->head_status |= 1;
 	} else if (!prefixcmp(line, "branch ")) {
+		origin_data->is_local_branch = 1;
 		origin = line + 7;
 		string_list_append(&src_data->branch, origin);
 		src_data->head_status |= 2;
@@ -119,7 +132,9 @@ static int handle_line(char *line)
 		sprintf(new_origin, "%s of %s", origin, src);
 		origin = new_origin;
 	}
-	string_list_append(&origins, origin)->util = sha1;
+	if (strcmp(".", src))
+		origin_data->is_local_branch = 0;
+	string_list_append(&origins, origin)->util = origin_data;
 	return 0;
 }
 
@@ -140,9 +155,30 @@ static void print_joined(const char *singular, const char *plural,
 	}
 }
 
-static void shortlog(const char *name, unsigned char *sha1,
-		struct commit *head, struct rev_info *rev, int limit,
-		struct strbuf *out)
+static void add_branch_desc(struct strbuf *out, const char *name)
+{
+	struct strbuf desc = STRBUF_INIT;
+
+	if (!read_branch_desc(&desc, name)) {
+		const char *bp = desc.buf;
+		while (*bp) {
+			const char *ep = strchrnul(bp, '\n');
+			if (*ep)
+				ep++;
+			strbuf_addf(out, "  : %.*s", (int)(ep - bp), bp);
+			bp = ep;
+		}
+		if (out->buf[out->len - 1] != '\n')
+			strbuf_addch(out, '\n');
+	}
+	strbuf_release(&desc);
+}
+
+static void shortlog(const char *name,
+		     struct origin_data *origin_data,
+		     struct commit *head,
+		     struct rev_info *rev, int limit,
+		     struct strbuf *out)
 {
 	int i, count = 0;
 	struct commit *commit;
@@ -150,6 +186,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	struct string_list subjects = STRING_LIST_INIT_DUP;
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
+	const unsigned char *sha1 = origin_data->sha1;
 
 	branch = deref_tag(parse_object(sha1), sha1_to_hex(sha1), 40);
 	if (!branch || branch->type != OBJ_COMMIT)
@@ -188,6 +225,9 @@ static void shortlog(const char *name, unsigned char *sha1,
 	else
 		strbuf_addf(out, "\n* %s:\n", name);
 
+	if (origin_data->is_local_branch && use_branch_desc)
+		add_branch_desc(out, name);
+
 	for (i = 0; i < subjects.nr; i++)
 		if (i >= limit)
 			strbuf_addf(out, "  ...\n");
@@ -303,8 +343,9 @@ static int do_fmt_merge_msg(int merge_title, struct strbuf *in,
 			strbuf_addch(out, '\n');
 
 		for (i = 0; i < origins.nr; i++)
-			shortlog(origins.items[i].string, origins.items[i].util,
-					head, &rev, shortlog_len, out);
+			shortlog(origins.items[i].string,
+				 origins.items[i].util,
+				 head, &rev, shortlog_len, out);
 	}
 	return 0;
 }
diff --git a/builtin/merge.c b/builtin/merge.c
index ab4077f..fe56aad 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -26,6 +26,7 @@
 #include "merge-recursive.h"
 #include "resolve-undo.h"
 #include "remote.h"
+#include "fmt-merge-msg.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -525,6 +526,8 @@ static void parse_branch_merge_options(char *bmo)
 
 static int git_merge_config(const char *k, const char *v, void *cb)
 {
+	int status;
+
 	if (branch && !prefixcmp(k, "branch.") &&
 		!prefixcmp(k + 7, branch) &&
 		!strcmp(k + 7 + strlen(branch), ".mergeoptions")) {
@@ -541,15 +544,7 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		return git_config_string(&pull_octopus, k, v);
 	else if (!strcmp(k, "merge.renormalize"))
 		option_renormalize = git_config_bool(k, v);
-	else if (!strcmp(k, "merge.log") || !strcmp(k, "merge.summary")) {
-		int is_bool;
-		shortlog_len = git_config_bool_or_int(k, v, &is_bool);
-		if (!is_bool && shortlog_len < 0)
-			return error(_("%s: negative length %s"), k, v);
-		if (is_bool && shortlog_len)
-			shortlog_len = DEFAULT_MERGE_LOG_LEN;
-		return 0;
-	} else if (!strcmp(k, "merge.ff")) {
+	else if (!strcmp(k, "merge.ff")) {
 		int boolval = git_config_maybe_bool(k, v);
 		if (0 <= boolval) {
 			allow_fast_forward = boolval;
@@ -562,6 +557,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 		default_to_upstream = git_config_bool(k, v);
 		return 0;
 	}
+	status = fmt_merge_msg_config(k, v, cb);
+	if (status)
+		return status;
 	return git_diff_ui_config(k, v, cb);
 }
 
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
new file mode 100644
index 0000000..9217fdb
--- /dev/null
+++ b/fmt-merge-msg.h
@@ -0,0 +1,6 @@
+#ifndef FMT_MERGE_MSG_H
+#define FMT_MERGE_MSG_H
+
+extern int fmt_merge_msg_config(const char *key, const char *value, void *cb);
+
+#endif /* FMT_MERGE_MSG_H */
-- 
1.7.7.138.g7f41b6
