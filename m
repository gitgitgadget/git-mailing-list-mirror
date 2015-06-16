From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 13:23:20 -0400
Message-ID: <20150616172320.GE18667@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212827.GC25757@peff.net>
 <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
 <xmqqvben6214.fsf@gitster.dls.corp.google.com>
 <20150616164310.GA18667@peff.net>
 <CAHcr6HbKfE=B502t9hJt601-mco+PK9s4uViFW3AkHABubiF0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Augie Fackler <augie@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 19:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4ua8-0006M7-Pv
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 19:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581AbbFPRXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 13:23:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:46903 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752176AbbFPRXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 13:23:23 -0400
Received: (qmail 14709 invoked by uid 102); 16 Jun 2015 17:23:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 12:23:22 -0500
Received: (qmail 16922 invoked by uid 107); 16 Jun 2015 17:23:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 13:23:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 13:23:20 -0400
Content-Disposition: inline
In-Reply-To: <CAHcr6HbKfE=B502t9hJt601-mco+PK9s4uViFW3AkHABubiF0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271784>

On Tue, Jun 16, 2015 at 12:52:46PM -0400, Augie Fackler wrote:

> Yeah, I don't have one - I may have been making assumptions because I
> knew something of the background on your implementation. i'd say let
> it live and if people provide feedback later figure out a reword
> (writing for humans is not a strong suit of mine, alas.)

OK, let's leave it as-is, then.

> +1 on TRACE_PACKFILE - also makes it harder to accidentally leave off
> the ET and get binary spew when one didn't expect that.

Here's a re-roll of 3/3, using TRACE_PACKFILE. I think the documentation
is enough to allay my other concern (that the name does not imply it is
about the network protocol).

-- >8 --
Subject: pkt-line: support tracing verbatim pack contents

When debugging the pack protocol, it is sometimes useful to
store the verbatim pack that we sent or received on the
wire. Looking at the on-disk result is often not helpful for
a few reasons:

  1. If the operation is a clone, we destroy the repo on
     failure, leaving nothing on disk.

  2. If the pack is small, we unpack it immediately, and the
     full pack never hits the disk.

  3. If we feed the pack to "index-pack --fix-thin", the
     resulting pack has the extra delta bases added to it.

We already have a GIT_TRACE_PACKET mechanism for tracing
packets. Let's extend it with GIT_TRACE_PACKFILE to dump the
verbatim packfile.

There are a few other positive fallouts that come from
rearranging this code:

 - We currently disable the packet trace after seeing the
   PACK header, even though we may get human-readable lines
   on other sidebands; now we include them in the trace.

 - We currently try to print "PACK ..." in the trace to
   indicate that the packfile has started. But because we
   disable packet tracing, we never printed this line. We
   will now do so.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git.txt | 13 +++++++++++-
 pkt-line.c            | 59 ++++++++++++++++++++++++++++++++++++++-------------
 t/t5601-clone.sh      |  7 ++++++
 trace.c               |  7 ++++++
 trace.h               |  1 +
 5 files changed, 71 insertions(+), 16 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 45b64a7..3453669 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -1000,9 +1000,20 @@ Unsetting the variable, or setting it to empty, "0" or
 	Enables trace messages for all packets coming in or out of a
 	given program. This can help with debugging object negotiation
 	or other protocol issues. Tracing is turned off at a packet
-	starting with "PACK".
+	starting with "PACK" (but see 'GIT_TRACE_PACKFILE' below).
 	See 'GIT_TRACE' for available trace output options.
 
+'GIT_TRACE_PACKFILE'::
+	Enables tracing of packfiles sent or received by a
+	given program. Unlike other trace output, this trace is
+	verbatim: no headers, and no quoting of binary data. You almost
+	certainly want to direct into a file (e.g.,
+	`GIT_TRACE_PACKFILE=/tmp/my.pack`) rather than displaying it on
+	the terminal or mixing it with other trace output.
++
+Note that this is currently only implemented for the client side
+of clones and fetches.
+
 'GIT_TRACE_PERFORMANCE'::
 	Enables performance related trace messages, e.g. total execution
 	time of each Git command.
