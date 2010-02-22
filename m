From: dborowitz@google.com
Subject: [PATCH] Document shallow/unshallow/deepen protocol request and response.
Date: Mon, 22 Feb 2010 15:47:37 -0800
Message-ID: <1266882457-21665-1-git-send-email-dborowitz@google.com>
Cc: Dave Borowitz <dborowitz@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 00:48:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nji1A-0001ga-Bz
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 00:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752020Ab0BVXsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 18:48:43 -0500
Received: from smtp-out.google.com ([216.239.33.17]:20697 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0BVXsm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 18:48:42 -0500
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id o1MNmd7a031465
	for <git@vger.kernel.org>; Mon, 22 Feb 2010 23:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1266882520; bh=ZlXCONa7a+UL6Cilae8E5clpoh4=;
	h=From:To:Cc:Subject:Date:Message-Id;
	b=AmepaHOlstaPXylTdq0M6Yxh4c/JX5bQyPcLWQTTy5m/2aE2LDHQjucJYyXTfvXXN
	 p5VIxf8uDqBFtUA0+0pKg==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=from:to:cc:subject:date:message-id:x-mailer:x-system-of-record;
	b=PxSd7q7r/Kw+AaNljEKyM6l2md85n3COgk7Nx/VsQbXtDbN9x/uMM41VOIFuN1qNE
	RkGnFUE3FVwWWFUlvs06w==
Received: from fxm26 (fxm26.prod.google.com [10.184.13.26])
	by kpbe13.cbf.corp.google.com with ESMTP id o1MNmaiP014646
	for <git@vger.kernel.org>; Mon, 22 Feb 2010 17:48:38 -0600
Received: by fxm26 with SMTP id 26so727746fxm.13
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 15:48:36 -0800 (PST)
Received: by 10.103.48.23 with SMTP id a23mr144417muk.77.1266882516498;
        Mon, 22 Feb 2010 15:48:36 -0800 (PST)
Received: from localhost.localdomain (serval.mtv.corp.google.com [172.18.104.63])
        by mx.google.com with ESMTPS id w5sm902507mue.52.2010.02.22.15.48.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 15:48:35 -0800 (PST)
X-Mailer: git-send-email 1.7.0.rc2.28.gf476c0
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140742>

From: Dave Borowitz <dborowitz@google.com>

This patch fixes a TODO in the pack protocol documentation about the
protocol for shallow clones. I'll be the first to admit I may not
understand shallow clones fully, but this patch is hopefully a good
starting point.

---
 Documentation/technical/pack-protocol.txt |   36 +++++++++++++++++++++-------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 9a5cdaf..d3392f5 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -194,6 +194,7 @@ effect, out of what the server said it could do with the first 'want' line.
 
 ----
   upload-request    =  want-list
+		       shallow-request
 		       have-list
 		       compute-end
 
@@ -204,6 +205,11 @@ effect, out of what the server said it could do with the first 'want' line.
   first-want        =  PKT-LINE("want" SP obj-id SP capability-list LF)
   additional-want   =  PKT-LINE("want" SP obj-id LF)
 
+  shallow-request   =  *shallow-line
+		       deepen-line
+  shallow-line      =  PKT-LINE("shallow" SP obj-id LF)
+  deepen-line       =  PKT-LINE("deepen" SP 1*DIGIT LF)
+
   have-list         =  *have-line
   have-line         =  PKT-LINE("have" SP obj-id LF)
   compute-end       =  flush-pkt / PKT-LINE("done")
@@ -215,15 +221,23 @@ discovery phase as 'want' lines. Clients MUST send at least one
 obj-id in a 'want' command which did not appear in the response
 obtained through ref discovery.
 
-If client is requesting a shallow clone, it will now send a 'deepen'
-line with the depth it is requesting.
+If client is requesting a shallow clone, it will now send a 'shallow'
+line for each shallow commit it currently has, followed by a 'deepen'
+line for the depth it is requesting.
+
+The server will respond to a shallow clone request with several
+'shallow'/'unshallow' lines. The server MUST send one 'shallow' line for
+each new commit that will be shallow following the deepen operation, and
+the server MUST send one 'unshallow' line for each shallow commit the
+client has that will no longer be shallow after the deepen. The server
+SHOULD NOT send 'shallow' lines for shallow commits the client has that
+remain shallow. The server MUST NOT mention an obj-id in an 'unshallow'
+line that the client did not mention in a corresponding 'shallow' line.
 
 Once all the "want"s (and optional 'deepen') are transferred,
 clients MUST send a flush-pkt. If the client has all the references
 on the server, client flushes and disconnects.
 
-TODO: shallow/unshallow response and document the deepen command in the ABNF.
-
 Now the client will send a list of the obj-ids it has using 'have'
 lines.  In multi_ack mode, the canonical implementation will send up
 to 32 of these at a time, then will send a flush-pkt.  The canonical
@@ -289,11 +303,15 @@ if there is no common base found.
 Then the server will start sending its packfile data.
 
 ----
-  server-response = *ack_multi ack / nak
-  ack_multi       = PKT-LINE("ACK" SP obj-id ack_status LF)
-  ack_status      = "continue" / "common" / "ready"
-  ack             = PKT-LINE("ACK SP obj-id LF)
-  nak             = PKT-LINE("NAK" LF)
+  server-response  = [shallow-response]
+		    *ack_multi ack / nak
+  shallow-response = *shallow-line
+		     *unshallow-line
+  unshallow-line   = PKT-LINE("unshallow" SP obj-id LF)
+  ack_multi        = PKT-LINE("ACK" SP obj-id ack_status LF)
+  ack_status       = "continue" / "common" / "ready"
+  ack              = PKT-LINE("ACK SP obj-id LF)
+  nak              = PKT-LINE("NAK" LF)
 ----
 
 A simple clone may look like this (with no 'have' lines):
-- 
1.7.0.rc2.28.gf476c0
