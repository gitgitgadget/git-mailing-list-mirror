From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v2 05/11] fetchpack.c: replace `git_config()` with `git_config_get_*()` family
Date: Thu,  7 Aug 2014 09:21:20 -0700
Message-ID: <1407428486-19049-6-git-send-email-tanayabh@gmail.com>
References: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 18:23:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFQTH-00066F-IV
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 18:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbaHGQXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2014 12:23:13 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:51124 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932312AbaHGQXL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2014 12:23:11 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so5707303pab.1
        for <git@vger.kernel.org>; Thu, 07 Aug 2014 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hQKDGWUE6XPbPd93x2ew+qMi8anr6m+abBnip3wG3g=;
        b=onkLmdQAQlvKRNL2m1eR+AYAbanLXGCLw8CDScBzZtYCy3GHUmw0FHdVbMZqExXvQs
         yp8soDLtqav/ngZ90sR+xZQXyarDEGTHB8PM5MAj9EDYH8ZCWd1U2/Da49D3/pdLgQkv
         Ln3QEee1ObDC0DwLu4HDqilLTgjCa2hXuJX/ZiaQHsVj6laHBGNIwhz0iyjCHkleiyv+
         LSZUUip1+YUOTPWqNF6WaaD7vBE+3IiM1CHOkDAo+fIcpcT+sZ4q3Xx01+451DqaiXvc
         mZquHPvJeUZ3Occ0ZW9R3oVefA2PleOy1xmSV2xvkq0Chu5eQVGeu8Rhe2JqA3vlc5ae
         7GFA==
X-Received: by 10.70.88.205 with SMTP id bi13mr18773089pdb.43.1407428590410;
        Thu, 07 Aug 2014 09:23:10 -0700 (PDT)
Received: from localhost.localdomain ([223.176.226.83])
        by mx.google.com with ESMTPSA id zt5sm16022338pac.31.2014.08.07.09.23.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 07 Aug 2014 09:23:09 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407428486-19049-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254969>

Use `git_config_get_*()` family instead of `git_config()` to take advantage of
the config-set API which provides a cleaner control flow.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 fetch-pack.c | 35 ++++++++---------------------------
 1 file changed, 8 insertions(+), 27 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index b8a58fa..a13e9db 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -869,34 +869,15 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
-static int fetch_pack_config(const char *var, const char *value, void *cb)
+static void fetch_pack_config(void)
 {
-	if (strcmp(var, "fetch.unpacklimit") == 0) {
-		fetch_unpack_limit = git_config_int(var, value);
-		return 0;
-	}
-
-	if (strcmp(var, "transfer.unpacklimit") == 0) {
-		transfer_unpack_limit = git_config_int(var, value);
-		return 0;
-	}
-
-	if (strcmp(var, "repack.usedeltabaseoffset") == 0) {
-		prefer_ofs_delta = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "fetch.fsckobjects")) {
-		fetch_fsck_objects = git_config_bool(var, value);
-		return 0;
-	}
-
-	if (!strcmp(var, "transfer.fsckobjects")) {
-		transfer_fsck_objects = git_config_bool(var, value);
-		return 0;
-	}
+	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
+	git_config_get_int("transfer.unpacklimit", &transfer_unpack_limit);
+	git_config_get_bool("repack.usedeltabaseoffset", &prefer_ofs_delta);
+	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
+	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 
-	return git_default_config(var, value, cb);
+	git_config(git_default_config, NULL);
 }
 
 static void fetch_pack_setup(void)
@@ -904,7 +885,7 @@ static void fetch_pack_setup(void)
 	static int did_setup;
 	if (did_setup)
 		return;
-	git_config(fetch_pack_config, NULL);
+	fetch_pack_config();
 	if (0 <= transfer_unpack_limit)
 		unpack_limit = transfer_unpack_limit;
 	else if (0 <= fetch_unpack_limit)
-- 
1.9.0.GIT
