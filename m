From: Jeff King <peff@peff.net>
Subject: [PATCH] pack-protocol: clarify LF-handling in PKT-LINE()
Date: Thu, 3 Sep 2015 04:24:09 -0400
Message-ID: <20150903082409.GA20786@sigill.intra.peff.net>
References: <20150903080205.GA20182@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 10:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPoh-0008I0-M2
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751976AbbICIYP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 04:24:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:54266 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbbICIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 04:24:12 -0400
Received: (qmail 12225 invoked by uid 102); 3 Sep 2015 08:24:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 03:24:12 -0500
Received: (qmail 8737 invoked by uid 107); 3 Sep 2015 08:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 04:24:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Sep 2015 04:24:09 -0400
Content-Disposition: inline
In-Reply-To: <20150903080205.GA20182@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277185>

On Thu, Sep 03, 2015 at 04:02:05AM -0400, Jeff King wrote:

> I'm also tempted to scrap this and say it just falls under the rule
> that every PKT-LINE is "sender SHOULD include LF" and "receiver MUST NOT
> complain about missing LF" (which does appear earlier in the document,
> though in a different context). Or maybe we should write out that rule
> explicitly and drop the "LF" from all parts of the grammar (which is
> what the thread above advocates).

Hmph, I just noticed that patch 2/7 from Dave's original series is
essentially the same as what I just sent.

Since the discussion seemed to end up in this "let's make PKT-LINE more
clear" direction, here is an attempt to do that.

-- >8 --
Subject: pack-protocol: clarify LF-handling in PKT-LINE()

The spec is very inconsistent about which PKT-LINE() parts
of the grammar include a LF. On top of that, the code is not
consistent, either (e.g., send-pack does not put newlines
into the ref-update commands it sends).

Let's make explicit the long-standing expectation that we
generally expect pkt-lines to end in a newline, but that
receivers should be lenient. This makes the spec consistent,
and matches what git already does (though it does not always
fulfill the SHOULD).

We do make an exception for the push-cert, where the
receiving code is currently a bit pickier. This is a
reasonable way to be, as the data needs to be byte-for-byte
compatible with what was signed. We _could_ make up some
rules about signing a canonicalized version including
newlines, but that would require a code change, and is out
of scope for this patch.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/pack-protocol.txt   | 46 ++++++++++++++++-------------
 Documentation/technical/protocol-common.txt |  5 +++-
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 4064fc7..c6977bb 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -14,6 +14,14 @@ data.  The protocol functions to have a server tell a client what is
 currently on the server, then for the two to negotiate the smallest amount
 of data to send in order to fully update one or the other.
 
+pkt-line Format
+---------------
+
+The descriptions below build on the pkt-line format described in
+protocol-common.txt. When the grammar indicate `PKT-LINE(...)`, unless
+otherwise noted the usual pkt-line LF rules apply: the sender SHOULD
+include a LF, but the receiver MUST NOT complain if it is not present.
+
 Transports
 ----------
 There are three transports over which the packfile protocol is
@@ -143,9 +151,6 @@ with the object name that each reference currently points to.
    003fe92df48743b7bc7d26bcaabfddde0a1e20cae47c refs/tags/v1.0^{}
    0000
 
-Server SHOULD terminate each non-flush line using LF ("\n") terminator;
-client MUST NOT complain if there is no terminator.
-
 The returned response is a pkt-line stream describing each ref and
 its current value.  The stream MUST be sorted by name according to
 the C locale ordering.
@@ -165,15 +170,15 @@ MUST peel the ref if it's an annotated tag.
 		      flush-pkt
 
   no-refs          =  PKT-LINE(zero-id SP "capabilities^{}"
-		      NUL capability-list LF)
+		      NUL capability-list)
 
   list-of-refs     =  first-ref *other-ref
   first-ref        =  PKT-LINE(obj-id SP refname
-		      NUL capability-list LF)
+		      NUL capability-list)
 
   other-ref        =  PKT-LINE(other-tip / other-peeled)
