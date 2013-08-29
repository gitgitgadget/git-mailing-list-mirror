From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/9] transport-helper: check for 'forced update' message
Date: Thu, 29 Aug 2013 10:23:21 -0500
Message-ID: <1377789808-2213-3-git-send-email-felipe.contreras@gmail.com>
References: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 17:28:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF49B-0008Un-35
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 17:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442Ab3H2P23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 11:28:29 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:43474 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754225Ab3H2P23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 11:28:29 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so779075oag.12
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FTN9o3sjM0CBrNHELVyaJhBQk/m5uYrA2TKQHh7zX1Q=;
        b=aizxhb8LuEnIoCyBrEhhjNwv/HbxhmuTGlwq32SFvptCKtvlK4Q0bXJztn2ijM6nqf
         o1ABxMdx2P+N8WepM52+WDoaJUCATvaXiwb4/VmEfqOPiR8mSZxXSWL8I/eYYapm7AOj
         IYzRTCz20+EVg5E9sMUc4W+Sg7n24xs/0Yah6qLLfR8hyVVFoQY5sgd/2g4Hhy55q+E4
         QEfhoufGVSaJ+UZl/+kVmVNKp1zlPO0LSeQwZDijIomhQN42GhaV6xUIKcJEm6HEN0mw
         C5bMTbYLxCmTxv2k5rYGPhzfDQiXlBJm9gyokEK9X1edBFw5jx41ntc/Z/GZvkVItDuS
         FhPQ==
X-Received: by 10.182.246.99 with SMTP id xv3mr2874210obc.47.1377790108602;
        Thu, 29 Aug 2013 08:28:28 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id qi5sm31898066obb.6.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 08:28:27 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377789808-2213-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233269>

So the remote-helpers can tell us when a forced push was needed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 62051a6..95dd72e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -630,7 +630,7 @@ static int push_update_ref_status(struct strbuf *buf,
 				   struct ref *remote_refs)
 {
 	char *refname, *msg;
-	int status;
+	int status, forced = 0;
 
 	if (!prefixcmp(buf->buf, "ok ")) {
 		status = REF_STATUS_OK;
@@ -683,6 +683,11 @@ static int push_update_ref_status(struct strbuf *buf,
 			free(msg);
 			msg = NULL;
 		}
+		else if (!strcmp(msg, "forced update")) {
+			forced = 1;
+			free(msg);
+			msg = NULL;
+		}
 	}
 
 	if (*ref)
@@ -704,6 +709,7 @@ static int push_update_ref_status(struct strbuf *buf,
 	}
 
 	(*ref)->status = status;
+	(*ref)->forced_update = forced;
 	(*ref)->remote_status = msg;
 	return !(status == REF_STATUS_OK);
 }
-- 
1.8.4-fc
