From: Jeff King <peff@peff.net>
Subject: [PATCH] imap-send: avoid curl functions when not building curl
 support
Date: Mon, 10 Nov 2014 01:39:47 -0500
Message-ID: <20141110063947.GA7894@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Mon Nov 10 07:39:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xnidm-0000df-Ar
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 07:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbaKJGju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 01:39:50 -0500
Received: from cloud.peff.net ([50.56.180.127]:38608 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752257AbaKJGjt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 01:39:49 -0500
Received: (qmail 15793 invoked by uid 102); 10 Nov 2014 06:39:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 00:39:50 -0600
Received: (qmail 32660 invoked by uid 107); 10 Nov 2014 06:39:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Nov 2014 01:39:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Nov 2014 01:39:47 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Imap-send recently learned to conditionally compile against
and use curl for imap support. To use this feature, you must
both:

  1. Compile with USE_CURL_FOR_IMAP_SEND

  2. Specify --curl on the command line to enable it

It is OK (and even desirable) for the code checking --curl
to be compiled even if USE_CURL_FOR_IMAP_SEND is not in
effect; this lets us explain the situation to the user
(instead of saying "--curl? never heard of it").

However, the code which conditionally runs when --curl is
enabled must _not_ be compiled in this case. It references
functions which are neither declared nor defined, causing
the compiler to complain.

Signed-off-by: Jeff King <peff@peff.net>
---
On top of br/imap-send-via-libcurl. I needed this to compile 'pu' with
NO_CURL (which I don't usually do, but was testing on a minimal box). I
expect it can just be squashed in to the next re-roll.

Since we were talking about testing in another thread, Junio, I wonder
if it is worth having you compile your integration results against a
couple different configs (e.g., NO_CURL). Obviously that will make
things slower if you don't throw more CPU power at it, but that seems
like a problem that can be solved with build servers or similar.

 imap-send.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/imap-send.c b/imap-send.c
index ad4ac22..e0e1f09 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1542,8 +1542,10 @@ int main(int argc, char **argv)
 	if (server.tunnel)
 		return append_msgs_to_imap(&server, &all_msgs, total);
 
+#ifdef USE_CURL_FOR_IMAP_SEND
 	if (use_curl)
 		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+#endif
 
 	return append_msgs_to_imap(&server, &all_msgs, total);
 }
-- 
2.1.2.596.g7379948
