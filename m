From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] Add core.mode configuration
Date: Tue, 17 Sep 2013 09:07:51 -0500
Message-ID: <1379426871-6823-1-git-send-email-felipe.contreras@gmail.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 17 16:13:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLw1i-00055u-Sl
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 16:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840Ab3IQONK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 10:13:10 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:53959 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748Ab3IQONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 10:13:09 -0400
Received: by mail-qe0-f50.google.com with SMTP id a11so3750101qen.9
        for <git@vger.kernel.org>; Tue, 17 Sep 2013 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iHpeCYFYChovQibXbDj3V35WXlW5F5FSmNcq67ikWPg=;
        b=bM/5xyv41iaA22F/Y1GRQECDkS4eyrojLbVRwajFjOrx1ppXlayoco/ce3yo5fWMol
         J4fY8x4U69G0B+47pw8g+UzFNkFPM9aebQV9FmnnCU4VYzGG9iqWx0MYY8xrvsBi7kyE
         +QM+IhgmPo+kWBaSjJQZzMEVNJ9X6BmXPTMVJAWCZbc0fwasJPPdb6GgVnp6DlLHjoBw
         gdYPPyXPu/J3UQjsXNV0P/BlhDmo8UG7VbTyFePBhsBGgvYaw22Obi7p2wjfUFqv2bge
         LOv5emTtuBV8RFh8F4Q6cXGXBbLOAqmg1864YTGW0fYw74t1lidoK6KV4SecrT+BuMMQ
         cknA==
X-Received: by 10.224.76.10 with SMTP id a10mr6913167qak.9.1379427187628;
        Tue, 17 Sep 2013 07:13:07 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id n9sm31553378qag.8.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Sep 2013 07:13:06 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234879>

So that we can specify general modes of operation, specifically, add the
'next' mode, which makes Git pre v2.0 behave as Git v2.0.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/add.c |  3 +++
 cache.h       |  6 ++++++
 config.c      | 13 +++++++++++++
 environment.c |  1 +
 4 files changed, 23 insertions(+)

diff --git a/builtin/add.c b/builtin/add.c
index 8266a9c..85b4c54 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -41,6 +41,9 @@ static void warn_pathless_add(void)
 	static int shown;
 	assert(option_with_implicit_dot && short_option_with_implicit_dot);
 
+	if (git_mode == MODE_NEXT)
+		return;
+
 	if (shown)
 		return;
 	shown = 1;
diff --git a/cache.h b/cache.h
index 85b544f..f28240f 100644
--- a/cache.h
+++ b/cache.h
@@ -627,9 +627,15 @@ enum push_default_type {
 	PUSH_DEFAULT_UNSPECIFIED
 };
 
+enum git_mode {
+	MODE_CURRENT = 0,
+	MODE_NEXT
+};
+
 extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
+extern enum git_mode git_mode;
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
diff --git a/config.c b/config.c
index e13a7b6..f0e0370 100644
--- a/config.c
+++ b/config.c
@@ -831,6 +831,19 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.mode")) {
+		if (!value)
+			return config_error_nonbool(var);
+		else if (!strcmp(value, "current"))
+			git_mode = MODE_CURRENT;
+		else if (!strcmp(value, "next")) {
+			git_mode = MODE_NEXT;
+			push_default = PUSH_DEFAULT_SIMPLE;
+		} else
+			die("wrong mode '%s'", value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 5398c36..751e14d 100644
--- a/environment.c
+++ b/environment.c
@@ -62,6 +62,7 @@ int merge_log_config = -1;
 int precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
 struct startup_info *startup_info;
 unsigned long pack_size_limit_cfg;
+enum git_mode git_mode = MODE_CURRENT;
 
 /*
  * The character that begins a commented line in user-editable file
-- 
1.8.4-fc
