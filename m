Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3911A2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754695AbdESMz3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:55:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:54848 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751225AbdESMz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:55:28 -0400
Received: (qmail 2826 invoked by uid 109); 19 May 2017 12:55:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:55:28 +0000
Received: (qmail 27880 invoked by uid 111); 19 May 2017 12:56:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:56:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:55:26 -0400
Date:   Fri, 19 May 2017 08:55:26 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 11/15] handle_revision_arg: record paths for pending objects
Message-ID: <20170519125526.dxezhtsuib267byg@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the revision parser sees an argument like tree:path, we
parse it down to the correct blob (or tree), but throw away
the "path" portion. Let's ask get_sha1_with_context() to
record it, and pass it along in the pending array.

This will let programs like git-diff which rely on the
revision-parser show more accurate paths.

Note that the implementation is a little tricky; we have to
make sure we free oc.path in all code paths. For handle_dotdot(),
we can piggy-back on the existing cleanup-wrapper pattern.
The real work happens in handle_dotdot_1(), but the
handle_dotdot() wrapper makes sure that the path is freed no
matter how we exit the function (and for that reason we make
sure that the object_context struct is zero'd, so if we fail
to even get to the get_sha1_with_context() call, we just end
up calling free(NULL)).

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index 96427e3c2..a7b93dcc8 100644
--- a/revision.c
+++ b/revision.c
@@ -1443,16 +1443,17 @@ static int dotdot_missing(const char *arg, char *dotdot,
 
 static int handle_dotdot_1(const char *arg, char *dotdot,
 			   struct rev_info *revs, int flags,
-			   int cant_be_filename)
+			   int cant_be_filename,
+			   struct object_context *a_oc,
+			   struct object_context *b_oc)
 {
 	const char *a_name, *b_name;
 	struct object_id a_oid, b_oid;
 	struct object *a_obj, *b_obj;
-	struct object_context a_oc, b_oc;
 	unsigned int a_flags, b_flags;
 	int symmetric = 0;
 	unsigned int flags_exclude = flags ^ (UNINTERESTING | BOTTOM);
-	unsigned int oc_flags = GET_SHA1_COMMITTISH;
+	unsigned int oc_flags = GET_SHA1_COMMITTISH | GET_SHA1_RECORD_PATH;
 
 	a_name = arg;
 	if (!*a_name)
@@ -1466,8 +1467,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	if (!*b_name)
 		b_name = "HEAD";
 
-	if (get_sha1_with_context(a_name, oc_flags, a_oid.hash, &a_oc) ||
-	    get_sha1_with_context(b_name, oc_flags, b_oid.hash, &b_oc))
+	if (get_sha1_with_context(a_name, oc_flags, a_oid.hash, a_oc) ||
+	    get_sha1_with_context(b_name, oc_flags, b_oid.hash, b_oc))
 		return -1;
 
 	if (!cant_be_filename) {
@@ -1509,8 +1510,8 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	b_obj->flags |= b_flags;
 	add_rev_cmdline(revs, a_obj, a_name, REV_CMD_LEFT, a_flags);
 	add_rev_cmdline(revs, b_obj, b_name, REV_CMD_RIGHT, b_flags);
-	add_pending_object_with_mode(revs, a_obj, a_name, a_oc.mode);
-	add_pending_object_with_mode(revs, b_obj, b_name, b_oc.mode);
+	add_pending_object_with_path(revs, a_obj, a_name, a_oc->mode, a_oc->path);
+	add_pending_object_with_path(revs, b_obj, b_name, b_oc->mode, b_oc->path);
 	return 0;
 }
 
@@ -1518,16 +1519,24 @@ static int handle_dotdot(const char *arg,
 			 struct rev_info *revs, int flags,
 			 int cant_be_filename)
 {
+	struct object_context a_oc, b_oc;
 	char *dotdot = strstr(arg, "..");
 	int ret;
 
 	if (!dotdot)
 		return -1;
 
+	memset(&a_oc, 0, sizeof(a_oc));
+	memset(&b_oc, 0, sizeof(b_oc));
+
 	*dotdot = '\0';
-	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename);
+	ret = handle_dotdot_1(arg, dotdot, revs, flags, cant_be_filename,
+			      &a_oc, &b_oc);
 	*dotdot = '.';
 
+	free(a_oc.path);
+	free(b_oc.path);
+
 	return ret;
 }
 
@@ -1540,7 +1549,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	int local_flags;
 	const char *arg = arg_;
 	int cant_be_filename = revarg_opt & REVARG_CANNOT_BE_FILENAME;
-	unsigned get_sha1_flags = 0;
+	unsigned get_sha1_flags = GET_SHA1_RECORD_PATH;
 
 	flags = flags & UNINTERESTING ? flags | BOTTOM : flags & ~BOTTOM;
 
@@ -1591,7 +1600,7 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 	}
 
 	if (revarg_opt & REVARG_COMMITTISH)
-		get_sha1_flags = GET_SHA1_COMMITTISH;
+		get_sha1_flags |= GET_SHA1_COMMITTISH;
 
 	if (get_sha1_with_context(arg, get_sha1_flags, sha1, &oc))
 		return revs->ignore_missing ? 0 : -1;
@@ -1599,7 +1608,8 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 		verify_non_filename(revs->prefix, arg);
 	object = get_reference(revs, arg, sha1, flags ^ local_flags);
 	add_rev_cmdline(revs, object, arg_, REV_CMD_REV, flags ^ local_flags);
-	add_pending_object_with_mode(revs, object, arg, oc.mode);
+	add_pending_object_with_path(revs, object, arg, oc.mode, oc.path);
+	free(oc.path);
 	return 0;
 }
 
-- 
2.13.0.219.g63f6bc368

