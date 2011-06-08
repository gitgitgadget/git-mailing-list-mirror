From: ZAK Neronskiy <zakmagnus@google.com>
Subject: [PATCH 2/2] Document the underlying protocol used by shallow repositories and --depth commands.
Date: Wed,  8 Jun 2011 15:11:51 -0700
Message-ID: <1307571111-14219-2-git-send-email-zakmagnus@google.com>
References: <1307571111-14219-1-git-send-email-zakmagnus@google.com>
Cc: Johannes.Schindelin@gmx.de, schacon@gmail.com,
	ZAK Neronskiy <zakmagnus@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 00:13:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUR0Q-0006TO-GW
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 00:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab1FHWNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 18:13:37 -0400
Received: from smtp-out.google.com ([74.125.121.67]:58189 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab1FHWNg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 18:13:36 -0400
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id p58MDYXq001011
	for <git@vger.kernel.org>; Wed, 8 Jun 2011 15:13:35 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1307571215; bh=aY9jBl3TrhBpXy7Zqph+fhuI7C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
	b=xningjpfS96mPvM/pWnBKuJEaBg+BETCYW3RW3sL7jusqVejxZLfL54CzARemHzj1
	 WU93Rw2pE8A3868VN32XQ==
Received: from pzk4 (pzk4.prod.google.com [10.243.19.132])
	by kpbe13.cbf.corp.google.com with ESMTP id p58MDW71028722
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 8 Jun 2011 15:13:33 -0700
Received: by pzk4 with SMTP id 4so576782pzk.14
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 15:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=VemgUQFPrDaEPgThp8Cx8uVxyvLg6SSPRNgCPnk3siw=;
        b=p+HGuaG387lSH+Ge/qw1osq+1mP7y4nvbxPZCCLQ2Ct1JnM/DkmMkVPCmmt1EXp6re
         mD5cYpXso+7VGxOwCOSQ==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=kS++LJe480xxFUi6s+v4etifcfm1QkklaZ6sotXGsIWKGN9p9VmoCKgCEv3kehleQp
         EHCIJxcJK0+dJRXGiKhQ==
Received: by 10.68.1.68 with SMTP id 4mr983732pbk.306.1307571212667;
        Wed, 08 Jun 2011 15:13:32 -0700 (PDT)
Received: from localhost.localdomain (outrider.mtv.corp.google.com [172.22.72.173])
        by mx.google.com with ESMTPS id k4sm828459pbl.27.2011.06.08.15.13.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 15:13:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1
In-Reply-To: <1307571111-14219-1-git-send-email-zakmagnus@google.com>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175467>

Explain the exchange that occurs between a client and server when
the client is requesting shallow history and/or is already using
a shallow repository.

Signed-off-by: Alex Neronskiy <zakmagnus@google.com>
---
 Documentation/technical/pack-protocol.txt |   88 +++++++++++++++++++++-------
 1 files changed, 66 insertions(+), 22 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index ce69f57..a7004c6 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -187,27 +187,28 @@ the client already is up-to-date.
 
 Otherwise, it enters the negotiation phase, where the client and
 server determine what the minimal packfile necessary for transport is,
-by telling the server what objects it wants and what objects it has,
-so the server can make a packfile that only contains the objects that the
-client needs.  The client will also send a list of the capabilities it
-wants to be in effect, out of what the server said it could do with the
-first 'want' line.
+by telling the server what objects it wants, its shallow objects
+(if any), and the maximum commit depth it wants (if any).  The client
+will also send a list of the capabilities it wants to be in effect,
+out of what the server said it could do with the first 'want' line.
 
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
@@ -216,21 +217,64 @@ discovery phase as 'want' lines. Clients MUST send at least one
 obj-id in a 'want' command which did not appear in the response
 obtained through ref discovery.
 
-If client is requesting a shallow clone, it will now send a 'deepen'
-line with the depth it is requesting.
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
+transferred, clients MUST send a flush-pkt, to tell the server side
+that it is done sending the list.
+
+Otherwise, if the client sent a positive depth request, the server
+will determine which commits will and will not be shallow and
+send this information to the client. If the client did not request
+a positive depth, this step is skipped.
 
-Once all the "want"s (and optional 'deepen') are transferred,
-clients MUST send a flush-pkt, to tell the server side that it is
-done sending the list.
+----
+  shallow-update   =  *shallow-line
+		      *unshallow-line
+		      flush-pkt
 
-TODO: shallow/unshallow response and document the deepen command in the ABNF.
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
