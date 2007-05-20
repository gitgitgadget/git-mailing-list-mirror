From: skimo@liacs.nl
Subject: [PATCH 04/15] git-config: read remote config files over HTTP
Date: Sun, 20 May 2007 20:04:37 +0200
Message-ID: <11796842881906-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmp-0007La-JR
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756970AbXETSFH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757116AbXETSFF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:05 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37200 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756918AbXETSE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:04:58 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4ng7007801;
	Sun, 20 May 2007 20:04:54 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id F38077DDA3; Sun, 20 May 2007 20:04:48 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47867>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Makefile           |    7 ++++++-
 builtin-config.c   |    8 ++++++--
 config.c           |   16 +++++++++++++++-
 http.c             |   10 ++++++----
 http.h             |    2 +-
 http_config.h      |    1 +
 http_config_curl.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 http_config_none.c |    6 ++++++
 8 files changed, 93 insertions(+), 9 deletions(-)
 create mode 100644 http_config.h
 create mode 100644 http_config_curl.c
 create mode 100644 http_config_none.c

diff --git a/Makefile b/Makefile
index 37eb861..bce8514 100644
--- a/Makefile
+++ b/Makefile
@@ -319,7 +319,8 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o
+	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o \
+	$(HTTP_CONFIG_OBJ)
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -526,6 +527,10 @@ ifndef NO_CURL
 	ifndef NO_EXPAT
 		EXPAT_LIBEXPAT = -lexpat
 	endif
+	HTTP_CONFIG_OBJ = http_config_curl.o http.o
+	EXTLIBS += $(CURL_LIBCURL)
+else
+	HTTP_CONFIG_OBJ = http_config_none.o
 endif
 
 ifndef NO_OPENSSL
diff --git a/builtin-config.c b/builtin-config.c
index 3a1e86c..7e18f73 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -147,8 +147,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			type = T_INT;
 		else if (!strcmp(argv[1], "--bool"))
 			type = T_BOOL;
-		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l"))
-			return git_config(show_all_config);
+		else if (!strcmp(argv[1], "--list") || !strcmp(argv[1], "-l")) {
+			if (dest)
+				return git_config_from_remote(show_all_config, dest);
+			else
+				return git_config(show_all_config);
+		}
 		else if (!strcmp(argv[1], "--global")) {
 			char *home = getenv("HOME");
 			if (home) {
diff --git a/config.c b/config.c
index dbfae3f..fc2162b 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "pkt-line.h"
+#include "http_config.h"
 
 #define MAXNAME (256)
 
@@ -406,6 +407,16 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 	return ret;
 }
 
+static int config_from_http(config_fn_t fn, char *dest)
+{
+	char config_temp[50];
+	if (git_http_fetch_config(dest, config_temp, sizeof(config_temp)))
+		return 1;
+	git_config_from_file(fn, config_temp);
+	unlink(config_temp);
+	return 0;
+}
+
 int git_config_from_remote(config_fn_t fn, char *dest)
 {
 	int ret;
@@ -414,7 +425,10 @@ int git_config_from_remote(config_fn_t fn, char *dest)
 	static char var[MAXNAME];
 	static char value[1024];
 
-	pid = git_connect(fd, dest, dumpconfig);
+	if (!prefixcmp(dest, "http://"))
+		return config_from_http(fn, dest);
+
+	pid = git_connect(fd, dest, dumpconfig, 0);
 	if (pid < 0)
 		return 1;
 	ret = 0;
diff --git a/http.c b/http.c
index ae27e0c..c8237cb 100644
--- a/http.c
+++ b/http.c
@@ -25,6 +25,8 @@ long curl_low_speed_limit = -1;
 long curl_low_speed_time = -1;
 int curl_ftp_no_epsv = 0;
 
+void (*fill_active_slots)(void) = NULL;
+
 struct curl_slist *pragma_header;
 
 struct active_request_slot *active_queue_head = NULL;
@@ -394,7 +396,8 @@ void step_active_slots(void)
 	} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
 	if (num_transfers < active_requests) {
 		process_curl_messages();
-		fill_active_slots();
+		if (fill_active_slots)
+			fill_active_slots();
 	}
 }
 #endif
@@ -458,9 +461,8 @@ void release_active_slot(struct active_request_slot *slot)
 		curl_easy_cleanup(slot->curl);
 		slot->curl = NULL;
 	}
-#ifdef USE_CURL_MULTI
-	fill_active_slots();
-#endif
+	if (fill_active_slots)
+		fill_active_slots();
 }
 
 static void finish_active_slot(struct active_request_slot *slot)
diff --git a/http.h b/http.h
index 7a41cde..7f29ff8 100644
--- a/http.h
+++ b/http.h
@@ -68,8 +68,8 @@ extern void run_active_slot(struct active_request_slot *slot);
 extern void finish_all_active_slots(void);
 extern void release_active_slot(struct active_request_slot *slot);
 
-#ifdef USE_CURL_MULTI
 extern void (*fill_active_slots)(void);
+#ifdef USE_CURL_MULTI
 extern void step_active_slots(void);
 #endif
 
diff --git a/http_config.h b/http_config.h
new file mode 100644
index 0000000..25f5c19
--- /dev/null
+++ b/http_config.h
@@ -0,0 +1 @@
+int git_http_fetch_config(const char *repo, char *config_file, int len);
diff --git a/http_config_curl.c b/http_config_curl.c
new file mode 100644
index 0000000..88317cf
--- /dev/null
+++ b/http_config_curl.c
@@ -0,0 +1,52 @@
+#include "http_config.h"
+#include "http.h"
+
+int git_http_fetch_config(const char *repo, char *config, int config_len)
+{
+	char url[PATH_MAX];
+	int len = strlen(repo);
+
+	int fd;
+	FILE *configfile;
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	strcpy(url, repo);
+	while (len > 0 && url[len-1] == '/')
+		--len;
+	snprintf(url+len, sizeof(url)-len, "/config");
+
+	fd = git_mkstemp(config, config_len, ".config_XXXXXX");
+	if (fd >= 0)
+		configfile = fdopen(fd, "w");
+	if (fd < 0 || !configfile)
+		return error("Unable to open local file %s for config",
+			     config);
+
+	http_init();
+
+	slot = get_active_slot();
+	slot->results = &results;
+	curl_easy_setopt(slot->curl, CURLOPT_FILE, configfile);
+	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite);
+	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
+	slot->local = configfile;
+
+	if (start_active_slot(slot)) {
+		run_active_slot(slot);
+		if (results.curl_result != CURLE_OK) {
+			fclose(configfile);
+			warning("Unable to get config %s\n%s", url,
+				 curl_errorstr);
+		}
+	} else {
+		fclose(configfile);
+		return error("Unable to start request");
+	}
+
+	http_cleanup();
+
+	fclose(configfile);
+
+	return 0;
+}
diff --git a/http_config_none.c b/http_config_none.c
new file mode 100644
index 0000000..860ae84
--- /dev/null
+++ b/http_config_none.c
@@ -0,0 +1,6 @@
+#include "http_config.h"
+
+int git_http_fetch_config(const char *repo, char *config_file, int len)
+{
+	return error("Reading http config files not supported");
+}
-- 
1.5.2.rc3.815.g8fc2
