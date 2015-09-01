From: Jeff King <peff@peff.net>
Subject: [PATCH 2/2] pkt-line: show packets in async processes as "sideband"
Date: Tue, 1 Sep 2015 16:24:13 -0400
Message-ID: <20150901202412.GA8020@sigill.intra.peff.net>
References: <20150901202215.GA17370@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 22:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWs6N-00023v-N4
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 22:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbbIAUYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 16:24:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:53293 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751113AbbIAUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 16:24:15 -0400
Received: (qmail 21612 invoked by uid 102); 1 Sep 2015 20:24:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 15:24:15 -0500
Received: (qmail 5449 invoked by uid 107); 1 Sep 2015 20:24:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 01 Sep 2015 16:24:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Sep 2015 16:24:13 -0400
Content-Disposition: inline
In-Reply-To: <20150901202215.GA17370@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277038>

If you run "GIT_TRACE_PACKET=1 git push", you may get
confusing output like (line prefixes omitted for clarity):

   packet:      push< \1000eunpack ok0019ok refs/heads/master0000
   packet:      push< unpack ok
   packet:      push< ok refs/heads/master
   packet:      push< 0000
   packet:      push< 0000

Why do we see the data twice, once apparently wrapped inside
another pkt-line, and once unwrapped? Why do we get two
flush packets?

The answer is that we start an async process to demux the
sideband data. The first entry comes from the sideband
process reading the data, and the second from push itself.
Likewise, the first flush is inside the demuxed packet, and
the second is an actual sideband flush.

We can make this a bit more clear by marking the sideband
demuxer explicitly as "sideband" rather than "push". The
most elegant way to do this would be to simply call
packet_trace_identity() inside the sideband demuxer. But we
can't do that reliably, because it relies on a global
variable, which might be shared if pthreads are in use.

What we really need is thread-local storage for
packet_trace_identity. But the async code does not provide
an interface for that, and it would be messy to add it here
(we'd have to care about pthreads, initializing our
pthread_key_t ahead of time, etc).

So instead, let us just assume that any async process is
handling sideband data. That's always true now, and is
likely to remain so in the future.

The output looks like:

   packet:  sideband< \1000eunpack ok0019ok refs/heads/master0000
   packet:      push< unpack ok
   packet:      push< ok refs/heads/master
   packet:      push< 0000
   packet:  sideband< 0000

Signed-off-by: Jeff King <peff@peff.net>
---
 pkt-line.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index 08a1427..62fdb37 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "pkt-line.h"
+#include "run-command.h"
 
 char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
@@ -11,6 +12,11 @@ void packet_trace_identity(const char *prog)
 	packet_trace_prefix = xstrdup(prog);
 }
 
+static const char *get_trace_prefix(void)
+{
+	return in_async() ? "sideband" : packet_trace_prefix;
+}
+
 static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
 {
 	if (!sideband) {
@@ -57,7 +63,7 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	strbuf_init(&out, len+32);
 
 	strbuf_addf(&out, "packet: %12s%c ",
-		    packet_trace_prefix, write ? '>' : '<');
+		    get_trace_prefix(), write ? '>' : '<');
 
 	/* XXX we should really handle printable utf8 */
 	for (i = 0; i < len; i++) {
-- 
2.5.1.739.g7891f6b
