From: Sven Verdoolaege <skimo@liacs.nl>
Subject: [PATCH 4/5] git-config: read remote config files over HTTP
Date: Fri,  4 May 2007 12:56:42 +0200
Message-ID: <11782762034009-git-send-email-skimo@liacs.nl>
References: <11782762032207-git-send-email-skimo@liacs.nl>
Cc: Sven Verdoolaege <skimo@liacs.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 04 12:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjvT7-0005RI-3I
	for gcvg-git@gmane.org; Fri, 04 May 2007 12:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767881AbXEDK4w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 06:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767884AbXEDK4w
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 06:56:52 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:41485 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767881AbXEDK4v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 06:56:51 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l44AuhfP026580;
	Fri, 4 May 2007 12:56:48 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 99A033C011; Fri,  4 May 2007 12:56:43 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11782762032207-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46159>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Makefile           |    6 +++++-
 config.c           |   14 ++++++++++++++
 http.c             |   10 ++++++++--
 http_config.h      |    1 +
 http_config_curl.c |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 http_config_none.c |    6 ++++++
 6 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 http_config.h
 create mode 100644 http_config_curl.c
 create mode 100644 http_config_none.c

diff --git a/Makefile b/Makefile
index 0185386..b782111 100644
--- a/Makefile
+++ b/Makefile
@@ -311,7 +311,7 @@ LIB_OBJS = \
 	write_or_die.o trace.o list-objects.o grep.o match-trees.o \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
-	convert.o attr.o decorate.o progress.o mailmap.o
+	convert.o attr.o decorate.o progress.o mailmap.o $(HTTP_CONFIG_OBJ)
 
 BUILTIN_OBJS = \
 	builtin-add.o \
@@ -518,6 +518,10 @@ ifndef NO_CURL
 	ifndef NO_EXPAT
 		EXPAT_LIBEXPAT = -lexpat
 	endif
+	HTTP_CONFIG_OBJ = http_config_curl.o http.o
+	EXTLIBS += $(CURL_LIBCURL)
+else
+	HTTP_CONFIG_OBJ = http_config_none.o
 endif
 
 ifndef NO_OPENSSL
diff --git a/config.c b/config.c
index 0da74e0..36e3b97 100644
--- a/config.c
+++ b/config.c
@@ -7,6 +7,7 @@
  */
 #include "cache.h"
 #include "pkt-line.h"
+#include "http_config.h"
 
 #define MAXNAME (256)
 
@@ -395,6 +396,16 @@ int git_config_from_file(config_fn_t fn, const char *filename)
 	return ret;
 }
 
+static int config_from_http(config_fn_t fn, char *dest)
+{
+	static char *config_temp = "config.temp";
+	if (git_http_fetch_config(dest, config_temp))
+		return 1;
+	git_config_from_file(fn, config_temp);
+	unlink(config_temp);
+	return 0;
+}
+
 int git_config_from_remote(config_fn_t fn, char *dest)
 {
 	int ret;
@@ -403,6 +414,9 @@ int git_config_from_remote(config_fn_t fn, char *dest)
 	static char var[MAXNAME];
 	static char value[1024];
 
+	if (!prefixcmp(dest, "http://"))
+		return config_from_http(fn, dest);
+
 	pid = git_connect(fd, dest, dumpconfig);
 	if (pid < 0)
 		return 1;
diff --git a/http.c b/http.c
index ae27e0c..3e1ccce 100644
--- a/http.c
+++ b/http.c
@@ -25,6 +25,10 @@ long curl_low_speed_limit = -1;
 long curl_low_speed_time = -1;
 int curl_ftp_no_epsv = 0;
 
+#ifdef USE_CURL_MULTI
+void (*fill_active_slots)(void) = NULL;
+#endif
+
 struct curl_slist *pragma_header;
 
 struct active_request_slot *active_queue_head = NULL;
@@ -394,7 +398,8 @@ void step_active_slots(void)
 	} while (curlm_result == CURLM_CALL_MULTI_PERFORM);
 	if (num_transfers < active_requests) {
 		process_curl_messages();
-		fill_active_slots();
+		if (fill_active_slots)
+			fill_active_slots();
 	}
 }
 #endif
@@ -459,7 +464,8 @@ void release_active_slot(struct active_request_slot *slot)
 		slot->curl = NULL;
 	}
 #ifdef USE_CURL_MULTI
-	fill_active_slots();
+	if (fill_active_slots)
+		fill_active_slots();
 #endif
 }
 
diff --git a/http_config.h b/http_config.h
new file mode 100644
index 0000000..0fddf98
--- /dev/null
+++ b/http_config.h
@@ -0,0 +1 @@
+int git_http_fetch_config(const char *repo, const char *config_file);
diff --git a/http_config_curl.c b/http_config_curl.c
new file mode 100644
index 0000000..3047ea2
--- /dev/null
+++ b/http_config_curl.c
@@ -0,0 +1,49 @@
+#include "http_config.h"
+#include "http.h"
+
+int git_http_fetch_config(const char *repo, const char *config)
+{
+	char url[PATH_MAX];
+	int len = strlen(repo);
+
+	FILE *configfile;
+	struct active_request_slot *slot;
+	struct slot_results results;
+
+	strcpy(url, repo);
+	while (len > 0 && url[len-1] == '/')
+		--len;
+	snprintf(url+len, sizeof(url)-len, "/config");
+
+	configfile = fopen(config, "w");
+	if (!configfile)
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
+			return error("Unable to get config %s\n%s", url,
+				     curl_errorstr);
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
index 0000000..303160b
--- /dev/null
+++ b/http_config_none.c
@@ -0,0 +1,6 @@
+#include "http_config.h"
+
+int git_http_fetch_config(const char *repo, const char *config_file)
+{
+	return error("Reading http config files not supported");
+}
-- 
1.5.2.rc1.25.g889f-dirty
