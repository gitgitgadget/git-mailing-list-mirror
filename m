From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 06/15] copy.c: make copy_fd preserve meaningful errno
Date: Mon,  3 Nov 2014 08:55:48 -0800
Message-ID: <1415033757-9539-7-git-send-email-sahlberg@google.com>
References: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 17:59:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlKyG-0003FT-Vw
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 17:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbaKCQ6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 11:58:50 -0500
Received: from mail-pd0-f202.google.com ([209.85.192.202]:60892 "EHLO
	mail-pd0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbaKCQ4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 11:56:05 -0500
Received: by mail-pd0-f202.google.com with SMTP id ft15so1937892pdb.3
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjed1sbQZpmuYRbgZL7YmUUPGXMtkEnlv2kTSXe+V0A=;
        b=NYQle0T/YwWITRORycQIa5SnjBMDHVBeSVs0BrQd5LENWv59e8jr8bDeHKNJbJzOqC
         vonJQV7PS97S/mh+FkopVbzh6VDmUyUzug89T7Us3bsjHxCDcAJz9gondA0Nn5jp+SHI
         qU+h39IO7ho1QP0KF3LYsUsgCnISemBmpI1QJlF6VKCQNPuKFK5BP4/IAM3aNaI0LbLG
         Jk8XcIQTRqNtz/24PDRxKqHSOLqg2c8qPKRW/LoKkpLBuTWbYmLYOc7GNzvKgn26KIeT
         azZhOEqJXccBHpG7LxjUHBpt5Z1vsbtu/2SVT7SIHX1He5Ma07pa6ok5QJQrzFbvt6E2
         p5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjed1sbQZpmuYRbgZL7YmUUPGXMtkEnlv2kTSXe+V0A=;
        b=KjvO1DLn9mSoHKAam0af177Zf5BRTL+7NgQ6Cnjtum66v1VltOaF55g5vWqh96SEWy
         p0djXxk6Gh5VuU50Qyz4lYZ8zMSwYaU/xYFf5IB2M5PsiNKLa8OA13B/5NZ1dbAE2Yng
         xe4fzMP83TLqwlhK9EeFdcqssSijQ6Jz2lLKVgNa1jAmg2Mcm+dD21Od97DCNTBjxnV8
         Gzk0Bji1CE9GXF16+1wry7uy033Ns8z0ub3dZUF5oJl6j6tzGdErmsG7LUYDgCcS4hd6
         XGFsQaUzp2caEHoFIFwyBPT03WYn32adAiG7M78YqaAAL3eFGYPgbGIJqYUznwgOlVqA
         amFg==
X-Gm-Message-State: ALoCoQkTn0v4s8u0MoRhb1/KdVdaoyVMPvaiZsrRyfmfcRU4yyabArDqviaMry+I/6kA7fxym4sI
X-Received: by 10.68.132.234 with SMTP id ox10mr32349448pbb.8.1415033763645;
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id s23si959286yhf.0.2014.11.03.08.56.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 08:56:03 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id mte8G6bb.1; Mon, 03 Nov 2014 08:56:03 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 53983E1081; Mon,  3 Nov 2014 08:56:02 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415033757-9539-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update copy_fd to return a meaningful errno on failure.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 copy.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/copy.c b/copy.c
index f2970ec..a8d366e 100644
--- a/copy.c
+++ b/copy.c
@@ -8,12 +8,17 @@ int copy_fd(int ifd, int ofd)
 		if (!len)
 			break;
 		if (len < 0) {
-			return error("copy-fd: read returned %s",
-				     strerror(errno));
+			int save_errno = errno;
+			error("copy-fd: read returned %s", strerror(errno));
+			errno = save_errno;
+			return -1;
+		}
+		if (write_in_full(ofd, buffer, len) < 0) {
+			int save_errno = errno;
+			error("copy-fd: write returned %s", strerror(errno));
+			errno = save_errno;
+			return -1;
 		}
-		if (write_in_full(ofd, buffer, len) < 0)
-			return error("copy-fd: write returned %s",
-				     strerror(errno));
 	}
 	return 0;
 }
-- 
2.1.0.rc2.206.gedb03e5