diff --git a/pkt-line.c b/pkt-line.c
index e75af02..08a1427 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,16 +4,51 @@
 char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
+static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
 
 void packet_trace_identity(const char *prog)
 {
 	packet_trace_prefix = xstrdup(prog);
 }
 
+static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
+{
+	if (!sideband) {
+		trace_verbatim(&trace_pack, buf, len);
+		return 1;
+	} else if (len && *buf == '\1') {
+		trace_verbatim(&trace_pack, buf + 1, len - 1);
+		return 1;
+	} else {
+		/* it's another non-pack sideband */
+		return 0;
+	}
+}
+
 static void packet_trace(const char *buf, unsigned int len, int write)
 {
 	int i;
 	struct strbuf out;
+	static int in_pack, sideband;
+
+	if (!trace_want(&trace_packet) && !trace_want(&trace_pack))
+		return;
+
+	if (in_pack) {
+		if (packet_trace_pack(buf, len, sideband))
+			return;
+	} else if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
+		in_pack = 1;
+		sideband = *buf == '\1';
+		packet_trace_pack(buf, len, sideband);
+
+		/*
+		 * Make a note in the human-readable trace that the pack data
+		 * started.
+		 */
+		buf = "PACK ...";
+		len = strlen(buf);
+	}
 
 	if (!trace_want(&trace_packet))
 		return;
@@ -24,21 +59,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_addf(&out, "packet: %12s%c ",
 		    packet_trace_prefix, write ? '>' : '<');
 
-	if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
-		strbuf_addstr(&out, "PACK ...");
-		trace_disable(&trace_packet);
-	}
-	else {
-		/* XXX we should really handle printable utf8 */
-		for (i = 0; i < len; i++) {
-			/* suppress newlines */
-			if (buf[i] == '\n')
-				continue;
-			if (buf[i] >= 0x20 && buf[i] <= 0x7e)
-				strbuf_addch(&out, buf[i]);
-			else
-				strbuf_addf(&out, "\\%o", buf[i]);
-		}
+	/* XXX we should really handle printable utf8 */
+	for (i = 0; i < len; i++) {
+		/* suppress newlines */
+		if (buf[i] == '\n')
+			continue;
+		if (buf[i] >= 0x20 && buf[i] <= 0x7e)
+			strbuf_addch(&out, buf[i]);
+		else
+			strbuf_addf(&out, "\\%o", buf[i]);
 	}
 
 	strbuf_addch(&out, '\n');
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index bfdaf75..9b34f3c 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -496,4 +496,11 @@ test_expect_success 'shallow clone locally' '
 	( cd ddsstt && git fsck )
 '
 
+test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
+	rm -rf dst.git &&
+	GIT_TRACE_PACKFILE=$PWD/tmp.pack git clone --no-local --bare src dst.git &&
+	git init --bare replay.git &&
+	git -C replay.git index-pack -v --stdin <tmp.pack
+'
+
 test_done
diff --git a/trace.c b/trace.c
index 3c3bd8f..7393926 100644
--- a/trace.c
+++ b/trace.c
@@ -120,6 +120,13 @@ static int prepare_trace_line(const char *file, int line,
 	return 1;
 }
 
+void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
+{
+	if (!trace_want(key))
+		return;
+	write_or_whine_pipe(get_trace_fd(key), buf, len, err_msg);
+}
+
 static void print_trace_line(struct trace_key *key, struct strbuf *buf)
 {
 	strbuf_complete_line(buf);
diff --git a/trace.h b/trace.h
index ae6a332..179b249 100644
--- a/trace.h
+++ b/trace.h
@@ -18,6 +18,7 @@ extern int trace_want(struct trace_key *key);
 extern void trace_disable(struct trace_key *key);
 extern uint64_t getnanotime(void);
 extern void trace_command_performance(const char **argv);
+extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 
 #ifndef HAVE_VARIADIC_MACROS
 
-- 
2.4.3.699.g84b4da7
