From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 3/6] http.c: Tiny refactoring of finish_http_pack_request
Date: Thu, 15 Apr 2010 12:09:17 -0700
Message-ID: <1271358560-8946-4-git-send-email-spearce@spearce.org>
References: <20100415141504.GB17883@spearce.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2URf-0004rK-OC
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:09:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756059Ab0DOTJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:09:43 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47207 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0DOTJm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:09:42 -0400
Received: by mail-wy0-f174.google.com with SMTP id 39so698478wyb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:09:41 -0700 (PDT)
Received: by 10.216.85.135 with SMTP id u7mr531437wee.51.1271358578689;
        Thu, 15 Apr 2010 12:09:38 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id t27sm13938741wbc.23.2010.04.15.12.09.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:09:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100415141504.GB17883@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145006>

Always remove the struct packed_git from the active list, even
if the rename of the temporary file fails.

While we are here, simplify the code a bit by using a common
local variable name ("p") to hold the relevant packed_git.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/http.c b/http.c
index f26625e..4558f11 100644
--- a/http.c
+++ b/http.c
@@ -1002,8 +1002,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 {
 	int ret;
 	struct packed_git **lst;
+	struct packed_git *p = preq->target;
 
-	preq->target->pack_size = ftell(preq->packfile);
+	p->pack_size = ftell(preq->packfile);
 
 	if (preq->packfile != NULL) {
 		fclose(preq->packfile);
@@ -1011,18 +1012,17 @@ int finish_http_pack_request(struct http_pack_request *preq)
 		preq->slot->local = NULL;
 	}
 
-	ret = move_temp_to_file(preq->tmpfile, preq->filename);
-	if (ret)
-		return ret;
-
 	lst = preq->lst;
-	while (*lst != preq->target)
+	while (*lst != p)
 		lst = &((*lst)->next);
 	*lst = (*lst)->next;
 
-	if (verify_pack(preq->target))
+	ret = move_temp_to_file(preq->tmpfile, preq->filename);
+	if (ret)
+		return ret;
+	if (verify_pack(p))
 		return -1;
-	install_packed_git(preq->target);
+	install_packed_git(p);
 
 	return 0;
 }
-- 
1.7.1.rc1.269.ga27c7
