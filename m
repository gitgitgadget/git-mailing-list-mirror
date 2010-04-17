From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 03/11] http.c: Tiny refactoring of finish_http_pack_request
Date: Sat, 17 Apr 2010 13:07:36 -0700
Message-ID: <1271534864-31944-3-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJl-0005p7-La
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab0DQUIF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:05 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:43704 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754358Ab0DQUHv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:51 -0400
Received: by mail-yx0-f199.google.com with SMTP id 37so2119918yxe.21
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:51 -0700 (PDT)
Received: by 10.100.29.37 with SMTP id c37mr1094059anc.242.1271534871102;
        Sat, 17 Apr 2010 13:07:51 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id n2sm26785023ann.12.2010.04.17.13.07.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145181>

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
