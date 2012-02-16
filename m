From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] config: teach git_config_rename_section a file argument
Date: Thu, 16 Feb 2012 03:04:25 -0500
Message-ID: <20120216080425.GD11843@sigill.intra.peff.net>
References: <20120216080102.GA11793@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 16 09:04:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxwKO-0000fl-Rc
	for gcvg-git-2@plane.gmane.org; Thu, 16 Feb 2012 09:04:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab2BPIE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Feb 2012 03:04:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38586
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755467Ab2BPIE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2012 03:04:27 -0500
Received: (qmail 28027 invoked by uid 107); 16 Feb 2012 08:11:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Feb 2012 03:11:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2012 03:04:25 -0500
Content-Disposition: inline
In-Reply-To: <20120216080102.GA11793@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190879>

The other config-writing functions (git_config_set and
git_config_set_multivar) each have an -"in_file" version to
write a specific file. Let's add one for rename_section,
with the eventual goal of moving away from the magic
config_exclusive_filename global.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h  |    1 +
 config.c |   20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 94f3eaf..7e375ce 100644
--- a/cache.h
+++ b/cache.h
@@ -1130,6 +1130,7 @@ extern int git_config_parse_key(const char *, char **, int *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
+extern int git_config_rename_section_in_file(const char *, const char *, const char *);
 extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value, void *cb);
 extern int git_env_bool(const char *, int);
diff --git a/config.c b/config.c
index a9eec58..c456600 100644
--- a/config.c
+++ b/config.c
@@ -1537,19 +1537,19 @@ static int section_name_match (const char *buf, const char *name)
 }
 
 /* if new_name == NULL, the section is removed instead */
-int git_config_rename_section(const char *old_name, const char *new_name)
+int git_config_rename_section_in_file(const char *config_filename,
+				      const char *old_name, const char *new_name)
 {
 	int ret = 0, remove = 0;
-	char *config_filename;
+	char *filename_buf = NULL;
 	struct lock_file *lock = xcalloc(sizeof(struct lock_file), 1);
 	int out_fd;
 	char buf[1024];
 	FILE *config_file;
 
-	if (config_exclusive_filename)
-		config_filename = xstrdup(config_exclusive_filename);
-	else
-		config_filename = git_pathdup("config");
+	if (!config_filename)
+		config_filename = filename_buf = git_pathdup("config");
+
 	out_fd = hold_lock_file_for_update(lock, config_filename, 0);
 	if (out_fd < 0) {
 		ret = error("could not lock config file %s", config_filename);
@@ -1613,10 +1613,16 @@ unlock_and_out:
 	if (commit_lock_file(lock) < 0)
 		ret = error("could not commit config file %s", config_filename);
 out:
-	free(config_filename);
+	free(filename_buf);
 	return ret;
 }
 
+int git_config_rename_section(const char *old_name, const char *new_name)
+{
+	return git_config_rename_section_in_file(config_exclusive_filename,
+						 old_name, new_name);
+}
+
 /*
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
-- 
1.7.9.1.4.g8ffed
