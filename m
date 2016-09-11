Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48E12207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 10:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755951AbcIKKzz (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 06:55:55 -0400
Received: from mout.gmx.net ([212.227.17.21]:60296 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755938AbcIKKzx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 06:55:53 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lyi0B-1avylO1WQp-01665w; Sun, 11 Sep 2016 12:55:49
 +0200
Date:   Sun, 11 Sep 2016 12:55:48 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 21/25] sequencer: refactor write_message()
In-Reply-To: <cover.1473590966.git.johannes.schindelin@gmx.de>
Message-ID: <da2293aee439da2274e30304e2d1f097b9644e64.1473590966.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de> <cover.1473590966.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jBlRxlw9VmBThiPFUopnBcbxeZcV445THEb3UWGhy/SH6blqPP2
 7x0awwU4EjGMCeRD8uBc3dzd1nC+kexAxbhvFfJPcglPfm4qSXE9WoydqWohQaqrILUUog5
 fPvTovkiPCiKSO+EJNToLoWCHuIWF/TKIHY9oj//iipqULQ67YpQa9Ta74MlJtDu9nu4c4p
 63V5zcpFIyGsSgQDO6D6w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZroMqvGXA1A=:/lQ0vCcZH7dscGeLIVMK65
 6kKwvY2mbtRM0y+gh5net584gDH+CzrziMD8xNGRkGxxuj7axVnf/H4C/2Izeezh3u/Psc/X+
 +XO+OnL8R6x4aO0U4tYoSuVhEj9zB2K+fOK1gn5qX23aourlU9zjYEUxnqCn82IdIPNvEawWU
 sBAhCfGecDQJ3l/ZGBN4P9zO8vM/CChE21127hU1JgYpgpd0XxdxAa4Zz8HOLFVgkWxvMzpXM
 HmYjvs/HdtoYD1qen2LxbxV7sFnXhjBlta9fdb7StMZBqax/CQmoCGjM+/c9ir4UiZGH8wjqc
 TxQsKUOktEq1OydZSYevourA8UtC4QkJ2eX/VHjf5B7ktNi5PUXwokJqIKCnwxzo3qc5aeJHC
 Fku1hM8yhC5G01uPlEU7HMjOi1DkNGRBF+owmYWUpZuJI4BjbScvreBEfbQCtsc4tGvLBR16V
 nOLnf+j8uWwabJqRQJcOeW5YOpr6hLF15kPjxb+mcE2YqvJcMVmexZbkYqUMiQ5sIDp4/YStG
 SDLsmnVo2YPxxFDB4D29jdu1aQhCpt0dFVYfMbgiDdo+TXWgOyHoW2uMGwOO7IzuliRoauUyv
 HTAXGYdd5zrB3b66sb2A38j7jaLZxLjQvsZ5p8gWbE7/+mnJypsXA2vN6vL+tbdfrDz228jcr
 IELBjoeo0Ahc234lkFImiAaxt1k/5t0Zxj76yKPON14Y46EvQri8jv5rPOQ/1T3O8fFT60MSw
 EF8/sU3nooPXY/P+BPmJ/NT37PmaRnbQD4DuPOgOdcpaLCQg9ptZ9CDDo1wgnVb6PvWxnjMnP
 TkAGFJ/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_message() function safely writes an strbuf to a file.
Sometimes it is inconvenient to require an strbuf, though: the text to
be written may not be stored in a strbuf, or the strbuf should not be
released after writing.

Let's refactor "safely writing string to a file" into
write_with_lock_file(), and make write_message() use it. The new
function makes it easy to create new convenience function
write_file_gently(); as some of the upcoming callers of this new
function would want to append a newline character, add a flag for it in
write_file_gently(), and thus in write_with_lock_file().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5e5d113..aa949d4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -242,22 +242,37 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(struct strbuf *msgbuf, const char *filename)
+static int write_with_lock_file(const char *filename,
+				const void *buf, size_t len, int append_eol)
 {
 	static struct lock_file msg_file;
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
 	if (msg_fd < 0)
 		return error_errno(_("Could not lock '%s'"), filename);
-	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		return error_errno(_("Could not write to %s"), filename);
-	strbuf_release(msgbuf);
+	if (write_in_full(msg_fd, buf, len) < 0)
+		return error_errno(_("Could not write to '%s'"), filename);
+	if (append_eol && write(msg_fd, "\n", 1) < 0)
+		return error_errno(_("Could not write eol to '%s"), filename);
 	if (commit_lock_file(&msg_file) < 0)
 		return error(_("Error wrapping up %s."), filename);
 
 	return 0;
 }
 
+static int write_message(struct strbuf *msgbuf, const char *filename)
+{
+	int res = write_with_lock_file(filename, msgbuf->buf, msgbuf->len, 0);
+	strbuf_release(msgbuf);
+	return res;
+}
+
+static int write_file_gently(const char *filename,
+			     const char *text, int append_eol)
+{
+	return write_with_lock_file(filename, text, strlen(text), append_eol);
+}
+
 /*
  * Reads a file that was presumably written by a shell script, i.e.
  * with an end-of-line marker that needs to be stripped.
-- 
2.10.0.windows.1.10.g803177d


