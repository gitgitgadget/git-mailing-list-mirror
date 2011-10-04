From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] remote-curl: Fix warning after HTTP failure
Date: Tue,  4 Oct 2011 16:20:19 -0700
Message-ID: <1317770419-24403-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Oct 05 01:20:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBEHl-0008NM-0N
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 01:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676Ab1JDXUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 19:20:24 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59495 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933299Ab1JDXUX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 19:20:23 -0400
Received: by yxl31 with SMTP id 31so1012229yxl.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 16:20:23 -0700 (PDT)
Received: by 10.68.35.97 with SMTP id g1mr13235158pbj.38.1317770422499;
        Tue, 04 Oct 2011 16:20:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:2201:be30:5bff:fed0:8744])
        by mx.google.com with ESMTPS id ji3sm608802pbc.2.2011.10.04.16.20.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 04 Oct 2011 16:20:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182815>

From: "Shawn O. Pearce" <spearce@spearce.org>

If the HTTP connection is broken in the middle of a fetch or clone
body, the client presented a useless error message due to part of
the upload-pack->remote-curl pkt-line protocol leaking out of the
helper as the helper's "fetch result":

  error: RPC failed; result=18, HTTP code = 200
  fatal: The remote end hung up unexpectedly
  fatal: early EOF
  fatal: unpack-objects failed
  warning: https unexpectedly said: '0000'

Instead when the HTTP RPC fails discard all remaining data from
upload-pack and report nothing to the transport helper. Errors
were already sent to stderr.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 remote-curl.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 69831e9..d2bf832 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -573,7 +573,16 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 
 	close(client.in);
 	client.in = -1;
-	strbuf_read(&rpc->result, client.out, 0);
+	if (!err) {
+	  strbuf_read(&rpc->result, client.out, 0);
+	} else {
+		char buf[4096];
+		for (;;) {
+			int n = read(client.out, buf, sizeof(buf));
+			if (n <= 0)
+			  break;
+		}
+	}
 
 	close(client.out);
 	client.out = -1;
-- 
1.7.6.4.dirty
