Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 7791 invoked by uid 111); 22 Sep 2008 17:21:05 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 22 Sep 2008 13:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbYIVRUo (ORCPT <rfc822;peff@peff.net>);
	Mon, 22 Sep 2008 13:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbYIVRUo
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 13:20:44 -0400
Received: from [212.249.11.140] ([212.249.11.140]:57881 "EHLO pixie.suse.cz"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751672AbYIVRUn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Sep 2008 13:20:43 -0400
Received: by pixie.suse.cz (Postfix, from userid 2001)
	id 45E102AC8E5; Mon, 22 Sep 2008 19:20:29 +0200 (CEST)
From:	Petr Baudis <pasky@suse.cz>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com
Subject: [PATCH] Do not rename read-only files during a push
Date:	Mon, 22 Sep 2008 19:20:29 +0200
Message-Id: <1222104029-28366-1-git-send-email-pasky@suse.cz>
X-Mailer: git-send-email 1.5.6.3.392.g292f1
To:	git@vger.kernel.org
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Win32 does not allow renaming read-only files (at least on a Samba
share), making push into a local directory to fail. Thus, defer
the chmod() call in index-pack.c:final() only after
move_temp_to_file() was called.

Signed-off-by: Petr Baudis <pasky@suse.cz>

---
 index-pack.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index a6e91fe..2af72d6 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -786,7 +786,6 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		err = close(output_fd);
 		if (err)
 			die("error while closing pack file: %s", strerror(errno));
-		chmod(curr_pack_name, 0444);
 	}
 
 	if (keep_msg) {
@@ -820,8 +819,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
 			die("cannot store pack file");
 	}
+	chmod(final_pack_name, 0444);
 
-	chmod(curr_index_name, 0444);
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name) {
 			snprintf(name, sizeof(name), "%s/pack/pack-%s.idx",
@@ -831,6 +830,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_index_name, final_index_name))
 			die("cannot store index file");
 	}
+	chmod(final_index_name, 0444);
 
 	if (!from_stdin) {
 		printf("%s\n", sha1_to_hex(sha1));
-- 
tg: (fe33b33..) t/pack/rdonly (depends on: vanilla/master)
