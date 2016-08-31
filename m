Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E18441F6BF
	for <e@80x24.org>; Wed, 31 Aug 2016 08:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933708AbcHaI41 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 04:56:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:64132 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933839AbcHaIzi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 04:55:38 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LbMb0-1bG9oy2fjm-00kuZm; Wed, 31 Aug 2016 10:55:34
 +0200
Date:   Wed, 31 Aug 2016 10:55:34 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 17/34] sequencer (rebase -i): allow fast-forwarding for
 edit/reword
In-Reply-To: <cover.1472633606.git.johannes.schindelin@gmx.de>
Message-ID: <84b2be2078f4fb4853cb5725df9ae8e387dff42c.1472633606.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AenhvEgHyttLZAIfCbSSX0rFs3GuQqcqHviJubi/tARIA+3yq2m
 RCO66PWHWlIi0ibM+KQ13VGbMu70sCngE4Io5bo8iDnwtGaQwaAzak6lYzu9IY7AhZM57tx
 LiaZo908c/IsgWdVJBRiqTRKKYiRqEAi1aVbhhy+TgqHkXsH3EUY7tU27zqLfGOFRKqGB8g
 8dzaLzmTNUHhbTbZb2F2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CvCJA8AryYg=:E2cXKk9Dhtmqaz7xJ3PFUS
 LXDeHHv118ykt5g8h6PJUV5gAK9MsJtCokgh15skrzbPYDhaSPfDL3S8JYM7HauUsxqzF0ZUX
 SXux3khzAjo5cmj9eQt66V1ofKECrRDZaxp/C8gRP6ciV+NycXtayBGGdDDVI0fAxtC+UGX/z
 QFsAVuxfwzmFKhcHwA/tOhxAAoAZ6hObAd2VZceByeYC4Ny/cn2NS7lH7jEN/hnB4EeJ0tNUt
 tMeXMbPVbBCD7618Jgp70jJXk4adLAgdRTvGo4lSpFoZ/JEGqiHuFmDLlQS3OJds4jN4hE1nR
 2CRlMnicnACGfdoD3+RTU0UuyVEsY+22FGtzLncOeCUK4qViq7R7JIox808nnEEPCXtYvpAVM
 GuPtFKI5gc90SpqfLzHDNcHsPq2ivLZFg0Yxf6tr0Bbhy1wfn/Z9SesYcsuS/R98c31+Gd9dA
 muSfGWU4R3iTc0bVoBW6VbOW0It1/ntTFKIY308+HvzFT1Z2tJV/TUQNxPx8dEDbRHuRFFQiW
 JEAFcHKfeg+JDMWScvYHQc/knhsX6SNGZ4kB7/FSS+zyF29TZhzFjpchySTpck/KGP31v6oZR
 dWKvHpU0rZpo465DCik4v1BZVpEUrtA/AyuJxwhBesjMzCU7A7Zb2Svjp7KZM5lJ07PGY/0LD
 u3HoriHGw+Jvi1oYUfbW70PGZ39I21NUQo5fCAsEOAYzB9SxTpNCLrSh4oKgj/KplSFXgmeJu
 Buyq8K7Y10N126de5P0h7eSTohSAaAhHgJHNUeH+pkrpaXI9BzIsG0OVU2yfyIlJv9BVznfK7
 VJSVFzt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer already knew how to fast-forward instead of
cherry-picking, if possible.

We want to continue to do this, of course, but in case of the 'reword'
command, we will need to call `git commit` after fast-forwarding.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 64fec47..399fc8d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -896,7 +896,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	const char *base_label, *next_label;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	struct strbuf msgbuf = STRBUF_INIT;
-	int res = 0, unborn = 0, amend = 0, allow;
+	int res = 0, unborn = 0, amend = 0, allow = 0;
 
 	if (opts->no_commit) {
 		/*
@@ -942,11 +942,23 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	else
 		parent = commit->parents->item;
 
+	if (get_message(commit, &msg) != 0)
+		return error(_("Cannot get commit message for %s"),
+			oid_to_hex(&commit->object.oid));
+
 	if (opts->allow_ff && !is_fixup(command) &&
 	    ((parent && !hashcmp(parent->object.oid.hash, head)) ||
-	     (!parent && unborn)))
-		return fast_forward_to(commit->object.oid.hash, head, unborn, opts);
-
+	     (!parent && unborn))) {
+		if (is_rebase_i(opts))
+			write_author_script(msg.message);
+		res |= fast_forward_to(commit->object.oid.hash, head, unborn,
+			opts);
+		if (res || command != TODO_REWORD)
+			goto leave;
+		edit = amend = 1;
+		msg_file = NULL;
+		goto fast_forward_edit;
+	}
 	if (parent && parse_commit(parent) < 0)
 		/* TRANSLATORS: The first %s will be "revert" or
 		   "cherry-pick", the second %s a SHA1 */
@@ -954,10 +966,6 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 			command_to_string(command),
 			oid_to_hex(&parent->object.oid));
 
-	if (get_message(commit, &msg) != 0)
-		return error(_("Cannot get commit message for %s"),
-			oid_to_hex(&commit->object.oid));
-
 	/*
 	 * "commit" is an existing commit.  We would want to apply
 	 * the difference it introduces since its first parent "prev"
@@ -1083,6 +1091,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		goto leave;
 	}
 	if (!opts->no_commit)
+fast_forward_edit:
 		res |= sequencer_commit(msg_file, opts, allow, edit, amend,
 			cleanup_commit_message);
 
-- 
2.10.0.rc2.102.g5c102ec


