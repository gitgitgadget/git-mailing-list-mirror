From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v4 5/5] alias.c: replace `git_config()` with `git_config_get_string()`
Date: Wed, 30 Jul 2014 06:39:09 -0700
Message-ID: <1406727549-22334-6-git-send-email-tanayabh@gmail.com>
References: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 15:40:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCU7V-0000xR-D3
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jul 2014 15:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752891AbaG3Nkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2014 09:40:32 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:53269 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbaG3Nka (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2014 09:40:30 -0400
Received: by mail-pa0-f53.google.com with SMTP id rd3so1520496pab.26
        for <git@vger.kernel.org>; Wed, 30 Jul 2014 06:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eLnr6j9uGv/2u0rpJ149Ek53dA4XvpZP33nIXVWBtwo=;
        b=wjofmr5GTilYShDLVmkdsoGqjkEHyP/USWkVvWl2JCptdSeEDgOfy1+ikqHzKKuZHM
         HO+5PufOBR4fA2Gqfp0w5mavmW7LB4GW5UQLfGbFUdGYAiWnumRj8j2Isd2/ruHZ5T2z
         HrkqWvA49SireMQtgaefaIrartGBGTRAE5MBkrCQCIjwpHgKM2qncz2IQed5z7pbMwl8
         e08M+Rz9Ao1tp0YONuvDaaYZpdWVzLykLy+YKam4a6uCWEkbYinb5GDFyvYiDvYaN+pH
         zoHfPRXLskidy9j6VrgWc28SekIwdDkyIfzPdc7VNGStONNnbxg0KesmIzEUnuKPLYFn
         6vxw==
X-Received: by 10.70.38.72 with SMTP id e8mr4769274pdk.33.1406727630359;
        Wed, 30 Jul 2014 06:40:30 -0700 (PDT)
Received: from localhost.localdomain ([223.184.63.185])
        by mx.google.com with ESMTPSA id y4sm2397686pbt.60.2014.07.30.06.40.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jul 2014 06:40:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1406727549-22334-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254493>

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
