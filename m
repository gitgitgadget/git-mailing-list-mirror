From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] remote-curl: sanity check ref advertisement from server
Date: Sat, 16 Feb 2013 01:49:29 -0500
Message-ID: <20130216064929.GC22626@sigill.intra.peff.net>
References: <20130216064455.GA27063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 07:49:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6bau-0005Cr-Iz
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 07:49:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030Ab3BPGtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 01:49:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49781 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788Ab3BPGtc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 01:49:32 -0500
Received: (qmail 2945 invoked by uid 107); 16 Feb 2013 06:51:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 16 Feb 2013 01:51:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 16 Feb 2013 01:49:29 -0500
Content-Disposition: inline
In-Reply-To: <20130216064455.GA27063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216380>

If the smart HTTP response from the server is truncated for
any reason, we will get an incomplete ref advertisement. If
we then feed this incomplete list to "fetch-pack", one of a
few things may happen:

  1. If the truncation is in a packet header, fetch-pack
     will notice the bogus line and complain.

  2. If the truncation is inside a packet, fetch-pack will
     keep waiting for us to send the rest of the packet,
     which we never will.

  3. If the truncation is at a packet boundary, fetch-pack
     will keep waiting for us to send the next packet, which
     we never will.

As a result, fetch-pack hangs, waiting for input. However,
remote-curl believes it has sent all of the advertisement,
and therefore waits for fetch-pack to speak. The two
processes end up in a deadlock.

This fortunately doesn't happen in the normal fetching
workflow, because git-fetch first uses the "list" command,
which feeds the refs to get_remote_heads, which does notice
the error. However, you can trigger it by sending a direct
"fetch" to the remote-curl helper.

We can make this more robust by verifying that the packet
stream we got from the server does indeed parse correctly
and ends with a flush packet, which means that what
fetch-pack receives will at least be syntactically correct.

The normal non-stateless-rpc case does not have to deal with
this problem; it detects a truncation by getting EOF on the
file descriptor before it has read all data. So it is
tempting to think that we can solve this by closing the
descriptor after relaying the server's advertisement.
Unfortunately, in the stateless rpc case, we need to keep
the descriptor to fetch-pack open in order to pass more data
to it.

We could solve that by using two descriptors, but our
run-command interface does not support that (and modifying
it to create more pipes would make life hard for the Windows
port of git).

Signed-off-by: Jeff King <peff@peff.net>
---
 remote-curl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/remote-curl.c b/remote-curl.c
index 73134f5..c7647c7 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -101,6 +101,15 @@ static int read_packets_until_flush(char **buf, size_t *len)
 	}
 }
 
+static int verify_ref_advertisement(char *buf, size_t len)
+{
+	/*
+	 * Our function parameters are copies, so we do not
+	 * have to care that read_packets will increment our pointers.
+	 */
+	return read_packets_until_flush(&buf, &len);
+}
+
 static struct discovery* discover_refs(const char *service)
 {
 	struct strbuf exp = STRBUF_INIT;
@@ -174,6 +183,9 @@ static struct discovery* discover_refs(const char *service)
 			die("smart-http metadata lines are invalid at %s",
 			    refs_url);
 
+		if (verify_ref_advertisement(last->buf, last->len) < 0)
+			die("ref advertisement is invalid at %s", refs_url);
+
 		last->proto_git = 1;
 	}
 
-- 
1.8.1.2.11.g1a2f572
