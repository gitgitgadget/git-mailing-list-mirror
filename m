From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH v2 1/2] attr: read core.attributesfile from git_default_core_config
Date: Wed,  5 Oct 2011 23:00:13 -0500
Message-ID: <1317873614-3057-2-git-send-email-drafnel@gmail.com>
References: <1317873614-3057-1-git-send-email-drafnel@gmail.com>
Cc: git@vger.kernel.org, peff@peff.net,
	Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Oct 06 06:00:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBf8g-0006Zo-Qp
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 06:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab1JFEAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 00:00:50 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:40691 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1JFEAt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 00:00:49 -0400
Received: by mail-yx0-f174.google.com with SMTP id 31so2240401yxl.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 21:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=QdGukbfPI9obnocYZA8W4T/PT+OOvzRFO+k4Ix7w/hI=;
        b=UQTmvJYBlyXUHeo+9hzi1Td7ZOzLngFMp0nifa+gxmVnHt+E+Qd0fwrBTGveucz4VR
         sZmwAvkci/EgKjByX1ImEOxDsT6cRWm/2zVc7AKeB7xNGvTB13p2jD0540VWTN3mvhQ/
         yPxLldWXZk0d5d/eiVZ3TZtqwDZw6Y/N92llY=
Received: by 10.100.83.8 with SMTP id g8mr145646anb.92.1317873649333;
        Wed, 05 Oct 2011 21:00:49 -0700 (PDT)
Received: from localhost.localdomain ([96.19.140.155])
        by mx.google.com with ESMTPS id h20sm11169124ani.16.2011.10.05.21.00.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 05 Oct 2011 21:00:48 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.1.ge3b6f
In-Reply-To: <1317873614-3057-1-git-send-email-drafnel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182924>

From: Junio C Hamano <gitster@pobox.com>

This code calls git_config from a helper function to parse the config entry
it is interested in.  Calling git_config in this way may cause a problem if
the helper function can be called after a previous call to git_config by
another function since the second call to git_config may reset some
variable to the value in the config file which was previously overridden.

The above is not a problem in this case since the function passed to
git_config only parses one config entry and the variable it sets is not
assigned outside of the parsing function.  But a programmer who desires
all of the standard config options to be parsed may be tempted to modify
git_attr_config() so that it falls back to git_default_config() and then it
_would_ be vulnerable to the above described behavior.

So, move the call to git_config up into the top-level cmd_* function and
move the responsibility for parsing core.attributesfile into the main
config file parser.

Which is only the logical thing to do ;-)

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 attr.c               |   15 ++-------------
 builtin/check-attr.c |    2 ++
 cache.h              |    1 +
 config.c             |    3 +++
 environment.c        |    1 +
 5 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/attr.c b/attr.c
index 0793859..124337d 100644
--- a/attr.c
+++ b/attr.c
@@ -20,8 +20,6 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define ATTR__UNSET NULL
 #define ATTR__UNKNOWN git_attr__unknown
 
-static const char *attributes_file;
-
 /* This is a randomly chosen prime. */
 #define HASHSIZE 257
 
@@ -494,14 +492,6 @@ static int git_attr_system(void)
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
 
-static int git_attr_config(const char *var, const char *value, void *dummy)
-{
-	if (!strcmp(var, "core.attributesfile"))
-		return git_config_pathname(&attributes_file, var, value);
-
-	return 0;
-}
-
 static void bootstrap_attr_stack(void)
 {
 	if (!attr_stack) {
@@ -521,9 +511,8 @@ static void bootstrap_attr_stack(void)
 			}
 		}
 
-		git_config(git_attr_config, NULL);
-		if (attributes_file) {
-			elem = read_attr_from_file(attributes_file, 1);
+		if (git_attributes_file) {
+			elem = read_attr_from_file(git_attributes_file, 1);
 			if (elem) {
 				elem->origin = NULL;
 				elem->prev = attr_stack;
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 708988a..abb1165 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -92,6 +92,8 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 	struct git_attr_check *check;
 	int cnt, i, doubledash, filei;
 
+	git_config(git_default_config, NULL);
+
 	argc = parse_options(argc, argv, prefix, check_attr_options,
 			     check_attr_usage, PARSE_OPT_KEEP_DASHDASH);
 
diff --git a/cache.h b/cache.h
index 607c2ea..8d95fb2 100644
--- a/cache.h
+++ b/cache.h
@@ -589,6 +589,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern const char *apply_default_ignorewhitespace;
+extern const char *git_attributes_file;
 extern int zlib_compression_level;
 extern int core_compression_level;
 extern int core_compression_seen;
diff --git a/config.c b/config.c
index 4183f80..d3bcaa0 100644
--- a/config.c
+++ b/config.c
@@ -491,6 +491,9 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.attributesfile"))
+		return git_config_pathname(&git_attributes_file, var, value);
+
 	if (!strcmp(var, "core.bare")) {
 		is_bare_repository_cfg = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index e96edcf..d60b73f 100644
--- a/environment.c
+++ b/environment.c
@@ -29,6 +29,7 @@ const char *git_log_output_encoding;
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 const char *apply_default_ignorewhitespace;
+const char *git_attributes_file;
 int zlib_compression_level = Z_BEST_SPEED;
 int core_compression_level;
 int core_compression_seen;
-- 
1.7.7.1.ge3b6f
