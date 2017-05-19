Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E265D2021E
	for <e@80x24.org>; Fri, 19 May 2017 12:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754977AbdESM5o (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 May 2017 08:57:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:54857 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754936AbdESM5f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2017 08:57:35 -0400
Received: (qmail 2977 invoked by uid 109); 19 May 2017 12:57:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 12:57:32 +0000
Received: (qmail 27901 invoked by uid 111); 19 May 2017 12:58:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 May 2017 08:58:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 May 2017 08:57:30 -0400
Date:   Fri, 19 May 2017 08:57:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 12/15] diff: pass whole pending entry in blobinfo
Message-ID: <20170519125730.yakprrok7nom3kjh@sigill.intra.peff.net>
References: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170519124651.4q7waz75rmzfopgn@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When diffing blobs directly, git-diff picks the blobs out of
the rev_info's pending array and copies the relevant bits to
a custom "struct blobinfo". But the pending array entry
already has all of this information (and more, which we'll
use in future patches). Let's just pass the original entry
instead.

In practice, these two blobs are probably adjacent in the
revs->pending array, and we could just pass the whole array.
But the current code is careful to pick each blob out
separately and put it into another array, so we'll continue
to do so and make our own array-of-pointers.

Signed-off-by: Jeff King <peff@peff.net>
---
I looked into just passing "blob_a" and "blob_b", instead of passing an
array and letting the called functions decide how many elements
should be in it. But I don't know if we would ever want to handle
arbitrary numbers of blobs (e.g., n-way combined diffs). It would be a
step backwards in that case, so I decided not to.

 builtin/diff.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index d184aafab..8b276ae57 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -20,12 +20,6 @@
 #define DIFF_NO_INDEX_EXPLICIT 1
 #define DIFF_NO_INDEX_IMPLICIT 2
 
-struct blobinfo {
-	struct object_id oid;
-	const char *name;
-	unsigned mode;
-};
-
 static const char builtin_diff_usage[] =
 "git diff [<options>] [<commit> [<commit>]] [--] [<path>...]";
 
@@ -65,7 +59,7 @@ static void stuff_change(struct diff_options *opt,
 
 static int builtin_diff_b_f(struct rev_info *revs,
 			    int argc, const char **argv,
-			    struct blobinfo *blob)
+			    struct object_array_entry **blob)
 {
 	/* Blob vs file in the working tree*/
 	struct stat st;
@@ -84,12 +78,12 @@ static int builtin_diff_b_f(struct rev_info *revs,
 
 	diff_set_mnemonic_prefix(&revs->diffopt, "o/", "w/");
 
-	if (blob[0].mode == S_IFINVALID)
-		blob[0].mode = canon_mode(st.st_mode);
+	if (blob[0]->mode == S_IFINVALID)
+		blob[0]->mode = canon_mode(st.st_mode);
 
 	stuff_change(&revs->diffopt,
-		     blob[0].mode, canon_mode(st.st_mode),
-		     &blob[0].oid, &null_oid,
+		     blob[0]->mode, canon_mode(st.st_mode),
+		     &blob[0]->item->oid, &null_oid,
 		     1, 0,
 		     path, path);
 	diffcore_std(&revs->diffopt);
@@ -99,24 +93,24 @@ static int builtin_diff_b_f(struct rev_info *revs,
 
 static int builtin_diff_blobs(struct rev_info *revs,
 			      int argc, const char **argv,
-			      struct blobinfo *blob)
+			      struct object_array_entry **blob)
 {
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	if (blob[0].mode == S_IFINVALID)
-		blob[0].mode = mode;
+	if (blob[0]->mode == S_IFINVALID)
+		blob[0]->mode = mode;
 
-	if (blob[1].mode == S_IFINVALID)
-		blob[1].mode = mode;
+	if (blob[1]->mode == S_IFINVALID)
+		blob[1]->mode = mode;
 
 	stuff_change(&revs->diffopt,
-		     blob[0].mode, blob[1].mode,
-		     &blob[0].oid, &blob[1].oid,
+		     blob[0]->mode, blob[1]->mode,
+		     &blob[0]->item->oid, &blob[1]->item->oid,
 		     1, 1,
-		     blob[0].name, blob[1].name);
+		     blob[0]->name, blob[1]->name);
 	diffcore_std(&revs->diffopt);
 	diff_flush(&revs->diffopt);
 	return 0;
@@ -259,7 +253,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct object_array ent = OBJECT_ARRAY_INIT;
 	int blobs = 0, paths = 0;
-	struct blobinfo blob[2];
+	struct object_array_entry *blob[2];
 	int nongit = 0, no_index = 0;
 	int result = 0;
 
@@ -408,9 +402,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		} else if (obj->type == OBJ_BLOB) {
 			if (2 <= blobs)
 				die(_("more than two blobs given: '%s'"), name);
-			hashcpy(blob[blobs].oid.hash, obj->oid.hash);
-			blob[blobs].name = name;
-			blob[blobs].mode = entry->mode;
+			blob[blobs] = entry;
 			blobs++;
 
 		} else {
-- 
2.13.0.219.g63f6bc368

