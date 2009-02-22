From: =?ISO-8859-1?Q?Marc=2DAndr=E9_Lureau?= <marcandre.lureau@gmail.com>
Subject: [PATCH/RFC 5/6] builtin-tag: add sort by date -D
Date: Sun, 22 Feb 2009 20:06:45 +0200
Message-ID: <e29894ca0902221006j3d602553x15807b41698f51a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 22 19:08:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbIkz-00047r-Pe
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 19:08:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZBVSGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 13:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751901AbZBVSGt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 13:06:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:37604 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbZBVSGr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 13:06:47 -0500
Received: by ug-out-1314.google.com with SMTP id 39so187473ugf.37
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=NaCRsrwkdxgXIVjZaZqAViBOc1P1jlTJrohuA9bEuDs=;
        b=H5/6QbDJ+Lu773hzk8YWTZCP7JBuOlWy6M2HRk33L9ltkoV2nJkYNohelUmBLkD54D
         CUuxmbrdzjAb8zTFxz/QQSk1kPdrCfUsrjjoCFVuzOVOGVuq5XELieaggH/8W8o4p1Gg
         mZIJPoX2NOXi1pjzhPJy5YJ3utcS6zyPx9f28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=MY1xQuQmHTQvWifY3znVfDP974wknqCun/bV7iKA1XYYhM0+og1AdGNR6/ZA3z399P
         Cb3l2XNstTETzlqOKTowqTIdyliZoz2iHjKhfINwhnRhJPLvmaTtTqSV3fSEsgnfn0PS
         q5MNdhL8Y4rHJld9fxEpBkPVxcxxqlBHlCQYY=
Received: by 10.210.68.17 with SMTP id q17mr2698650eba.128.1235326005613; Sun, 
	22 Feb 2009 10:06:45 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111036>

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 builtin-tag.c |  162 +++++++++++++++++++++++++++++++++++++++++++++------------
 1 files changed, 129 insertions(+), 33 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 01e7374..8ff9d03 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -16,7 +16,7 @@
 static const char * const git_tag_usage[] = {
 	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
 	"git tag -d <tagname>...",
-	"git tag -l [-n[<num>]] [<pattern>]",
+	"git tag -l [-n[<num>] -D] [<pattern>]",
 	"git tag -v <tagname>...",
 	NULL
 };
@@ -27,21 +27,108 @@ struct tag_filter {
 	const char *pattern;
 	int lines;
 	struct commit_list *with_commit;
+	int sort;
+	struct object_list *sorted_tags;
 };

+struct light_tag {
+	struct object object;
+	struct object *tagged;
+	char *refname;
+};
+
+#define OBJ_LIGHT_TAG (OBJ_MAX + 1)
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"

