Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF72620969
	for <e@80x24.org>; Thu, 30 Mar 2017 18:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934208AbdC3S0L (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 14:26:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:54293 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933378AbdC3S0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 14:26:10 -0400
Received: (qmail 21351 invoked by uid 109); 30 Mar 2017 18:26:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 18:26:07 +0000
Received: (qmail 1088 invoked by uid 111); 30 Mar 2017 18:26:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 30 Mar 2017 14:26:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Mar 2017 14:26:05 -0400
Date:   Thu, 30 Mar 2017 14:26:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/18] snprintf cleanups
Message-ID: <20170330182605.ymsr7bjhfdh4ao6a@sigill.intra.peff.net>
References: <20170328194255.vf7nfzzmmzxsbn36@sigill.intra.peff.net>
 <xmqq60itc9pv.fsf@gitster.mtv.corp.google.com>
 <20170329034105.bfgh4tutgrmjp2lc@sigill.intra.peff.net>
 <xmqqr31gax0y.fsf@gitster.mtv.corp.google.com>
 <20170330062730.ycsok7skrjy5c6en@sigill.intra.peff.net>
 <xmqqr31e65kb.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr31e65kb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 10:24:36AM -0700, Junio C Hamano wrote:

> > I'm OK either with the series I posted, or wrapping up the alternative
> > in a commit message.
> 
> I do find the updated one easier to follow (if anything it is more
> compact); I do not think it is worth a reroll, but it is easy enough
> to replace the patch part of the original with the updated patch and
> tweak "it's easy to fix by moving to a strbuf" in its log message to
> something like "But it's easy to eliminate the allocation with a few
> helper functions, and it makes the result easier to follow", so I am
> tempted to go that route myself...

Yeah, I think that's all that would be needed. Here it is wrapped up as
a patch:

-- >8 --
Subject: [PATCH] diff: avoid fixed-size buffer for patch-ids

To generate a patch id, we format the diff header into a
fixed-size buffer, and then feed the result to our sha1
computation. The fixed buffer has size '4*PATH_MAX + 20',
which in theory accommodates the four filenames plus some
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

We could fix this by moving to a strbuf. However, we can
observe that the purpose of formatting this in the first
place is to feed it to git_SHA1_Update(). So instead, let's
just feed each part of the formatted string directly. This
actually ends up more readable, and we can even factor out
some duplicated bits from the various conditional branches.

Technically this may change the output of patch-id for very
long filenames, but it's not worth making an exception for
this in the --stable output. It was a bug, and one that only
affected an unlikely set of paths.  And anyway, the exact
value would have varied from platform to platform depending
on the value of PATH_MAX, so there is no "stable" value.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 68 ++++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/diff.c b/diff.c
index 58cb72d7e..92d78e459 100644
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
-- 
2.12.2.922.g77065305a

