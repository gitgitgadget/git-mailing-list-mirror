From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 28/32] config: read ref storage config on startup
Date: Wed, 24 Feb 2016 17:59:00 -0500
Message-ID: <1456354744-8022-29-git-send-email-dturner@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 25 00:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYiQ7-0004K3-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 00:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759239AbcBXW7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 17:59:53 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35658 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759201AbcBXW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 17:59:46 -0500
Received: by mail-qk0-f180.google.com with SMTP id o6so13259950qkc.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/e1pw/8+iJ5IgaSMb7/nQUgwz0KEVnC0eG5oNm4xZYQ=;
        b=u8gyJQNmQl8NwuS0XQWb2cBpgSuVFXEr/Wj7iyVjg1lKObZaWmDKk0JcTi21zXrqUZ
         yPKRfT3mA80rmplxNOu/VT/N2f0kBiVo1fMN8vUV/AzbMr0J7pXuL4blByKXyNLfGrj+
         abcmcVtJSLLbZlCGcxRBIFopUGVmv5FgRvtX1H+Ca4dL+lcPfot+z4G1yjyXXnTKpBE/
         kLVwMSjIYeZKgQ38Zp1t1UJUJUy4V12NsW6Kd+KOGuHiz13NskcUisvpd94r2ZfuTIJK
         jjOqZQi+E2j5tt4upa48VIwb6iHPiNe56QB9mMJV8vOxNJrKEmRf04t1oh7SNF3eWotV
         S9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/e1pw/8+iJ5IgaSMb7/nQUgwz0KEVnC0eG5oNm4xZYQ=;
        b=ehTOgSNnK9WanocM/UHqkT5l7PNtHzA1M554d62OyUVgxOEcBz8kPdd3tJRZ+t+1R8
         hgeu2MKVURV15YmpncaHmoYQjTEa6XYyL3bHVPjLueIs5x2zuLSIcjZcbcugzPODMXAJ
         q3uassP54PvGDf1BWGw5M97+CnbVq20SocI0DhDu6K23RY8zM1fdkQ7p15qPnu8U3aUV
         9Zd0XUwZZv4jsLstYwzPoPVipsWT7EKytk/SvOfajCqLIYNUcXKhH2buWk+Jtg00/SXK
         SA08G26R1Ax/DIxPZiNHiLZaz9xYrJNEHKKLpyLG1vzFrU4SbnKq8vDaz+BgqOfyzoEL
         Ryag==
X-Gm-Message-State: AG10YOTamEljeNhTLRkLmmM9n4K+COd/1a9UsLoHabwU+vAWRVv6VR5+hgvhEcj5Uy1uEA==
X-Received: by 10.55.82.137 with SMTP id g131mr51531568qkb.66.1456354785418;
        Wed, 24 Feb 2016 14:59:45 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 66sm2154254qhp.4.2016.02.24.14.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 14:59:44 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287260>

This sets up the existing backend early, so that other code which
reads refs is reading from the right place.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 config.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/config.c b/config.c
index b95ac3a..6cea884 100644
--- a/config.c
+++ b/config.c
@@ -11,6 +11,7 @@
 #include "strbuf.h"
 #include "quote.h"
 #include "hashmap.h"
+#include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
 
@@ -1207,6 +1208,29 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 	}
 
 	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
+		char *storage = NULL;
+
+		/*
+		 * make sure we always read the ref storage config
+		 * from the extensions section on startup
+		 */
+		ret += git_config_from_file(ref_storage_backend_config,
+					    repo_config, &storage);
+
+		register_ref_storage_backends();
+		if (!storage)
+			storage = xstrdup("");
+
+		if (!*storage ||
+		    !strcmp(storage, "files")) {
+			/* default backend, nothing to do */
+			free(storage);
+		} else {
+			if (set_ref_storage_backend(ref_storage_backend))
+				die(_("Unknown ref storage backend %s"),
+				    ref_storage_backend);
+		}
+
 		ret += git_config_from_file(fn, repo_config, data);
 		found += 1;
 	}
-- 
2.4.2.767.g62658d5-twtrsrc
