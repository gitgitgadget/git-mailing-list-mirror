From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v3 1/6] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Mon, 21 Jul 2014 04:12:20 -0700
Message-ID: <1405941145-12120-2-git-send-email-tanayabh@gmail.com>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 13:13:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9BXO-0008Lh-Gw
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 13:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754765AbaGULNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 07:13:33 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:46997 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754670AbaGULNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 07:13:31 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so9685807pad.10
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 04:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tZokBPeaaBbkdwTarYoLIkP34cN0JTog9ChstxsYR+Q=;
        b=qWwBWHRLuC1ABgZNxtmidV3YH9emwhrf6pRU+ARtoDEHIAWmCjLXYvh4VXzHFbYpmr
         277xXrPM6ymKzTiFXJx8z7LWr2m83hStTvwyHxS38TA1sX0kxxCofWDMvO5FUTa5NkSO
         euRqODpMi+gmaI+uFhSfkVRCIOpLPzSENVCsBheGC4tKZBM/YbYKO4j6fuuu1R1uI6NU
         UaZCrKqhNJXsFq9fIOR6+yKWvisjFsr8vSTnyXbFBCejRWALlH0UxbQUk3RgRrV9JggC
         53zs8kZsqAuQk5mlIpNN0ZzJqYOP9KwrXiYo9zjmHkRnHcj4ZwtdpNOO86a38jmfkOYI
         u6pQ==
X-Received: by 10.68.92.195 with SMTP id co3mr13358782pbb.36.1405941209537;
        Mon, 21 Jul 2014 04:13:29 -0700 (PDT)
Received: from localhost.localdomain ([223.176.246.202])
        by mx.google.com with ESMTPSA id bl12sm2603688pac.44.2014.07.21.04.13.26
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Jul 2014 04:13:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253949>

Use `git_config_get_string()` instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.
The function now raises an error instead of dying when a NULL value is found.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 alias.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/alias.c b/alias.c
index 758c867..a453bd8 100644
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
-char *alias_lookup(const char *alias)
+char *alias_lookup(const char* alias)
 {
-	alias_key = alias;
-	alias_val = NULL;
-	git_config(alias_lookup_cb, NULL);
-	return alias_val;
+	const char *v = NULL;
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "alias.%s", alias);
+	git_config_get_string(key.buf, &v);
+	strbuf_release(&key);
+	return (char*)v;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
-- 
1.9.0.GIT
