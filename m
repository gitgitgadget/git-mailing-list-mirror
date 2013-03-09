From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH 1/2] setup.c: Fix prefix_pathspec from looping pass end of string
Date: Sat,  9 Mar 2013 18:45:59 -0500
Message-ID: <1362872760-25803-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 10 00:46:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UETTW-0005aZ-Dw
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 00:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194Ab3CIXqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 18:46:23 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:41140 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab3CIXqX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 18:46:23 -0500
Received: by mail-ie0-f169.google.com with SMTP id 13so3513224iea.0
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=lkUqCJUGdO4aSP6dQC9c/fiKFxEa4c71Rw5uwZNybPQ=;
        b=TLUkgUFOjYNUDuqKempCUj5a5ypb9bFqX6sqjr3z5Zoc6xM5sssHc2lnOmC4nZ86J8
         +t6nKROFsUiybvI5XU5mkYh72A7sMVxjuGDoiYkwn++9UImYxanJbvgv5/ENj+3MjUlo
         rr5UAR2o1SrC1ULwG6vJmoI/bc+ABs62MsvtqxRKH9C0WvWAsG6Bnb5uMN2yxAJs9xy6
         +QEYKvZ8Fa6DDDnbeLLSxlvZ621JGCiADOHW9vjhQFNP1A+O6XNZ5keEqmYG6UCgmIGy
         yswJjvzksPZL8AOuvy//A//rbPfbvQmY3oMIfzYbT6Wc8c3b/VsfKYvJvTPVTLhonXE3
         lglg==
X-Received: by 10.50.150.167 with SMTP id uj7mr3764883igb.1.1362872782539;
        Sat, 09 Mar 2013 15:46:22 -0800 (PST)
Received: from localhost.localdomain ([69.165.234.69])
        by mx.google.com with ESMTPS id l2sm5747376igb.1.2013.03.09.15.46.20
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 15:46:21 -0800 (PST)
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <7vk3pik6aq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217772>

The previous code was assuming length ends at either ")" or ",", and was
not handling the case where strcspn returns length due to end of string.
So specifying ":(top" as pathspec will cause the loop to go pass the end
of string.

Signed-off-by: Andrew Wong <andrew.kw.w@gmail.com>
---
 setup.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index 1dee47e..f4c4e73 100644
--- a/setup.c
+++ b/setup.c
@@ -207,9 +207,11 @@ static const char *prefix_pathspec(const char *prefix, int prefixlen, const char
 		     *copyfrom && *copyfrom != ')';
 		     copyfrom = nextat) {
 			size_t len = strcspn(copyfrom, ",)");
-			if (copyfrom[len] == ')')
+			if (copyfrom[len] == '\0')
 				nextat = copyfrom + len;
-			else
+			else if (copyfrom[len] == ')')
+				nextat = copyfrom + len;
+			else if (copyfrom[len] == ',')
 				nextat = copyfrom + len + 1;
 			if (!len)
 				continue;
-- 
1.7.12.4
