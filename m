Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10B3D1F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 04:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbdAZELD (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 23:11:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:45103 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdAZELD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 23:11:03 -0500
Received: (qmail 31123 invoked by uid 109); 26 Jan 2017 04:11:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 04:11:03 +0000
Received: (qmail 20088 invoked by uid 111); 26 Jan 2017 04:11:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 23:11:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 23:11:00 -0500
Date:   Wed, 25 Jan 2017 23:11:00 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] fsck: move typename() printing to its own function
Message-ID: <20170126041100.nndm45ha6yviiugk@sigill.intra.peff.net>
References: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126041025.hqg3znwew7jxgxxg@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an object has a problem, we mention its type. But we do
so by feeding the result of typename() directly to
fprintf(). This is potentially dangerous because typename()
can return NULL for some type values (like OBJ_NONE).

It's doubtful that this can be triggered in practice with
the current code, so this is probably not fixing a bug. But
it future-proofs us against modifications that make things
like OBJ_NONE more likely (and gives future patches a
central point to handle them).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 57f529b41..3d5ced2d3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -56,6 +56,17 @@ static const char *describe_object(struct object *obj)
 	return buf.buf;
 }
 
+static const char *printable_type(struct object *obj)
+{
+	const char *ret;
+
+	ret = typename(obj->type);
+	if (!ret)
+		ret = "unknown";
+
+	return ret;
+}
+
 static int fsck_config(const char *var, const char *value, void *cb)
 {
 	if (strcmp(var, "fsck.skiplist") == 0) {
@@ -83,7 +94,7 @@ static void objreport(struct object *obj, const char *msg_type,
 			const char *err)
 {
 	fprintf(stderr, "%s in %s %s: %s\n",
-		msg_type, typename(obj->type), describe_object(obj), err);
+		msg_type, printable_type(obj), describe_object(obj), err);
 }
 
 static int objerror(struct object *obj, const char *err)
@@ -114,7 +125,7 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!obj) {
 		/* ... these references to parent->fld are safe here */
 		printf("broken link from %7s %s\n",
-			   typename(parent->type), describe_object(parent));
+			   printable_type(parent), describe_object(parent));
 		printf("broken link from %7s %s\n",
 			   (type == OBJ_ANY ? "unknown" : typename(type)), "unknown");
 		errors_found |= ERROR_REACHABLE;
@@ -131,9 +142,9 @@ static int mark_object(struct object *obj, int type, void *data, struct fsck_opt
 	if (!(obj->flags & HAS_OBJ)) {
 		if (parent && !has_object_file(&obj->oid)) {
 			printf("broken link from %7s %s\n",
-				 typename(parent->type), describe_object(parent));
+				 printable_type(parent), describe_object(parent));
 			printf("              to %7s %s\n",
-				 typename(obj->type), describe_object(obj));
+				 printable_type(obj), describe_object(obj));
 			errors_found |= ERROR_REACHABLE;
 		}
 		return 1;
@@ -205,7 +216,7 @@ static void check_reachable_object(struct object *obj)
 	if (!(obj->flags & HAS_OBJ)) {
 		if (has_sha1_pack(obj->oid.hash))
 			return; /* it is in pack - forget about it */
-		printf("missing %s %s\n", typename(obj->type),
+		printf("missing %s %s\n", printable_type(obj),
 			describe_object(obj));
 		errors_found |= ERROR_REACHABLE;
 		return;
@@ -231,7 +242,7 @@ static void check_unreachable_object(struct object *obj)
 	 * since this is something that is prunable.
 	 */
 	if (show_unreachable) {
-		printf("unreachable %s %s\n", typename(obj->type),
+		printf("unreachable %s %s\n", printable_type(obj),
 			describe_object(obj));
 		return;
 	}
@@ -250,7 +261,7 @@ static void check_unreachable_object(struct object *obj)
 	 */
 	if (!obj->used) {
 		if (show_dangling)
-			printf("dangling %s %s\n", typename(obj->type),
+			printf("dangling %s %s\n", printable_type(obj),
 			       describe_object(obj));
 		if (write_lost_and_found) {
 			char *filename = git_pathdup("lost-found/%s/%s",
@@ -324,7 +335,7 @@ static int fsck_obj(struct object *obj)
 
 	if (verbose)
 		fprintf(stderr, "Checking %s %s\n",
-			typename(obj->type), describe_object(obj));
+			printable_type(obj), describe_object(obj));
 
 	if (fsck_walk(obj, NULL, &fsck_obj_options))
 		objerror(obj, "broken links");
@@ -350,7 +361,7 @@ static int fsck_obj(struct object *obj)
 		struct tag *tag = (struct tag *) obj;
 
 		if (show_tags && tag->tagged) {
-			printf("tagged %s %s", typename(tag->tagged->type),
+			printf("tagged %s %s", printable_type(tag->tagged),
 				describe_object(tag->tagged));
 			printf(" (%s) in %s\n", tag->tag,
 				describe_object(&tag->object));
-- 
2.11.0.840.gd37c5973a

