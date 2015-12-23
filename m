From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 02/11] update-index: use enum for untracked cache options
Date: Wed, 23 Dec 2015 22:03:50 +0100
Message-ID: <1450904639-25592-3-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaJ-0008Ca-4w
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965353AbbLWVEa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:30 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35970 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965276AbbLWVE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:26 -0500
Received: by mail-wm0-f49.google.com with SMTP id p187so160259316wmp.1
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qL1ya09NWG4BBBKFqy7T7ybo4FI7cZo+LpPM51Z5c7A=;
        b=mxHUKShi08gQ18l4OtGeXH87DtJSBuz5Se7AMGKb1a1yM3sVd7lzPiS/042utiHePI
         EFgPA9iXsifE5t/5ZogVXRy4J5iE8wjq4eBXEdcR8XUkTMGn3QCot9KulnSHPuXwlzh7
         sFVNyknDVm/MmIrzLBfQgBG7AB1fp8yUvNFupTgEl4WBImE4EZ0AwEma9PE3gSi/Hxkc
         NfAnKkPIMOQN1JmuvC1uVm4gPxNl2uPQQgY8DBcYr/Qkisf6VijnogBCttSzw789zfVm
         psmwBxjavFEGvUgu95GhGNn+f147ehMXEY7fUHIa956LxjyoRaWcG9jWWDJe0RW8Hc5f
         3MqQ==
X-Received: by 10.194.158.73 with SMTP id ws9mr40198089wjb.40.1450904665255;
        Wed, 23 Dec 2015 13:04:25 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:23 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282957>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6fff87..1e546a3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UC_UNSPECIFIED = -1,
+	UC_DISABLE = 0,
+	UC_ENABLE,
+	UC_FORCE
+};
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
-	int untracked_cache = -1;
+	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > UC_DISABLE) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1122,7 +1130,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-- 
2.7.0.rc2.11.g68ccdd4
