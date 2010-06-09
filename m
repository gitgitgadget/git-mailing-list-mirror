From: Steven Michalske <smichalske@gmail.com>
Subject: [PATCH] Use strncpy to protect from buffer overruns.
Date: Wed,  9 Jun 2010 03:22:01 -0700
Message-ID: <1276078921-25429-1-git-send-email-smichalske@gmail.com>
Cc: Steven Michalske <smichalske@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 12:22:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMIQS-0001gg-Eg
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 12:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab0FIKWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 06:22:12 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:46545 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757005Ab0FIKWL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 06:22:11 -0400
Received: by pxi8 with SMTP id 8so2108358pxi.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=LLv3235ZE9/AyvZy4GqE+kaZVm+VjgAf5LDIf4Sg+o8=;
        b=vUr/fTgWXYXk9Q8XwWJbtH/Xz7En1Y3aS8zHPhVSfCJHr3LDsFoiCQIvwL766GTiGh
         UV1XYZFN1UCjRaceZgfJ8E+Rk3vmw9/YLju/PxH46/YDeIGfwpwVlYew5yJJLXXc26mT
         bqoXkII7yJas27MPLbFS+tx3fCfBI+/wrMPZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZtyG8QslCaKL9K4jDrQ6UKX40MBfIAhhkNa2b2gjRHXl2rBI4zFXgjHXCjDMyhGDhw
         SZu4/TotX5S1OR1oaoxBif+5xttm4XFhLLHFblBSQwEzh1S4qJLKtS1oMc/UqqB1oVfF
         5Va+uafVkdKjuSAQ4hxkSLTwPdkoFZTpS4RPc=
Received: by 10.114.186.36 with SMTP id j36mr656812waf.193.1276078930360;
        Wed, 09 Jun 2010 03:22:10 -0700 (PDT)
Received: from localhost.localdomain (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id a23sm62516651wam.14.2010.06.09.03.22.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Jun 2010 03:22:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148759>

is_git_directory() uses strcpy with pointer arithmitic, protect it from
overflowing.  Even though we currently protect higher up when we have the
environment variable path passed in, we should protect the calls here.

Signed-off-by: Steven Michalske <smichalske@gmail.com>
---
 setup.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/setup.c b/setup.c
index 7e04602..0080299 100644
--- a/setup.c
+++ b/setup.c
@@ -170,22 +170,24 @@ static int is_git_directory(const char *suspect)
 	char path[PATH_MAX];
 	size_t len = strlen(suspect);
 
-	strcpy(path, suspect);
+	path[sizeof(path) - 1] = '\0';
+
+	strncpy(path, suspect, sizeof(path) - 1);
 	if (getenv(DB_ENVIRONMENT)) {
 		if (access(getenv(DB_ENVIRONMENT), X_OK))
 			return 0;
 	}
 	else {
-		strcpy(path + len, "/objects");
+		strncpy(path + len, "/objects", sizeof(path) - len - 1);
 		if (access(path, X_OK))
 			return 0;
 	}
 
-	strcpy(path + len, "/refs");
+	strncpy(path + len, "/refs", sizeof(path) - len - 1);
 	if (access(path, X_OK))
 		return 0;
 
-	strcpy(path + len, "/HEAD");
+	strncpy(path + len, "/HEAD", sizeof(path) - len - 1);
 	if (validate_headref(path))
 		return 0;
 
-- 
1.7.0.3
