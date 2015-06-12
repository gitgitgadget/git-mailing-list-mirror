From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch-pack: optionally save packs to disk
Date: Fri, 12 Jun 2015 14:00:05 -0400
Message-ID: <20150612180005.GA9242@peff.net>
References: <CAGZ79kaS4utvDbXOo7emmSUH6M-8LY-oA65Ss3PLDkFModkbSg@mail.gmail.com>
 <1434049168-10613-1-git-send-email-augie@google.com>
 <557A7ABA.2000404@kdbg.org>
 <xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, Augie Fackler <augie@google.com>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3TFV-0006jZ-TK
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098AbbFLSAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:00:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:45352 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752797AbbFLSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:00:08 -0400
Received: (qmail 1520 invoked by uid 102); 12 Jun 2015 18:00:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 13:00:08 -0500
Received: (qmail 16564 invoked by uid 107); 12 Jun 2015 18:00:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 14:00:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 14:00:05 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmw05dkxz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271506>

On Fri, Jun 12, 2015 at 08:07:36AM -0700, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > What is the problem with the current fetch-pack implementation? Does
> > it remove a bogus packfile after download? Does it abort during
> > download when it detects a broken packfile? Does --keep not do what
> > you need?
> 
> Doesn't the incoming data still go through the fattening process,
> though?  You will not be able to inspect the byte-for-byte identical
> stream that came out of the server end whose packfile generation
> logic is suspect.
> 
> For the purpose of debugging your own new server implementation, it
> might be a better approach to capture the pack as it comes out at
> the server end, instead of doing it at the fetch-pack end as it
> comes in. But the approach to add this "dump" at the fetch-pack side
> is that it gives us a tool to diagnose problems that come from
> broken server (re)implementations by other people we cannot debug,
> i.e. "you are spewing this corrupt pack against this request; here
> is a dump we took to help you go fix your server".

When I added GIT_TRACE_PACKET long ago, I had always intended to
follow-up with a GIT_TRACE_PACKFILE. The former stops tracing when we
get to the binary data, but I had intended the latter to store the pure
on-the-wire packfile transmission for later debugging to. I never got
around to it, but I think it is something like the patch below.

With:

  GIT_TRACE_PACKET=1 GIT_TRACE_PACK=/tmp/foo.pack git clone ...

this yields a usable pack in /tmp/foo.pack (note that it only kicks in
when packet-tracing is on at all; if we restructure the code a bit, we
can remove that limitation).

In theory it would also work when receiving a pack via push, but I
think we actually skip the pkt-line protocol there. We'd have to
manually check GIT_TRACE_PACK.

Also, as a bonus, it means we do not stop tracing completely when we
start to receive a sideband pack. The current GIT_TRACE_PACKET code
misses any sideband-2 messages that come after we start receiving the
pack.

diff --git a/pkt-line.c b/pkt-line.c
index 187a229..f82871a 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,20 +4,39 @@
 char packet_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
+static struct trace_key trace_pack = TRACE_KEY_INIT(PACK);
 
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
 
 	if (!trace_want(&trace_packet))
 		return;
 
+	if (in_pack && packet_trace_pack(buf, len, sideband))
+		return;
+
 	/* +32 is just a guess for header + quoting */
 	strbuf_init(&out, len+32);
 
@@ -27,7 +46,9 @@ static void packet_trace(const char *buf, unsigned int len, int write)
 	if ((len >= 4 && starts_with(buf, "PACK")) ||
 	    (len >= 5 && starts_with(buf+1, "PACK"))) {
 		strbuf_addstr(&out, "PACK ...");
-		trace_disable(&trace_packet);
+		in_pack = 1;
+		sideband = *buf == '\1';
+		packet_trace_pack(buf, len, sideband);
 	}
 	else {
 		/* XXX we should really handle printable utf8 */
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
 
