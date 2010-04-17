From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 04/11] http.c: Drop useless != NULL test in finish_http_pack_request
Date: Sat, 17 Apr 2010 13:07:37 -0700
Message-ID: <1271534864-31944-4-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJP-0005ew-Ew
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab0DQUII (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:08:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59025 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab0DQUHy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:54 -0400
Received: by gyg13 with SMTP id 13so1949036gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:53 -0700 (PDT)
Received: by 10.101.144.27 with SMTP id w27mr8020622ann.197.1271534873202;
        Sat, 17 Apr 2010 13:07:53 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id y6sm26785800ana.15.2010.04.17.13.07.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145176>

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
