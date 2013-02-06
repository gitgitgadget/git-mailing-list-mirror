From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [RFC/PATCH 4/4] grep: obey --textconv for the case rev:path
Date: Wed,  6 Feb 2013 16:08:53 +0100
Message-ID: <a2808975f00bac5de0902e6830f254e4b064e8a5.1360162813.git.git@drmicha.warpmail.net>
References: <20130205201106.GA29248@sigill.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 06 16:09:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36cr-0003Fu-N8
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:09:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755959Ab3BFPJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:09:03 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44338 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755989Ab3BFPI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2013 10:08:59 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E1D4E215EA;
	Wed,  6 Feb 2013 10:08:58 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 06 Feb 2013 10:08:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=bZ
	CHngoTSjOxEpniXKKnV/70E+0=; b=Ifao5jv2m9cw+E9TE1fJ4mQ56Vs+8CQOIf
	XTvvGn9D2K2vFmQyQmVJcKSl9/AnRsWfGyIJ114dIOTXkrANXv5DLSAblO5z4ZcY
	yyJ3sQSRiefQQdiS64Ywc6M2123M99iexJqkorBSin2NgbEdoFb7+ndMxEf0VtKJ
	5+C6NU7W8=
X-Sasl-enc: DH02JHFYboMNeYij8CKnisFyfIHL24NQmaVQrAk4bRkt 1360163338
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5D9BA4827DE;
	Wed,  6 Feb 2013 10:08:58 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.752.g32d147e
In-Reply-To: <20130205201106.GA29248@sigill.intra.peff.net>
In-Reply-To: <cover.1360162813.git.git@drmicha.warpmail.net>
References: <cover.1360162813.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215584>

Make "grep" obey the "--textconv" option also for the object case, i.e.
when used with an argument "rev:path".

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/grep.c | 11 ++++++-----
 object.c       | 26 ++++++++++++++++++++------
 object.h       |  2 ++
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 915c8ef..0f3c4db 100644
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
@@ -820,14 +820,15 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	for (i = 0; i < argc; i++) {
 		const char *arg = argv[i];
 		unsigned char sha1[20];
+		struct object_context oc;
 		/* Is it a rev? */
-		if (!get_sha1(arg, sha1)) {
+		if (!get_sha1_with_context(arg, 0, sha1, &oc)) {
 			struct object *object = parse_object(sha1);
 			if (!object)
 				die(_("bad object %s"), arg);
 			if (!seen_dashdash)
 				verify_non_filename(prefix, arg);
-			add_object_array(object, arg, &list);
+			add_object_array_with_context(object, arg, &list, xmemdupz(&oc, sizeof(struct object_context)));
 			continue;
 		}
 		if (!strcmp(arg, "--")) {
diff --git a/object.c b/object.c
index 4af3451..1b796c7 100644
--- a/object.c
+++ b/object.c
@@ -245,12 +245,7 @@ int object_list_contains(struct object_list *list, struct object *obj)
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
@@ -265,9 +260,28 @@ void add_object_array_with_mode(struct object *obj, const char *name, struct obj
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
index 6a97b6b..a11d719 100644
--- a/object.h
+++ b/object.h
@@ -13,6 +13,7 @@ struct object_array {
 		struct object *item;
 		const char *name;
 		unsigned mode;
+		struct object_context *context;
 	} *objects;
 };
 
@@ -74,6 +75,7 @@ int object_list_contains(struct object_list *list, struct object *obj);
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
 void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
+void add_object_array_with_context(struct object *obj, const char *name, struct object_array *array, struct object_context *context);
 void object_array_remove_duplicates(struct object_array *);
 
 void clear_object_flags(unsigned flags);
-- 
1.8.1.2.752.g32d147e
