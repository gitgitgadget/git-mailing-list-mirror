Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE89C4708D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 11:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjAFLEe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 06:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232810AbjAFLEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 06:04:24 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DCC6E0D2
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 03:04:19 -0800 (PST)
Received: (qmail 14004 invoked by uid 109); 6 Jan 2023 11:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Jan 2023 11:04:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13273 invoked by uid 111); 6 Jan 2023 11:04:24 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 06 Jan 2023 06:04:24 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 6 Jan 2023 06:04:18 -0500
From:   Jeff King <peff@peff.net>
To:     Carl Baldwin <carl@ecbaldwin.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/3] diff: clean up external-diff argv setup
Message-ID: <Y7gAMoEpF4k3hc92@coredump.intra.peff.net>
References: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7f/YiVu1TgbucDI@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the previous commit, setting up the tempfile for an external diff
uses df->path from the diff_filespec, rather than the logical name. This
means add_external_diff_name() does not need to take a "name" parameter
at all, and we can drop it. And that in turn lets us simplify the
conditional for handling renames (when the "other" name is non-NULL).

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 59039773a1..72bed1d0a3 100644
--- a/diff.c
+++ b/diff.c
@@ -4278,7 +4278,6 @@ static struct diff_tempfile *prepare_temp_file(struct repository *r,
 
 static void add_external_diff_name(struct repository *r,
 				   struct strvec *argv,
-				   const char *name,
 				   struct diff_filespec *df)
 {
 	struct diff_tempfile *temp = prepare_temp_file(r, df->path, df);
@@ -4308,11 +4307,9 @@ static void run_external_diff(const char *pgm,
 	strvec_push(&cmd.args, name);
 
 	if (one && two) {
-		add_external_diff_name(o->repo, &cmd.args, name, one);
-		if (!other)
-			add_external_diff_name(o->repo, &cmd.args, name, two);
-		else {
-			add_external_diff_name(o->repo, &cmd.args, other, two);
+		add_external_diff_name(o->repo, &cmd.args, one);
+		add_external_diff_name(o->repo, &cmd.args, two);
+		if (other) {
 			strvec_push(&cmd.args, other);
 			strvec_push(&cmd.args, xfrm_msg);
 		}
-- 
2.39.0.463.g3774f23bc9

