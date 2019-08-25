Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F141A1F461
	for <e@80x24.org>; Sun, 25 Aug 2019 08:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfHYIK5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 04:10:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:54830 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725995AbfHYIK4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 04:10:56 -0400
Received: (qmail 11900 invoked by uid 109); 25 Aug 2019 08:10:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 25 Aug 2019 08:10:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10157 invoked by uid 111); 25 Aug 2019 08:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 25 Aug 2019 04:12:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 25 Aug 2019 04:10:55 -0400
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: [PATCH 2/2] fast-import: duplicate into history rather than passing
 ownership
Message-ID: <20190825081055.GB31824@sigill.intra.peff.net>
References: <20190825080640.GA31453@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190825080640.GA31453@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fast-import's read_next_command() has somewhat odd memory ownership
semantics for the command_buf strbuf. After reading a command, we copy
the strbuf's pointer (without duplicating the string) into our cmd_hist
array of recent commands. And then when we're about to read a new
command, we clear the strbuf by calling strbuf_detach(), dropping
ownership from the strbuf (leaving the cmd_hist reference as the
remaining owner).

This has a few surprising implications:

  - if the strbuf hasn't been copied into cmd_hist (e.g., because we
    haven't ready any commands yet), then the strbuf_detach() will leak
    the resulting string

  - any modification to command_buf risks invalidating the pointer held
    by cmd_hist. There doesn't seem to be any way to trigger this
    currently (since we tend to modify it only by detaching and reading
    in a new value), but it's subtly dangerous.

  - any pointers into an input string will remain valid as long as
    cmd_hist points to them. So in general, you can point into
    command_buf.buf and call read_next_command() up to 100 times before
    your string is cycled out and freed, leaving you with a dangling
    pointer. This makes it easy to miss bugs during testing, as they
    might trigger only for a sufficiently large commit (e.g., the bug
    fixed in the previous commit).

Instead, let's make a new string to copy the command into the history
array, rather than having dual ownership with the old. Then we can drop
the strbuf_detach() calls entirely, and just reuse the same buffer
within command_buf over and over. We'd normally have to strbuf_reset()
it before using it again, but in both cases here we're using
strbuf_getline(), which does it automatically for us.

This fixes the leak, and it means that even a single call to
read_next_command() will invalidate any held pointers, making it easier
to find bugs. In fact, we can drop the extra input lines added to the
test case by the previous commit, as the unfixed bug would now trigger
just from reading the commit message, even without any modified files in
the commit.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Jeff King <peff@peff.net>
---
 fast-import.c          | 4 +---
 t/t9300-fast-import.sh | 5 -----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index ee7258037a..1f9160b645 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1763,7 +1763,6 @@ static int read_next_command(void)
 		} else {
 			struct recent_command *rc;
 
-			strbuf_detach(&command_buf, NULL);
 			stdin_eof = strbuf_getline_lf(&command_buf, stdin);
 			if (stdin_eof)
 				return EOF;
@@ -1784,7 +1783,7 @@ static int read_next_command(void)
 				free(rc->buf);
 			}
 
-			rc->buf = command_buf.buf;
+			rc->buf = xstrdup(command_buf.buf);
 			rc->prev = cmd_tail;
 			rc->next = cmd_hist.prev;
 			rc->prev->next = rc;
@@ -1833,7 +1832,6 @@ static int parse_data(struct strbuf *sb, uintmax_t limit, uintmax_t *len_res)
 		char *term = xstrdup(data);
 		size_t term_len = command_buf.len - (data - command_buf.buf);
 
-		strbuf_detach(&command_buf, NULL);
 		for (;;) {
 			if (strbuf_getline_lf(&command_buf, stdin) == EOF)
 				die("EOF in data (terminator '%s' not found)", term);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index cf66b40ebc..141b7fa35e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3314,11 +3314,6 @@ test_expect_success 'X: handling encoding' '
 
 	printf "Pi: \360\nCOMMIT\n" >>input &&
 
-	for i in $(test_seq 100)
-	do
-		echo "M 644 $EMPTY_BLOB file-$i"
-	done >>input &&
-
 	git fast-import <input &&
 	git cat-file -p encoding | grep $(printf "\360") &&
 	git log -1 --format=%B encoding | grep $(printf "\317\200")
-- 
2.23.0.478.g23872bed7d
