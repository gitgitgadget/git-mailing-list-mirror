Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EF561FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755758AbdC1Tqh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:46:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:53157 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755680AbdC1Tqb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:46:31 -0400
Received: (qmail 11780 invoked by uid 109); 28 Mar 2017 19:46:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:46:20 +0000
Received: (qmail 4359 invoked by uid 111); 28 Mar 2017 19:46:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:46:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:46:18 -0400
Date:   Tue, 28 Mar 2017 15:46:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 04/18] diff: avoid fixed-size buffer for patch-ids
Message-ID: <20170328194618.injneju2d2fkghmk@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To generate a patch id, we format the diff header into a
fixed-size buffer, and then feed the result to our sha1
computation. The fixed buffer has size '4*PATH_MAX + 20',
which in theory accomodates the four filenames plus some
extra data. Except:

  1. The filenames may not be constrained to PATH_MAX. The
     static value may not be a real limit on the current
     filesystem. Moreover, we may compute patch-ids for
     names stored only in git, without touching the current
     filesystem at all.

  2. The 20 bytes is not nearly enough to cover the
     extra content we put in the buffer.

As a result, the data we feed to the sha1 computation may be
truncated, and it's possible that a commit with a very long
filename could erroneously collide in the patch-id space
with another commit. For instance, if one commit modified
"really-long-filename/foo" and another modified "bar" in the
same directory.

In practice this is unlikely. Because the filenames are
repeated, and because there's a single cutoff at the end of
the buffer, the offending filename would have to be on the
order of four times larger than PATH_MAX.

But it's easy to fix by moving to a strbuf.

Technically this may change the output of patch-id for very
long filenames, but it's not worth making an exception for
this in the --stable output. It was a bug, and one that only
affected an unlikely set of paths.  And anyway, the exact
value would have varied from platform to platform depending
on the value of PATH_MAX, so there is no "stable" value.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 58cb72d7e..89b5dc890 100644
--- a/diff.c
+++ b/diff.c
@@ -4577,7 +4577,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 	int i;
 	git_SHA_CTX ctx;
 	struct patch_id_t data;
-	char buffer[PATH_MAX * 4 + 20];
+	struct strbuf buffer = STRBUF_INIT;
 
 	git_SHA1_Init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
@@ -4607,10 +4607,11 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 		diff_fill_sha1_info(p->one);
 		diff_fill_sha1_info(p->two);
 
+		strbuf_reset(&buffer);
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
 		if (p->one->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
+			strbuf_addf(&buffer,
 					"diff--gita/%.*sb/%.*s"
 					"newfilemode%06o"
 					"---/dev/null"
@@ -4620,7 +4621,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 					p->two->mode,
 					len2, p->two->path);
 		else if (p->two->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
+			strbuf_addf(&buffer,
 					"diff--gita/%.*sb/%.*s"
 					"deletedfilemode%06o"
 					"---a/%.*s"
@@ -4630,7 +4631,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 					p->one->mode,
 					len1, p->one->path);
 		else
-			len1 = snprintf(buffer, sizeof(buffer),
+			strbuf_addf(&buffer,
 					"diff--gita/%.*sb/%.*s"
 					"---a/%.*s"
 					"+++b/%.*s",
@@ -4638,14 +4639,16 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 					len2, p->two->path,
 					len1, p->one->path,
 					len2, p->two->path);
-		git_SHA1_Update(&ctx, buffer, len1);
+		git_SHA1_Update(&ctx, buffer.buf, buffer.len);
 
 		if (diff_header_only)
 			continue;
 
 		if (fill_mmfile(&mf1, p->one) < 0 ||
-		    fill_mmfile(&mf2, p->two) < 0)
+		    fill_mmfile(&mf2, p->two) < 0) {
+			strbuf_release(&buffer);
 			return error("unable to read files to diff");
+		}
 
 		if (diff_filespec_is_binary(p->one) ||
 		    diff_filespec_is_binary(p->two)) {
@@ -4660,11 +4663,14 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 		xecfg.ctxlen = 3;
 		xecfg.flags = 0;
 		if (xdi_diff_outf(&mf1, &mf2, patch_id_consume, &data,
-				  &xpp, &xecfg))
+				  &xpp, &xecfg)) {
+			strbuf_release(&buffer);
 			return error("unable to generate patch-id diff for %s",
 				     p->one->path);
+		}
 	}
 
+	strbuf_release(&buffer);
 	git_SHA1_Final(sha1, &ctx);
 	return 0;
 }
-- 
2.12.2.845.g55fcf8b10

