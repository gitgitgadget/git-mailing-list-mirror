Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED65B1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbcIIOh4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:56 -0400
Received: from mout.gmx.net ([212.227.17.20]:60082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750882AbcIIOhx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LtVLE-1b1IxU1pLA-010ssl; Fri, 09 Sep 2016 16:37:48
 +0200
Date:   Fri, 9 Sep 2016 16:37:47 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 12/17] sequencer: lib'ify save_head()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <b06592dcf50d808728ed7f6d1041ff45a5b6d6ec.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:RHl00Suqzzvnz/KRqZ/pSIPeDLnPYPvx38HK8yXojgkpFFFNdcC
 iBnjTTIIe0Oa2yOv4pCG0avFF7HDo7wjVCPZhFHoVBCw0mgliXff4FjW0CBC5qc6iMBBJ/8
 r0INoJ+hC025f6PPGCo4niL/8qp5DihFXXQ+M0DE0NRoENqj2CFZG3tXOaKj0YX1+MpOpIE
 j2gnZzcCNt2qLq6CB8Hhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eoirODgmiG8=:WeQccSNmiMJ+4zCUqmQSwi
 2EDXByNgCwlbDT1NlLbhvnAPaexVHIU6N3cQavoO43Fz7LFkY5oIjN05QL5drmTc+q8R2orEf
 euQ7W7iOuOOy80rjOueZ4aKr53pJUgD0wSE0uQwo3PwILiPnYuXU9wj8mRWJ9zXFih5D/Puxx
 HiNDWSvOCJtYs4tUnBUZR3otwmT2viuvENNQMCG/Eb+k/5r0CflpSWbR4IceHIITAw+kL+6y3
 Nmxj2rWWQPc/dSB+rsmyVJfiN4UxFkEIxeooPQssRAglZOlgQ6d9Z4+dmXCFPAaaEH1uDU5n3
 l9IK/IhpxFjz3gYE0t6Rpvr/LPa/QXl7cHzi6NLEN4JJAKyf0aJeNZn2hUPw81sag3Vq2yVkb
 wctkMkSfo1AqXlCXNj0amGT7RHULdXCHVxvyWI0+uN++u+hJifAsbiNMRsTbeAYrSCyjjQnSI
 NfFVChyCZJFvOhQrpGrGr8L+Hc4crXRW7aLQJknbzmD+vjL1aMZpw8xWhY9/AhWaPW32ayfCd
 KmODX6uOOyfhkg8FaQC+Ej+t1Be0fTk3jyjnu/HMpuZgGMHnPept6QSPlIZKESX/NpL9u7qNg
 fSn7LB2SrBQh8eIt8KO4LUTWRxM3v2TK0KR/gzX5dKl7aZFLW1CN4CEF/wp6GhNyVcypzl4Ve
 oFexpTyQNQNNDKdfS6CtDXwxi3LGdjc8hggN3zEMLKpiKR76XATYrPc9RcBt2TacHhZc+iI7g
 TjzYbib1w2uHKLJMZOUhN5jOJmIg1VpopJlhhlDVK7TY6hwJF8HUwjgToYoOMUk6IC7N6TebD
 skguQ3Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of save_head(), sequencer_pick_revisions() can already
return errors, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make save_head() callable from new
callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index eb9c473..7a1561e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -852,18 +852,28 @@ static int create_seq_dir(void)
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
+	if (fd < 0) {
+		rollback_lock_file(&head_lock);
+		return error_errno(_("Could not lock HEAD"));
+	}
 	strbuf_addf(&buf, "%s\n", head);
-	if (write_in_full(fd, buf.buf, buf.len) < 0)
-		die_errno(_("Could not write to %s"), git_path_head_file());
-	if (commit_lock_file(&head_lock) < 0)
-		die(_("Error wrapping up %s."), git_path_head_file());
+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
+		rollback_lock_file(&head_lock);
+		return error_errno(_("Could not write to %s"),
+				   git_path_head_file());
+	}
+	if (commit_lock_file(&head_lock) < 0) {
+		rollback_lock_file(&head_lock);
+		return error(_("Error wrapping up %s."), git_path_head_file());
+	}
+	return 0;
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
@@ -1127,7 +1137,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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
2.10.0.windows.1.10.g803177d


