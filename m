Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDA071F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756740AbcH2IG3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:29 -0400
Received: from mout.gmx.net ([212.227.17.21]:50206 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756656AbcH2IG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:28 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MACmL-1boxlx3zcP-00BKI6; Mon, 29 Aug 2016 10:06:25
 +0200
Date:   Mon, 29 Aug 2016 10:06:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 18/22] sequencer: support amending commits
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <c4e474af8e6237522f4c452ca90c2e2670059e60.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:L7RXa/iDOg/1GWLBF8OFnMnM1o1EDXEHTu6u/3ZZ9Bh7G31kc9z
 LC2ra4ZzL3+S5o4iAwQeK+WXVS4j042XQwPAIx5nsc+0H8TN0KFtwTrlxluYqsUZmLtOeut
 ukmu00JCcSoQbzRGimfHI0VlxuQ6byKziz9HRzAncpHMyK6LygnkLg9+yh3rKy5avFUkONm
 o1kHMAFg458W3KR7L5ucA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:DvVkJV4dpTk=:QPMGyRKmzK3JyUDrtU85TD
 NV539nxbKWOCbnuEMk/eEHLS9/UWXIk3empyU7kG5qdVJfNkyZ4/RfGGAxXHPWFso7K6qBjVL
 x8LPGhos5XP8uQBYb5g+XshO4kvrG6udx7iOXwNN0K4+gg3zUJO3Ixfs7nEePp1fm9dzHcnUS
 yst3W+1NtwdioLE+/p1ewmUOOkDbIDyn/wD3cgjGOUqAnY4vwMi78fWpCKf9ueAlfeukV53WZ
 NytUyudILXQfKYz405gDQ0vF2ZmHkiV+iFbGPVlclGmt3s3KQjN1eYG1Obvg2ROQ9ugg2WhgL
 B4xC3KT8Tej2YVyaETiNwMB+36wF4V6Mm6NTd30tY59ymoWBlzMfXrCTekz8Q2tqgBIesq7YM
 RFyeSfH6F84kOJXHDz4qEfhVS/9Adp8jcZtGOvVaed3zZNh2OdNitE6yLW20wn4qGjU7HyVsk
 94inmvL09zpovgneoT/Up8vQg4/ue85rVjmM5+SgldbLgVyrT2wikmK4/We41/VxD2dZP0Y4Z
 H6EFR8K/BO+B9YqjjWAjZHlHahWpwuIZNk317sEvVsOyN61rn47cB7e8Ax7bQJA0qZ9I4wyhw
 jP9+X5SdcyOtenFZoO9aYPq3Mhwa83luMD8I7a3kfu5o9WXAU0QCVJq6dV3Aby2NDHOw9xszG
 UrZuL7f4zFFjGZajqW6yQFlQvvW+ICbFFT68irx2U0O/NX0TswUhAWos5Ck97Aw71sCHfRxsK
 1JvcMMHaXNHX3Isa6pg1D7vS6cM0F0HUTrGQXIQgjz6VuZTvSuygToFDQduTJTF+oqFvmUTzW
 +mvLhc0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches the sequencer_commit() function to take an argument that
will allow us to implement "todo" commands that need to amend the commit
messages ("fixup", "squash" and "reword").

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 6 ++++--
 sequencer.h | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 7e17d14..20f7590 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -478,7 +478,7 @@ static char **read_author_script(void)
  * (except, of course, while running an interactive rebase).
  */
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit)
+			  int allow_empty, int edit, int amend)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -507,6 +507,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 	argv_array_push(&array, "commit");
 	argv_array_push(&array, "-n");
 
+	if (amend)
+		argv_array_push(&array, "--amend");
 	if (opts->gpg_sign)
 		argv_array_pushf(&array, "-S%s", opts->gpg_sign);
 	if (opts->signoff)
@@ -779,7 +781,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = sequencer_commit(opts->edit ? NULL : git_path_merge_msg(),
-			opts, allow, opts->edit);
+			opts, allow, opts->edit, 0);
 
 leave:
 	free_message(commit, &msg);
diff --git a/sequencer.h b/sequencer.h
index fd02baf..2106c0d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -50,7 +50,7 @@ int sequencer_rollback(struct replay_opts *opts);
 int sequencer_remove_state(struct replay_opts *opts);
 
 int sequencer_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit);
+			  int allow_empty, int edit, int amend);
 
 extern const char sign_off_header[];
 
-- 
2.10.0.rc1.114.g2bd6b38


