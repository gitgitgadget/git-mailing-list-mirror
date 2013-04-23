From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 6/7] grep: honor --textconv for the case rev:path
Date: Tue, 23 Apr 2013 14:11:58 +0200
Message-ID: <805accf9664ea7f9cd8de2cfa6d2e17601720767.1366718624.git.git@drmicha.warpmail.net>
References: <517298D4.3030802@drmicha.warpmail.net>
Cc: Matthieu.Moy@grenoble-inp.fr, jeremy.rosen@openwide.fr,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 14:12:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUc4y-0002Fq-7l
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 14:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900Ab3DWMMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 08:12:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53297 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab3DWMMC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Apr 2013 08:12:02 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 20CD7206C6;
	Tue, 23 Apr 2013 08:12:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Tue, 23 Apr 2013 08:12:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=uY
	DzMTLzvgWirU5hwldu5uDkyOQ=; b=Awj9wo/7JzLWb8vMTvY8kbM9hhYPy9Mhom
	e/7DZyNsos7XsgkZSQrtV1ClfoY0T0b5gWAQHCKtWLbNCowW/QYP05052lGHwZNr
	23jPu2MEN9A8xOVeQ0alYKjy+FoqOExgnuY3fC0VYj2UYl9s6t6t9GAZQ2k9Lna9
	HRBQzaIg8=
X-Sasl-enc: 6pBtg9da0G8aVss+XJZDf9WnRrKaQXxryUcnz9BqayLY 1366719121
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AF66DC80004;
	Tue, 23 Apr 2013 08:12:01 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.799.g1ac2534
In-Reply-To: <517298D4.3030802@drmicha.warpmail.net>
In-Reply-To: <cover.1366718624.git.git@drmicha.warpmail.net>
References: <cover.1366718624.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222148>

Make "grep" honor the "--textconv" option also for the object case, i.e.
when used with an argument "rev:path".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c         | 11 ++++++-----
 object.c               | 26 ++++++++++++++++++++------
 object.h               |  2 ++
 t/t7008-grep-binary.sh |  2 +-
 4 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 00ee57d..bb7f970 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -458,10 +458,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
-		       struct object *obj, const char *name)
+		       struct object *obj, const char *name, struct object_context *oc)
 {
 	if (obj->type == OBJ_BLOB)
-		return grep_sha1(opt, obj->sha1, name, 0, NULL);
+		return grep_sha1(opt, obj->sha1, name, 0, oc ? oc->path : NULL);
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -503,7 +503,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < nr; i++) {
 		struct object *real_obj;
 		real_obj = deref_tag(list->objects[i].item, NULL, 0);
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name)) {
+		if (grep_object(opt, pathspec, real_obj, list->objects[i].name, list->objects[i].context)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -820,12 +820,13 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
+		struct object_context oc;
 		/* Is it a rev? */
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
 			struct object *object = parse_object_or_die(sha1, arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
-			add_object_array(object, arg, &list);
+			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
diff --git a/object.c b/object.c
index 20703f5..c8ffc9e 100644
--- a/object.c
+++ b/object.c
@@ -255,12 +255,7 @@ int object_list_contains(struct object_list *list, struct object *obj)
 	return 0;
 }
 
-void add_object_array(struct object *obj, const char *name, struct object_array *array)
-{
-	add_object_array_with_mode(obj, name, array, S_IFINVALID);
-}
-
-void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
+static void add_object_array_with_mode_context(struct object *obj, const char *name, struct object_array *array, unsigned mode, struct object_context *context)
 {
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
@@ -275,9 +270,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
 	objects[nr].item = obj;
 	objects[nr].name = name;
 	objects[nr].mode = mode;
+	objects[nr].context = context;
 	array->nr = ++nr;
 }
 
+void add_object_array(struct object *obj, const char *name, struct object_array *array)
+{
+	add_object_array_with_mode(obj, name, array, S_IFINVALID);
+}
+
+void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
+{
+	add_object_array_with_mode_context(obj, name, array, mode, NULL);
+}
+
+void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context)
+{
+	if (context)
+		add_object_array_with_mode_context(obj, name, array, context->mode, context);
+	else
+		add_object_array_with_mode_context(obj, name, array, S_IFINVALID, context);
+}
+
 void object_array_remove_duplicates(struct object_array *array)
 {
 	unsigned int ref, src, dst;
diff --git a/object.h b/object.h
index 97d384b..695847d 100644
--- a/object.h
+++ b/object.h
@@ -13,6 +13,7 @@ struct object_array {
 		struct object *item;
 		const char *name;
 		unsigned mode;
+		struct object_context *context;
 	} *objects;
 };
 
@@ -85,6 +86,7 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
+void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context);
 void object_array_remove_duplicates(struct object_array *);
 
 void clear_object_flags(unsigned flags);
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index 1eae6a4..10b2c8b 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -178,7 +178,7 @@ test_expect_failure 'grep blob does not honor textconv' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'grep --textconv blob does not honor textconv' '
+test_expect_success 'grep --textconv blob does honor textconv' '
 	echo "HEAD:a:binaryQfile" >expect &&
 	git grep --textconv Qfile HEAD:a >actual &&
 	test_cmp expect actual
-- 
1.8.2.1.799.g1ac2534
