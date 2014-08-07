From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 10/11] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Thu,  7 Aug 2014 09:21:25 -0700
Message-ID: <1407428486-19049-11-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTX-0006Ut-Ox
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932468AbaHGQXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:30 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:41831 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932407AbaHGQX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:27 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so5580831pab.6
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLnr6j9uGv/2u0rpJ149Ek53dA4XvpZP33nIXVWBtwo=;
        b=o8Fe/0KdbpWPkG++BHsxTTwVCgcaxCXm9Ttztetrxmrg6xpdVEktSNAo4V6avgPYWK
         Uh2bH5wWcZbuLc74BKM2sjDrXAc7Ed5A9AwZ89MmLcwMJUGTkYDf5aJz766z5Ip9MXou
         P+2gjkvMUJ4rN0YlZVooNvx2Og2VV5RtzZfbXq0P7ERiGuDvkk1utwXkUAzTgfO1gzLA
         e2JhqfQBcEPuSG7YOHjfhY7zqeu/rBMccVMvtGFkZMEaQeuj18H8ZUdW/pKUII9fV60F
         dMqJ1O0Z7Jv9v5MhdURhEU59XOOFnxx9psZzqJAVd94Z49uZF8zA2v4HnFxhuaZudlKC
         hwyQ==
X-Received: by 10.66.227.225 with SMTP id sd1mr18870784pac.106.1407428606861;
        Thu, 07 Aug 2014 09:23:26 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:26 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254972>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 alias.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/alias.c b/alias.c
index 758c867..6aa164a 100644
--- a/alias.c
+++ b/alias.c
@@ -1,26 +1,13 @@
 #include "cache.h"
 
-static const char *alias_key;
-static char *alias_val;
-
-static int alias_lookup_cb(const char *k, const char *v, void *cb)
-{
-	const char *name;
-	if (skip_prefix(k, "alias.", &name) && !strcmp(name, alias_key)) {
-		if (!v)
-			return config_error_nonbool(k);
-		alias_val = xstrdup(v);
-		return 0;
-	}
-	return 0;
-}
-
 char *alias_lookup(const char *alias)
 {
-	alias_key = alias;
-	alias_val = NULL;
-	git_config(alias_lookup_cb, NULL);
-	return alias_val;
+	char *v = NULL;
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "alias.%s", alias);
+	git_config_get_string(key.buf, &v);
+	strbuf_release(&key);
+	return v;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
-- 
1.9.0.GIT
