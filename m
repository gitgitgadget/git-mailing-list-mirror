From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 16/16] read-cache: config for waiting for index-helper
Date: Tue, 12 Apr 2016 20:33:09 -0400
Message-ID: <1460507589-25525-17-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kd-0002my-OG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758940AbcDMAdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 20:33:42 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36417 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903AbcDMAdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:39 -0400
Received: by mail-qk0-f181.google.com with SMTP id n130so13663367qke.3
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D5RUAWUH70jUPfHGHuveC+WHQUDJ+hnt1lCa31CChZc=;
        b=G+MKNqosEf4rWdsz8IIIvOyIJrG0Wk9TnbHpQWHRqRN/IJr1piGvmvp1A6olEHwNOm
         gGobBG4+Oa78FBxZzD2SuNx0BGWoUntp+4Qsj+x4fiXf8AzgE4ZBZNLr68zYKFPAMVSq
         o89j9oyPLmi0nBBlGbI0KSJ3aNUYnNa0uvWtP2VI0SG8WFfz5IffrIvKfaLXK8NOchZR
         fGM5j3Iz9/xDuqgsp6DT6FuscLB9Kl44T2gPghql6xdASyGhG2+wvx7c+Od0HGqemy9l
         lyAEnens55NLm8HcYkDvhQeF/MDCaP8jH5sTHAdYbAV3VGouf+iPtwpgBZI5wq3NZp7j
         6pQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D5RUAWUH70jUPfHGHuveC+WHQUDJ+hnt1lCa31CChZc=;
        b=m/3YrfhVcoUQKsEJfDCAcHIa9mLPmWQgS339+xGMnU+k1Ni+mECY4yzxy3I07ARRBp
         vETy+sinMjXiXwVcG+swSBXNalg88f7f2fxfr9bXGZ5WXEh1YKBGdlYZBWO3qhxkwQ/A
         n6iqnXhDkPdtxJH4sPkpLzrlnkfB8UiTZuYnnyg6uxFZkBCTmejDrxhl7+eYzGUsjBlQ
         dInIwuEIUfIzmDDnxRwV6CHAUGqygLtHONp4bXNyXJncbUTUbkJjbA12s36V2nV0vfyv
         ozwsKxhgfK8yHEeLqg4Cl5JwbZyjBTKbIi/20M2jgLsQFe/j8h4FxAkVtwd52R7gXzcO
         UaTQ==
X-Gm-Message-State: AOPr4FXCEXggXxpDjkvRQ+raiXp6ab40UVmYBDfTxs0LFHnC7zqB7k55vD50NLBewtD3tQ==
X-Received: by 10.55.77.12 with SMTP id a12mr7309508qkb.44.1460507618603;
        Tue, 12 Apr 2016 17:33:38 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291346>

When we poke index-helper, and index-helper is using watchman, we want
to wait for a response (showing that the watchman extension shm has
been prepared).  If it's not using watchman, we don't.

So add a new config, core.waitforindexhelper, with sensible defaults, to
configure this behavior.

Signed-off-by: David Turner <dturner@twopensource.com>
---
 Documentation/config.txt | 6 ++++++
 cache.h                  | 1 +
 config.c                 | 5 +++++
 environment.c            | 5 +++++
 read-cache.c             | 5 ++++-
 5 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ec8824..f61e6fe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -670,6 +670,12 @@ Likewise, when the `LV` environment variable is unset, Git sets it
 to `-c`.  You can override this setting by exporting `LV` with
 another value or setting `core.pager` to `lv +c`.
 
+core.waitforindexhelper::
+	If true, git status and other commands which use the index
+	will wait for a response from the index-helper before continuing;
+	this gives time for the index-helper to communicate with watchman
+	and give information about modified files.
+
 core.whitespace::
 	A comma separated list of common whitespace problems to
 	notice.  'git diff' will use `color.diff.whitespace` to
diff --git a/cache.h b/cache.h
index 5713835..db66451 100644
--- a/cache.h
+++ b/cache.h
@@ -691,6 +691,7 @@ extern char *git_replace_ref_base;
 extern int fsync_object_files;
 extern int core_preload_index;
 extern int core_watchman_sync_timeout;
+extern int wait_for_index_helper;
 extern int core_apply_sparse_checkout;
 extern int precomposed_unicode;
 extern int protect_hfs;
diff --git a/config.c b/config.c
index e6dc141..5f1b8bd 100644
--- a/config.c
+++ b/config.c
@@ -887,6 +887,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.waitforindexhelper")) {
+		wait_for_index_helper = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.createobject")) {
 		if (!strcmp(value, "rename"))
 			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
diff --git a/environment.c b/environment.c
index 35e03c7..c7fb0a9 100644
--- a/environment.c
+++ b/environment.c
@@ -95,6 +95,11 @@ int core_preload_index = 1;
 int ignore_untracked_cache_config;
 
 int core_watchman_sync_timeout = 300;
+#ifdef USE_WATCHMAN
+int wait_for_index_helper = 1;
+#else
+int wait_for_index_helper = 0;
+#endif
 
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
diff --git a/read-cache.c b/read-cache.c
index 264a25b..224a019 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1846,7 +1846,10 @@ static int poke_daemon(struct index_state *istate,
 	if (refresh_cache) {
 		ret = write_in_full(fd, "refresh", 8) != 8;
 	} else {
-		ret = poke_and_wait_for_reply(fd);
+		if (wait_for_index_helper)
+			ret = poke_and_wait_for_reply(fd);
+		else
+			ret = write_in_full(fd, "poke", 5) != 5;
 	}
 
 	close(fd);
-- 
2.4.2.767.g62658d5-twtrsrc
