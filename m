From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 8/8] update-index: make core.untrackedCache a bool
Date: Tue,  1 Dec 2015 21:31:39 +0100
Message-ID: <1449001899-18956-9-git-send-email-chriscool@tuxfamily.org>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 21:33:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3rbg-00008l-4c
	for gcvg-git-2@plane.gmane.org; Tue, 01 Dec 2015 21:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756736AbbLAUcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 15:32:50 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36256 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756386AbbLAUcs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 15:32:48 -0500
Received: by wmec201 with SMTP id c201so5029242wme.3
        for <git@vger.kernel.org>; Tue, 01 Dec 2015 12:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pmGOVdLP2pGCYZl0mtkpr3w0xNBD1cWs2Oba5Mc0Yxk=;
        b=JCyfejkQGRbhoJcLcgPNd0AVn9Y1ISJRozTVWeTfMiGHnm2yiyV9QghEZOyJc3TS5O
         kdRGKdslwdcTKFwR8Q44aQNZOgyzmXKh6qe6lhUCR8wQljNGuqKZl1SIenPvOG2zV0OD
         1b7zZWrEG6zkRR5ovi57zxQ+C7ShPZVJTHbVz6GviXUX2g2meASWfB8IYEP8c+R0QYWQ
         AOTv+/0VAoaOkr7wz0lbqRB1ndpzlRO8QuCn8YJxKPMTtcPGZeIgo5WOjDCiHF6TsEZb
         uHvmG13HyakMgEvxkyoOPTcvog1Ho16MRvrheftia+wtMIHKOaKIHV6zffdCT6Fr3qlB
         KcdA==
X-Received: by 10.28.177.11 with SMTP id a11mr102998wmf.92.1449001966803;
        Tue, 01 Dec 2015 12:32:46 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id uw6sm1978310wjc.42.2015.12.01.12.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 01 Dec 2015 12:32:46 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.6.3.391.g95a3a5c
In-Reply-To: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281850>

Most features in Git can be enabled or disabled using a simple
bool config variable and it would be nice if untracked cache
behaved the same way.

This makes --[no-|force-]untracked-cache change the value of
core.untrackedCache in the repo config file, to avoid making
those options useless and because this avoids the untracked
cache being disabled by a kernel change or a directory
change. Of course this breaks some backward compatibility,
but the simplification and increased useability is worth it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-update-index.txt | 13 ++++++-------
 builtin/update-index.c             | 10 ++++------
 config.c                           |  8 +-------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 5f74cc7..256b9c5 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -181,10 +181,11 @@ The underlying operating system and file system must change `st_mtime`
 field of a directory if files are added or deleted in that
 directory. You can test that using
 `--test-untracked-cache`. `--untracked-cache` used to test that too
-but it doesn't anymore. If you want to always enable, or always
-disable, untracked cache, you can set the `core.untrackedCache`
-configuration variable to 'true' or 'false' respectively, (see
-linkgit:git-config[1]).
+but it doesn't anymore.
++
+This sets the `core.untrackedCache` configuration variable to 'true'
+or 'false' in the repo config file, (see linkgit:git-config[1]), so
+that the untracked cache stays enabled or disabled.
 
 --test-untracked-cache::
 	Only perform tests on the working directory to make sure
@@ -194,9 +195,7 @@ linkgit:git-config[1]).
 	it.
 
 --force-untracked-cache::
-	Same as `--untracked-cache`. Note that this option cannot
-	enable untracked cache if `core.untrackedCache` configuration
-	variable is set to false (see linkgit:git-config[1]).
+	Same as `--untracked-cache`.
 
 \--::
 	Do not interpret any more arguments as options.
diff --git a/builtin/update-index.c b/builtin/update-index.c
index fb0ea3d..048c293 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1111,15 +1111,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		return !test_if_untracked_cache_is_supported();
 	}
 	if (untracked_cache > 0) {
-		if (!use_untracked_cache)
-			die("core.untrackedCache is set to false; "
-			    "the untracked cache will not be enabled");
+		if (!use_untracked_cache && git_config_set("core.untrackedCache", "true"))
+			die("could not set core.untrackedCache to true");
 		add_untracked_cache();
 		fprintf(stderr, _("Untracked cache enabled for '%s'\n"), get_git_work_tree());
 	} else if (!untracked_cache) {
-		if (use_untracked_cache > 0)
-			die("core.untrackedCache is set to true; "
-			    "the untracked cache will not be disabled");
+		if (use_untracked_cache > 0 && git_config_set("core.untrackedCache", "false"))
+			die("could not set core.untrackedCache to false");
 		if (the_index.untracked) {
 			remove_untracked_cache();
 			fprintf(stderr, _("Untracked disabled\n"));
diff --git a/config.c b/config.c
index 7d50f43..f023ee7 100644
--- a/config.c
+++ b/config.c
@@ -692,13 +692,7 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 	if (!strcmp(var, "core.untrackedcache")) {
-		if (!strcasecmp(value, "default") || !strcasecmp(value, "check"))
-			use_untracked_cache = -1;
-		else {
-			use_untracked_cache = git_config_maybe_bool(var, value);
-			if (use_untracked_cache == -1)
-				error("unknown core.untrackedCache value '%s'; using default", value);
-		}
+		use_untracked_cache = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "core.checkstat")) {
-- 
2.6.3.391.g95a3a5c
