From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH v3 01/11] http.c: Remove bad free of static block
Date: Sat, 17 Apr 2010 13:07:34 -0700
Message-ID: <1271534864-31944-1-git-send-email-spearce@spearce.org>
References: <20100416100307.0000423f@unknown>
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	jan.sievers@sap.com, Matthias Sohn <matthias.sohn@sap.com>
To: Junio C Hamano <gitster@pobox.com>,
	Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 22:08:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3EJD-0005X6-3Z
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 22:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753831Ab0DQUHs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 16:07:48 -0400
Received: from mail-yx0-f199.google.com ([209.85.210.199]:43704 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752545Ab0DQUHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 16:07:47 -0400
Received: by yxe37 with SMTP id 37so2119918yxe.21
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 13:07:47 -0700 (PDT)
Received: by 10.101.126.10 with SMTP id d10mr8709823ann.196.1271534866892;
        Sat, 17 Apr 2010 13:07:46 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id 7sm1080387yxg.27.2010.04.17.13.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 13:07:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc1.269.ga27c7
In-Reply-To: <20100416100307.0000423f@unknown>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145175>

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
