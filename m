Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC87E1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756778AbcH2IGv (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:51 -0400
Received: from mout.gmx.net ([212.227.15.15]:60285 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756764AbcH2IGu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:50 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MaqeA-1bOG6u3pEo-00KMbF; Mon, 29 Aug 2016 10:06:47
 +0200
Date:   Mon, 29 Aug 2016 10:06:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/22] sequencer: refactor write_message()
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <cb4253698ae3eca066c031e0aec4e83ede1fa3e5.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:mPvDrFQ8vFhe81ulKk6S1WqrbvabCGTTs1W53T4DkIInUvi8rsA
 oxUIZjCHbo2NnnJ6pZB0By/jyxyhvoTkBEQnTtNXTgaGd0j4dqPpHXbp4YGv7luJ+BWLhfd
 5gWvPOuM3wC1/NkGUULP9pCG8pL68tOHMKW3Ofw+2PLpNMWYcg5WB68FwuP/UDWjrOhp8Qy
 j5FLXGyFd7u/eL96O2myw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7HODeZTPYyo=:FkIa9K+4RvdYmphZm/bGnS
 vB3PjmaFhOvup/2YtPGgRZ/WeVkhU8E5x82ttzIcHpn2v0SlZsuRwSYwTx3KdQ0FxLswZVllK
 0Y5F2fhByd9+rhj8m7cjQGNicNcAE7EL9M6GW3GfW/BelHTFiLJNc7WrfCky8wlwbwXxpD9Mk
 vi+330yNoV2j26iXzVwHBwFSfCewaNEHCjwsyog7am9MoycQJQoJ87zzxAUyPhPgES9ADvfRh
 5aQR5T/eHhBN3IicLU7MQdrXaHmK2scGez2ThUmwGlwdyeYZshTUySiCEC1bXR0oPAm1d2Lac
 qtC0lcrxtS0p9zf9+8Q3jpUoNJvr3VYkXBaV1kOeN9NwOXQZTViDJvxH9Y0INjjlCT44mNrhR
 rZ+5yIiUFT9uEj30aVo93JluaFpqtey6OXrbMbjxWicDJUhos0Jao8sT5AkO6lddYb/RDMOVj
 VA+tvzS6RIGsuWxn4ouZrpq0xorUCMybD0Kz7IMRU+euZ7DvwO6ds8phUM9AloIGccX5UltX1
 H2TgRQ7jeU/yR0aEDfBwe+dTd6PEEncZdoA8vnO0YTkzHWk7lsducYwyXtOCykYbeN/ihtpNT
 cM6m7p/LyXmr/PykcM/dhhRzSLmUmFKydaANqMcBFe1DjzWa6L3q4Y8fXKlSN/sfOkVfQI3oL
 zBorZtuSMB1yDJiFpiUhC9KXj0fR7zYuJ9p4Hk/yCoZ4+XLjV9FP+LXh0t9IHdvFxQnwAz6j7
 WbkbHPH3uLaINDE02EQNNud+Ycefhxkmde/ZwtSkzQtI1/7coo3hxE29dA7cdTms/iYqEH5Ug
 3wjOLJx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_message() function safely writes an strbuf to a file.
Sometimes this is inconvenient, though: the text to be written may not
be stored in a strbuf, or the strbuf should not be released after
writing.

Let's allow for such use cases by refactoring write_message() to allow
for a convenience function write_file_gently(). As some of the upcoming
callers of that new function will want to append a newline character,
let's just add a flag for that, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5efed2e..f5b5e5e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -239,22 +239,37 @@ static void print_advice(int show_hint, struct replay_opts *opts)
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
+	if (write_in_full(msg_fd, buf, len) < 0)
 		return error_errno(_("Could not write to %s"), filename);
-	strbuf_release(msgbuf);
+	if (append_eol && write(msg_fd, "\n", 1) < 0)
+		return error_errno(_("Could not write eol to %s"), filename);
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
2.10.0.rc1.114.g2bd6b38
