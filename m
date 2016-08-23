Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E0D11FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753830AbcHWQHj (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:07:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:51402 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbcHWQHQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:07:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Las1k-1as8u70eng-00kOwk; Tue, 23 Aug 2016 18:06:39
 +0200
Date:   Tue, 23 Aug 2016 18:06:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 01/15] sequencer: lib'ify write_message()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <6dc5e927cbdd1847db5b6cd75041609dd1e1f76d.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FTrmXm2tmgjGbdVETJoU/zjsBSle88FjTkxzWKd4NI1pQk/XlKJ
 RSPGd9usfV61WR/NOfIX7byDzpvPw5+NngUZ+pfhTK6rMjqSfGNbu0qC18pJKAw7DUGvtk0
 hWkxPXA+Ul4+nf9/A7gGkrizbaPlvsg1MyGRb7PD1TqNnj3MA2DSSPg1GbqkGNizyIXlpAL
 065ADci9SCoV/VWHM4/+g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lMSK8gJ7vYY=:eSVFaq72/6iT9RmVLODEWT
 osgVTfe1QHxvhfHKtVf8DpXjv94l1EsmAqapc8DwCSrz7dmzJZZaKzPaUgqHi/ZW7LmCB38fS
 x2MyVqsM+Yx2tEhKpu6UHYS1Pz1/mv+OkdakAgunYTXW/G488jqudY1MF8ywyr99TbN04Ho6f
 BypP4jQ44VmTy1nTUtAMSvGyqvLFtuU+Px8xX5gFpVn/zTl1GXBzFdUt92szAB9jNLEmOiwRE
 12SqHbjPAKQVYYA8lfrN3iD8aNFKFiSTzFNxa8+udbzu+txVtvISrR3swBvpsYddnxMYJltti
 GHF959//6UK5e+MO9ijmE7ArL3hQ5HQpu1JaduOro8K2+AhfudjwtrPph0rO4z1vjVBtmXhFp
 XrKWnTgUa/Ecctxo9dBwzxFGtwbY2uGKLavuJ/yYrJJW98LMQvnbzwGPWE+9BWVprgBKxmUQR
 Jnw2bEswshEHyXhJJhp1ahESB0c7g8gSmkBjKFLVxEidbZS5ePdyf8z1OZF0jHoZ34FrfBavO
 kmvohertSZTM26Bb1ZNAzdoHz76kyEXUNuP3XHbbqqiCCp8vUkbvmVbBS9myUu8keQe1f9F+t
 ikTFSd22ZrkkdIXxlu7w3WCH9UkGj88JEI3CGs0HWz6MHxmUIH13QUbrzUCpsGAH3hQfmfNqR
 ekYQtdFnejFSkEjIApjky1bVixoboD2PhKUNr3Q1ozIJx2Qh0j/U8qDJy+NgZW35gVblcl4gt
 fpK5twTc0uVyLL2kEEc+YahEiCRMFlo1PaVFBklMjpnNcealLFpRfqfoh0XgnqlEFPREY8Uk7
 Ja+qMfH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 2e9c7d0..c75296c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -180,17 +180,20 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-					       LOCK_DIE_ON_ERROR);
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+	if (msg_fd < 0)
+		return error_errno(_("Could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s"), filename);
+		return error_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s."), filename);
+		return error(_("Error wrapping up %s."), filename);
+
+	return 0;
 }
 
 static struct tree *empty_tree(void)
@@ -564,16 +567,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
-		write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		write_message(&msgbuf, git_path_merge_msg());
+		res = write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+		res |= try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
 					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
-- 
2.10.0.rc1.99.gcd66998


