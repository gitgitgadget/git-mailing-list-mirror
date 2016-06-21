Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A191FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 12:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbcFUMRe (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 08:17:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:57814 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751719AbcFUMRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 08:17:33 -0400
Received: (qmail 15221 invoked by uid 102); 21 Jun 2016 12:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 08:10:46 -0400
Received: (qmail 23705 invoked by uid 107); 21 Jun 2016 12:11:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 08:11:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 08:10:42 -0400
Date:	Tue, 21 Jun 2016 08:10:42 -0400
From:	Jeff King <peff@peff.net>
To:	Eric Wong <e@80x24.org>
Cc:	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: http-backend fatal error message on shallow clone
Message-ID: <20160621121041.GA29156@sigill.intra.peff.net>
References: <20160621112303.GA21973@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160621112303.GA21973@dcvr.yhbt.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jun 21, 2016 at 11:23:03AM +0000, Eric Wong wrote:

> I noticed "fatal: The remote end hung up unexpectedly" in server
> logs from shallow clones.  Totally reproducible in the test
> cases, too.  The following change shows it:
> [...]
> [Tue Jun 21 11:07:41.391269 2016] [cgi:error] [pid 21589] [client 127.0.0.1:37518] AH01215: fatal: The remote end hung up unexpectedly
> 
> It doesn't show above, but I think http-backend exits
> with a non-zero status, too, which might cause some CGI
> implementations to complain or break.
> 
> Not sure if it's just a corner case that wasn't tested
> or something else, but the clone itself seems successful...

The dying process is actually upload-pack. If we instrument it like
this:

diff --git a/upload-pack.c b/upload-pack.c
index 9e03c27..a1da676 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -820,6 +820,14 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
+NORETURN
+static void custom_die(const char *err, va_list params)
+{
+	vreportf("fatal: ", err, params);
+	warning("aborting");
+	abort();
+}
+
 int main(int argc, const char **argv)
 {
 	const char *dir;
@@ -836,6 +844,9 @@ int main(int argc, const char **argv)
 		OPT_END()
 	};
 
+	warning("running upload-pack");
+	set_die_routine(custom_die);
+
 	git_setup_gettext();
 
 	packet_trace_identity("upload-pack");

we can see two things. One is we can get a backtrace from the core file:

#0  0x00007f04aef51458 in __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:55
#1  0x00007f04aef528da in __GI_abort () at abort.c:89
#2  0x0000000000406009 in custom_die (err=0x4ede60 "The remote end hung up unexpectedly", 
    params=0x7ffe15858758) at upload-pack.c:828
#3  0x000000000045ec63 in die (err=0x4ede60 "The remote end hung up unexpectedly") at usage.c:108
#4  0x000000000041e016 in get_packet_data (fd=0, src_buf=0x0, src_size=0x0, dst=0x7ffe158588b0, 
    size=4, options=2) at pkt-line.c:167
#5  0x000000000041e0ea in packet_read (fd=0, src_buf=0x0, src_len=0x0, 
    buffer=0x73cc40 <packet_buffer> "deepen 1", size=65520, options=2) at pkt-line.c:204
#6  0x000000000041e22b in packet_read_line_generic (fd=0, src=0x0, src_len=0x0, dst_len=0x0)
    at pkt-line.c:234
#7  0x000000000041e27c in packet_read_line (fd=0, len_p=0x0) at pkt-line.c:244
#8  0x0000000000404dc9 in get_common_commits () at upload-pack.c:384
#9  0x0000000000405eb4 in upload_pack () at upload-pack.c:798
#10 0x0000000000406229 in main (argc=1, argv=0x7ffe15858c28) at upload-pack.c:872

So we expected to read a packet but didn't get one. Not surprising. The
interesting thing is that we are in get_common_commits(), and if we were
to get a flush packet in stateless-rpc mode, we would simply exit(0).
But we get EOF instead, which provokes packet_read_line() to die.

The other interesting thing is that we can see in httpd's error.log that
it is the penultimate upload-pack that dies (I trimmed the log lines for
readability):

AH01215: warning: running upload-pack
AH01215: fatal: The remote end hung up unexpectedly
AH01215: warning: aborting
AH01215: error: git-upload-pack died of signal 6
AH01215: warning: running upload-pack

So this request actually takes _two_ upload-pack instances to serve
(which is not uncommon when we need multiple rounds of
get_common_commits(), though I am a little surprised that would be the
case for a clone). And the first one seems to be missing a closing
"0000" flush packet from the client to end it.

If that analysis is correct, this isn't affecting operation in any way;
it's just giving a useless message from upload-pack (and as you note,
that could trigger http-backend to exit(1), which may make the webserver
unhappy).

If we further instrument upload-pack to set GIT_TRACE_PACKET on the
server side, we can see the two requests:

packet:  upload-pack< want 379518c0c94e3b1a0710129d03d5560814a0ba6f multi_ack_detailed no-done side-band-64k thin-pack include-tag ofs-delta agent=git/2.9.0.37.gb3ad8ab.dirty
packet:  upload-pack< deepen 1
packet:  upload-pack< 0000
packet:  upload-pack> shallow 379518c0c94e3b1a0710129d03d5560814a0ba6f
packet:  upload-pack> 0000

packet:  upload-pack< want 379518c0c94e3b1a0710129d03d5560814a0ba6f multi_ack_detailed no-done side-band-64k thin-pack include-tag ofs-delta agent=git/2.9.0.37.gb3ad8ab.dirty
packet:  upload-pack< deepen 1
packet:  upload-pack< 0000
packet:  upload-pack> shallow 379518c0c94e3b1a0710129d03d5560814a0ba6f
packet:  upload-pack> 0000
packet:  upload-pack< done
packet:  upload-pack> NAK
packet:  upload-pack> 0000

I think in the first one we would get "deepen 1" from the client in
receive_needs(), and similarly write out our "shallow" line. But then we
go into get_common_commits() and the client has hung up, which causes
the message. Whereas in the second line it gives us a "done", which
completes the negotiation.

So my not-very-educated thoughts are:

  1. The client should probably be sending an extra flush in the first
     request. Alternatively, in the stateless-rpc case we should just
     accept the lack of flush as an acceptable end to the request.

  2. Presumably the shallowness is what causes the double-request, as
     fetch-pack wants to see the shallow list before proceeding. But
     since it has no actual commits to negotiate, the negotiation is a
     noop. So probably this case could actually happen in a single
     request.

     I suspect that other fetches could not, though, so I'm not sure how
     much effort is worth putting into optimizing.

-Peff
