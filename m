Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943A02018E
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753109AbcHZNs4 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:49391 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752930AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M6BKc-1atiHO2q0Q-00y6aI; Fri, 26 Aug 2016 15:48:04
 +0200
Date:   Fri, 26 Aug 2016 15:48:04 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/14] sequencer: lib'ify save_todo()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <1cd7ba2d13dff6d1fed3560e2889c438fa468e87.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9CZmLfpVvjMApwuYoGgOg3s18R5+kXOLGk0o4OnPov5/LgmXDJD
 9eIRFDS7AfCfIF55HPAVu4yCdKJYZgRLbNY8VhhGSd2jwQq7TDUeF8sBImS+DKkIsg+Xri8
 v9fQAkPbpY6+VZRxlvKhw1VGguAQZinKpHjknOGFOpvdLv94/hA0Exm4AqPdq4zRXWt12I8
 DUoI5AVz5whTTH3uE3/WQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LD7FI3clysA=:Yc2cii6jOC876u/bD4Om8s
 Ryw5JRoMSZKCplJcGzZv+c9KnO6x2PpDpQdC9NCcY5IshrUUN70Sy/sk+/s+8RDoQuTC+OOv2
 yGiGaTkQ42wXg+D1K+tavR5+FQjWrzyjt2CJgrmSUQZ5lWkiKrwXS8IoehjJQ9LvirYsR4ga1
 036XhKhVlCVyGHl1Pq16Xk4g9dYYzzj9kYOfbZqiZgif/sh0jsKKSIZeSqXmXVzCH78z6urw5
 9YhgwfpUbwBZv+lRak4eBlfGLFWcD46+duvzIOylZZEs9n1IB3VyiC7HQBda6ks+Cunr3AP2+
 ycjk6PS8zah39cS/oQKMqc+SB52PGDTESbXlss02KmRSToyjRX1490L64TaAv/f/gBRVD49EE
 QNdh9XD+M4gYYzY0e3NTB4fBZlhe/C2kDAzCXQQH4iCQrY5glcWNznDDR4uHqoHgsiJ71Yjd9
 zq9aTLngW09z72PL8zPh06CoSsSfwMb5mewU/ZKLi3aICWQas2l8y1U28CinwP6xs1TPj1gkD
 FkQd6GACJZTnORVDXrpI23+8j/nj9pkp+ViCfjHC8MTQyt6+aftGq1NZxD2Qp61z+YWcBWjGP
 odv3GWkGR6UUp2qpSila2v8/LivbIH+KE9l8j+UN8WKvGC9FlmbpMZjS1mKHhFxr7FArXlT1i
 whyGn1LLltwOHFqs/d+L9dnHdffK2zM3BHAvxEYrFJMx66VNaiZb92fSn7zdSflc4MK0XTlt9
 /JKpmiPJVYezKSntW/E20zhD9eRaSE/0yig0MNYeQ+wM/rKBavU3ROrMrCM5BPqB1MNRirM/e
 o6FCTJH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of save_todo(), pick_commits() can already return
errors, so its caller must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make save_todo() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index a819919..3e877f1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -931,24 +931,31 @@ static int sequencer_rollback(struct replay_opts *opts)
 	return -1;
 }
 
-static void save_todo(struct commit_list *todo_list, struct replay_opts *opts)
+static int save_todo(struct commit_list *todo_list, struct replay_opts *opts)
 {
 	static struct lock_file todo_lock;
 	struct strbuf buf = STRBUF_INIT;
 	int fd;
 
-	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), LOCK_DIE_ON_ERROR);
-	if (format_todo(&buf, todo_list, opts) < 0)
-		die(_("Could not format %s."), git_path_todo_file());
+	fd = hold_lock_file_for_update(&todo_lock, git_path_todo_file(), 0);
+	if (fd < 0)
+		return error_errno(_("Could not lock '%s'"),
+				   git_path_todo_file());
+	if (format_todo(&buf, todo_list, opts) < 0) {
+		strbuf_release(&buf);
+		return error(_("Could not format %s."), git_path_todo_file());
+	}
 	if (write_in_full(fd, buf.buf, buf.len) < 0) {
 		strbuf_release(&buf);
-		die_errno(_("Could not write to %s"), git_path_todo_file());
+		return error_errno(_("Could not write to %s"),
+				   git_path_todo_file());
 	}
 	if (commit_lock_file(&todo_lock) < 0) {
 		strbuf_release(&buf);
-		die(_("Error wrapping up %s."), git_path_todo_file());
+		return error(_("Error wrapping up %s."), git_path_todo_file());
 	}
 	strbuf_release(&buf);
+	return 0;
 }
 
 static void save_opts(struct replay_opts *opts)
@@ -997,7 +1004,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 		return -1;
 
 	for (cur = todo_list; cur; cur = cur->next) {
-		save_todo(cur, opts);
+		if (save_todo(cur, opts))
+			return -1;
 		res = do_pick_commit(cur->item, opts);
 		if (res)
 			return res;
-- 
2.10.0.rc1.99.gcd66998


