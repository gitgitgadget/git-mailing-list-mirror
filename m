Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BA65209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753371AbcJJR00 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:26 -0400
Received: from mout.gmx.net ([212.227.15.19]:60902 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753359AbcJJR0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:25 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lug4m-1atslx1dHk-00zkNz; Mon, 10 Oct 2016 19:26:21
 +0200
Date:   Mon, 10 Oct 2016 19:26:20 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 20/25] sequencer: refactor write_message()
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <2365ff42eec1c795a4b9caf1f419cd5eb8137965.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+lc9RbgxWUuUIChmQoiO3+jumPHTVQvovxJPMd5VKEcplDYp+Ki
 U3JV/1Scf5lj7koivKSiKriUlhjOjHlQoFa+3+F1KneGceV5vfQSFKUtdC9NG2Q9MQgtLLb
 S3BgEmBkqXKXNGEh61a71Mqbke0VBl2Fj+5Hle3ApDDDH/irTopy1w7QofP8HT5aFPc5OPI
 wz2NKSvNoRNZopojRdIAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jwArQWnAmUU=:h4ZIoRMKlH4ZwvouphZqof
 4ElQl2p6kE+70xAcr5JEI4ZqW/XUuczqzX6eTGt36Zyj2nRgM9XDKmEHD25w6yXQM/RdvaTzv
 qjh9ibG56m05sNl07fhKGN/z16mrFvMe3a08zvikUhGlGqTir7YWH3TdWW6lYAAfIs9qhyJhX
 u+yFBvels07gK95bTWHGIoQT04XrE7RMHHiQL32qIVrpNIEPSecGdWtdC1TfC9C5rneCGLizv
 RSuN8ZWqAhaByuS2J4Kjo678lj5LqgkVbgHl9s4r4e4rIzZNyPqCERovBT6DMF6FdtOIz+AJb
 eGVYwZdrwppQKA0KKmvcMZuaFyxRBfs3C1OvQjhaGri4hCZzc1h+dOFjcMERBJVOCVQ8gMTHM
 +kB/KycsxkgpQ09yCyt14yXWVri65gRBGwxq8uUJ40Pbl0odd/+Sb9PXy7JApCTWN8OPxLPbC
 sFtatMsZgpEPUJwq+eR57K6HdG/FAGv47BQPzr+9vAsRT3cROElq6LD4UmCJOYvzfDlohoOQb
 m24/PP/BKX+ma8NDutzwEPoEOSBrAZ+0nZBeTUAuts+MTwanYI2ML7MjnL5uEX8XeuCaoCTz1
 1xwAO/NXjPgK8iZM5t6bhYkEFTQ/LvbzQK48zWM/UtcxbLgib0A06q/wsA38+aMttYI5HgM8f
 UvJKQHinwELvcEtWQvLU7T5DsjiaAqgRq3JVTRZwQkYMk+z8lZtQpFOkWSjjH4XhY9f+IaNqP
 0/wmefCH+Hw5GkwOjbogFsHdh7Yfkc1+EpFdkHV5o1db1kl9YN65Lz0aMMygCBBwFxI4qnwip
 FK/HG5u
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

While at it, roll back the locked files in case of failure, as pointed
out by Hannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 45a3651..5cca8d8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,22 +234,43 @@ static void print_advice(int show_hint, struct replay_opts *opts)
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
2.10.0.windows.1.325.ge6089c1


