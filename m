From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 9 Dec 2014 12:49:58 -0500
Message-ID: <20141209174958.GA26167@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 18:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyOvO-0006gz-M4
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 18:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbaLIRuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 12:50:02 -0500
Received: from cloud.peff.net ([50.56.180.127]:50572 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751057AbaLIRuB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 12:50:01 -0500
Received: (qmail 10582 invoked by uid 102); 9 Dec 2014 17:50:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 11:50:00 -0600
Received: (qmail 2120 invoked by uid 107); 9 Dec 2014 17:50:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 12:50:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 12:49:58 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261133>

When we send out pkt-lines with refnames, we use a static
1000-byte buffer. This means that the maximum size of a ref
over the git protocol is around 950 bytes (the exact size
depends on the protocol line being written, but figure on a sha1
plus some boilerplate).

This is enough for any sane workflow, but occasionally odd
things happen (e.g., a bug may create a ref "foo/foo/foo/..."
accidentally).  With the current code, you cannot even use
"push" to delete such a ref from a remote.

Let's bump the size of the buffer to LARGE_PACKET_MAX. This
matches the size of the readers, as of 74543a0 (pkt-line:
provide a LARGE_PACKET_MAX static buffer, 2013-02-20).
Versions of git older than that will complain about our
large packets, but it's really no worse than the current
behavior. Right now the sender barfs with "impossibly long
line" trying to send the packet, and afterwards the reader
will barf with "protocol error: bad line length %d", which
is arguably better anyway.

Note that we're not really _solving_ the problem here, but
just bumping the limits. In theory, the length of a ref is
unbounded, and pkt-line can only represent sizes up to
65531 bytes. So we are just bumping the limit, not removing.
But hopefully 64K should be enough for anyone.

Signed-off-by: Jeff King <peff@peff.net>
---
This was inspired by a real-world case (with the "foo/foo" bug mentioned
above). It is rather an unlikely scenario, though (it literally was a
hook on the receiving end creating the ref, and push-deletion would have
been the simplest way to fix the situation). On the other hand, it's
nice to eliminate as many arbitrary limits as possible.

This does waste 63K of BSS. I was tempted to just use the existing
static packet_buffer (introduced by 74543a0) that the readers use. But
that is probably too magical; some callers may be surprised to find
the buffers they read invalidated by a call to packet_write. I think the
current callers are probably OK, but it's a little too error-prone for
my taste.

Another option would be to use a static strbuf. Then we're only wasting
heap, and even then only as much as we need (we'd still manually cap it
at LARGE_PACKET_MAX since that's what the protocol dictates). This would
also make packet_buf_write more efficient (right now it formats into a
static buffer, and then copies the result into a strbuf; probably not
measurably important, but silly nonetheless).

 pkt-line.c                |  2 +-
 t/t5527-fetch-odd-refs.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8bc89b1..aa42fb5 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -64,7 +64,7 @@ void packet_buf_flush(struct strbuf *buf)
 }
 
 #define hex(a) (hexchar[(a) & 15])
-static char buffer[1000];
+static char buffer[LARGE_PACKET_MAX];
 static unsigned format_packet(const char *fmt, va_list args)
 {
 	static char hexchar[] = "0123456789abcdef";
diff --git a/t/t5527-fetch-odd-refs.sh b/t/t5527-fetch-odd-refs.sh
index edea9f9..c86d38b 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -26,4 +26,33 @@ test_expect_success 'suffix ref is ignored during fetch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create repo with absurdly long refname' '
+	ref240=$_z40/$_z40/$_z40/$_z40/$_z40/$_z40
+	ref1440=$ref240/$ref240/$ref240/$ref240/$ref240/$ref240 &&
+	git init long &&
+	(
+		cd long &&
+		test_commit long &&
+		test_commit master &&
+		git update-ref refs/heads/$ref1440 long
+	)
+'
+
+test_expect_success 'fetch handles extremely long refname' '
+	git fetch long refs/heads/*:refs/remotes/long/* &&
+	cat >expect <<-\EOF &&
+	long
+	master
+	EOF
+	git for-each-ref --format="%(subject)" refs/remotes/long >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'push handles extremely long refname' '
+	git push long :refs/heads/$ref1440 &&
+	git -C long for-each-ref --format="%(subject)" refs/heads >actual &&
+	echo master >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.2.0.454.g7eca6b7
