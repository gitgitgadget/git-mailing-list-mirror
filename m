Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C47C72021E
	for <e@80x24.org>; Fri, 19 May 2017 12:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdESMyq (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:54:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:54830 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdESMyq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:54:46 -0400
Received: (qmail 2710 invoked by uid 109); 19 May 2017 12:54:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:54:45 +0000
Received: (qmail 27822 invoked by uid 111); 19 May 2017 12:55:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:55:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:54:43 -0400
Date:   Fri, 19 May 2017 08:54:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 08/15] get_sha1_with_context: dynamically allocate oc->path
Message-ID: <20170519125443.7fknotkezbpfwdht@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a sha1 lookup returns the tree path via "struct
object_context", it just copies it into a fixed-size buffer.
This means the result can be truncated, and it means our
"struct object_context" consumes a lot of stack space.

Instead, let's allocate a string on the heap. Because most
callers don't care about this information, we'll avoid doing
it by default (so they don't all have to start calling
free() on the result). There are basically two options for
the caller to signal to us that it's interested:

  1. By setting a pointer to storage in the object_context.

  2. By passing a flag in another parameter.

Doing (1) would match the way that sha1_object_info_extended()
works. But it would mean that every caller would have to
initialize the object_context, which they don't currently
have to do.

This patch does (2), and adds a new bit to the function's
flags field. All of the callers that look at the "path"
field are updated to pass the new flag.

Signed-off-by: Jeff King <peff@peff.net>
---
If there's a topic in flight that adds a new call without the flag, note
that it will stop filling the "path" field (which is what most calls
would want). And you won't get a compile error, because the pointer can
be used in largely the same way as the array.

I find it unlikely that there's a case that would care, but if we wanted
to be really paranoid, we could change the name of oc->path (at the cost
of making this diff much noisier).

 builtin/cat-file.c |  4 +++-
 builtin/grep.c     |  4 +++-
 builtin/log.c      | 10 +++++++---
 cache.h            |  8 +++++++-
 sha1_name.c        |  6 ++++--
 5 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1890d7a63..421709517 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -61,7 +61,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 	if (unknown_type)
 		flags |= LOOKUP_UNKNOWN_OBJECT;
 
-	if (get_sha1_with_context(obj_name, 0, oid.hash, &obj_context))
+	if (get_sha1_with_context(obj_name, GET_SHA1_RECORD_PATH,
+				  oid.hash, &obj_context))
 		die("Not a valid object name %s", obj_name);
 
 	if (!path)
@@ -165,6 +166,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		die("git cat-file %s: bad file", obj_name);
 
 	write_or_die(1, buf, size);
+	free(obj_context.path);
 	return 0;
 }
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 3ffb5b4e8..254c1c784 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1190,7 +1190,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			break;
 		}
 
-		if (get_sha1_with_context(arg, 0, oid.hash, &oc)) {
+		if (get_sha1_with_context(arg, GET_SHA1_RECORD_PATH,
+					  oid.hash, &oc)) {
 			if (seen_dashdash)
 				die(_("unable to resolve revision: %s"), arg);
 			break;
@@ -1200,6 +1201,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		if (!seen_dashdash)
 			verify_non_filename(prefix, arg);
 		add_object_array_with_path(object, arg, &list, oc.mode, oc.path);
+		free(oc.path);
 	}
 
 	/*
diff --git a/builtin/log.c b/builtin/log.c
index fd3d10ec2..a0d5233dc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -483,16 +483,20 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
-	if (get_sha1_with_context(obj_name, 0, oidc.hash, &obj_context))
+	if (get_sha1_with_context(obj_name, GET_SHA1_RECORD_PATH,
+				  oidc.hash, &obj_context))
 		die(_("Not a valid object name %s"), obj_name);
-	if (!obj_context.path[0] ||
-	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size))
+	if (!obj_context.path ||
+	    !textconv_object(obj_context.path, obj_context.mode, &oidc, 1, &buf, &size)) {
+		free(obj_context.path);
 		return stream_blob_to_fd(1, oid, NULL, 0);
+	}
 
 	if (!buf)
 		die(_("git show %s: bad file"), obj_name);
 
 	write_or_die(1, buf, size);
+	free(obj_context.path);
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index 656341b8e..e219c45ed 100644
--- a/cache.h
+++ b/cache.h
@@ -1333,13 +1333,18 @@ static inline int hex2chr(const char *s)
 
 struct object_context {
 	unsigned char tree[20];
-	char path[PATH_MAX];
 	unsigned mode;
 	/*
 	 * symlink_path is only used by get_tree_entry_follow_symlinks,
 	 * and only for symlinks that point outside the repository.
 	 */
 	struct strbuf symlink_path;
+	/*
+	 * If GET_SHA1_RECORD_PATH is set, this will record path (if any)
+	 * found when resolving the name. The caller is responsible for
+	 * releasing the memory.
+	 */
+	char *path;
 };
 
 #define GET_SHA1_QUIETLY           01
@@ -1349,6 +1354,7 @@ struct object_context {
 #define GET_SHA1_TREEISH          020
 #define GET_SHA1_BLOB             040
 #define GET_SHA1_FOLLOW_SYMLINKS 0100
+#define GET_SHA1_RECORD_PATH     0200
 #define GET_SHA1_ONLY_TO_DIE    04000
 
 #define GET_SHA1_DISAMBIGUATORS \
diff --git a/sha1_name.c b/sha1_name.c
index 35b16efc6..70f096749 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -1550,7 +1550,8 @@ static int get_sha1_with_context_1(const char *name,
 			namelen = strlen(cp);
 		}
 
-		strlcpy(oc->path, cp, sizeof(oc->path));
+		if (flags & GET_SHA1_RECORD_PATH)
+			oc->path = xstrdup(cp);
 
 		if (!active_cache)
 			read_cache();
@@ -1613,7 +1614,8 @@ static int get_sha1_with_context_1(const char *name,
 				}
 			}
 			hashcpy(oc->tree, tree_sha1);
-			strlcpy(oc->path, filename, sizeof(oc->path));
+			if (flags & GET_SHA1_RECORD_PATH)
+				oc->path = xstrdup(filename);
 
 			free(new_filename);
 			return ret;
-- 
2.13.0.219.g63f6bc368

