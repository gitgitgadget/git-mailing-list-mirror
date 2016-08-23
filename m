Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72A341FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbcHWQOL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:58259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbcHWQOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:09 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LcFTN-1atVPf1jzp-00jbHI; Tue, 23 Aug 2016 18:07:26
 +0200
Date:   Tue, 23 Aug 2016 18:07:25 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 10/15] sequencer: lib'ify save_head()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <416659fa3df92eabf3265ec079a6ea8cbc17366f.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ZMJREKahgPB8yUSLCbKI/UP7m1Ug3o+CC6q22UmOwF4CFx4VVFG
 swqOu1MOC+gyIJMsTGHGeVz4dIUT2ZeC9X7zCFjG4l/WtbiCJKkxl1+ysaPTe59YRAQi7VQ
 IBv/lHlWS9s3rdo4Mzx6jP5SVIQm69zgz73qV0PAyEbGK/cvp/HmrE8RlKzWYMPBMlWXSRB
 dSypre7NWV5WJBDOsYWaQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:n1Glw4+zoDM=:xs7Lm0WLeag7rjW8HvyglT
 ci9fnvry6pMWfIZZc/sHsKs2OZIjAMS3aMebm6gQZ+yzkqpAOFV1sKX3X8w7SLeatrtvEG6uO
 VLlCPIOZRO66uVF1wvX5JPOYki7mgs8p8euBAPT5zBU1saZF8e92ptLMLm1BYEUwInDLx0krG
 7htdWq3nkXakQGVchRZAAIWG2VZ3wHpRVg6OFOOTsDr+jZFZAMVSv4mfqCiQIjDCLCoX50lAd
 S8YblSILJhXCexZE1iWeTH/9/Gyj367MHHlC6vP+qR8iPY/D0+zABMsXD6/s1IT4NvXo94HNH
 Nhflimcf1tX9ODJ53zR5bPgkz37rpCpJurZaWxVTxEEf3hm/oVrbIQH5GOyErpWE3HMMCWKH2
 KAE7VWZZqTDc5R8xGqPffdcl3kIdweduaYz4xVx1trFGwSVeJjbjZVEFp/4S6I/KH7ObtGaTD
 oBwPxPIWPra9ZeP8HmErXpBk1JVICcGckOOf5GTvbtUgGP/6y4ZdAeMh1vt0qgRcyWYw9y/ss
 HYscmFbgyMUTTSDydbQNXOw9Y8scQsHMqlthAmMxbFp0XG575PWH3Hvce42WWJMwTehFMUnkv
 J0vGlWeI8rbXMnQvguQe051ls9GzcveftBK9G4W+OdHLyuYopAsFnkDhUbM0k4d6BZJ/PvQhh
 mGyoEHEhG087nQDc0GnXWKCi7wTgXwmyRs0m2xJniQUFIgnaODWqD3ED1cUs4HmLtkaiJlXG3
 +Ojq+uxiH7vxeGEa+2b80IzGawshWXiFN+OaIA+uUSmACBUIgeGzL8Y8ggyhpFIE3AFcwyu67
 dvGd7ho
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 1706ef4..3e07aa0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -844,18 +844,22 @@ static int create_seq_dir(void)
 	return 0;
 }
 
-static void save_head(const char *head)
+static int save_head(const char *head)
 {
 	static struct lock_file head_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), LOCK_DIE_ON_ERROR);
+	fd = hold_lock_file_for_update(&head_lock, git_path_head_file(), 0);
+	if (fd < 0)
+		return error_errno(_("Could not lock HEAD"));
 	strbuf_addf(&buf, "%s\n", head);
 	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s"), git_path_head_file());
+		return error_errno(_("Could not write to %s"),
+				   git_path_head_file());
 	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), git_path_head_file());
+		return error(_("Error wrapping up %s."), git_path_head_file());
+	return 0;
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
@@ -1118,7 +1122,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 		return -1;
 	if (get_sha1("HEAD", sha1) && (opts->action == REPLAY_REVERT))
 		return error(_("Can't revert as initial commit"));
-	save_head(sha1_to_hex(sha1));
+	if (save_head(sha1_to_hex(sha1)))
+		return -1;
 	save_opts(opts);
 	return pick_commits(todo_list, opts);
 }
-- 
2.10.0.rc1.99.gcd66998


