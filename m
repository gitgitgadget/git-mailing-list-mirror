Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCC31FAFB
	for <e@80x24.org>; Tue, 28 Mar 2017 19:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932282AbdC1TvD (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 15:51:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:53205 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932243AbdC1TvD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 15:51:03 -0400
Received: (qmail 12094 invoked by uid 109); 28 Mar 2017 19:50:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 19:50:38 +0000
Received: (qmail 27762 invoked by uid 111); 28 Mar 2017 19:50:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Mar 2017 15:50:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Mar 2017 15:50:36 -0400
Date:   Tue, 28 Mar 2017 15:50:36 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: Re: [PATCH 04/18] diff: avoid fixed-size buffer for patch-ids
Message-ID: <20170328195035.ffeewnchhucwi5nj@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
 <20170328194618.injneju2d2fkghmk@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170328194618.injneju2d2fkghmk@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2017 at 03:46:18PM -0400, Jeff King wrote:

> As a result, the data we feed to the sha1 computation may be
> truncated, and it's possible that a commit with a very long
> filename could erroneously collide in the patch-id space
> with another commit. For instance, if one commit modified
> "really-long-filename/foo" and another modified "bar" in the
> same directory.
> 
> In practice this is unlikely. Because the filenames are
> repeated, and because there's a single cutoff at the end of
> the buffer, the offending filename would have to be on the
> order of four times larger than PATH_MAX.
> 
> But it's easy to fix by moving to a strbuf.

The other obvious solution is to avoid formatting the string entirely,
and just feed the pieces to the sha1 computation. Unfortunately that
still involves formatting the modes (into a fixed-size buffer!) since we
need the sha1 of their string representations.

That patch is below for reference. I'm not sure if it's more readable or
not.

---
diff --git a/diff.c b/diff.c
index a628ac3a9..435c734f4 100644
--- a/diff.c
+++ b/diff.c
@@ -4570,6 +4570,19 @@ static void patch_id_consume(void *priv, char *line, unsigned long len)
 	data->patchlen += new_len;
 }
 
+static void patch_id_add_string(git_SHA_CTX *ctx, const char *str)
+{
+	git_SHA1_Update(ctx, str, strlen(str));
+}
+
+static void patch_id_add_mode(git_SHA_CTX *ctx, unsigned mode)
+{
+	/* large enough for 2^32 in octal */
+	char buf[12];
+	int len = xsnprintf(buf, sizeof(buf), "%06o", mode);
+	git_SHA1_Update(ctx, buf, len);
+}
+
 /* returns 0 upon success, and writes result into sha1 */
 static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1, int diff_header_only)
 {
@@ -4577,7 +4590,6 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 	int i;
 	git_SHA_CTX ctx;
 	struct patch_id_t data;
-	char buffer[PATH_MAX * 4 + 20];
 
 	git_SHA1_Init(&ctx);
 	memset(&data, 0, sizeof(struct patch_id_t));
@@ -4609,36 +4621,30 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1,
 
 		len1 = remove_space(p->one->path, strlen(p->one->path));
 		len2 = remove_space(p->two->path, strlen(p->two->path));
-		if (p->one->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
-					"diff--gita/%.*sb/%.*s"
-					"newfilemode%06o"
-					"---/dev/null"
-					"+++b/%.*s",
-					len1, p->one->path,
-					len2, p->two->path,
-					p->two->mode,
-					len2, p->two->path);
-		else if (p->two->mode == 0)
-			len1 = snprintf(buffer, sizeof(buffer),
-					"diff--gita/%.*sb/%.*s"
-					"deletedfilemode%06o"
-					"---a/%.*s"
-					"+++/dev/null",
-					len1, p->one->path,
-					len2, p->two->path,
-					p->one->mode,
-					len1, p->one->path);
-		else
-			len1 = snprintf(buffer, sizeof(buffer),
-					"diff--gita/%.*sb/%.*s"
-					"---a/%.*s"
-					"+++b/%.*s",
-					len1, p->one->path,
-					len2, p->two->path,
-					len1, p->one->path,
-					len2, p->two->path);
-		git_SHA1_Update(&ctx, buffer, len1);
+		patch_id_add_string(&ctx, "diff--git");
+		patch_id_add_string(&ctx, "a/");
+		git_SHA1_Update(&ctx, p->one->path, len1);
+		patch_id_add_string(&ctx, "b/");
+		git_SHA1_Update(&ctx, p->two->path, len2);
+
+		if (p->one->mode == 0) {
+			patch_id_add_string(&ctx, "newfilemode");
+			patch_id_add_mode(&ctx, p->two->mode);
+			patch_id_add_string(&ctx, "---/dev/null");
+			patch_id_add_string(&ctx, "+++b/");
+			git_SHA1_Update(&ctx, p->two->path, len2);
+		} else if (p->two->mode == 0) {
+			patch_id_add_string(&ctx, "deletedfilemode");
+			patch_id_add_mode(&ctx, p->one->mode);
+			patch_id_add_string(&ctx, "---a/");
+			git_SHA1_Update(&ctx, p->one->path, len1);
+			patch_id_add_string(&ctx, "+++/dev/null");
+		} else {
+			patch_id_add_string(&ctx, "---a/");
+			git_SHA1_Update(&ctx, p->one->path, len1);
+			patch_id_add_string(&ctx, "+++b/");
+			git_SHA1_Update(&ctx, p->two->path, len2);
+		}
 
 		if (diff_header_only)
 			continue;
