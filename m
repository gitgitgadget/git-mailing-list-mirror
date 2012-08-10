From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] send-pack: fix capability-sending logic
Date: Fri, 10 Aug 2012 03:57:31 -0400
Message-ID: <20120810075731.GA8399@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 09:57:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szk6K-0003z3-F8
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 09:57:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495Ab2HJH5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 03:57:39 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60067 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755656Ab2HJH5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 03:57:38 -0400
Received: (qmail 27161 invoked by uid 107); 10 Aug 2012 07:57:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 03:57:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 03:57:31 -0400
Content-Disposition: inline
In-Reply-To: <20120810075342.GA30072@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203207>

If we have capabilities to send to the server, we send the
regular "want" line followed by a NUL, then the
capabilities; otherwise, we do not even send the NUL.

However, when checking whether we want to send the "quiet"
capability, we check args->quiet, which is wrong. That flag
only tells us whether the client side wanted to be quiet,
not whether the server supports it (originally, in c207e34f,
it meant both; however, that was later split into two flags
by 01fdc21f).

We still check the right flag when actually printing
"quiet", so this could only have two effects:

  1. We might send the trailing NUL when we do not otherwise
     need to. In theory, an antique pre-capability
     implementation of git might choke on this (since the
     client is instructed never to respond with capabilities
     that the server has not first advertised).

  2. We might also want to send the quiet flag if the
     args->progress flag is false, but this code path would
     not trigger in that instance.

In practice, it almost certainly never matters. The
report-status capability dates back to 2005. Any real-world
server is going to advertise that, and we will always
respond with at least that capability.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm tempted to remove this part of the conditional entirely to make the
code simpler, which would mean that we always send the extra NUL, even
if there are no capabilities. But I'm not 100% sure that pre-1.1.0
versions of git actually handle that, and who knows if there are other
implementations. This fix is the safe, conservative route.

 builtin/send-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index c4d4211..5c69995 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -306,7 +306,7 @@ int send_pack(struct send_pack_args *args,
 			char *new_hex = sha1_to_hex(ref->new_sha1);
 			int quiet = quiet_supported && (args->quiet || !args->progress);
 
-			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
+			if (!cmds_sent && (status_report || use_sideband || quiet)) {
 				packet_buf_write(&req_buf,
 						 "%s %s %s%c%s%s%s agent=%s",
 						 old_hex, new_hex, ref->name, 0,
-- 
1.7.12.rc2.4.g7f05cf9
