Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E20C3208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 09:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbeHGLsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 07:48:37 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:31813 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeHGLsh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 07:48:37 -0400
Received: from lindisfarne.localdomain ([92.22.26.195])
        by smtp.talktalk.net with SMTP
        id myOIfyQGYbZX5myOQf3soB; Tue, 07 Aug 2018 10:35:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533634506;
        bh=D19vGFHkiBv9eSFbmWxqxCy3GSNoyWT0Qd6IqukfN1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=O+NJOc7bvqtqkkOPrn1BTCCofQ/y8EuEjkseHgNbYzhGrOHXu3zmziEmnGG8ymVNI
         CIh603wqfeHPWqkaSZGPEI9/G5Vx2QPqFiU4HHvA/q8Fl9rVlQ7+oUsl5RD4QLrzI7
         +42ZJLEX/21HxrkTR4uTwHq8qpRvVAo+yGt7/EJ0=
X-Originating-IP: [92.22.26.195]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=8bf3kEuDtVJeVZALKX4IsA==:117
 a=8bf3kEuDtVJeVZALKX4IsA==:17 a=evINK-nbAAAA:8 a=BCjA09oAAAAA:8
 a=A1X0JdhQAAAA:8 a=VCa2VAtjGsG_TLzpEEEA:9 a=8GSxMrLjHnXAkoAF:21
 a=ucx3igyUsaJIwT9H:21 a=RfR_gqz1fSpA9VikTjo0:22 a=jYKBPJSq9nmHKCndOPe9:22
 a=Df3jFdWbhGDLdZNm0fyq:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4 2/2] sequencer: fix quoting in write_author_script
Date:   Tue,  7 Aug 2018 10:34:52 +0100
Message-Id: <20180807093452.22524-3-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180807093452.22524-1-phillip.wood@talktalk.net>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180807093452.22524-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfBqTbLJnzWaZzlHB1lGSY7nBdJpUbr0Tl1DL2Bfw5Z0BH1NEDUvK3ihA9jou9KJgEWvmF35wa0mpSgECktJjDM9ZqxhIhZI9a7N2YdKpgwBI4/UBRisb
 QN8YgY9CJhygn+nT7seYkPpcFmcZTHpdORwBFNmAlliLEuoOj+49AMB33utWV6Zx7quQKDZQCbkR+aEMovrzlfzlwj66nz4hMxcEqVJj6zfwZTz55p9bHGoO
 4xREflmS5eqNlljiuvcoaxmN8doEdNrxKNmvpZkLEDEpkyJ4G0kLKY0HXTmMuikNVKdPoJo8HL8Ja/RIqvSoHFCGTRjsPZRiA6rx5qjtbUs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Single quotes should be escaped as \' not \\'. The bad quoting breaks
the interactive version of 'rebase --root' (which is used when there
is no '--onto' even if the user does not specify --interactive) for
authors that contain "'" as sq_dequote() called by read_author_ident()
errors out on the bad quoting.

For other interactive rebases this only affects external scripts that
read the author script and users whose git is upgraded from the shell
version of rebase -i while rebase was stopped when the author contains
"'". This is because the parsing in read_env_script() expected the
broken quoting.

This patch includes code to handle the broken quoting when
git has been upgraded while rebase was stopped. It does this by
detecting the missing "'" at the end of the GIT_AUTHOR_DATE line to see
if it should dequote \\' as "'". Note this is only implemented for
normal picks, not for creating a new root commit (rebase will stop with
an error complaining out bad quoting in that case).

The fallback code has been manually tested by reverting both the quoting
fixes in write_author_script() and the previous fix for the missing "'"
at the end of the GIT_AUTHOR_DATE line and running
t3404-rebase-interactive.sh.

Ideally rebase and am would share the same code for reading and
writing the author script, but this commit just fixes the immediate
bug.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

Notes:
    changes since v3:
    
     - Reverted the implementation to v2 with more robust detection of the
       missing "'" on the last line of the author script based on a
       suggestion by Eric. This means that this series needs to progress
       closely with Eric's series of fixes or the fallback code will never
       be called.
    
    - Tweaked the last test

 sequencer.c                   | 36 ++++++++++++++++++++++++++++-------
 t/t3404-rebase-interactive.sh | 18 +++++++++++++++---
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index c4e4418559..ba11fe5bca 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -636,42 +636,64 @@ static int write_author_script(const char *message)
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
 	return res;
 }
 
+
+/*
+ * write_author_script() used to fail to terminate the last line with a "'" and
+ * also escaped "'" incorrectly as "'\\\\''" rather than "'\\''". We check for
+ * the terminating "'" on the last line to see how "'" has been escaped in case
+ * git was upgraded while rebase was stopped.
+ */
+static int quoting_is_broken(const char *s, size_t n)
+{
+	/* Skip any empty lines in case the file was hand edited */
+	while (n > 0 && s[--n] == '\n')
+		; /* empty */
+	if (n > 0 && s[n] != '\'')
+		return 1;
+
+	return 0;
+}
+
 /*
  * Read a list of environment variable assignments (such as the author-script
  * file) into an environment block. Returns -1 on error, 0 otherwise.
  */
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
-
+	/* write_author_script() used to quote incorrectly */
+	sq_bug = quoting_is_broken(script.buf, script.len);
 	for (p = script.buf; *p; p++)
-		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+		if (sq_bug && skip_prefix(p, "'\\\\''", &p2))
+			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
+		else if (skip_prefix(p, "'\\''", &p2))
 			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
 		else if (*p == '\'')
 			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index b72167ecd5..834a124d60 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1382,9 +1382,21 @@ test_expect_success 'rebase -i --gpg-sign=<key-id> overrides commit.gpgSign' '
 test_expect_success 'valid author header after --root swap' '
 	rebase_setup_and_clean author-header no-conflict-branch &&
 	set_fake_editor &&
-	FAKE_LINES="2 1" git rebase -i --root &&
-	git cat-file commit HEAD^ >out &&
-	grep "^author ..*> [0-9][0-9]* [-+][0-9][0-9][0-9][0-9]$" out
+	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
+	git cat-file commit HEAD | grep ^author >expected &&
+	FAKE_LINES="5 1" git rebase -i --root &&
+	git cat-file commit HEAD^ | grep ^author >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'valid author header when author contains single quote' '
+	rebase_setup_and_clean author-header no-conflict-branch &&
+	set_fake_editor &&
+	git commit --amend --author="Au ${SQ}thor <author@example.com>" --no-edit &&
+	git cat-file commit HEAD | grep ^author >expected &&
+	FAKE_LINES="2" git rebase -i HEAD~2 &&
+	git cat-file commit HEAD | grep ^author >actual &&
+	test_cmp expected actual
 '
 
 test_done
-- 
2.18.0

