From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH 05/11] fetchpack.c: replace `git_config()` with `git_config_get_*()` family
Date: Mon,  4 Aug 2014 11:33:43 -0700
Message-ID: <1407177229-30081-6-git-send-email-tanayabh@gmail.com>
References: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 20:35:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEN62-0007pS-99
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbaHDSex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:34:53 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:56612 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751709AbaHDSev (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:34:51 -0400
Received: by mail-pd0-f182.google.com with SMTP id fp1so10038179pdb.41
        for <git@vger.kernel.org>; Mon, 04 Aug 2014 11:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0hQKDGWUE6XPbPd93x2ew+qMi8anr6m+abBnip3wG3g=;
        b=AokAJQqkKUqOXGq3uTAWxZUibaGWe9bjRHLqAyruwF+HgLWZTl253GAis3qIcA5n9a
         qpqlznuTeuAyTtFZzT9T47hpFL4IPgDnKF7WPXRCwlMmYHdOgAOhE0Y4FYZcZ0n+z+dn
         jAluESD9OZNysElAUrzXrOhuHk9XE3Pi8zYVn3r+WIqTIpYyWlghJvPmi9akXt2Qqoi8
         gdIZBt7O0YDygcAVraDodglMgxymEwzeJmAmNzeGQ0sFFAYtxgbp/CiXraHDGF2pmXID
         7YbDQlCozpdL9EUE3w34Ds1R/jolw0Vd0Mo0HjPTat3X18mcQSNZsQryL0/EtD0qoKL5
         wzzQ==
X-Received: by 10.70.96.38 with SMTP id dp6mr4102418pdb.136.1407177290728;
        Mon, 04 Aug 2014 11:34:50 -0700 (PDT)
Received: from localhost.localdomain ([223.226.75.102])
        by mx.google.com with ESMTPSA id pm10sm12158905pdb.69.2014.08.04.11.34.47
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 04 Aug 2014 11:34:50 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
In-Reply-To: <1407177229-30081-1-git-send-email-tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254757>

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
