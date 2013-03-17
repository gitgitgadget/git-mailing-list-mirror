From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] safe_create_leading_directories: fix race that could give a false negative
Date: Sun, 17 Mar 2013 10:09:27 -0400
Message-ID: <1363529367-5919-1-git-send-email-stevenrwalter@gmail.com>
References: <7v7gl6sfsg.fsf@alter.siamese.dyndns.org>
Cc: Steven Walter <stevenrwalter@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Mar 17 15:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHEHk-00039c-Nt
	for gcvg-git-2@plane.gmane.org; Sun, 17 Mar 2013 15:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756364Ab3CQOJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Mar 2013 10:09:37 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:61373 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab3CQOJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Mar 2013 10:09:37 -0400
Received: by mail-ve0-f171.google.com with SMTP id b10so3718085vea.16
        for <git@vger.kernel.org>; Sun, 17 Mar 2013 07:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=kYgeRWo4OWA00CunrAs8kc5wCOM45UUNSz96IKRWMnE=;
        b=GkFC8YViEAc2M8yfKeqokTbFhSij1VGXhkCtUBbrRvSPbO9esDIYlwJrxDVMt4L5ZZ
         QG9skBwUWBu9e4DU991RVxh9dvzYGWF8PpekEpFI9UgijLQxQOKr4+pjIITE//uHbuq6
         6V4OLQQboNJgKZleNH4A/oWB0lbak4qBLrNLyGuza2AZIbqRzRpVxGeU35I0NTfOp7A+
         mjvcoU1Yj75XmeEYQ+hF6RbMknBzeZb7u+/mDns3n0PE6ch8QQhO5FVHWhnsNKJm26lt
         wFKOmh+tjVTKfBC8BNx12Ljy2qXkvCVVQ6EEnEPveORvJpZuobcaRGSDT2o+tD0lv/sA
         IhyQ==
X-Received: by 10.220.154.199 with SMTP id p7mr9913193vcw.46.1363529376247;
        Sun, 17 Mar 2013 07:09:36 -0700 (PDT)
Received: from brock (CPE-76-177-45-54.natcky.res.rr.com. [76.177.45.54])
        by mx.google.com with ESMTPS id a19sm16789156vdh.9.2013.03.17.07.09.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 17 Mar 2013 07:09:35 -0700 (PDT)
Received: by brock (Postfix, from userid 1000)
	id CB8A62623A9; Sun, 17 Mar 2013 10:09:32 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <7v7gl6sfsg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218365>

If two processes are racing to create the same directory tree, they will
both see that the directory doesn't exist, both try to mkdir(), and one
of them will fail.  This is okay, as we only care that the directory
gets created.  So, we add a check for EEXIST from mkdir, and continue if
the directory now exists.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 sha1_file.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index 40b2329..5668ecc 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -123,6 +123,15 @@ int safe_create_leading_directories(char *path)
 			}
 		}
 		else if (mkdir(path, 0777)) {
+			if (errno == EEXIST) {
+				/*
+				 * We could be racing with another process to
+				 * create the directory.  As long as the
+				 * directory gets created, we don't care.
+				 */
+				if (stat(path, &st) && S_ISDIR(st.st_mode))
+					continue;
+			}
 			*pos = '/';
 			return -1;
 		}
-- 
1.7.10.4
