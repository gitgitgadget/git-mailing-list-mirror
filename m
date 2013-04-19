From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 6/6] grep: obey --textconv for the case rev:path
Date: Fri, 19 Apr 2013 18:44:49 +0200
Message-ID: <717ec305e9bd056a44b1da5cc478d314db2920e5.1366389739.git.git@drmicha.warpmail.net>
References: <cover.1366389739.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 19 18:45:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTERg-0000Ao-3C
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 18:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031151Ab3DSQpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 12:45:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54703 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030840Ab3DSQps (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Apr 2013 12:45:48 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 345A420AAE
	for <git@vger.kernel.org>; Fri, 19 Apr 2013 12:45:48 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 19 Apr 2013 12:45:48 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=wEqAqIasMmk3V37z06uQr5Hq9
	wQ=; b=fJ+6XsbQUIeCwP4gIl92WcrWwaHrQ9mbO5BjRkAsYgw4oBXf4DBto2EPU
	pkDukCEdHFW68fIfwxmZicuQFO/BOZ0ZxMl2nCIBB1RP4BSxeUxemiEOSm4+EjoI
	XO2aaWV2rNuivIir/A6swiyt11909a/VqMR8edG6/sXvrFke0s=
X-Sasl-enc: VlEVKl5D6DNByKneyEvPWKEKxn1VWSEBwS8TUxr2LggY 1366389947
Received: from localhost (unknown [46.115.51.241])
	by mail.messagingengine.com (Postfix) with ESMTPA id AD2D520006A;
	Fri, 19 Apr 2013 12:45:47 -0400 (EDT)
X-Mailer: git-send-email 1.8.2.1.728.ge98e8b0
In-Reply-To: <cover.1366389739.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221776>

Make "grep" obey the "--textconv" option also for the object case, i.e.
when used with an argument "rev:path".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c         | 11 ++++++-----
 object.c               | 26 ++++++++++++++++++++------
 object.h               |  2 ++
 t/t7008-grep-binary.sh |  6 ++++--
 4 files changed, 32 insertions(+), 13 deletions(-)

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
index a7fe94a..ef78abe 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -174,8 +174,10 @@ test_expect_success 'grep blob does not obey textconv' '
 	test_must_fail git grep Qfile HEAD:a
 '
 
-test_expect_success 'grep --textconv blob does not obey textconv' '
-	test_must_fail git grep --textconv Qfile HEAD:a
+test_expect_success 'grep --textconv blob does obey textconv' '
+	echo "HEAD:a:binaryQfile" >expect &&
+	git grep --textconv Qfile HEAD:a >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'grep --no-textconv blob does not obey textconv' '
-- 
1.8.2.1.728.ge98e8b0
