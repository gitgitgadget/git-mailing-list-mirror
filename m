Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4887DEB64DD
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGCGo3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjGCGoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383A109
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:19 -0700 (PDT)
Received: (qmail 14067 invoked by uid 109); 3 Jul 2023 06:44:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2631 invoked by uid 111); 3 Jul 2023 06:44:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 08/14] fsck: mark unused parameters in various fsck callbacks
Message-ID: <20230703064418.GH3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few callback functions which are used with the fsck code,
but it's natural that not all callbacks need all parameters. For
reporting, even something as obvious as "the oid of the object which had
a problem" is not always used, as some callers are only checking a
single object in the first place. And for both reporting and walking,
things like void data pointers and the fsck_options aren't always
necessary.

But since each such parameter is used by _some_ callback, we have to
keep them in the interface. Mark the unused ones in specific callbacks
to avoid triggering -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fsck.c           | 10 +++++-----
 builtin/index-pack.c     |  3 ++-
 builtin/mktag.c          |  8 ++++----
 builtin/unpack-objects.c |  3 ++-
 fsck.c                   |  4 ++--
 object-file.c            | 10 +++++-----
 6 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index fa26462337..9af71a4e03 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -92,11 +92,11 @@ static int objerror(struct object *obj, const char *err)
 	return -1;
 }
 
-static int fsck_error_func(struct fsck_options *o,
+static int fsck_error_func(struct fsck_options *o UNUSED,
 			   const struct object_id *oid,
 			   enum object_type object_type,
 			   enum fsck_msg_type msg_type,
-			   enum fsck_msg_id msg_id,
+			   enum fsck_msg_id msg_id UNUSED,
 			   const char *message)
 {
 	switch (msg_type) {
@@ -121,7 +121,7 @@ static int fsck_error_func(struct fsck_options *o,
 static struct object_array pending;
 
 static int mark_object(struct object *obj, enum object_type type,
-		       void *data, struct fsck_options *options)
+		       void *data, struct fsck_options *options UNUSED)
 {
 	struct object *parent = data;
 
@@ -206,8 +206,8 @@ static int traverse_reachable(void)
 	return !!result;
 }
 
-static int mark_used(struct object *obj, enum object_type object_type,
-		     void *data, struct fsck_options *options)
+static int mark_used(struct object *obj, int type UNUSED,
+		     void *data UNUSED, struct fsck_options *options UNUSED)
 {
 	if (!obj)
 		return 1;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index c1250b070f..f6c2f0909d 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -223,7 +223,8 @@ static void cleanup_thread(void)
 }
 
 static int mark_link(struct object *obj, enum object_type type,
-		     void *data, struct fsck_options *options)
+		     void *data UNUSED,
+		     struct fsck_options *options UNUSED)
 {
 	if (!obj)
 		return -1;
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 43e2766db4..d8e0b5afc0 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -18,11 +18,11 @@ static int option_strict = 1;
 
 static struct fsck_options fsck_options = FSCK_OPTIONS_STRICT;
 
-static int mktag_fsck_error_func(struct fsck_options *o,
-				 const struct object_id *oid,
-				 enum object_type object_type,
+static int mktag_fsck_error_func(struct fsck_options *o UNUSED,
+				 const struct object_id *oid UNUSED,
+				 enum object_type object_type UNUSED,
 				 enum fsck_msg_type msg_type,
-				 enum fsck_msg_id msg_id,
+				 enum fsck_msg_id msg_id UNUSED,
 				 const char *message)
 {
 	switch (msg_type) {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 1979532a9d..558b8485ba 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -214,7 +214,8 @@ static void write_cached_object(struct object *obj, struct obj_buffer *obj_buf)
  * Verify its reachability and validity recursively and write it out.
  */
 static int check_object(struct object *obj, enum object_type type,
-			void *data, struct fsck_options *options)
+			void *data UNUSED,
+			struct fsck_options *options UNUSED)
 {
 	struct obj_buffer *obj_buf;
 
diff --git a/fsck.c b/fsck.c
index a219d6f2c0..feba5239a4 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1307,9 +1307,9 @@ int fsck_buffer(const struct object_id *oid, enum object_type type,
 
 int fsck_error_function(struct fsck_options *o,
 			const struct object_id *oid,
-			enum object_type object_type,
+			enum object_type object_type UNUSED,
 			enum fsck_msg_type msg_type,
-			enum fsck_msg_id msg_id,
+			enum fsck_msg_id msg_id UNUSED,
 			const char *message)
 {
 	if (msg_type == FSCK_WARN) {
diff --git a/object-file.c b/object-file.c
index 8d87720dd5..68a2397e33 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2308,11 +2308,11 @@ int repo_has_object_file(struct repository *r,
  * report the minimal fsck error here, and rely on the caller to
  * give more context.
  */
-static int hash_format_check_report(struct fsck_options *opts,
-				     const struct object_id *oid,
-				     enum object_type object_type,
-				     enum fsck_msg_type msg_type,
-				     enum fsck_msg_id msg_id,
+static int hash_format_check_report(struct fsck_options *opts UNUSED,
+				     const struct object_id *oid UNUSED,
+				     enum object_type object_type UNUSED,
+				     enum fsck_msg_type msg_type UNUSED,
+				     enum fsck_msg_id msg_id UNUSED,
 				     const char *message)
 {
 	error(_("object fails fsck: %s"), message);
-- 
2.41.0.586.g3c0cc15bc7

