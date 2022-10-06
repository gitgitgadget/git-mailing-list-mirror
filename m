Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0163C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJFNLD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJFNKz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:10:55 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F775A599C
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:10:54 -0700 (PDT)
Received: (qmail 11994 invoked by uid 109); 6 Oct 2022 13:10:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:10:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26204 invoked by uid 111); 6 Oct 2022 13:10:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:10:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:10:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/4] multi-pack-index: avoid writing to global in option
 callback
Message-ID: <Yz7T3SHEnYjDDPnn@coredump.intra.peff.net>
References: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We declare the --object-dir option like:

  OPT_CALLBACK(0, "object-dir", &opts.object_dir, ...);

but the pointer to opts.object_dir is completely unused. Instead, the
callback writes directly to a global. Which fortunately happens to be
opts.object_dir. So everything works as expected, but it's unnecessarily
confusing.

Instead, let's have the callback write to the option value pointer that
has been passed in. This also quiets a -Wunused-parameter warning (since
we don't otherwise look at "opt").

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/multi-pack-index.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 9b126d6ce0..9a18a82b05 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -56,11 +56,12 @@ static struct opts_multi_pack_index {
 static int parse_object_dir(const struct option *opt, const char *arg,
 			    int unset)
 {
-	free(opts.object_dir);
+	char **value = opt->value;
+	free(*value);
 	if (unset)
-		opts.object_dir = xstrdup(get_object_directory());
+		*value = xstrdup(get_object_directory());
 	else
-		opts.object_dir = real_pathdup(arg, 1);
+		*value = real_pathdup(arg, 1);
 	return 0;
 }
 
-- 
2.38.0.661.g581b1c9920

