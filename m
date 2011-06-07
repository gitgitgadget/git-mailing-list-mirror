From: Alex Neronskiy <zakmagnus@google.com>
Subject: [PATCH v2] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Tue, 7 Jun 2011 19:24:30 +0000 (UTC)
Message-ID: <loom.20110607T212226-56@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 21:24:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU1tR-00072O-FA
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 21:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758186Ab1FGTYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 15:24:44 -0400
Received: from lo.gmane.org ([80.91.229.12]:35284 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758182Ab1FGTYn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 15:24:43 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QU1tJ-0006yy-PZ
	for git@vger.kernel.org; Tue, 07 Jun 2011 21:24:41 +0200
Received: from 216-239-45-4.google.com ([216.239.45.4])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 21:24:41 +0200
Received: from zakmagnus by 216-239-45-4.google.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 21:24:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 216.239.45.4 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175256>

Explain the exchange that occurs between a client and server when
the client is requesting shallow history and/or is already using
a shallow repository.

Signed-off-by: Alex Neronskiy <zakmagnus@google.com>
---
 Documentation/technical/pack-protocol.txt |   88 ++++++++++++++++++++++-------
 1 files changed, 67 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt
b/Documentation/technical/pack-protocol.txt
index 369f91d..8727d40 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -187,26 +187,28 @@ server determine what the minimal packfile necessary for
transport is.
 
 Once the client has the initial list of references that the server
 has, as well as the list of capabilities, it will begin telling the
-server what objects it wants and what objects it has, so the server
-can make a packfile that only contains the objects that the client needs.
-The client will also send a list of the capabilities it wants to be in
-effect, out of what the server said it could do with the first 'want' line.
+server what objects it wants, its shallow objects (if any), and the
+maximum commit depth it wants (if any).  The client will also send a
+list of the capabilities it wants to be in effect, out of what the
+server said it could do with the first 'want' line.
 
 ----
   upload-request    =  want-list
-		       have-list
-		       compute-end
+		       *shallow-line
+		       *1depth-request
+		       flush-pkt
 
   want-list         =  first-want
 		       *additional-want
-		       flush-pkt
+
+  shallow-line      =  PKT_LINE("shallow" SP obj-id)
+
+  depth-request     =  PKT_LINE("deepen" SP depth)
 
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
   additional-want   =  PKT-LINE("want" SP obj-id LF)
 
-  have-list         =  *have-line
-  have-line         =  PKT-LINE("have" SP obj-id LF)
-  compute-end       =  flush-pkt / PKT-LINE("done")
+  depth             =  1*DIGIT
 ----
 
 Clients MUST send all the obj-ids it wants from the reference
@@ -215,21 +217,65 @@ discovery phase as 'want' lines. Clients MUST send at
least one
 obj-id in a 'want' command which did not appear in the response
 obtained through ref discovery.
 
-If client is requesting a shallow clone, it will now send a 'deepen'
-line with the depth it is requesting.
-
-Once all the "want"s (and optional 'deepen') are transferred,
-clients MUST send a flush-pkt. If the client has all the references
+The client MUST write all obj-ids which it only has shallow copies
+of (meaning that it does not have the parents of a commit) as
+'shallow' lines so that the server is aware of the limitations of
+the client's history. Clients MUST NOT mention an obj-id which
+it does not know exists on the server.
+
+The client now sends the maximum commit history depth it wants for
+this transaction, which is the number of commits it wants from the
+tip of the history, if any, as a 'deepen' line.  A depth of 0 is the
+same as not making a depth request. The client does not want to receive
+any commits beyond this depth, nor objects needed only to complete
+those commits. Commits whose parents are not received as a result are
+defined as shallow and marked as such in the server. This information
+is sent back to the client in the next step.
+
+Once all the 'want's and 'shallow's (and optional 'deepen') are
+transferred, clients MUST send a flush-pkt. If the client did not
+request a shallow history and has all of the most recent references
 on the server, client flushes and disconnects.
 
-TODO: shallow/unshallow response and document the deepen command in the ABNF.
+Otherwise, if the client sent a positive depth request, the server
+will determine which commits will and will not be shallow and
+send this information to the client. If the client did not request
+a positive depth, this step is skipped.
+
+----
+  shallow-update   =  *shallow-line
+		      *unshallow-line
+		      flush-pkt
+
+  shallow-line     =  PKT-LINE("shallow" SP obj-id)
+
+  unshallow-line   =  PKT-LINE("unshallow" SP obj-id)
+----
+
+If the client has requested a positive depth, the server will compute
+the set of commits which are no deeper than the desired depth, starting
+at the client's wants. The server writes 'shallow' lines for each
+commit whose parents will not be sent as a result. The server writes
+an 'unshallow' line for each commit which the client has indicated is
+shallow, but is no longer shallow at the currently requested depth
+(that is, its parents will now be sent). The server MUST NOT mark
+as unshallow anything which the client has not indicated was shallow.
 
 Now the client will send a list of the obj-ids it has using 'have'
-lines.  In multi_ack mode, the canonical implementation will send up
-to 32 of these at a time, then will send a flush-pkt.  The canonical
-implementation will skip ahead and send the next 32 immediately,
-so that there is always a block of 32 "in-flight on the wire" at a
-time.
+lines, so the server can make a packfile that only contains the objects
+that the client needs. In multi_ack mode, the canonical implementation
+will send up to 32 of these at a time, then will send a flush-pkt. The
+canonical implementation will skip ahead and send the next 32 immediately,
+so that there is always a block of 32 "in-flight on the wire" at a time.
+
+----
+  upload-haves      =  have-list
+		       compute-end
+
+  have-list         =  *have-line
+  have-line         =  PKT-LINE("have" SP obj-id LF)
+  compute-end       =  flush-pkt / PKT-LINE("done")
+----
 
 If the server reads 'have' lines, it then will respond by ACKing any
 of the obj-ids the client said it had that the server also has. The
-- 
1.7.3.1
