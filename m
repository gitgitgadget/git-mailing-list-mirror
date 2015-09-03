From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-protocol: document newline behavior in push commands
Date: Thu, 3 Sep 2015 04:02:05 -0400
Message-ID: <20150903080205.GA20182@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 10:02:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPTN-0002MS-9Q
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbICICL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 04:02:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:54254 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbbICICI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 04:02:08 -0400
Received: (qmail 9858 invoked by uid 102); 3 Sep 2015 08:02:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 03:02:08 -0500
Received: (qmail 8612 invoked by uid 107); 3 Sep 2015 08:02:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 04:02:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Sep 2015 04:02:05 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277182>

Our pack-protocol spec indicates that a pushing client
should send ref update commands like:

  $old_sha1 $new_sha1 $ref\n

with each ref update in its own pktline, with a trailing
newline. However, git itself does not follow this behavior;
it omits the trailing newline.

For the most part the distinction is harmless. The
`receive-pack` on the other end will call
`packet_read_line`, which strips off the newline if it is
there, and we are fine either way.

Things are more complicated for the initial ref, which also
has capabilities. The spec says to send:

  $old_sha1 $new_sha1 $ref\0 $caps\n

which is also OK by the current `receive-pack code (the
newline is at the end of the packet, so we still strip it).

As an aside, it would _not_ be OK to send:

  $old_sha1 $new_sha1 $ref\n\0 $caps\n

The spec does not allow that and receive-pack would reject
it, but it is perhaps a mistake that a naive client
implementation might make.

So what is in the current spec is quite reasonable, and
simply follows the normal rules for pkt-line framing (we say
LF, but it really is optional). But it does not document
how git actually behaves.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Junio, Dave, and Shawn, as this is somewhat related to the
discussion in
http://thread.gmane.org/gmane.comp.version-control.git/273175/focus=273444

I happened to be looking into some protocol stuff recently and noticed
that we do not follow the spec here (but interestingly, libgit2 does!).

Frankly, this feels a bit like a step backwards to me. I am tempted to
suggest instead that git start sending the newlines, but I'm not sure
it's worth any potential fallout.

I'm also tempted to scrap this and say it just falls under the rule
that every PKT-LINE is "sender SHOULD include LF" and "receiver MUST NOT
complain about missing LF" (which does appear earlier in the document,
though in a different context). Or maybe we should write out that rule
explicitly and drop the "LF" from all parts of the grammar (which is
what the thread above advocates).

 Documentation/technical/pack-protocol.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4064fc7..9ce53b4 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -469,8 +469,8 @@ references.
 
   shallow           =  PKT-LINE("shallow" SP obj-id LF)
 
-  command-list      =  PKT-LINE(command NUL capability-list LF)
-		       *PKT-LINE(command LF)
+  command-list      =  PKT-LINE(command NUL capability-list)
+		       *PKT-LINE(command)
 		       flush-pkt
 
   command           =  create / delete / update
@@ -586,8 +586,8 @@ An example client/server communication might look like this:
    S: 003f74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/team\n
    S: 0000
 
-   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug\n
-   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master\n
+   C: 003e7d1665144a3a975c05f1f43902ddaf084e784dbe 74730d410fcb6603ace96f1dc55ea6196122532d refs/heads/debug
+   C: 003e74730d410fcb6603ace96f1dc55ea6196122532d 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a refs/heads/master
    C: 0000
    C: [PACKDATA]
 
-- 
2.5.1.812.ge796bff
