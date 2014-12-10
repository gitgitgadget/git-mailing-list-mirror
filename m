From: Jeff King <peff@peff.net>
Subject: [PATCH v3] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 02:34:47 -0500
Message-ID: <20141210073447.GA20298@peff.net>
References: <20141209174958.GA26167@peff.net>
 <20141209180916.GA26873@peff.net>
 <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Michael Blume <blume.mike@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 08:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XybnV-0002Mu-Gl
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 08:34:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbaLJHev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 02:34:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:50905 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753643AbaLJHeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 02:34:50 -0500
Received: (qmail 21630 invoked by uid 102); 10 Dec 2014 07:34:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 01:34:50 -0600
Received: (qmail 7159 invoked by uid 107); 10 Dec 2014 07:34:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Dec 2014 02:34:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Dec 2014 02:34:47 -0500
Content-Disposition: inline
In-Reply-To: <xmqqa92wla34.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261191>

On Tue, Dec 09, 2014 at 02:41:51PM -0800, Junio C Hamano wrote:

> >> Another option would be to use a static strbuf. Then we're only wasting
> >> heap, and even then only as much as we need (we'd still manually cap it
> >> at LARGE_PACKET_MAX since that's what the protocol dictates). This would
> >> also make packet_buf_write more efficient (right now it formats into a
> >> static buffer, and then copies the result into a strbuf; probably not
> >> measurably important, but silly nonetheless).
> >
> > Below is what that would look like. It's obviously a much more invasive
> > change, but I think the result is nice.
> 
> Yes, indeed.  Is there any reason why we shouldn't go with this
> variant, other than "it touches a bit more lines" that I am not
> seeing?

I don't think so. Mostly I wrote and sent the minimal one first, and
only later realized that the strbuf approach would be so neat.

> Anything older than 1.8.3 is affected by this, but only when the
> sending side has to send a large packet.  It is between failing
> because the sender cannot send a large packet and failing because
> the receiver does not expect such a large packet to come, and either
> way the whole operation will fail anyway, so there is no net loss.

Exactly.

Below is a another iteration on the patch. The actual code changes are
the same as the strbuf one, but the tests take care to avoid assuming
the filesystem can handle such a long path. Testing on Windows and OS X
is appreciated.

Note that in addition to cheating on the creation of the long ref, I had
to tweak the fetch test a little to avoid writing the loose ref there,
too. That makes the test a little weaker (it is not as "end to end",
checking that all parts of fetch can handle it), but it does check the
thing we are changing here, that the protocol code can handle it.

-- >8 --
Subject: [PATCH] pkt-line: allow writing of LARGE_PACKET_MAX buffers

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
 t/t5527-fetch-odd-refs.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 18 deletions(-)

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
index edea9f9..0921a2a 100755
--- a/t/t5527-fetch-odd-refs.sh
+++ b/t/t5527-fetch-odd-refs.sh
@@ -26,4 +26,46 @@ test_expect_success 'suffix ref is ignored during fetch' '
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
+
+		# not all filesystems can handle such long filenames, so
+		# we cheat a bit and explicitly create our long ref as a
+		# packed ref. Since we are doing it by hand, let us also
+		# double check that git respects what we wrote.
+		long=$(git rev-parse long) &&
+		echo "$long refs/heads/$ref1440" >.git/packed-refs &&
+		cat >expect <<-\EOF &&
+		long
+		master
+		EOF
+		git for-each-ref --format="%(subject)" refs/heads >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'fetch handles extremely long refname' '
+	# do not fetch it verbatim, as many systems would barf not
+	# on the protocol, but on writing the loose ref locally.
+	# Instead, give it a sane local name and just make sure
+	# we got it.
+	git fetch long refs/heads/$ref1440:refs/heads/long-ref &&
+	echo long >expect &&
+	git log -1 --format=%s long-ref >actual &&
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
