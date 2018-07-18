Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD651F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbeGRQeE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:34:04 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:32937 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbeGRQeE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:34:04 -0400
Received: from lindisfarne.localdomain ([92.22.19.104])
        by smtp.talktalk.net with SMTP
        id fonPfIdwgVlGZfonXfiwAG; Wed, 18 Jul 2018 16:55:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1531929329;
        bh=V8MxgbXLZUCyn544KHGSxqwI0uIeULOWDTiLD94tSQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=VqPQkYRS4216NZZiU91YZTpVXkAyh7swiJf6klz/QdkRCmAyYJ2U5dBWIa42fm80M
         C/CL0cjMm/dlAAoIjNUvd7GHUxXqql/qf7K4csbUR75D0Y+76fzfCeNHNXXK8pgqGw
         suMR+8mf0qYQGw+AZHIx7PFN4JO+m8ZRkCaowMyk=
X-Originating-IP: [92.22.19.104]
X-Spam: 0
X-OAuthority: v=2.3 cv=JcuSU3CV c=1 sm=1 tr=0 a=f/8ZdrXn5sPnqdHA06GUHw==:117
 a=f/8ZdrXn5sPnqdHA06GUHw==:17 a=evINK-nbAAAA:8 a=XfR03bueP5RTgS1P8tkA:9
 a=NDqiHMlFLoMj-y0G:21 a=yOuVjcXvY0fumi6z:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH] sequencer: fix quoting in write_author_script
Date:   Wed, 18 Jul 2018 16:55:18 +0100
Message-Id: <20180718155518.1025-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
References: <eb295aea-dae5-5e1c-bacf-2c77d3ce0195@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfHPVP0aa7bzpwgy9Ipk0xN7dexomaGVcZg0RP4CivgKafFmiCna9s/nMae8wlThIk/hq/O8JUeVeNWX20V/WqKd2Z3/rA8Rt7YHIr5RMHjs6vI3K36H0
 D+mutJCIr2gNmNji6dn67+a2arnlFsnNXveiiA3gG9UCQtCmvZlG4k7pRKd2qA6zdAPFVH/G4E/qV8NG4Ot6Fv20xOA4LLDhQkjbiR9eVYsaDTzQvFiMn68f
 B90hquJjCHsu3UmyH7iSypuBaQmr9SzSQDOgr0ialRGT5kEnVm3vS25PCP+o8fFBkNXJt8J2f/JoBec1+0yajg==
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

Ideally write_author_script() would be rewritten to use
split_ident_line() and sq_quote_buf() but this commit just fixes the
immediate bug.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---

This is untested, unfortuantely I don't have really have time to write a test or
follow this up at the moment, if someone else want to run with it then please
do.

sequencer.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..0b78d1f100 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -638,21 +638,21 @@ static int write_author_script(const char *message)
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
 	res = write_message(buf.buf, buf.len, rebase_path_author_script(), 1);
 	strbuf_release(&buf);
 	return res;
@@ -666,13 +666,21 @@ static int read_env_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
 	int i, count = 0;
-	char *p, *p2;
+	const char *p2;
+	char *p;
 
 	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
 		return -1;
 
 	for (p = script.buf; *p; p++)
-		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
+		/*
+		 * write_author_script() used to escape "'" incorrectly as
+		 * "'\\\\''" rather than "'\\''" so we check for the correct
+		 * version the incorrect version in case git was upgraded while
+		 * rebase was stopped.
+		 */
+		if (skip_prefix(p, "'\\''", &p2) ||
+		    skip_prefix(p, "'\\\\''", &p2))
 			strbuf_splice(&script, p - script.buf, p2 - p, "'", 1);
 		else if (*p == '\'')
 			strbuf_splice(&script, p-- - script.buf, 1, "", 0);
-- 
2.18.0

