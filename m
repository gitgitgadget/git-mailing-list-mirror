From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access of ETC_GITCONFIG.
Date: Tue, 13 Nov 2007 21:05:05 +0100
Message-ID: <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:06:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is21H-0001Be-4x
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761486AbXKMUFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761196AbXKMUFg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:05:36 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49206 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762507AbXKMUFM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:05:12 -0500
Received: from localhost.localdomain (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id DCDCE10AD38;
	Tue, 13 Nov 2007 21:05:09 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1592.g0d6db
In-Reply-To: <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64858>

In a subsequent patch the path to the system-wide config file will be
computed. This is a preparation for that change. It turns all accesses
of ETC_GITCONFIG into function calls. There is no change in behavior.

As a consequence, config.c is the only file that needs the definition of
ETC_GITCONFIG. Hence, -DETC_GITCONFIG is removed from the CFLAGS and a
special build rule for config.c is introduced. As a side-effect, changing
the defintion of ETC_GITCONFIG (e.g. in config.mak) does not trigger a
complete rebuild anymore.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 Makefile         |    5 ++++-
 builtin-config.c |    4 ++--
 cache.h          |    1 +
 config.c         |    9 +++++++--
 4 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 18c61f3..e32f07e 100644
--- a/Makefile
+++ b/Makefile
@@ -752,7 +752,7 @@ TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
 LIBS = $(GITLIBS) $(EXTLIBS)
 
 BASIC_CFLAGS += -DSHA1_HEADER='$(SHA1_HEADER_SQ)' \
-	-DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $(COMPAT_CFLAGS)
+	$(COMPAT_CFLAGS)
 LIB_OBJS += $(COMPAT_OBJS)
 
 ALL_CFLAGS += $(BASIC_CFLAGS)
@@ -901,6 +901,9 @@ exec_cmd.o: exec_cmd.c GIT-CFLAGS
 builtin-init-db.o: builtin-init-db.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DDEFAULT_GIT_TEMPLATE_DIR='"$(template_dir_SQ)"' $<
 
+config.o: config.c GIT-CFLAGS
+	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DETC_GITCONFIG='"$(ETC_GITCONFIG_SQ)"' $<
+
 http.o: http.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) -DGIT_USER_AGENT='"git/$(GIT_VERSION)"' $<
 
diff --git a/builtin-config.c b/builtin-config.c
index e5e243f..f672c9c 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -81,7 +81,7 @@ static int get_value(const char* key_, const char* regex_)
 			local = repo_config = xstrdup(git_path("config"));
 		if (home)
 			global = xstrdup(mkpath("%s/.gitconfig", home));
-		system_wide = ETC_GITCONFIG;
+		system_wide = git_etc_gitconfig();
 	}
 
 	key = xstrdup(key_);
@@ -191,7 +191,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			}
 		}
 		else if (!strcmp(argv[1], "--system"))
-			setenv(CONFIG_ENVIRONMENT, ETC_GITCONFIG, 1);
+			setenv(CONFIG_ENVIRONMENT, git_etc_gitconfig(), 1);
 		else if (!strcmp(argv[1], "--file") || !strcmp(argv[1], "-f")) {
 			if (argc < 3)
 				usage(git_config_set_usage);
diff --git a/cache.h b/cache.h
index 28870c5..0eb7b43 100644
--- a/cache.h
+++ b/cache.h
@@ -551,6 +551,7 @@ extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
 extern int git_config_rename_section(const char *, const char *);
+extern const char *git_etc_gitconfig(void);
 extern int check_repository_format_version(const char *var, const char *value);
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index dc3148d..dd7e9ad 100644
--- a/config.c
+++ b/config.c
@@ -452,6 +452,11 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 	return ret;
 }
 
+const char *git_etc_gitconfig(void)
+{
+	return ETC_GITCONFIG;
+}
+
 int git_config(config_fn_t fn)
 {
 	int ret = 0;
@@ -464,8 +469,8 @@ int git_config(config_fn_t fn)
 	 * config file otherwise. */
 	filename = getenv(CONFIG_ENVIRONMENT);
 	if (!filename) {
-		if (!access(ETC_GITCONFIG, R_OK))
-			ret += git_config_from_file(fn, ETC_GITCONFIG);
+		if (!access(git_etc_gitconfig(), R_OK))
+			ret += git_config_from_file(fn, git_etc_gitconfig());
 		home = getenv("HOME");
 		filename = getenv(CONFIG_LOCAL_ENVIRONMENT);
 		if (!filename)
-- 
1.5.3.5.1592.g0d6db
