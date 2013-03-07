From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: [PATCH] setup.c: Fix prefix_pathspec from looping pass end of string
Date: Thu,  7 Mar 2013 11:36:03 -0500
Message-ID: <1362674163-24682-1-git-send-email-andrew.kw.w@gmail.com>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 07 17:41:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDdsc-00032f-VQ
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 17:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753852Ab3CGQkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 11:40:53 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:46588 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab3CGQkw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 11:40:52 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so582057iak.38
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Ol5IDkQe3B4JJrfWV6RV45OIuBo/yJYpXxuYiJX3HAk=;
        b=tyGHfiCw4IoE8kvDH+wADwjbc8WLg3uxUDeAlkWUCXmQ4/QvuUuzCsCQqRgdtjsfVP
         618eGQr0fEWzBRFORVVRXdf1e5tkSY4IS7M1ue+kMhQY5pifbvlrYa/l/jHWANOsMCEI
         v3TR5DhMkCa5exqMoQSlOU+XYpBlW22PJIlftG7Sl3rUUOjkKSqlz88F0w22kbq6Wxrg
         NCeISeEtrPF03OlwjrL8jivdqCEueRWL69fpHebDs+xNS4uyvQmDcKXpOYUxq8GxSRcw
         zdCxBoxJPbD6C5Jzq+lqVs39T1kvoObdWV1VlwDeNr8g54alCws+e931KfWBW0bjdaKL
         SguA==
X-Received: by 10.50.46.202 with SMTP id x10mr15303010igm.87.1362674451853;
        Thu, 07 Mar 2013 08:40:51 -0800 (PST)
Received: from localhost.localdomain ([69.165.234.69])
        by mx.google.com with ESMTPS id xf4sm27396945igb.8.2013.03.07.08.40.49
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Mar 2013 08:40:50 -0800 (PST)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217600>

The previous code was assuming length ends at either `)` or `,`, and was
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
1.8.2.rc0.22.gb3600c3
