Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE6E71F461
	for <e@80x24.org>; Sun, 25 Aug 2019 04:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfHYEoG (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 00:44:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:60460 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbfHYEoG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 00:44:06 -0400
X-Greylist: delayed 1813 seconds by postgrey-1.27 at vger.kernel.org; Sun, 25 Aug 2019 00:44:05 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <glandium@glandium.org>)
        id 1i1juW-0008IE-4U; Sun, 25 Aug 2019 13:13:48 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH] fast-import: Reinitialize command_buf rather than detach it.
Date:   Sun, 25 Aug 2019 13:13:48 +0900
Message-Id: <20190825041348.31835-1-mh@glandium.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

command_buf.buf is also stored in cmd_hist, so instead of
strbuf_release, the current code uses strbuf_detach in order to
"leak" the buffer as far as the strbuf is concerned.

However, strbuf_detach does more than "leak" the strbuf buffer: it
possibly reallocates it to ensure a terminating nul character. And when
that happens, what is already stored in cmd_hist may now be a free()d
buffer.

In practice, though, command_buf.buf is most of the time a nul
terminated string, meaning command_buf.len < command_buf.alloc, and
strbuf_detach is a no-op. BUT, when it's not (e.g. on the first call),
command_buf.buf is &strbuf_slopbuf. In that case, strbuf_detach does
allocate a 1 byte buffer to store a nul character in it, which is then
leaked.

Since the code using strbuf_detach is assuming it does nothing to
command_buf.buf, it's overall safer to use strbuf_init, which has
the same practical effect in the usual case, and works appropriately
when command_buf is empty.
---
 fast-import.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..b1d07efe8c 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1763,7 +1763,9 @@ static int read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			strbuf_detach(&command_buf, NULL);
+			// command_buf is enther empty or also stored in cmd_hist,
+			// reinitialize it.
+			strbuf_init(&command_buf, 0);
 			stdin_eof = strbuf_getline_lf(&command_buf, stdin);
 			if (stdin_eof)
 				return EOF;
@@ -1833,7 +1835,9 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 		char *term = xstrdup(data);
 		size_t term_len = command_buf.len - (data - command_buf.buf);
 
-		strbuf_detach(&command_buf, NULL);
+		// command_buf is enther empty or also stored in cmd_hist,
+		// reinitialize it.
+		strbuf_init(&command_buf, 0);
 		for (;;) {
 			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
 				die("EOF in data (terminator '%s' not found)", term);
-- 
2.23.0