-  other-tip        =  obj-id SP refname LF
-  other-peeled     =  obj-id SP refname "^{}" LF
+  other-tip        =  obj-id SP refname
+  other-peeled     =  obj-id SP refname "^{}"
 
   shallow          =  PKT-LINE("shallow" SP obj-id)
 
@@ -216,8 +221,8 @@ out of what the server said it could do with the first 'want' line.
 
   depth-request     =  PKT-LINE("deepen" SP depth)
 
-  first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
-  additional-want   =  PKT-LINE("want" SP obj-id LF)
+  first-want        =  PKT-LINE("want" SP obj-id SP capability-list)
+  additional-want   =  PKT-LINE("want" SP obj-id)
 
   depth             =  1*DIGIT
 ----
@@ -284,7 +289,7 @@ so that there is always a block of 32 "in-flight on the wire" at a time.
 		       compute-end
 
   have-list         =  *have-line
-  have-line         =  PKT-LINE("have" SP obj-id LF)
+  have-line         =  PKT-LINE("have" SP obj-id)
   compute-end       =  flush-pkt / PKT-LINE("done")
 ----
 
@@ -348,10 +353,10 @@ Then the server will start sending its packfile data.
 
 ----
   server-response = *ack_multi ack / nak
-  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status LF)
+  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status)
   ack_status      = "continue" / "common" / "ready"
-  ack             = PKT-LINE("ACK SP obj-id LF)
-  nak             = PKT-LINE("NAK" LF)
+  ack             = PKT-LINE("ACK" SP obj-id)
+  nak             = PKT-LINE("NAK")
 ----
 
 A simple clone may look like this (with no 'have' lines):
@@ -467,10 +472,10 @@ references.
 ----
   update-request    =  *shallow ( command-list | push-cert ) [packfile]
 
-  shallow           =  PKT-LINE("shallow" SP obj-id LF)
+  shallow           =  PKT-LINE("shallow" SP obj-id)
 
-  command-list      =  PKT-LINE(command NUL capability-list LF)
-		       *PKT-LINE(command LF)
+  command-list      =  PKT-LINE(command NUL capability-list)
+		       *PKT-LINE(command)
 		       flush-pkt
 
   command           =  create / delete / update
@@ -521,7 +526,8 @@ Push Certificate
 
 A push certificate begins with a set of header lines.  After the
 header and an empty line, the protocol commands follow, one per
-line.
+line. Note that the the trailing LF in push-cert PKT-LINEs is _not_
+optional; it must be present.
 
 Currently, the following header fields are defined:
 
@@ -560,12 +566,12 @@ update was successful, or 'ng [refname] [error]' if the update was not.
 		      1*(command-status)
 		      flush-pkt
 
-  unpack-status     = PKT-LINE("unpack" SP unpack-result LF)
+  unpack-status     = PKT-LINE("unpack" SP unpack-result)
   unpack-result     = "ok" / error-msg
 
   command-status    = command-ok / command-fail
-  command-ok        = PKT-LINE("ok" SP refname LF)
-  command-fail      = PKT-LINE("ng" SP refname SP error-msg LF)
+  command-ok        = PKT-LINE("ok" SP refname)
+  command-fail      = PKT-LINE("ng" SP refname SP error-msg)
 
   error-msg         = 1*(OCTECT) ; where not "ok"
 ----
diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index 889985f..bf30167 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -62,7 +62,10 @@ A pkt-line MAY contain binary data, so implementors MUST ensure
 pkt-line parsing/formatting routines are 8-bit clean.
 
 A non-binary line SHOULD BE terminated by an LF, which if present
-MUST be included in the total length.
+MUST be included in the total length. Receivers MUST treat pkt-lines
+with non-binary data the same whether or not they contain the trailing
+LF (stripping the LF if present, and not complaining when it is
+missing).
 
 The maximum length of a pkt-line's data component is 65520 bytes.
 Implementations MUST NOT send pkt-line whose length exceeds 65524
-- 
2.5.1.812.ge796bff
