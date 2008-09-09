From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] is_directory(): a generic helper function
Date: Tue,  9 Sep 2008 01:27:07 -0700
Message-ID: <1220948830-3275-2-git-send-email-gitster@pobox.com>
References: <1220948830-3275-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 10:28:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyaV-0005P5-QI
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbYIII1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbYIII1W
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:27:22 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56434 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754443AbYIII1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:27:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 034A07A7C3
	for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1DCD17A7C2 for <git@vger.kernel.org>; Tue,  9 Sep 2008 04:27:16
 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.415.g7bb82
In-Reply-To: <1220948830-3275-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1D48B7D2-7E49-11DD-A403-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95355>

A simple "grep -e stat --and -e S_ISDIR" revealed there are many
open-coded implementations of this function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 abspath.c       |   13 ++++++++++++-
 builtin-clone.c |    9 +--------
 cache.h         |    1 +
 daemon.c        |   10 +++-------
 rerere.c        |    3 +--
 sha1_file.c     |    3 +--
 6 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/abspath.c b/abspath.c
index 0d56124..8c06782 100644
--- a/abspath.c
+++ b/abspath.c
@@ -1,5 +1,16 @@
 #include "cache.h"
 
+/*
+ * Do not use this for inspecting *tracked* content.  When path is a
+ * symlink to a directory, we do not want to say it is a directory.
+ * Worth yet, leading components in path could contain symbolic links.
+ */
+int is_directory(const char *path)
+{
+	struct stat st;
+	return (!stat(path, &st) && S_ISDIR(st.st_mode));
+}
+
 /* We allow "recursive" symbolic links. Only within reason, though. */
 #define MAXDEPTH 5
 
@@ -17,7 +28,7 @@ const char *make_absolute_path(const char *path)
 		die ("Too long path: %.*s", 60, path);
 
 	while (depth--) {
-		if (stat(buf, &st) || !S_ISDIR(st.st_mode)) {
+		if (!is_directory(buf)) {
 			char *last_slash = strrchr(buf, '/');
 			if (last_slash) {
 				*last_slash = '\0';
diff --git a/builtin-clone.c b/builtin-clone.c
index c843529..a4b8790 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -77,7 +77,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 	for (i = 0; i < ARRAY_SIZE(suffix); i++) {
 		const char *path;
 		path = mkpath("%s%s", repo, suffix[i]);
-		if (!stat(path, &st) && S_ISDIR(st.st_mode)) {
+		if (is_directory(path)) {
 			*is_bundle = 0;
 			return xstrdup(make_nonrelative_path(path));
 		}
@@ -140,13 +140,6 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 	return xstrndup(start, end - start);
 }
 
-static int is_directory(const char *path)
-{
-	struct stat buf;
-
-	return !stat(path, &buf) && S_ISDIR(buf.st_mode);
-}
-
 static void strip_trailing_slashes(char *dir)
 {
 	char *end = dir + strlen(dir);
diff --git a/cache.h b/cache.h
index de8c2b6..ce1f630 100644
--- a/cache.h
+++ b/cache.h
@@ -533,6 +533,7 @@ static inline int is_absolute_path(const char *path)
 {
 	return path[0] == '/' || has_dos_drive_prefix(path);
 }
+int is_directory(const char *);
 const char *make_absolute_path(const char *path);
 const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
diff --git a/daemon.c b/daemon.c
index c315932..ab7a273 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1115,13 +1115,9 @@ int main(int argc, char **argv)
 	if (strict_paths && (!ok_paths || !*ok_paths))
 		die("option --strict-paths requires a whitelist");
 
-	if (base_path) {
-		struct stat st;
-
-		if (stat(base_path, &st) || !S_ISDIR(st.st_mode))
-			die("base-path '%s' does not exist or "
-			    "is not a directory", base_path);
-	}
+	if (base_path && !is_directory(base_path))
+		die("base-path '%s' does not exist or is not a directory",
+		    base_path);
 
 	if (inetd_mode) {
 		struct sockaddr_storage ss;
diff --git a/rerere.c b/rerere.c
index 323e493..c38886b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -319,7 +319,6 @@ static int git_rerere_config(const char *var, const char *value, void *cb)
 
 static int is_rerere_enabled(void)
 {
-	struct stat st;
 	const char *rr_cache;
 	int rr_cache_exists;
 
@@ -327,7 +326,7 @@ static int is_rerere_enabled(void)
 		return 0;
 
 	rr_cache = git_path("rr-cache");
-	rr_cache_exists = !stat(rr_cache, &st) && S_ISDIR(st.st_mode);
+	rr_cache_exists = is_directory(rr_cache);
 	if (rerere_enabled < 0)
 		return rr_cache_exists;
 
diff --git a/sha1_file.c b/sha1_file.c
index 9ee1ed1..ae550e8 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -250,7 +250,6 @@ static void read_info_alternates(const char * alternates, int depth);
  */
 static int link_alt_odb_entry(const char * entry, int len, const char * relative_base, int depth)
 {
-	struct stat st;
 	const char *objdir = get_object_directory();
 	struct alternate_object_database *ent;
 	struct alternate_object_database *alt;
@@ -281,7 +280,7 @@ static int link_alt_odb_entry(const char * entry, int len, const char * relative
 	ent->base[pfxlen] = ent->base[entlen-1] = 0;
 
 	/* Detect cases where alternate disappeared */
-	if (stat(ent->base, &st) || !S_ISDIR(st.st_mode)) {
+	if (!is_directory(ent->base)) {
 		error("object directory %s does not exist; "
 		      "check .git/objects/info/alternates.",
 		      ent->base);
-- 
1.6.0.1.415.g7bb82
