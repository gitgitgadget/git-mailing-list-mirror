Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221C91F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409568AbfJRE6J (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:58:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:51716 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2409565AbfJRE6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:58:08 -0400
Received: (qmail 9459 invoked by uid 109); 18 Oct 2019 04:58:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:58:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14348 invoked by uid 111); 18 Oct 2019 05:01:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:01:13 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:58:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 12/23] fsck: don't require object structs for display
 functions
Message-ID: <20191018045807.GL17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our printable_type() and describe_object() functions take whole object
structs, but they really only care about the oid and type. Let's take
those individually in order to give our callers more flexibility.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 69 +++++++++++++++++++++++++++-----------------------
 1 file changed, 37 insertions(+), 32 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 66fa727c14..59c77c1baa 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -50,23 +50,20 @@ static int name_objects;
 #define ERROR_REFS 010
 #define ERROR_COMMIT_GRAPH 020
 
-static const char *describe_object(struct object *obj)
+static const char *describe_object(const struct object_id *oid)
 {
-	return fsck_describe_object(&fsck_walk_options, &obj->oid);
+	return fsck_describe_object(&fsck_walk_options, oid);
 }
 
-static const char *printable_type(struct object *obj)
+static const char *printable_type(const struct object_id *oid,
+				  enum object_type type)
 {
 	const char *ret;
 
-	if (obj->type == OBJ_NONE) {
-		enum object_type type = oid_object_info(the_repository,
-							&obj->oid, NULL);
-		if (type > 0)
-			object_as_type(the_repository, obj, type, 0);
-	}
+	if (type == OBJ_NONE)
+		type = oid_object_info(the_repository, oid, NULL);
 
-	ret = type_name(obj->type);
+	ret = type_name(type);
 	if (!ret)
 		ret = _("unknown");
 
@@ -101,7 +98,8 @@ static int objerror(struct object *obj, const char *err)
 	errors_found |= ERROR_OBJECT;
 	/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 	fprintf_ln(stderr, _("error in %s %s: %s"),
-		   printable_type(obj), describe_object(obj), err);
+		   printable_type(&obj->oid, obj->type),
+		   describe_object(&obj->oid), err);
 	return -1;
 }
 
@@ -112,12 +110,14 @@ static int fsck_error_func(struct fsck_options *o,
 	case FSCK_WARN:
 		/* TRANSLATORS: e.g. warning in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("warning in %s %s: %s"),
-			   printable_type(obj), describe_object(obj), message);
+			   printable_type(&obj->oid, obj->type),
+			   describe_object(&obj->oid), message);
 		return 0;
 	case FSCK_ERROR:
 		/* TRANSLATORS: e.g. error in tree 01bfda: <more explanation> */
 		fprintf_ln(stderr, _("error in %s %s: %s"),
-			   printable_type(obj), describe_object(obj), message);
+			   printable_type(&obj->oid, obj->type),
+			   describe_object(&obj->oid), message);
 		return 1;
 	default:
 		BUG("%d (FSCK_IGNORE?) should never trigger this callback", type);
@@ -138,7 +138,8 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf_ln(_("broken link from %7s %s"),
-			  printable_type(parent), describe_object(parent));
+			  printable_type(&parent->oid, parent->type),
+			  describe_object(&parent->oid));
 		printf_ln(_("broken link from %7s %s"),
 			  (type == OBJ_ANY ? _("unknown") : type_name(type)),
 			  _("unknown"));
@@ -166,10 +167,10 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 		if (parent && !has_object_file(&obj->oid)) {
 			printf_ln(_("broken link from %7s %s\n"
 				    "              to %7s %s"),
-				  printable_type(parent),
-				  describe_object(parent),
-				  printable_type(obj),
-				  describe_object(obj));
+				  printable_type(&parent->oid, parent->type),
+				  describe_object(&parent->oid),
+				  printable_type(&obj->oid, obj->type),
+				  describe_object(&obj->oid));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -275,8 +276,9 @@ static void check_reachable_object(struct object *obj)
 			return;
 		if (has_object_pack(&obj->oid))
 			return; /* it is in pack - forget about it */
-		printf_ln(_("missing %s %s"), printable_type(obj),
-			  describe_object(obj));
+		printf_ln(_("missing %s %s"),
+			  printable_type(&obj->oid, obj->type),
+			  describe_object(&obj->oid));
 		errors_found |= ERROR_REACHABLE;
 		return;
 	}
@@ -301,8 +303,9 @@ static void check_unreachable_object(struct object *obj)
 	 * since this is something that is prunable.
 	 */
 	if (show_unreachable) {
-		printf_ln(_("unreachable %s %s"), printable_type(obj),
-			  describe_object(obj));
+		printf_ln(_("unreachable %s %s"),
+			  printable_type(&obj->oid, obj->type),
+			  describe_object(&obj->oid));
 		return;
 	}
 
@@ -320,12 +323,13 @@ static void check_unreachable_object(struct object *obj)
 	 */
 	if (!(obj->flags & USED)) {
 		if (show_dangling)
-			printf_ln(_("dangling %s %s"), printable_type(obj),
-				  describe_object(obj));
+			printf_ln(_("dangling %s %s"),
+				  printable_type(&obj->oid, obj->type),
+				  describe_object(&obj->oid));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
 				obj->type == OBJ_COMMIT ? "commit" : "other",
-				describe_object(obj));
+				describe_object(&obj->oid));
 			FILE *f;
 
 			if (safe_create_leading_directories_const(filename)) {
@@ -338,7 +342,7 @@ static void check_unreachable_object(struct object *obj)
 				if (stream_blob_to_fd(fileno(f), &obj->oid, NULL, 1))
 					die_errno(_("could not write '%s'"), filename);
 			} else
-				fprintf(f, "%s\n", describe_object(obj));
+				fprintf(f, "%s\n", describe_object(&obj->oid));
 			if (fclose(f))
 				die_errno(_("could not finish '%s'"),
 					  filename);
@@ -357,7 +361,7 @@ static void check_unreachable_object(struct object *obj)
 static void check_object(struct object *obj)
 {
 	if (verbose)
-		fprintf_ln(stderr, _("Checking %s"), describe_object(obj));
+		fprintf_ln(stderr, _("Checking %s"), describe_object(&obj->oid));
 
 	if (obj->flags & REACHABLE)
 		check_reachable_object(obj);
@@ -415,7 +419,8 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 	if (verbose)
 		fprintf_ln(stderr, _("Checking %s %s"),
-			   printable_type(obj), describe_object(obj));
+			   printable_type(&obj->oid, obj->type),
+			   describe_object(&obj->oid));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, _("broken links"));
@@ -428,7 +433,7 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 		if (!commit->parents && show_root)
 			printf_ln(_("root %s"),
-				  describe_object(&commit->object));
+				  describe_object(&commit->object.oid));
 	}
 
 	if (obj->type == OBJ_TAG) {
@@ -436,10 +441,10 @@ static int fsck_obj(struct object *obj, void *buffer, unsigned long size)
 
 		if (show_tags && tag->tagged) {
 			printf_ln(_("tagged %s %s (%s) in %s"),
-				  printable_type(tag->tagged),
-				  describe_object(tag->tagged),
+				  printable_type(&tag->tagged->oid, tag->tagged->type),
+				  describe_object(&tag->tagged->oid),
 				  tag->tag,
-				  describe_object(&tag->object));
+				  describe_object(&tag->object.oid));
 		}
 	}
 
-- 
2.23.0.1228.gee29b05929

