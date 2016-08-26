Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5C31FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbcHZNsm (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:61588 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752835AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M0smx-1aqg0r0S9n-00v9VK; Fri, 26 Aug 2016 15:48:02
 +0200
Date:   Fri, 26 Aug 2016 15:48:01 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 12/14] sequencer: lib'ify save_head()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <729cf9d7cca4ec3fe9caeb6f21a322f3c68ce135.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GU68eMRa6y1mlTkBZP2Bc9a3XXtVpObRWFqcfbEsuDVcXNXlsuo
 qoEVOZSOETNhFUu0orvJQPp9rMCW/1ZDzOiqeeeDsbuNtBMM3i3VGVUFMTHXfSaCpWA0lb4
 UGisbvtYD83l69JJyeHjUp4/Wl9p1zCLNqC8gpPyKCiOv0tYiFMbeUyOH+2z85yVFs99WAD
 iKRXDZigUQvFopTSo56SA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xwajRUaTpkU=:KXjDnvAQJJPeOqH/IUGw9D
 pIY6F+9YeIxRaG9doNWoaA06ZyupYCZkqcIE+Psn+L1dX/LVjC9oYnQVkG96/3wa14jfdKBiT
 zmGpRYNPRcqmvmWaTxD6hukATd6LB3K832UifgF+Lt7vptxRoo64qfDDl/T9edmvkwToO3JiE
 ho88vDXz55soT+8L6WxnZyH1jC9EDwWC+4QuKyPlyrzOL+YrwLxU7zli1xaKGA3H6/oorAw7p
 CpNBntgzLAyixDuKOiTdtAFQnTq2o2ohQ0DewzYFTTsK5U1eRzi8l98GtJyjOI9a00ngtARZy
 w9Cn/muIzm9XEyEf0ZLXQxhDUd6wFozCRdFjIa+AfdCLKGoaiG3yK+F5Q+lis2mFyXq8izKd5
 BM4DxlLWLE0r6b8SSQJGeXz9lN8lCITL1yQWYZ6yqDDDxfGtQXOJshrOVti/dLsVw/D33ZPQv
 ASHfnSv2Kvf/kkJXarG5EGeY1owLa4VCZNv0XkzSt7HU6KZ3TNVZFtZU1O2rNyxmyaYYPSeAw
 fU6T6O8uLQlLXJ9h5FbfwW6IJq2/+MMOvxIXOBMKaUO5KV2Wds0pI8ELZbqCZubTDKYN+Z4mi
 pys1QCZujZqmGpJgdIQaOPdHFRicwFLOJ+PuqovIObuWZUDsyUGwj/PRELeX03F94N7ggAUi2
 /Hb0FpGjLx+LrCEYctoddYJAHSg3ea7IZ73adhAkIhRIgguchhoUCegdiI3Ml6AsB5xX/L0P1
 dcVz/1yE+xqo0rxnqf5TeuRH0b3nUfpAzMSu6m5M0ruo0sAHDrWVbZAQ4YQiC256cpBEbMAX0
 Q9h/Uqq
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
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9a1f0af..a819919 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -846,18 +846,22 @@ static int create_seq_dir(void)
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
@@ -1121,7 +1125,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
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


