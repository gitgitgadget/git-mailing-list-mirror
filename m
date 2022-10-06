Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041A0C433FE
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJFNLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJFNLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:11:35 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F42F66E
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:11:33 -0700 (PDT)
Received: (qmail 11997 invoked by uid 109); 6 Oct 2022 13:11:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:11:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26209 invoked by uid 111); 6 Oct 2022 13:11:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:11:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:11:31 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] commit: avoid writing to global in option callback
Message-ID: <Yz7UA2cdxVPellOe@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The callback function for --trailer writes directly to the global
trailer_args and ignores opt->value completely. This is OK, since that's
where we expect to find the value. But it does mean the option
declaration isn't as clear. E.g., we have:

    OPT_BOOL(0, "reset-author", &renew_authorship, ...),
    OPT_CALLBACK_F(0, "trailer", NULL, ..., opt_pass_trailer)

In the first one we can see where the result will be stored, but in the
second, we get only NULL, and you have to go read the callback.

Let's pass &trailer_args, and use it in the callback. As a bonus, this
silences a -Wunused-parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fcf9c85947..d9de4ef008 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -139,7 +139,7 @@ static int opt_pass_trailer(const struct option *opt, const char *arg, int unset
 {
 	BUG_ON_OPT_NEG(unset);
 
-	strvec_pushl(&trailer_args, "--trailer", arg, NULL);
+	strvec_pushl(opt->value, "--trailer", arg, NULL);
 	return 0;
 }
 
@@ -1633,7 +1633,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "fixup", &fixup_message, N_("[(amend|reword):]commit"), N_("use autosquash formatted message to fixup or amend/reword specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
 		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_CALLBACK_F(0, "trailer", NULL, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
+		OPT_CALLBACK_F(0, "trailer", &trailer_args, N_("trailer"), N_("add custom trailer(s)"), PARSE_OPT_NONEG, opt_pass_trailer),
 		OPT_BOOL('s', "signoff", &signoff, N_("add a Signed-off-by trailer")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
-- 
2.38.0.661.g581b1c9920

