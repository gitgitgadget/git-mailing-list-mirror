Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81DDA1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 11:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGaMzh (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 08:55:37 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:36262 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729273AbeGaMzg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 08:55:36 -0400
Received: from lindisfarne.localdomain ([92.22.0.63])
        by smtp.talktalk.net with SMTP
        id kScrfkUhMbZX5kSczf0evE; Tue, 31 Jul 2018 12:15:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533035746;
        bh=LIAVRm95NqxPZs3LiEwnbU1YrTPkSiXm7fmr/wj6L5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=J+whvbUL7yuN3KlNmv0LVY8fEIzrSponEfZgSltUd8MlZPvKsw2mCscDI/ySe277W
         FQs9YAVA6TJ4J+80l4HGiILPqALTxjUhPaJVhZG7sONoVaEz7wvSa1xxOhn4hL/yEg
         9sbJSGy05B8k6fTIbT+P418Oo36YKvRgMFdomR40=
X-Originating-IP: [92.22.0.63]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=ohMtzhKkgcX7CUCE/LoB2A==:117
 a=ohMtzhKkgcX7CUCE/LoB2A==:17 a=evINK-nbAAAA:8 a=bgzLuWNqvIMvi-oUiE0A:9
 a=olf2vpewWahKpvD0:21 a=zzWfwAIsZgOXDJQ3:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v2 2/2] sequencer: fix quoting in write_author_script
Date:   Tue, 31 Jul 2018 12:15:32 +0100
Message-Id: <20180731111532.9358-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731111532.9358-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180731111532.9358-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfPshlSfRgWIhePQzdpI0cGgL0oOGiEuJGoUf1609f0DCG23EA8CI84uczHqJxQ2cqWGKISvFsUjLxg01xn9XkE+Gjz/OOboUVnOo1rIhrRXRiVaTANaA
 XlaZrdsmJiOXM+P8M328+JTdKlcC219H/5h+X4ISHOjeUzPmfZPfg2u1/In+QYsSFm5Mygk4XI6p8MIuP3+tWW/EhO9yAdxXkYuDnm5JGALJmUflnliM1Sej
 8Tmbj9OgQYa/M5e1JpGyFjw54Xoayw+eaKHFn8k2nIX2okV3pEc0h++2FBWbSfSZo1J2DzlfwygXU1C9ChJCJHzXQOLjiCb4yKRSHA71bbA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Single quotes should be escaped as \' not \\'. Note that this only
affects authors that contain a single quote and then only external
scripts that read the author script and users whose git is upgraded from
the shell version of rebase -i while rebase was stopped. This is because
the parsing in read_env_script() expected the broken version and for
some reason sq_dequote() called by read_author_ident() seems to handle
the broken quoting correctly.

Ideally rebase and am would share the same code for reading and
writing the author script, but this commit just fixes the immediate
bug.

The test is based on an original by Akinori MUSHA which was designed to
check that the author script was parsable by posix shell.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c                   | 23 +++++++++++++++++------
 t/t3404-rebase-interactive.sh | 17 ++++++++++++++++-
 2 files changed, 33 insertions(+), 7 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 212b912420..b6e17c1c32 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -636,21 +636,21 @@ static int write_author_script(const char *message)
 		else if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addstr(&buf, "'\nGIT_AUTHOR_EMAIL='");
 	while (*message && *message != '\n' && *message != '\r')
 		if (skip_prefix(message, "> ", &message))
 			break;
 		else if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addstr(&buf, "'\nGIT_AUTHOR_DATE='@");
 	while (*message && *message != '\n' && *message != '\r')
 		if (*message != '\'')
 			strbuf_addch(&buf, *(message++));
 		else
-			strbuf_addf(&buf, "'\\\\%c'", *(message++));
+			strbuf_addf(&buf, "'\\%c'", *(message++));
 	strbuf_addch(&buf, '\'');
 	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
 	strbuf_release(&buf);
@@ -664,14 +664,25 @@ static int write_author_script(const char *message)
 static int read_env_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
-	int i, count = 0;
-	char *p, *p2;
+	int i, count = 0, sq_bug;
+	const char *p2;
+	char *p;
 
 	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
 		return -1;
 
+	/*
+	 * write_author_script() used to fail to terminate the GIT_AUTHOR_DATE
+	 * line with a "'" and also escaped "'" incorrectly as "'\\\\''" rather
+	 * than "'\\''". We check for the terminating "'" on the last line to
+	 * see how "'" has been escaped in case git was upgraded while rebase
+	 * was stopped.
+	 */
+	sq_bug = script.len && script.buf[script.len - 2] != '\'';
 	for (p = script.buf; *p; p++)
-		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+		if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
+			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
+		else if (skip_prefix(p, "'\\''", &p2))
 			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
 		else if (*p == '\'')
 			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b72167ecd5..ae9036d4d9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -75,6 +75,22 @@ test_expect_success 'rebase --keep-empty' '
 	test_line_count = 6 actual
 '
 
+SQ="'"
+test_expect_success 'rebase -i writes correct author-script' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	git checkout -b author-with-sq master &&
+	GIT_AUTHOR_NAME="Auth O$SQ R" git commit --allow-empty -m with-sq &&
+	set_fake_editor &&
+	FAKE_LINES="edit 1" git rebase -ki HEAD^ &&
+	tail -n1 .git/rebase-merge/author-script | grep "$SQ\$" &&
+	(
+		sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE &&
+		. .git/rebase-merge/author-script &&
+		test "$(git show -s --date=raw --format=%an,%ae,@%ad)" = \
+			"Auth O$SQ R,$GIT_AUTHOR_EMAIL,$GIT_AUTHOR_DATE"
+	)
+'
+
 test_expect_success 'rebase -i with the exec command' '
 	git checkout master &&
 	(
@@ -1361,7 +1377,6 @@ test_expect_success 'editor saves as CR/LF' '
 	)
 '
 
-SQ="'"
 test_expect_success 'rebase -i --gpg-sign=<key-id>' '
 	test_when_finished "test_might_fail git rebase --abort" &&
 	set_fake_editor &&
-- 
2.18.0

