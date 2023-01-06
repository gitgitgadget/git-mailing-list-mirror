Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEDEC5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 11:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjAFLFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjAFLFC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 06:05:02 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B84C6E0D2
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 03:05:01 -0800 (PST)
Received: (qmail 14016 invoked by uid 109); 6 Jan 2023 11:05:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 11:05:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13298 invoked by uid 111); 6 Jan 2023 11:05:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 06:05:05 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 06:05:00 -0500
From:   Jeff King <peff@peff.net>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] diff: drop "name" parameter from prepare_temp_file()
Message-ID: <Y7gAXK9GQ/XIY19e@coredump.intra.peff.net>
References: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The prepare_temp_file() function takes a diff_filespec as well as a
filename. But it is almost certainly an error to pass in a name that
isn't the filespec's "path" parameter, since that is the only thing that
reliably tells us how to find the content (and indeed, this was the
source of a recently-fixed bug).

So let's drop the redundant "name" parameter and just use one->path
throughout the function. This simplifies the interface a little bit, and
makes it impossible for calling code to get it wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 72bed1d0a3..329eebf16a 100644
--- a/diff.c
+++ b/diff.c
@@ -4213,7 +4213,6 @@ static void prep_temp_blob(struct index_state *istate,
 }
 
 static struct diff_tempfile *prepare_temp_file(struct repository *r,
-					       const char *name,
 					       struct diff_filespec *one)
 {
 	struct diff_tempfile *temp = claim_diff_tempfile();
@@ -4231,18 +4230,18 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 
 	if (!S_ISGITLINK(one->mode) &&
 	    (!one->oid_valid ||
-	     reuse_worktree_file(r->index, name, &one->oid, 1))) {
+	     reuse_worktree_file(r->index, one->path, &one->oid, 1))) {
 		struct stat st;
-		if (lstat(name, &st) < 0) {
+		if (lstat(one->path, &st) < 0) {
 			if (errno == ENOENT)
 				goto not_a_valid_file;
-			die_errno("stat(%s)", name);
+			die_errno("stat(%s)", one->path);
 		}
 		if (S_ISLNK(st.st_mode)) {
 			struct strbuf sb = STRBUF_INIT;
-			if (strbuf_readlink(&sb, name, st.st_size) < 0)
-				die_errno("readlink(%s)", name);
-			prep_temp_blob(r->index, name, temp, sb.buf, sb.len,
+			if (strbuf_readlink(&sb, one->path, st.st_size) < 0)
+				die_errno("readlink(%s)", one->path);
+			prep_temp_blob(r->index, one->path, temp, sb.buf, sb.len,
 				       (one->oid_valid ?
 					&one->oid : null_oid()),
 				       (one->oid_valid ?
@@ -4251,7 +4250,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 		}
 		else {
 			/* we can borrow from the file in the work tree */
-			temp->name = name;
+			temp->name = one->path;
 			if (!one->oid_valid)
 				oid_to_hex_r(temp->hex, null_oid());
 			else
@@ -4269,7 +4268,7 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 	else {
 		if (diff_populate_filespec(r, one, NULL))
 			die("cannot read data blob for %s", one->path);
-		prep_temp_blob(r->index, name, temp,
+		prep_temp_blob(r->index, one->path, temp,
 			       one->data, one->size,
 			       &one->oid, one->mode);
 	}
@@ -4280,7 +4279,7 @@ static void add_external_diff_name(struct repository *r,
 				   struct strvec *argv,
 				   struct diff_filespec *df)
 {
-	struct diff_tempfile *temp = prepare_temp_file(r, df->path, df);
+	struct diff_tempfile *temp = prepare_temp_file(r, df);
 	strvec_push(argv, temp->name);
 	strvec_push(argv, temp->hex);
 	strvec_push(argv, temp->mode);
@@ -7031,7 +7030,7 @@ static char *run_textconv(struct repository *r,
 	struct strbuf buf = STRBUF_INIT;
 	int err = 0;
 
-	temp = prepare_temp_file(r, spec->path, spec);
+	temp = prepare_temp_file(r, spec);
 	strvec_push(&child.args, pgm);
 	strvec_push(&child.args, temp->name);
 
-- 
2.39.0.463.g3774f23bc9
