Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A59C020705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbcIIOhp (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:45 -0400
Received: from mout.gmx.net ([212.227.17.20]:54982 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752400AbcIIOh1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:27 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LjquD-1bBV1P04Mb-00bsYR; Fri, 09 Sep 2016 16:37:22
 +0200
Date:   Fri, 9 Sep 2016 16:37:21 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 08/17] sequencer: lib'ify read_and_refresh_cache()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <cfe6288ab534c859d385e3abec64ca06bf5e35f1.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:yViMe92sRnM6gVm/34I2156BmJiHlAE6uiwIVEEjvikN7z7SD4f
 9dT8kxQKCcpAoehqWZ2LMkVM0mn0zEGxf2UHbHApKddBauqfdDa2HUVR6dlM8twDPW7m+WK
 XCI58oPZqZ+dD/vza2SPjQoVR3RcW+qeuYMxPjdXh5cYqzODjj3ZazvjNjo4CTvZTXK3w9/
 kg38+YjSUHJBhf/pUTMug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MZaG5d2+5FI=:pNxsTGHrAKkbN1YiQ72vkF
 HLTAxNaj8MqoHHJCalvk8tqgVMwkyB9RKCVHqPq83I8qmiNrVTEFw+Mj2J7RjVjTid2cYPCg2
 2vsLz8rMY4y+6tWhXZ3s0ub8DlViB0UU4eWtpzZWJhtUEFxSzyuNn1l0b3aqE8avOrUdGUzzy
 Kkw8EQpulm3SgpUD0fDWO35UyL0Axokm1+NIT7zbcmS94cYJJcBcxvi9kCuL/FwvazthWtjxb
 Az8qHCO5hc0AkstngbUW2WZ9JcfNB0Fd1ZI39AgTyX1jk3r5xFZq5cPwiKR95oIvO17fGA/1a
 5Xu6SZtMyREr+2ZqFryKav2rxSWMyYIfFV5sBUAvyf91hag7zks4esZm33DTyfnsJpsDYURIg
 8GoQBrAmPPN1eLUxsxAmwhEejlYtBpPZqC7mpk2Fyu//oiwDAFH4knij+hk0likU0w5MogaD4
 3KqBtXPyRPfPIRLCXj/slRQbWRe5ifMAdRSuD3HN3w9FSbmwbhlU+oGP2FOWdshW5uAG+PkBZ
 B59PASGHKSEftB1R6NBw8Gc+kH8s9oTSiMvgaXkrM+Vq8cHFtnrdvWZeoeJY4q2bltOMHDxng
 LOW69VZZJJB9twDMsVSfwaSa/19f829DOm+3p4vdhFsqfk6Kxn5jWHJ+hdAW2vMlI7J7EJgG2
 xykp8P2sU3b5f2D/blT7LY8Q9pirZjX3t73JcAI36bdJue2rbZskil6JWwB4ntrTJM5WlYdy0
 +KDE85NJVPZchWBKUYV/b/6xBa4up80vqR8I7eJ1N61iGEPux0gDHOZzy5UhC4wdh+ctNB/gZ
 JJLuGhY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

There are two call sites of read_and_refresh_cache(), one of which is
pick_commits(), whose callers were already prepared to do the right
thing given an "error" return from it by an earlier patch, so the
conversion is safe.

The other one, sequencer_pick_revisions() was also prepared to relay
an error return back to its caller in all remaining cases in an
earlier patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7fd0f99..631b75d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -640,18 +640,21 @@ static int prepare_revs(struct replay_opts *opts)
 	return 0;
 }
 
-static void read_and_refresh_cache(struct replay_opts *opts)
+static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), action_name(opts));
+		return error(_("git %s: failed to read the index"),
+			action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-			die(_("git %s: failed to refresh the index"), action_name(opts));
+			return error(_("git %s: failed to refresh the index"),
+				action_name(opts));
 	}
 	rollback_lock_file(&index_lock);
+	return 0;
 }
 
 static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
@@ -981,7 +984,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
-	read_and_refresh_cache(opts);
+	if (read_and_refresh_cache(opts))
+		return -1;
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
@@ -1045,7 +1049,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
 
-	read_and_refresh_cache(opts);
+	if (read_and_refresh_cache(opts))
+		return -1;
 
 	/*
 	 * Decide what to do depending on the arguments; a fresh
-- 
2.10.0.windows.1.10.g803177d


