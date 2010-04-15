From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 4/6] http.c: Drop useless != NULL test in finish_http_pack_request
Date: Thu, 15 Apr 2010 12:09:18 -0700
Message-ID: <1271358560-8946-5-git-send-email-spearce@spearce.org>
References: <20100415141504.GB17883@spearce.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:10:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2US1-00055I-CS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab0DOTJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:09:46 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63322 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0DOTJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:09:44 -0400
Received: by wwb24 with SMTP id 24so711662wwb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:09:43 -0700 (PDT)
Received: by 10.216.91.16 with SMTP id g16mr500670wef.102.1271358583023;
        Thu, 15 Apr 2010 12:09:43 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x1sm13940302wbx.19.2010.04.15.12.09.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:09:42 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100415141504.GB17883@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145010>

The test preq->packfile != NULL is always true.  If packfile was
actually NULL when entering this function the ftell() above would
crash out with a SIGSEGV, resulting in never reaching this point.

Simplify the code by just removing the conditional.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/http.c b/http.c
index 4558f11..64e0c18 100644
--- a/http.c
+++ b/http.c
@@ -1005,12 +1005,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	struct packed_git *p = preq->target;
 
 	p->pack_size = ftell(preq->packfile);
-
-	if (preq->packfile != NULL) {
-		fclose(preq->packfile);
-		preq->packfile = NULL;
-		preq->slot->local = NULL;
-	}
+	fclose(preq->packfile);
+	preq->packfile = NULL;
+	preq->slot->local = NULL;
 
 	lst = preq->lst;
 	while (*lst != p)
-- 
1.7.1.rc1.269.ga27c7