+static unsigned long object_date(struct object *object)
+{
+	if (object->type == OBJ_TAG)
+		return ((struct tag*)object)->date;
+	else if (object->type == OBJ_COMMIT)
+		return ((struct commit*)object)->date;
+	else if (object->type == OBJ_TREE)
+		return 0;
+	else if (object->type == OBJ_BLOB)
+		return 0;
+	else if (object->type == OBJ_LIGHT_TAG)
+		return object_date(((struct light_tag*)object)->tagged);
+
+	return 0;
+}
+
+static struct object_list *object_list_insert_by_date(struct object
*item, struct object_list **list)
+{
+	struct object_list **pp = list;
+	struct object_list *p;
+	unsigned long item_date;
+	unsigned long p_date;
+
+	if (!item->parsed)
+		return NULL;
+
+	while ((p = *pp) != NULL) {
+		p_date = object_date(p->item);
+		item_date = object_date(item);
+
+		if (p_date > item_date)
+			break;
+
+		pp = &p->next;
+	}
+	return object_list_insert(item, pp);
+}
+
+static void pretty_print_tag(const struct object *object, int lines)
+{
+	int i;
+	char *sp, *eol;
+	size_t len;
+
+	if (!lines) {
+		if (object->type == OBJ_TAG)
+			printf("%s\n", ((struct tag*)object)->tag);
+		else if (object->type == OBJ_LIGHT_TAG)
+			printf("%s\n", ((struct light_tag*)object)->refname);
+		/* other not implemented */
+		return;
+	}
+
+	if (object->type == OBJ_TAG) {
+		struct tag *tag;
+
+		tag = (struct tag*)object;
+		printf("%-15s ", tag->tag);
+
+		/* skip header */
+		sp = strstr(tag->buffer, "\n\n");
+		if (!sp)
+			return;
+
+		/* only take up to "lines" lines, and strip the signature */
+		for (i = 0, sp += 2;
+		     i < lines && sp < tag->buffer + tag->size &&
+			     prefixcmp(sp, PGP_SIGNATURE "\n");
+		     i++) {
+			if (i)
+				printf("\n    ");
+			eol = memchr(sp, '\n', tag->size - (sp - tag->buffer));
+			len = eol ? eol - sp : tag->size - (sp - tag->buffer);
+			fwrite(sp, len, 1, stdout);
+			if (!eol)
+				break;
+			sp = eol + 1;
+		}
+		putchar('\n');
+	}
+}
+
 static int show_reference(const char *refname, const unsigned char *sha1,
 			  int flag, void *cb_data)
 {
 	struct tag_filter *filter = cb_data;
+	struct object *object;

 	if (!fnmatch(filter->pattern, refname, 0)) {
-		int i;
-		unsigned long size;
-		enum object_type type;
-		char *buf, *sp, *eol;
-		size_t len;

 		if (filter->with_commit) {
 			struct commit *commit;
@@ -53,45 +140,43 @@ static int show_reference(const char *refname,
const unsigned char *sha1,
 				return 0;
 		}

-		if (!filter->lines) {
+		if (!filter->lines && !filter->sort) {
 			printf("%s\n", refname);
 			return 0;
 		}
-		printf("%-15s ", refname);

-		buf = read_sha1_file(sha1, &type, &size);
-		if (!buf || !size)
+		object = parse_object(sha1);
+		if (!object)
 			return 0;

-		/* skip header */
-		sp = strstr(buf, "\n\n");
-		if (!sp) {
-			free(buf);
-			return 0;
+		if (object->type != OBJ_TAG) {
+			struct light_tag *light_tag;
+			struct object *o;
+
+			o = xmalloc(sizeof(struct light_tag));
+			light_tag = (struct light_tag*)o;
+			o->parsed = 1;
+			o->used = 0;
+			o->type = OBJ_LIGHT_TAG;
+			o->flags = 0;
+			light_tag->tagged = object;
+			light_tag->refname = xstrdup(refname);
+			object = o;
 		}
-		/* only take up to "lines" lines, and strip the signature */
-		for (i = 0, sp += 2;
-				i < filter->lines && sp < buf + size &&
-				prefixcmp(sp, PGP_SIGNATURE "\n");
-				i++) {
-			if (i)
-				printf("\n    ");
-			eol = memchr(sp, '\n', size - (sp - buf));
-			len = eol ? eol - sp : size - (sp - buf);
-			fwrite(sp, len, 1, stdout);
-			if (!eol)
-				break;
-			sp = eol + 1;
+
+		if (filter->sort) {
+			object_list_insert_by_date(object, &filter->sorted_tags);
+			return 0;
 		}
-		putchar('\n');
-		free(buf);
+
+		pretty_print_tag(object, filter->lines);
 	}

 	return 0;
 }

 static int list_tags(const char *pattern, int lines,
-			struct commit_list *with_commit)
+			struct commit_list *with_commit, int sort)
 {
 	struct tag_filter filter;

@@ -101,9 +186,19 @@ static int list_tags(const char *pattern, int lines,
 	filter.pattern = pattern;
 	filter.lines = lines;
 	filter.with_commit = with_commit;
+	filter.sort = sort;
+	filter.sorted_tags = NULL;

 	for_each_tag_ref(show_reference, (void *) &filter);

+	if (filter.sort) {
+		struct object_list *l;
+		for (l = filter.sorted_tags; l; l = l->next) {
+			pretty_print_tag(l->item, lines);
+		}
+		/* free_object_list(filter.sorted_tags); */
+	}
+
 	return 0;
 }

@@ -370,12 +465,13 @@ int cmd_tag(int argc, const char **argv, const
char *prefix)
 	struct ref_lock *lock;

 	int annotate = 0, sign = 0, force = 0, lines = -1,
-		list = 0, delete = 0, verify = 0;
+		list = 0, delete = 0, verify = 0, sort = 0;
 	const char *msgfile = NULL, *keyid = NULL;
 	struct msg_arg msg = { 0, STRBUF_INIT };
 	struct commit_list *with_commit = NULL;
 	struct option options[] = {
 		OPT_BOOLEAN('l', NULL, &list, "list tag names"),
+		OPT_BOOLEAN('D', NULL, &sort, "sort tag by date"),
 		{ OPTION_INTEGER, 'n', NULL, &lines, NULL,
 				"print n lines of each tag message",
 				PARSE_OPT_OPTARG, NULL, 1 },
@@ -425,7 +521,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		usage_with_options(git_tag_usage, options);
 	if (list)
 		return list_tags(argv[0], lines == -1 ? 0 : lines,
-				 with_commit);
+				 with_commit, sort);
 	if (lines != -1)
 		die("-n option is only allowed with -l.");
 	if (with_commit)
-- 
1.6.2.rc1.28.g05ef4.dirty
