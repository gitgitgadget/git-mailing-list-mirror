From: Jeff King <peff@peff.net>
Subject: [PATCH] strbuf_getwholeline: NUL-terminate getdelim buffer on error
Date: Sat, 5 Mar 2016 13:43:30 -0500
Message-ID: <20160305184330.GA7534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 19:43:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acHAx-0005mO-OH
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 19:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbcCESnf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 13:43:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:55257 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750940AbcCESnd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 13:43:33 -0500
Received: (qmail 2770 invoked by uid 102); 5 Mar 2016 18:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 13:43:32 -0500
Received: (qmail 11106 invoked by uid 107); 5 Mar 2016 18:43:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Mar 2016 13:43:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Mar 2016 13:43:30 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288319>

Commit 0cc30e0 (strbuf_getwholeline: use getdelim if it is
available, 2015-04-16) tries to clean up after getdelim()
returns EOF, but gets one case wrong, which can lead in some
obscure cases to us reading uninitialized memory.

After getdelim() returns -1, we re-initialize the strbuf
only if sb->buf is NULL. The thinking was that either:

  1. We fed an existing allocated buffer to getdelim(), and
     at most it would have realloc'd, leaving our NUL in
     place.

  2. We didn't have a buffer to feed, so we gave getdelim()
     NULL; sb->buf will remain NULL, and we just want to
     restore the empty slopbuf.

But that second case isn't quite right. getdelim() may
allocate a buffer, write nothing into it, and then return
EOF. The resulting strbuf rightfully has sb->len set to "0",
but is missing the NUL terminator in the first byte.

Most call-sites are fine with this. They see the EOF and
don't bother looking at the strbuf. Or they notice that
sb->len is empty, and don't look at the contents. But
there's at least one case that does neither, and relies on
parsing the resulting (possibly zero-length) string:
fast-import. You can see this in action with the new test
(though we probably only notice failure there when run with
--valgrind or ASAN).

We can fix this by unconditionally resetting the strbuf when
we have a buffer after getdelim(). That fixes case 2 above.
Case 1 is probably already fine in practice, but it does not
hurt for us to re-assert our invariants (especially because
we are relying on whatever getdelim() happens to do, which
may vary from platform to platform). Our fix covers that
case, too.

Signed-off-by: Jeff King <peff@peff.net>
---
Not a big rush for 2.8.0-rc, as the bug is in v2.5.0, and I doubt
there's an easy trigger besides fast-import. But it might be harmless
enough to squeeze in.

 strbuf.c               | 8 +++++++-
 t/t9300-fast-import.sh | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index f60e2ee..2c08dbb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -481,9 +481,15 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
 	if (errno == ENOMEM)
 		die("Out of memory, getdelim failed");
 
-	/* Restore slopbuf that we moved out of the way before */
+	/*
+	 * Restore strbuf invariants; if getdelim left us with a NULL pointer,
+	 * we can just re-init, but otherwise we should make sure that our
+	 * length is empty, and that the result is NUL-terminated.
+	 */
 	if (!sb->buf)
 		strbuf_init(sb, 0);
+	else
+		strbuf_reset(sb);
 	return EOF;
 }
 #else
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 4c5f3c9..25bb60b 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -55,6 +55,10 @@ test_expect_success 'empty stream succeeds' '
 	git fast-import </dev/null
 '
 
+test_expect_success 'truncated stream complains' '
+	echo "tag foo" | test_must_fail git fast-import
+'
+
 test_expect_success 'A: create pack from stdin' '
 	test_tick &&
 	cat >input <<-INPUT_END &&
-- 
2.8.0.rc1.318.g2193183
