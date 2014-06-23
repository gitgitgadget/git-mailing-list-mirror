From: Tanay Abhra <tanayabh@gmail.com>
Subject: [RFC/PATCH V2] alias.c: replace git_config with git_config_get_string
Date: Mon, 23 Jun 2014 03:41:40 -0700
Message-ID: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 12:42:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz1hm-0001tI-P2
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 12:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbaFWKm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 06:42:27 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:39853 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbaFWKm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 06:42:26 -0400
Received: by mail-pd0-f172.google.com with SMTP id w10so5550468pde.31
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=vbR+BVrl9JqWgIj/JcDGgZcmM9Q+LvQL1WTkSRYQ/Ac=;
        b=uSItjspA0aROZRIokeajF0lBjBWeMS0wYUAH2W8J7BWL2M4ioQv5wk/i3PId4H1Uww
         sNoks8Bp5M5iD3iZdw8DcxWkF7JATEi1bvqjYA9JRRILy3YU81jCS+nfM2baU17H0RYC
         EWBnFL4pr+DnLRQwMRSvWdkcLRyQ1x6AXn2kg3HoPxf5Z3SaYU2zXVtgG9UAp8bNoq4B
         IbD4+t5+r6KHpfPb0IcSlrqRdtg8GOAWOVHCHJEmyV9mM49/36V2MreocJlJb1PUaCq+
         dCxTHs6URiBmA/LmzX6JntrIasD2eblwT9PaFDLscBA+P1wnv6XMFTT3sScZjNSjqJla
         HXNw==
X-Received: by 10.68.103.98 with SMTP id fv2mr27365134pbb.18.1403520146035;
        Mon, 23 Jun 2014 03:42:26 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.81])
        by mx.google.com with ESMTPSA id zc10sm91487896pac.46.2014.06.23.03.42.22
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Jun 2014 03:42:25 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252334>

Use git_config_get_string instead of git_config to take advantage of
the config hash-table api which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 alias.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/alias.c b/alias.c
index 5efc3d6..0fe32bc 100644
--- a/alias.c
+++ b/alias.c
@@ -1,25 +1,17 @@
 #include "cache.h"
 
-static const char *alias_key;
-static char *alias_val;
-
-static int alias_lookup_cb(const char *k, const char *v, void *cb)
-{
-	if (starts_with(k, "alias.") && !strcmp(k + 6, alias_key)) {
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
+	const char *v;
+	char *value;
+	struct strbuf key = STRBUF_INIT;
+	strbuf_addf(&key, "alias.%s", alias);
+	git_config_get_string(key.buf, &v);
+	if (!v)
+		config_error_nonbool(key.buf);
+	value = xstrdup(v);
+	strbuf_release(&key);
+	return value;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
-- 
1.9.0.GIT
