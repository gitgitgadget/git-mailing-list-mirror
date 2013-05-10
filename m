From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 7/7] grep: honor --textconv for the case rev:path
Date: Fri, 10 May 2013 17:10:16 +0200
Message-ID: <dd973eae534bed5f7106d54e06c7c2172595f402.1368197380.git.git@drmicha.warpmail.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 10 17:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaozD-0007Em-Di
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 17:11:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab3EJPLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 11:11:48 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45656 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754965Ab3EJPLq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 May 2013 11:11:46 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 02F0220B25;
	Fri, 10 May 2013 11:11:42 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 10 May 2013 11:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=oF
	BUcUMtuTW0bo+H2FW/igLuOnE=; b=sBfNpio22oKnsgi3EpoL4nSuemi16cGLuK
	G6gWtifQF9TsPnviTQnGwdq4AkU3OjbN4TMi8/aPAiamNlCFphXM3dBLQSIic81K
	+CW+9p+7K1Bm9q7OjSCT9J+TAsct3P6qyYDGUOrh38VxsfKSuRc6iLGB+7YCDRPn
	geUnb/l9g=
X-Sasl-enc: nFfaZWXr3LZpuoC/zrjhChXJ+X1nDEEW//yozyycWuh3 1368198701
Received: from localhost (unknown [213.221.117.228])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7CDF320016E;
	Fri, 10 May 2013 11:11:41 -0400 (EDT)
X-Mailer: git-send-email 1.8.3.rc1.406.gf4dce7e
In-Reply-To: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1368197380.git.git@drmicha.warpmail.net>
References: <cover.1368197380.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223868>

Make "grep" honor the "--textconv" option also for the object case, i.e.
when used with an argument "rev:path".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c         | 11 ++++++-----
 object.c               | 26 ++++++++++++++++++++------
 object.h               |  2 ++
 t/t7008-grep-binary.sh |  6 +-----
 4 files changed, 29 insertions(+), 16 deletions(-)

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
index 88d0bec..264b6df 100644
--- a/object.c
+++ b/object.c
@@ -265,12 +265,7 @@ int object_list_contains(struct object_list *list, struct object *obj)
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
@@ -285,9 +280,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
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
index a91260a..b146406 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -170,14 +170,10 @@ test_expect_success 'grep --no-textconv does not honor textconv' '
 	test_must_fail git grep --no-textconv Qfile
 '
 
-test_expect_failure 'grep --textconv blob honors textconv' '
+test_expect_success 'grep --textconv blob honors textconv' '
 	echo "HEAD:a:binaryQfile" >expect &&
 	git grep --textconv Qfile HEAD:a >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'grep --no-textconv blob does not honor textconv' '
-	test_must_fail git grep --no-textconv Qfile HEAD:a
-'
-
 test_done
-- 
1.8.3.rc1.406.gf4dce7e
