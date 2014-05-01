From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v6 05/42] update-ref.c: log transaction error from the update_ref
Date: Thu,  1 May 2014 13:37:05 -0700
Message-ID: <1398976662-6962-6-git-send-email-sahlberg@google.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 22:40:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wfxmg-0003xB-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:40:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbaEAUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:40:43 -0400
Received: from mail-ve0-f202.google.com ([209.85.128.202]:50191 "EHLO
	mail-ve0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752222AbaEAUhr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:37:47 -0400
Received: by mail-ve0-f202.google.com with SMTP id sa20so429866veb.3
        for <git@vger.kernel.org>; Thu, 01 May 2014 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bjwdg+FPsUWfZP+K7AhsqTacTMygzKpjURtI2ChHtRs=;
        b=Qwv0BBEUwA8wmXk4KJsSM4eeH6WJoLjqAblghxFli+9j2iXM09F3APduNYjzNk7+lB
         dTbhHITZCfNgZ34Yho0cfMV1Bcz57iUici3XBs0iNdGpDUomzcHbhED2YeZ6SeHqb3pc
         UAP62Fb64zJNngAm+SqtDzeBOznG8ReEomVrh9e7xezZAtUcjbCstmVLt+wQkOPY+xyU
         1el9QkajfOAWX69LL9qJM7BeTX717r5GAYmw/wb/Fq4V81dlDW6bfHkCx/SmJt0b07rB
         027U0VX/h390wverIvBHRgbEh+sNdn7bQVwgMxOzruNWiM1O/bfdy3XPPayO9YBru2jB
         yzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bjwdg+FPsUWfZP+K7AhsqTacTMygzKpjURtI2ChHtRs=;
        b=Sb0yqhxyWojq7EWS7xkyD9YYshZrdR9DntD9g0cBs/B4B6j7cpIoVTzccrAMlT76pc
         i69XxUR7kehnnfyBsIoPadCylTjccjggKxzCWSrTBa6sH+hgfURbCJasuYLc6wSvKySs
         mzkVZWYVmnb0PauufifwKXf3uq6ZgP2Ajo98pzR8sBXeWIMMJzWeJBPyM13GzYvCWTVU
         pMPFwd268v7quJXDspTsXpraDbiaWh9GZ3nReyTiz+Q7zidas/fXTAYBcmT0+ewWebWr
         NV76PbX5R/8vgnpTYhyKyQrOzoiYwnlF28vzzZietpyksbcTv0GSVuug4jPYq9zEMKJc
         nbKg==
X-Gm-Message-State: ALoCoQnPuRjOcA5LcuPbEp/YKlClcW32VDLUmBW8PpkoEsKRkRPM71YUPrE50ly0rfWB0+xaqUtY
X-Received: by 10.236.180.2 with SMTP id i2mr5742548yhm.4.1398976666812;
        Thu, 01 May 2014 13:37:46 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id x22si3537059yhd.5.2014.05.01.13.37.46
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 May 2014 13:37:46 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id A7B0931C1CC;
	Thu,  1 May 2014 13:37:46 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 62DDFE097F; Thu,  1 May 2014 13:37:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.351.g4d2c8e4
In-Reply-To: <1398976662-6962-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247875>

Call ref_transaction_commit with QUIET_ON_ERR and use the strbuf that is
returned to print a log message if/after the transaction fails.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 builtin/update-ref.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index aaa06aa..207e24d 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -342,6 +342,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	const char *refname, *oldval, *msg = NULL;
 	unsigned char sha1[20], oldsha1[20];
 	int delete = 0, no_deref = 0, read_stdin = 0, end_null = 0, flags = 0;
+	struct strbuf err = STRBUF_INIT;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
 		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
@@ -359,17 +360,16 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 		die("Refusing to perform update with empty message.");
 
 	if (read_stdin) {
-		int ret;
 		transaction = ref_transaction_begin();
-
 		if (delete || no_deref || argc > 0)
 			usage_with_options(git_update_ref_usage, options);
 		if (end_null)
 			line_termination = '\0';
 		update_refs_stdin();
-		ret = ref_transaction_commit(transaction, msg, NULL,
-					     UPDATE_REFS_DIE_ON_ERR);
-		return ret;
+		if (ref_transaction_commit(transaction, msg, &err,
+					   UPDATE_REFS_QUIET_ON_ERR))
+			die("%s", err.buf);
+		return 0;
 	}
 
 	if (end_null)
-- 
2.0.0.rc1.351.g4d2c8e4
