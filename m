From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 6/7] fmt-merge-msg: remove custom string_list implementation
Date: Wed, 24 Mar 2010 00:16:03 -0700
Message-ID: <1269414964-9518-7-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpx-0006wZ-V9
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922Ab0CXHQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:31 -0400
Received: from mail-yx0-f188.google.com ([209.85.210.188]:32896 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0CXHQY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:24 -0400
Received: by yxe26 with SMTP id 26so2675211yxe.23
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=DSygEvK24xGkWzQ0kVH38QkvWI7QcK8tqWyyJWJu4/E=;
        b=WJO5qDq1xHO0eEaaz8tDAb3XnA1xH4RMqP1DHqfFZ93xE17uFgm2LBCY/z8XJhPTfU
         Qs2/ExkBrjl+BAMQjIes27RrnR+uZOY0NHd5GjUAEYrKRH84yo0CJM7/QHLJNLXbAJhs
         n5N3zonXGnre9z79z7IX0AIF7rByO93eLWF7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=lKrOst0ClF9WhWuwFS4tJU7UxDxE8FHh0lomkOiGRpTv8RxoyKshd3yRjw2HAWsqWp
         TTBIhwd74ZlTdkC8oA5dQt7ngOeC7O/zC+WyOS05kEFRaCAA9I1rzfWqb4xsA08MebM1
         pVJ2fARm191mUURu48xpkWdhpcadMKkyBZJXY=
Received: by 10.150.254.14 with SMTP id b14mr7098819ybi.10.1269414983604;
        Wed, 24 Mar 2010 00:16:23 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 20sm4938874iwn.5.2010.03.24.00.16.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143073>

This command uses a custom version of string list when it could
just as easily use the string_list API. Convert it to use string_list
and reduce the code size a bit.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---

Anyone else annoyed that string_list_append() is the only function
that takes doesn't take the string list as the first argument?

On another note, git-compat-util.h:115 says:

  #undef _ALL_SOURCE /* AIX 5.3L defines a struct list with...

which may be unnecessary now that struct list is gone. Need someone
on AIX 5.3L to test that though.

Finally, this doesn't free some of the lists since I wanted it to be a
straight conversion. I'm feeling lazy right now but I'll think about it.

 builtin/fmt-merge-msg.c |  127 ++++++++++++++++------------------------------
 1 files changed, 44 insertions(+), 83 deletions(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 44b74f4..0fb4014 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "tag.h"
+#include "string-list.h"
 
 static const char * const fmt_merge_msg_usage[] = {
 	"git fmt-merge-msg [--log|--no-log] [--file <file>]",
@@ -24,58 +25,21 @@ static int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 	return 0;
 }
 
-struct list {
-	char **list;
-	void **payload;
-	unsigned nr, alloc;
+struct src_data {
+	struct string_list branch, tag, r_branch, generic;
+	int head_status;
 };
 
-static void append_to_list(struct list *list, char *value, void *payload)
-{
-	if (list->nr == list->alloc) {
-		list->alloc += 32;
-		list->list = xrealloc(list->list, sizeof(char *) * list->alloc);
-		list->payload = xrealloc(list->payload,
-				sizeof(char *) * list->alloc);
-	}
-	list->payload[list->nr] = payload;
-	list->list[list->nr++] = value;
-}
-
-static int find_in_list(struct list *list, char *value)
-{
-	int i;
-
-	for (i = 0; i < list->nr; i++)
-		if (!strcmp(list->list[i], value))
-			return i;
-
-	return -1;
-}
-
-static void free_list(struct list *list)
+void init_src_data(struct src_data *data)
 {
-	int i;
-
-	if (list->alloc == 0)
-		return;
-
-	for (i = 0; i < list->nr; i++) {
-		free(list->list[i]);
-		free(list->payload[i]);
-	}
-	free(list->list);
-	free(list->payload);
-	list->nr = list->alloc = 0;
+	data->branch.strdup_strings = 1;
+	data->tag.strdup_strings = 1;
+	data->r_branch.strdup_strings = 1;
+	data->generic.strdup_strings = 1;
 }
 
-struct src_data {
-	struct list branch, tag, r_branch, generic;
-	int head_status;
-};
-
-static struct list srcs = { NULL, NULL, 0, 0};
-static struct list origins = { NULL, NULL, 0, 0};
+static struct string_list srcs = { NULL, 0, 0, 1 };
+static struct string_list origins = { NULL, 0, 0, 1 };
 
 static int handle_line(char *line)
 {
@@ -83,6 +47,7 @@ static int handle_line(char *line)
 	unsigned char *sha1;
 	char *src, *origin;
 	struct src_data *src_data;
+	struct string_list_item *item;
 	int pulling_head = 0;
 
 	if (len < 43 || line[40] != '\t')
@@ -115,64 +80,62 @@ static int handle_line(char *line)
 		pulling_head = 1;
 	}
 
-	i = find_in_list(&srcs, src);
-	if (i < 0) {
-		i = srcs.nr;
-		append_to_list(&srcs, xstrdup(src),
-				xcalloc(1, sizeof(struct src_data)));
+	item = unsorted_string_list_lookup(&srcs, src);
+	if (!item) {
+		item = string_list_append(src, &srcs);
+		item->util = xcalloc(1, sizeof(struct src_data));
+		init_src_data(item->util);
 	}
-	src_data = srcs.payload[i];
+	src_data = item->util;
 
 	if (pulling_head) {
-		origin = xstrdup(src);
+		origin = src;
 		src_data->head_status |= 1;
 	} else if (!prefixcmp(line, "branch ")) {
-		origin = xstrdup(line + 7);
-		append_to_list(&src_data->branch, origin, NULL);
+		origin = line + 7;
+		string_list_append(origin, &src_data->branch);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "tag ")) {
 		origin = line;
-		append_to_list(&src_data->tag, xstrdup(origin + 4), NULL);
+		string_list_append(origin + 4, &src_data->tag);
 		src_data->head_status |= 2;
 	} else if (!prefixcmp(line, "remote branch ")) {
-		origin = xstrdup(line + 14);
-		append_to_list(&src_data->r_branch, origin, NULL);
+		origin = line + 14;
+		string_list_append(origin, &src_data->r_branch);
 		src_data->head_status |= 2;
 	} else {
-		origin = xstrdup(src);
-		append_to_list(&src_data->generic, xstrdup(line), NULL);
+		origin = src;
+		string_list_append(line, &src_data->generic);
 		src_data->head_status |= 2;
 	}
 
 	if (!strcmp(".", src) || !strcmp(src, origin)) {
 		int len = strlen(origin);
-		if (origin[0] == '\'' && origin[len - 1] == '\'') {
+		if (origin[0] == '\'' && origin[len - 1] == '\'')
 			origin = xmemdupz(origin + 1, len - 2);
-		} else {
-			origin = xstrdup(origin);
-		}
 	} else {
 		char *new_origin = xmalloc(strlen(origin) + strlen(src) + 5);
 		sprintf(new_origin, "%s of %s", origin, src);
 		origin = new_origin;
 	}
-	append_to_list(&origins, origin, sha1);
+	string_list_append(origin, &origins)->util = sha1;
 	return 0;
 }
 
 static void print_joined(const char *singular, const char *plural,
-		struct list *list, struct strbuf *out)
+		struct string_list *list, struct strbuf *out)
 {
 	if (list->nr == 0)
 		return;
 	if (list->nr == 1) {
-		strbuf_addf(out, "%s%s", singular, list->list[0]);
+		strbuf_addf(out, "%s%s", singular, list->items[0].string);
 	} else {
 		int i;
 		strbuf_addstr(out, plural);
 		for (i = 0; i < list->nr - 1; i++)
-			strbuf_addf(out, "%s%s", i > 0 ? ", " : "", list->list[i]);
-		strbuf_addf(out, " and %s", list->list[list->nr - 1]);
+			strbuf_addf(out, "%s%s", i > 0 ? ", " : "",
+				    list->items[i].string);
+		strbuf_addf(out, " and %s", list->items[list->nr - 1].string);
 	}
 }
 
@@ -183,7 +146,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	int i, count = 0;
 	struct commit *commit;
 	struct object *branch;
-	struct list subjects = { NULL, NULL, 0, 0 };
+	struct string_list subjects = { NULL, 0, 0, 1 };
 	int flags = UNINTERESTING | TREESAME | SEEN | SHOWN | ADDED;
 	struct strbuf sb = STRBUF_INIT;
 
@@ -213,12 +176,10 @@ static void shortlog(const char *name, unsigned char *sha1,
 		strbuf_ltrim(&sb);
 
 		if (!sb.len)
-			append_to_list(&subjects, xstrdup(sha1_to_hex(
-							commit->object.sha1)),
-					NULL);
+			string_list_append(sha1_to_hex(commit->object.sha1),
+					   &subjects);
 		else
-			append_to_list(&subjects, strbuf_detach(&sb, NULL),
-					NULL);
+			string_list_append(strbuf_detach(&sb, NULL), &subjects);
 	}
 
 	if (count > limit)
@@ -230,7 +191,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 		if (i >= limit)
 			strbuf_addf(out, "  ...\n");
 		else
-			strbuf_addf(out, "  %s\n", subjects.list[i]);
+			strbuf_addf(out, "  %s\n", subjects.items[i].string);
 
 	clear_commit_marks((struct commit *)branch, flags);
 	clear_commit_marks(head, flags);
@@ -238,7 +199,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	rev->commits = NULL;
 	rev->pending.nr = 0;
 
-	free_list(&subjects);
+	string_list_clear(&subjects, 0);
 }
 
 int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
