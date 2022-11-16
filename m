Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D01BC433FE
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 16:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiKPQEY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbiKPQEV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 11:04:21 -0500
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 16 Nov 2022 08:04:19 PST
Received: from mailproxy09.manitu.net (mailproxy09.manitu.net [217.11.48.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A9D25C4D
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 08:04:19 -0800 (PST)
Received: from localhost (ip21.237.mip.uni-hannover.de [130.75.237.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy09.manitu.net (Postfix) with ESMTPSA id 2FCD712000F2;
        Wed, 16 Nov 2022 16:56:41 +0100 (CET)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Subject: [PATCH] notes: avoid empty line in template
Date:   Wed, 16 Nov 2022 16:56:40 +0100
Message-Id: <347ee7ad6fea7cf96bb1e51772802102082b58cc.1668614158.git.git@grubix.eu>
X-Mailer: git-send-email 2.38.1.672.gc8cd8f59d3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When `git notes` prepares the template it adds an empty newline between
the comment header and the content:

>
> #
> # Write/edit the notes for the following object:
>
> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
> # etc

This is wrong structurally because that newline is part of the comment,
too, and thus should be commented. Also, it throws off some positioning
strategies of editors and plugins, and it differs from how we do commit
templates.

Change this to follow the standard set by `git commit`:

>
> #
> # Write/edit the notes for the following object:
> #
> # commit 0f3c55d4c2b7864bffb2d92278eff08d0b2e083f
>

Tests pass unchanged after this code change.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/notes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index be51f69225..80d9dfd25c 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -181,7 +181,7 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 		strbuf_addch(&buf, '\n');
 		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
 		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
-		strbuf_addch(&buf, '\n');
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
 		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
-- 
2.38.1.672.gc8cd8f59d3

