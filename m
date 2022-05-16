Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE17C433EF
	for <git@archiver.kernel.org>; Mon, 16 May 2022 11:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242295AbiEPLCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241000AbiEPLC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 07:02:26 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4774B38B9
        for <git@vger.kernel.org>; Mon, 16 May 2022 04:02:25 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e4-20020a17090301c400b00161995eef69so201615plh.12
        for <git@vger.kernel.org>; Mon, 16 May 2022 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/GJiC+5vJNBYXUIZNAgaFBpDItymrUoTWvJKBXRbGR8=;
        b=g43pzexvJUEjz+3x0SU4VLM/siSmrJ7crQU8nEw7VI8VphX/FBlSSaoO8r/263EvWc
         7cwnNo7I/CY+somZ4yJDjnDnEa2ivANQFwkEogJ+ZJ3jnK0TemgwaNMhS4TLcO9YVVPq
         5H3M50LfnVNlqPqn5vv/9WXbY5IyKjJlSbWTzy6Z/8I9htiTjntAhJhck2n4qESnQFw4
         cIJOXcjnWlsdRHKv6zd0azzUssaphEkde6DTXB6ht7xALDsqshXQtltetrbE8TaturqJ
         j9MSOI/Y1hc9RqfJeAkIM6qF55zvUQm8Ft24cOtpsZObVhlCN5MRcj4rCeMhWNMQ5l8o
         a0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/GJiC+5vJNBYXUIZNAgaFBpDItymrUoTWvJKBXRbGR8=;
        b=bYVfbjcOAwlq3edhWgSJQZ4mShZLKtV9ghzUChs0rRoMUvtK0mG4mvfnl6E2ge1YnU
         0GasL3npB4R/SC4KRte+339oy63nouoOZPTFrwGR+EEQFCfKrRb9vEcVVQkq4hP66FrT
         7Fi1vAUff0G4mWuIZvGJPrgCKbW3T6iVSTAj6ngvI/TTNxWNhROZuDBEbm2WLZ4/D4+W
         OmAGl8JIoeZPiN2cDRtTH4U2fTG+K6oMFtQh0+UznjwUHIMxXIxh7UxyPudp7mSy7OSk
         I5pAc7x4VdsrlcHa//zFX1Izqu+bT6hidK/27jsKFEtRqdkGAa9b5UYOlu5hlQmXMKa3
         g7wg==
X-Gm-Message-State: AOAM532IhwjEcwG4z6QfJpN6ldcOcUSFfU/VOpph+diyQNieD3Yptq/l
        NOiBbqFBPOjlw8WCIpQvv/ZMccuS1JebwkyzicowCKidEewhOPTnri2azNQOUiofOC8H+oNgmhv
        26bvmuaHIlkM7U8mThVlbT+01Mk4Q78jW4PmVwi3J3CuL6VQs1DOeBBfvFARLVz7obqsxVnGS6r
        rT
X-Google-Smtp-Source: ABdhPJx5sZpcozudgtVVNtwajb0cwCdw5Lr47bz7B1iT+9ot5nbGuB6bQEh9HOuxmhrUdg9rO0VrCmUWqW8tGrw8+Mvb
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:f3d5:b0:1df:2191:5ad2 with
 SMTP id ha21-20020a17090af3d500b001df21915ad2mr10683505pjb.136.1652698944551;
 Mon, 16 May 2022 04:02:24 -0700 (PDT)
Date:   Mon, 16 May 2022 04:02:20 -0700
Message-Id: <20220516110221.3490982-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] fetch-pack: make unexpected peek result non-fatal
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a Git server responds to a fetch request, it may send optional
sections before the packfile section. To handle this, the Git client
calls packet_reader_peek() (see process_section_header()) in order to
see what's next without consuming the line.

However, as implemented, Git errors out whenever what's peeked is not an
ordinary line. This is not only unexpected (here, we only need to know
whether the upcoming line is the section header we want) but causes
errors to include the name of a section header that is irrelevant to the
cause of the error. For example, at $DAYJOB, we have seen "fatal: error
reading section header 'shallow-info'" error messages when none of the
repositories involved are shallow.

Therefore, fix this so that the peek returns 1 if the upcoming line is
the wanted section header and nothing else. Because of this change,
reader->line may now be NULL later in the function, so update the error
message printing code accordingly.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 4e1e88eea0..6d0d271259 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1370,17 +1370,20 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
 static int process_section_header(struct packet_reader *reader,
 				  const char *section, int peek)
 {
-	int ret;
-
-	if (packet_reader_peek(reader) != PACKET_READ_NORMAL)
-		die(_("error reading section header '%s'"), section);
+	int ret = 0;
 
-	ret = !strcmp(reader->line, section);
+	if (packet_reader_peek(reader) == PACKET_READ_NORMAL &&
+	    !strcmp(reader->line, section))
+		ret = 1;
 
 	if (!peek) {
-		if (!ret)
-			die(_("expected '%s', received '%s'"),
-			    section, reader->line);
+		if (!ret) {
+			if (reader->line)
+				die(_("expected '%s', received '%s'"),
+				    section, reader->line);
+			else
+				die(_("expected '%s'"), section);
+		}
 		packet_reader_read(reader);
 	}
 
-- 
2.36.0.550.gb090851708-goog