@@ -273,14 +234,14 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 
 	strbuf_addstr(out, "Merge ");
 	for (i = 0; i < srcs.nr; i++) {
-		struct src_data *src_data = srcs.payload[i];
+		struct src_data *src_data = srcs.items[i].util;
 		const char *subsep = "";
 
 		strbuf_addstr(out, sep);
 		sep = "; ";
 
 		if (src_data->head_status == 1) {
-			strbuf_addstr(out, srcs.list[i]);
+			strbuf_addstr(out, srcs.items[i].string);
 			continue;
 		}
 		if (src_data->head_status == 3) {
@@ -309,8 +270,8 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 			print_joined("commit ", "commits ", &src_data->generic,
 					out);
 		}
-		if (strcmp(".", srcs.list[i]))
-			strbuf_addf(out, " of %s", srcs.list[i]);
+		if (strcmp(".", srcs.items[i].string))
+			strbuf_addf(out, " of %s", srcs.items[i].string);
 	}
 
 	if (!strcmp("master", current_branch))
@@ -329,7 +290,7 @@ int fmt_merge_msg(int merge_summary, struct strbuf *in, struct strbuf *out) {
 		rev.limited = 1;
 
 		for (i = 0; i < origins.nr; i++)
-			shortlog(origins.list[i], origins.payload[i],
+			shortlog(origins.items[i].string, origins.items[i].util,
 					head, &rev, limit, out);
 	}
 	return 0;
-- 
1.7.0.3.254.g4503b
