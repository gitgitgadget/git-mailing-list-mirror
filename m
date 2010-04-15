From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/6] http.c: Remove bad free of static block
Date: Thu, 15 Apr 2010 12:09:15 -0700
Message-ID: <1271358560-8946-2-git-send-email-spearce@spearce.org>
References: <20100415141504.GB17883@spearce.org>
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 15 21:09:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2URe-0004rK-GK
	for gcvg-git-2@lo.gmane.org; Thu, 15 Apr 2010 21:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755918Ab0DOTJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Apr 2010 15:09:34 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47207 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843Ab0DOTJb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Apr 2010 15:09:31 -0400
Received: by wyb39 with SMTP id 39so698478wyb.19
        for <git@vger.kernel.org>; Thu, 15 Apr 2010 12:09:30 -0700 (PDT)
Received: by 10.216.86.16 with SMTP id v16mr476339wee.169.1271358570016;
        Thu, 15 Apr 2010 12:09:30 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id x14sm13955361wbs.12.2010.04.15.12.09.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Apr 2010 12:09:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100415141504.GB17883@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145004>

The filename variable here is pointing to a block of memory that
was allocated by sha1_file.c and is also held in a static variable
scoped within the sha1_pack_name() function.  Doing a free() here is
returning that memory to the allocator while we might still try to
reuse it on a subsequent sha1_pack_name() invocation.  That's not
acceptable, so don't free it.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 http.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/http.c b/http.c
index 4814217..f26625e 100644
--- a/http.c
+++ b/http.c
@@ -1082,7 +1082,6 @@ struct http_pack_request *new_http_pack_request(
 	return preq;
 
 abort:
-	free(filename);
 	free(preq->url);
 	free(preq);
 	return NULL;
-- 
1.7.1.rc1.269.ga27c7
