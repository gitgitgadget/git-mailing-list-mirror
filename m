From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Tue, 9 Dec 2014 13:09:16 -0500
Message-ID: <20141209180916.GA26873@peff.net>
References: <20141209174958.GA26167@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 09 19:09:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyPDw-0000K2-8o
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 19:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbaLISJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 13:09:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:50583 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751495AbaLISJT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 13:09:19 -0500
Received: (qmail 11381 invoked by uid 102); 9 Dec 2014 18:09:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 12:09:18 -0600
Received: (qmail 2279 invoked by uid 107); 9 Dec 2014 18:09:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Dec 2014 13:09:23 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Dec 2014 13:09:16 -0500
Content-Disposition: inline
In-Reply-To: <20141209174958.GA26167@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261134>

On Tue, Dec 09, 2014 at 12:49:58PM -0500, Jeff King wrote:

> Another option would be to use a static strbuf. Then we're only wasting
> heap, and even then only as much as we need (we'd still manually cap it
> at LARGE_PACKET_MAX since that's what the protocol dictates). This would
> also make packet_buf_write more efficient (right now it formats into a
> static buffer, and then copies the result into a strbuf; probably not
> measurably important, but silly nonetheless).

Below is what that would look like. It's obviously a much more invasive
change, but I think the result is nice.

-- >8 --
Subject: pkt-line: allow writing of LARGE_PACKET_MAX buffers

When we send out pkt-lines with refnames, we use a static
1000-byte buffer. This means that the maximum size of a ref
over the git protocol is around 950 bytes (the exact size
depends on the protocol line being written, but figure on a sha1
plus some boilerplate).

This is enough for any sane workflow, but occasionally odd
things happen (e.g., a bug may create a ref "foo/foo/foo/..."
accidentally).  With the current code, you cannot even use
"push" to delete such a ref from a remote.

Let's switch to using a strbuf, with a hard-limit of
LARGE_PACKET_MAX (which is specified by the protocol).  This
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
65531 bytes. So we are just bumping the limit, not removing
it.  But hopefully 64K should be enough for anyone.

As a bonus, by using a strbuf for the formatting we can
eliminate an unnecessary copy in format_buf_write.

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c                | 37 +++++++++++++++++++------------------
 t/t5527-fetch-odd-refs.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/pkt-line.c b/pkt-line.c
index 8bc89b1..187a229 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -64,44 +64,45 @@ void packet_buf_flush(struct strbuf *buf)
 }
 
 #define hex(a) (hexchar[(a) & 15])
-static char buffer[1000];
-static unsigned format_packet(const char *fmt, va_list args)
+static void format_packet(struct strbuf *out, const char *fmt, va_list args)
 {
 	static char hexchar[] = "0123456789abcdef";
-	unsigned n;
+	size_t orig_len, n;
 
-	n = vsnprintf(buffer + 4, sizeof(buffer) - 4, fmt, args);
-	if (n >= sizeof(buffer)-4)
+	orig_len = out->len;
+	strbuf_addstr(out, "0000");
+	strbuf_vaddf(out, fmt, args);
+	n = out->len - orig_len;
+
+	if (n > LARGE_PACKET_MAX)
 		die("protocol error: impossibly long line");
-	n += 4;
-	buffer[0] = hex(n >> 12);
-	buffer[1] = hex(n >> 8);
-	buffer[2] = hex(n >> 4);
-	buffer[3] = hex(n);
-	packet_trace(buffer+4, n-4, 1);
-	return n;
+
+	out->buf[orig_len + 0] = hex(n >> 12);
+	out->buf[orig_len + 1] = hex(n >> 8);
+	out->buf[orig_len + 2] = hex(n >> 4);
+	out->buf[orig_len + 3] = hex(n);
+	packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }
 
 void packet_write(int fd, const char *fmt, ...)
 {
+	static struct strbuf buf = STRBUF_INIT;
 	va_list args;
-	unsigned n;
 
+	strbuf_reset(&buf);
 	va_start(args, fmt);
-	n = format_packet(fmt, args);
+	format_packet(&buf, fmt, args);
 	va_end(args);
-	write_or_die(fd, buffer, n);
+	write_or_die(fd, buf.buf, buf.len);
 }
 
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
 {
 	va_list args;
-	unsigned n;
 
 	va_start(args, fmt);
-	n = format_packet(fmt, args);
+	format_packet(buf, fmt, args);
 	va_end(args);
-	strbuf_add(buf, buffer, n);
 }
 
 static int get_packet_data(int fd, char **src_buf, size_t *src_size,
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
