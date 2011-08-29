From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] strbuf_grow(): maintain nul-termination even for new buffer
Date: Mon, 29 Aug 2011 23:16:12 +0200
Message-ID: <c8d8686c1813885a36d8f4cada218686989df236.1314651926.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 23:16:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qy9Bs-0000P2-T1
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 23:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab1H2VQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 17:16:15 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:53415 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab1H2VQO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 17:16:14 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 23:16:11 +0200
Received: from localhost.localdomain (129.132.153.219) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.289.1; Mon, 29 Aug
 2011 23:16:12 +0200
X-Mailer: git-send-email 1.7.7.rc0.370.gdcae57
X-Originating-IP: [129.132.153.219]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180354>

In the case where sb is initialized to the slopbuf (through
strbuf_init(sb,0) or STRBUF_INIT), strbuf_grow() loses the terminating
nul: it grows the buffer, but gives ALLOC_GROW a NULL source to avoid
it being freed.  So ALLOC_GROW does not copy anything to the new
memory area.

This subtly broke the call to strbuf_getline in read_next_command()
[fast-import.c:1855], which goes

    strbuf_detach(&command_buf, NULL);  # command_buf is now = STRBUF_INIT
    stdin_eof = strbuf_getline(&command_buf, stdin, '\n');
    if (stdin_eof)
            return EOF;

In strbuf_getwholeline, this did

    strbuf_grow(sb, 0);  # loses nul-termination
    if (feof(fp))
            return EOF;
    strbuf_reset(sb);    # this would have nul-terminated!

Valgrind found this because fast-import subsequently uses prefixcmp()
on command_buf.buf, which after the EOF exit contains only
uninitialized memory.

Arguably strbuf_getwholeline is also broken, in that it touches the
buffer before deciding whether to do any work.  However, it seems more
futureproof to not let the strbuf API lose the nul-termination by its
own fault.

So make sure that strbuf_grow() puts in a nul even if it has nowhere
to copy it from.  This makes strbuf_grow(sb, 0) a semantic no-op as
far as readers of the buffer are concerned.

Also remove the nul-termination added by strbuf_init, which is made
redudant.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Only found this now because the bug is only triggered by the tests
added in 4cedb78 (fast-import: add input format tests, 2011-08-11).


 strbuf.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 1a7df12..4556f96 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -30,10 +30,8 @@ void strbuf_init(struct strbuf *sb, size_t hint)
 {
 	sb->alloc = sb->len = 0;
 	sb->buf = strbuf_slopbuf;
-	if (hint) {
+	if (hint)
 		strbuf_grow(sb, hint);
-		sb->buf[0] = '\0';
-	}
 }
 
 void strbuf_release(struct strbuf *sb)
@@ -65,12 +63,15 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
 
 void strbuf_grow(struct strbuf *sb, size_t extra)
 {
+	int new_buf = !sb->alloc;
 	if (unsigned_add_overflows(extra, 1) ||
 	    unsigned_add_overflows(sb->len, extra + 1))
 		die("you want to use way too much memory");
-	if (!sb->alloc)
+	if (new_buf)
 		sb->buf = NULL;
 	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
+	if (new_buf)
+		sb->buf[0] = '\0';
 }
 
 void strbuf_trim(struct strbuf *sb)
-- 
1.7.7.rc0.370.gdcae57
