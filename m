Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26021EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjGCGoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjGCGoN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:44:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08A6D2
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:44:12 -0700 (PDT)
Received: (qmail 14046 invoked by uid 109); 3 Jul 2023 06:44:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:44:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2622 invoked by uid 111); 3 Jul 2023 06:44:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:44:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:44:11 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/14] am: mark unused keep_cr parameters
Message-ID: <20230703064411.GE3537614@coredump.intra.peff.net>
References: <20230703064347.GA3524892@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703064347.GA3524892@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing the input, we have a "keep_cr" parameter to tell us how to
handle line endings. But this doesn't apply to stgit or hg patches
(which are not mailbox formats where we have to worry about that), so we
ignore the parameter entirely in those functions.

Let's mark these as unused so that -Wunused-parameter does not complain
about them.

Note that we could just drop these parameters entirely. They are
necessary to conform to the mail_conv_fn interface used by
split_mail_conv(), but these two callbacks are the only ones used with
that function. The other formats (which _do_ care about keep_cr) use
split_mail_mbox(). But it's conceivable that we'd eventually add another
format that does care about this option, so let's leave it as part of
the generic interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/am.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index a78daa6971..8451f5e423 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -787,7 +787,7 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
  * A split_mail_conv() callback that converts an StGit patch to an RFC2822
  * message suitable for parsing with git-mailinfo.
  */
-static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr)
+static int stgit_patch_to_mail(FILE *out, FILE *in, int keep_cr UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int subject_printed = 0;
@@ -870,7 +870,7 @@ static int split_mail_stgit_series(struct am_state *state, const char **paths,
  * A split_patches_conv() callback that converts a mercurial patch to a RFC2822
  * message suitable for parsing with git-mailinfo.
  */
-static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
+static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr UNUSED)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int rc = 0;
-- 
2.41.0.586.g3c0cc15bc7

