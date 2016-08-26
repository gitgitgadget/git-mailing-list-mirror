Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D2CA2018E
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbcHZNsz (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:56617 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752619AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LmeGF-1b533s0IPj-00aBNx; Fri, 26 Aug 2016 15:47:51
 +0200
Date:   Fri, 26 Aug 2016 15:47:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 08/14] sequencer: lib'ify read_and_refresh_cache()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <99f3ab3a30a469b271300ff61309ac4c4a8af448.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nMz1H+aYGV/rXLdywSnqIu7eMEoAtsmCUZ06IxlNqVefFK6ckfA
 Kd0pPUBdAuJDDZeODNLOYjgxXuk7MK2V3U+yJwznpmYwUby3NVxl95PWFnqoCpp7Rb/DHXs
 CM3QxH8POzBDHl8IPKezl3AVhiZBz4Vbv6hhw5jbp6dRgtZ61QDxWYuwKHnn5ELUOWCfApG
 wIdkbCnyTNVSay5KRaSSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j9S3YBQlUxk=:qw+6pjEZFAf1ITUg814bEy
 cQFAO9RA3fw9BSRGUB/lPWouXSB1FFLw0ynZqF5Y1FQqt2yuuc1RO1zqoxYaHEPhuFF0gwIOf
 qNmBMlTfN2IA/G/z2Lu21WtmyiKGFGNpuboxoU34hKfZsSnrY6k4Amjs9NjKZoZjfDEvfeNZi
 4fmSnaElkcQofR+jD03abkoQif7xGrVDWVJ40QneXs4EvnQ1s6AOhGAVx9sdvWlUCU043TLye
 M1Ui/a41SV7usfWqeVs21Y3gUBMChTUsw3/CW1i1erVZx+NgaX1yQC/d1vTyi1iVyTE3IVlSy
 L+TDK2hkH48U7Uo+Gjlxa9UdOTdOrtn/qw1gV06spV6hy3l8SCjO8zBKOJvrtMHmdxpQTL3p6
 BZ3860sdwTgnPLUj9+Dz8ktYiNyCYRI+Z45tysitTOWsSoryo3DbFtgRFTSCaT9OZzy22c0KF
 ClKOF/HdINjYXNpJNHJhRSeWmEbcoppJwRZMCRPv/YG4k+Wo/2Qo7djf3OLGLdLhMqY3533Y4
 bCgx09fGjYrJ0FGejrOQFqfja8ln+LVoIrrzgjTOi+HeZr04tsRclha+QydCYwPXdZTL7H1uF
 9TVxJ62kZfxeNU9QRsgJLyVvfn+ChDA4O5JPGpo2Uaw4JQdnj8e1Z2lQfRD85CeIJIeGvQfjA
 v+jZ5FUFz5nNjx0FJBJIISs+pzlbjQU8qnxb2AP/nVyqf7YTtVG6ZfRKGoAsxDexbsGDUfqN9
 kaX0RIKgqMCigAPz0H/VWAgSlvM2lLlp5y4L6q/e0MG7KBDIS9j6c2iEuZjTE7vizjlJce16f
 +//8D39
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
index c006cae..e30aa82 100644
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
2.10.0.rc1.99.gcd66998


