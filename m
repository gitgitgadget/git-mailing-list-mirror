Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0030F1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbcJNNTZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:25 -0400
Received: from mout.gmx.net ([212.227.15.18]:64860 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932578AbcJNNS6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Ltqb7-1cvqAg3HBF-0117Oq; Fri, 14 Oct 2016 15:18:51
 +0200
Date:   Fri, 14 Oct 2016 15:18:37 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 20/25] sequencer: refactor write_message()
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <9a66d53ebd86d35136597e534be03605bb1346bc.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:tVU+TSVv5AezYxPuerTTDYIqb47bEld2UjhuvAjz4W5bjYyE3uH
 ffmBUlNHiNP5T6vsSAUPpW+ZAdAEIqQKn19Hl7lP+f8DkbPERfC/9KLw7NB8T2s7KF5XS7F
 FIQGWXw7vp+rhjM3MfvmT1oDceJr/INaZb8O+GtnSRFJUJJU5DSDO66sNa4BTeX063m75hF
 4FUWQI6aZbYaJOUwlbQmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVHQBvRc20k=:1EJTyJWJu6uAyEv75zUzph
 yL7/EICgcCipahrajjt7FwWeBvUBM2LmaD9AUh/Tn6C9wZw0LBnfKJYygs2tqDzq2oVphBEWg
 q4CocSWOsvraliEMrSjxOFfIlOSPKzhJE1xeJbUO40APYdAPbzbXhLTa24IYXelzdtbeMDKHX
 lR3v6yTMh5jLGmOM+IPCoO3zfpGqIHzbvmf58n+I1Y8CspL/fKnHQQUZP6B03NsQA/MRvUWaM
 gLNscnCne9We2GikHKx9LVYcVajz4vaHlGEec4WEKY5WSYZHLWzg08d2MasJVoYPim+8aKpkU
 AyCUke0iHoR5G4SK4CbihqP2QeUmov43zJ8UGJpm3H/cl6KdM6p4FHf8ITzJmAucZ7XL4HrlK
 oy08juYMQn0W/6tiVCy/5gZIw+fcEvRrLHXNvYI0N4ANJaEXNZMmEVpNHGCIu0touJy5iIfWV
 wgT3R39MRl8gXiBSjoaFWFinvxIJj90st7uh5QCuPOkSgRpiehv2whl4NYSkZKTBYzLlLYwgp
 oLGOQ5kUSbARturuIYpHgk3hOkP20OatpX24UTe5bhvh4J7Vsi25HQLXvS8wqOZwBJbDncMxD
 +cCfyNjhIX1E3JzwnemQ+FvKbB2OmffHGO/LkrhgQdWxl8VsHs1Ld586jFYQ13hGH1ErwbukB
 sWMcwLYCOHsmh3xFgy2XS2WxwP0LxsCSM6ADi1SSEc3FPOn6B8bRoGI2Bbl2TYOLRvkwj3xZH
 VNxFyiyVRKwdqcsfPyGZnNFxlX5BZMLv1Sw+PDDYs1vB1kZ2k1ZDwZ7gMdRsBcPFs8/6v3kdm
 SJ+8UP9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The write_message() function safely writes an strbuf to a file.
Sometimes it is inconvenient to require an strbuf, though: the text to
be written may not be stored in a strbuf, or the strbuf should not be
released after writing.

Let's refactor "safely writing string to a file" into
write_with_lock_file(), and make write_message() use it.

The new function will make it easy to create a new convenience function
write_file_gently() that does not die(); as some of the upcoming callers
of this new function will want to append a newline character, we already
add that flag as parameter to write_with_lock_file().

While at it, roll back the locked files in case of failure, as pointed
out by Hannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 914a576..baccee9 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,22 +234,37 @@ static void print_advice(int show_hint, struct replay_opts *opts)
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
-	if (commit_lock_file(&msg_file) < 0)
+	if (write_in_full(msg_fd, buf, len) < 0) {
+		rollback_lock_file(&msg_file);
+		return error_errno(_("Could not write to '%s'"), filename);
+	}
+	if (append_eol && write(msg_fd, "\n", 1) < 0) {
+		rollback_lock_file(&msg_file);
+		return error_errno(_("Could not write eol to '%s"), filename);
+	}
+	if (commit_lock_file(&msg_file) < 0) {
+		rollback_lock_file(&msg_file);
 		return error(_("Error wrapping up %s."), filename);
+	}
 
 	return 0;
 }
 
+static int write_message(struct strbuf *msgbuf, const char *filename)
+{
+	int res = write_with_lock_file(filename, msgbuf->buf, msgbuf->len, 0);
+	strbuf_release(msgbuf);
+	return res;
+}
+
 /*
  * Reads a file that was presumably written by a shell script, i.e.
  * with an end-of-line marker that needs to be stripped.
-- 
2.10.1.513.g00ef6dd


