Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A66A1F4C4
	for <e@80x24.org>; Fri, 18 Oct 2019 04:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395281AbfJRE7a (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 00:59:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:51740 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727020AbfJRE7a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 00:59:30 -0400
Received: (qmail 9486 invoked by uid 109); 18 Oct 2019 04:59:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Oct 2019 04:59:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14413 invoked by uid 111); 18 Oct 2019 05:02:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2019 01:02:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Oct 2019 00:59:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 16/23] fsck: accept an oid instead of a "struct blob" for
 fsck_blob()
Message-ID: <20191018045928.GP17879@sigill.intra.peff.net>
References: <20191018044103.GA17625@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191018044103.GA17625@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't actually need any information from the object struct except its
oid (and the type, of course, but that's implicitly OBJ_BLOB). This
gives our callers more flexibility to drop the object structs, too.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fsck.c b/fsck.c
index 465247be71..6e9640a1a6 100644
--- a/fsck.c
+++ b/fsck.c
@@ -890,7 +890,7 @@ static int fsck_tag(struct tag *tag, const char *buffer,
 }
 
 struct fsck_gitmodules_data {
-	struct object *obj;
+	const struct object_id *oid;
 	struct fsck_options *options;
 	int ret;
 };
@@ -909,21 +909,21 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 	name = xmemdupz(subsection, subsection_len);
 	if (check_submodule_name(name) < 0)
 		data->ret |= report(data->options,
-				    &data->obj->oid, data->obj->type,
+				    data->oid, OBJ_BLOB,
 				    FSCK_MSG_GITMODULES_NAME,
 				    "disallowed submodule name: %s",
 				    name);
 	if (!strcmp(key, "url") && value &&
 	    looks_like_command_line_option(value))
 		data->ret |= report(data->options,
-				    &data->obj->oid, data->obj->type,
+				    data->oid, OBJ_BLOB,
 				    FSCK_MSG_GITMODULES_URL,
 				    "disallowed submodule url: %s",
 				    value);
 	if (!strcmp(key, "path") && value &&
 	    looks_like_command_line_option(value))
 		data->ret |= report(data->options,
-				    &data->obj->oid, data->obj->type,
+				    data->oid, OBJ_BLOB,
 				    FSCK_MSG_GITMODULES_PATH,
 				    "disallowed submodule path: %s",
 				    value);
@@ -932,17 +932,17 @@ static int fsck_gitmodules_fn(const char *var, const char *value, void *vdata)
 	return 0;
 }
 
-static int fsck_blob(struct blob *blob, const char *buf,
+static int fsck_blob(const struct object_id *oid, const char *buf,
 		     unsigned long size, struct fsck_options *options)
 {
 	struct fsck_gitmodules_data data;
 	struct config_options config_opts = { 0 };
 
-	if (!oidset_contains(&gitmodules_found, &blob->object.oid))
+	if (!oidset_contains(&gitmodules_found, oid))
 		return 0;
-	oidset_insert(&gitmodules_done, &blob->object.oid);
+	oidset_insert(&gitmodules_done, oid);
 
-	if (object_on_skiplist(options, &blob->object.oid))
+	if (object_on_skiplist(options, oid))
 		return 0;
 
 	if (!buf) {
@@ -951,18 +951,18 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		 * blob too gigantic to load into memory. Let's just consider
 		 * that an error.
 		 */
-		return report(options, &blob->object.oid, blob->object.type,
+		return report(options, oid, OBJ_BLOB,
 			      FSCK_MSG_GITMODULES_LARGE,
 			      ".gitmodules too large to parse");
 	}
 
-	data.obj = &blob->object;
+	data.oid = oid;
 	data.options = options;
 	data.ret = 0;
 	config_opts.error_action = CONFIG_ERROR_SILENT;
 	if (git_config_from_mem(fsck_gitmodules_fn, CONFIG_ORIGIN_BLOB,
 				".gitmodules", buf, size, &data, &config_opts))
-		data.ret |= report(options, &blob->object.oid, blob->object.type,
+		data.ret |= report(options, oid, OBJ_BLOB,
 				   FSCK_MSG_GITMODULES_PARSE,
 				   "could not parse gitmodules blob");
 
@@ -976,7 +976,7 @@ int fsck_object(struct object *obj, void *data, unsigned long size,
 		return report(options, NULL, OBJ_NONE, FSCK_MSG_BAD_OBJECT_SHA1, "no valid object to fsck");
 
 	if (obj->type == OBJ_BLOB)
-		return fsck_blob((struct blob *)obj, data, size, options);
+		return fsck_blob(&obj->oid, data, size, options);
 	if (obj->type == OBJ_TREE)
 		return fsck_tree((struct tree *) obj, data, size, options);
 	if (obj->type == OBJ_COMMIT)
@@ -1042,7 +1042,7 @@ int fsck_finish(struct fsck_options *options)
 		}
 
 		if (type == OBJ_BLOB)
-			ret |= fsck_blob(blob, buf, size, options);
+			ret |= fsck_blob(&blob->object.oid, buf, size, options);
 		else
 			ret |= report(options,
 				      &blob->object.oid, blob->object.type,
-- 
2.23.0.1228.gee29b05929

