From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] smart-http: Don't deadlock on server failure
Date: Fri,  6 Aug 2010 14:19:44 -0700
Message-ID: <1281129584-18781-1-git-send-email-spearce@spearce.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUKt-0005ak-D8
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542Ab0HFVTt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 17:19:49 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33245 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403Ab0HFVTs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:19:48 -0400
Received: by pzk26 with SMTP id 26so3013486pzk.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:19:47 -0700 (PDT)
Received: by 10.114.103.7 with SMTP id a7mr14629078wac.184.1281129587253;
        Fri, 06 Aug 2010 14:19:47 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id k23sm3552056waf.17.2010.08.06.14.19.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:19:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.52.g7f7860
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152818>

If the remote HTTP server fails (e.g. returns 404 or 500) when we
posted the RPC to it, we won't have sent anything to the background
Git process that is supposed to handle the stream.  Because we
didn't send anything, its waiting for input from remote-curl, and
remote-curl cannot read its response payload because doing so would
lead to a deadlock.

Send the background task EOF on its input before we try to read
its response back, that way it will break out of its read loop
and terminate.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This was found in Git 1.6.6.1, and exists since we added smart HTTP
 in 1.6.6.  Should apply at least to 'maint', if not older... :-)

 remote-curl.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 8f169dd..c9d8f60 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -491,11 +491,12 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
 		rpc->len = n;
 		err |= post_rpc(rpc);
 	}
-	strbuf_read(&rpc->result, client.out, 0);
 
 	close(client.in);
-	close(client.out);
 	client.in = -1;
+	strbuf_read(&rpc->result, client.out, 0);
+
+	close(client.out);
 	client.out = -1;
 
 	err |= finish_command(&client);
-- 
1.7.2.1.52.g7f7860
