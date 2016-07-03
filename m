Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 109F820179
	for <e@80x24.org>; Sun,  3 Jul 2016 08:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307AbcGCIAM (ORCPT <rfc822;e@80x24.org>);
	Sun, 3 Jul 2016 04:00:12 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:55426 "EHLO
	homiemail-a21.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750944AbcGCIAK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2016 04:00:10 -0400
Received: from homiemail-a21.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTP id BF077300090;
	Sun,  3 Jul 2016 00:58:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=novalis.org;
	 bh=DFaZ0zyTAbi1N4IbGd/hDykxXqI=; b=fXLrZALDX797xd7P+pUU35MwEg5a
	f0d47czjdLfMTa73iHX22V6pHwZicTW1/M/cSDPuXWYo2z/PZIxKv9AUV/FRaiwp
	JScdUeRa+2cUEFf7du1k7RlDKwrxiugF5hbEXqqIRCnrAQq2HSIYyJ8fSDG2FLuR
	2W4pPIZw/0rsxcE=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a21.g.dreamhost.com (Postfix) with ESMTPSA id 042A730007B;
	Sun,  3 Jul 2016 00:58:33 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kmaggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v14 08/21] index-helper: log warnings
Date:	Sun,  3 Jul 2016 03:58:00 -0400
Message-Id: <1467532693-20017-9-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.11.g9232872.dirty
In-Reply-To: <1467532693-20017-1-git-send-email-novalis@novalis.org>
References: <1467532693-20017-1-git-send-email-novalis@novalis.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: David Turner <dturner@twopensource.com>

Instead of writing warnings to stderr, write them to a log.  Later, we'll
probably be daemonized, so writing to stderr will be pointless.

Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-index-helper.txt |  3 +++
 index-helper.c                     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
index 228b1df..3d2c829 100644
--- a/Documentation/git-index-helper.txt
+++ b/Documentation/git-index-helper.txt
@@ -57,6 +57,9 @@ command. The following commands are used to control the daemon:
 
 All commands and replies are in pkt-line format.
 
+In the event of an error, messages may be written to
+$GIT_DIR/index-helper.log.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/index-helper.c b/index-helper.c
index eca8ae9..1b79f1d 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -103,7 +103,8 @@ static void share_index(struct index_state *istate, struct shm *is)
 	if (shared_mmap_create(istate->mmap_size, &new_mmap,
 			       git_path("shm-index-%s",
 					sha1_to_hex(istate->sha1))) < 0) {
-		die("Failed to create shm-index file");
+		warning("Failed to create shm-index file");
+		exit(1);
 	}
 
 
@@ -302,8 +303,17 @@ int main(int argc, char **argv)
 		die("--exit-after value must be less than %d seconds",
 		    INT_MAX / 1000);
 
+	if (detach) {
+		FILE *fp = fopen(git_path("index-helper.log"), "a");
+		if (!fp)
+			die("failed to open %s for writing",
+			    git_path("index-helper.log"));
+		set_error_handle(fp);
+	}
+
 	if (detach && daemonize(&daemonized))
 		die_errno(_("unable to detach"));
+
 	loop(fd, idle_in_seconds);
 
 	close(fd);
-- 
1.9.1

