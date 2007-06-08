From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [RFC][PATCH 05/10] Sparse: fix some "symbol not declared" warnings
 (Part 3)
Date: Fri, 08 Jun 2007 23:15:01 +0100
Message-ID: <4669D4E5.2070702@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jun 09 05:39:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hwrnn-0003Cy-Mg
	for gcvg-git@gmane.org; Sat, 09 Jun 2007 05:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198AbXFIDjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 23:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXFIDjb
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 23:39:31 -0400
Received: from anchor-fallback-94.mail.demon.net ([194.217.242.94]:51598 "EHLO
	anchor-fallback-94.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754292AbXFIDjZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jun 2007 23:39:25 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:1536 "EHLO
	anchor-post-30.mail.demon.net") by anchor-fallback-94.mail.demon.net
	with ESMTP id S2738902AbXFHWce (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 23:32:34 +0100
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1Hwmy0-0005nv-2q; Fri, 08 Jun 2007 22:30:01 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49557>


This commit removes this warning, in various ways, for three more
symbols, thus:

    - 'common_cmds': this symbol is created by the generate-cmdlist.sh
      script, so modify the script to include the static keyword in
      the declaration.

    - 'curl_ftp_no_epsv': add declaration to http.h header file.
      (Note that it could be declared static in http.c, but so could
      several other variables in that header; just being consistent)

    - 'wt_status_use_color': add a declaration to the wt-status.h
      header file, but change the symbol to a function at the same
      time.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin-runstatus.c |    6 ++----
 generate-cmdlist.sh |    2 +-
 http.h              |    2 +-
 wt-status.c         |   12 +++++++++---
 wt-status.h         |    1 +
 5 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin-runstatus.c b/builtin-runstatus.c
index d7b04cb..1a9a647 100644
--- a/builtin-runstatus.c
+++ b/builtin-runstatus.c
@@ -2,8 +2,6 @@
 #include "wt-status.h"
 #include "builtin.h"
 
-extern int wt_status_use_color;
-
 static const char runstatus_usage[] =
 "git-runstatus [--color|--nocolor] [--amend] [--verbose] [--untracked]";
 
@@ -17,9 +15,9 @@ int cmd_runstatus(int argc, const char **argv, const char *prefix)
 
 	for (i = 1; i < argc; i++) {
 		if (!strcmp(argv[i], "--color"))
-			wt_status_use_color = 1;
+			wt_status_use_color(1);
 		else if (!strcmp(argv[i], "--nocolor"))
-			wt_status_use_color = 0;
+			wt_status_use_color(0);
 		else if (!strcmp(argv[i], "--amend")) {
 			s.amend = 1;
 			s.reference = "HEAD^1";
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 975777f..17df47b 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -7,7 +7,7 @@ struct cmdname_help
     char help[80];
 };
 
-struct cmdname_help common_cmds[] = {"
+static struct cmdname_help common_cmds[] = {"
 
 sort <<\EOF |
 add
diff --git a/http.h b/http.h
index 69b6b66..9070e6f 100644
--- a/http.h
+++ b/http.h
@@ -99,9 +99,9 @@ extern char *ssl_capath;
 extern char *ssl_cainfo;
 extern long curl_low_speed_limit;
 extern long curl_low_speed_time;
+extern int curl_ftp_no_epsv;
 
 extern struct curl_slist *pragma_header;
-extern struct curl_slist *no_range_header;
 
 extern struct active_request_slot *active_queue_head;
 
diff --git a/wt-status.c b/wt-status.c
index fd8a877..9fa9100 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,7 +8,7 @@
 #include "revision.h"
 #include "diffcore.h"
 
-int wt_status_use_color = 0;
+static int use_color = 0;
 static char wt_status_colors[][COLOR_MAXLEN] = {
 	"",         /* WT_STATUS_HEADER: normal */
 	"\033[32m", /* WT_STATUS_UPDATED: green */
@@ -39,7 +39,7 @@ static int parse_status_slot(const char *var, int offset)
 
 static const char* color(int slot)
 {
-	return wt_status_use_color ? wt_status_colors[slot] : "";
+	return use_color ? wt_status_colors[slot] : "";
 }
 
 void wt_status_prepare(struct wt_status *s)
@@ -349,7 +349,7 @@ void wt_status_print(struct wt_status *s)
 int git_status_config(const char *k, const char *v)
 {
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
-		wt_status_use_color = git_config_colorbool(k, v);
+		use_color = git_config_colorbool(k, v);
 		return 0;
 	}
 	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
@@ -358,3 +358,9 @@ int git_status_config(const char *k, const char *v)
 	}
 	return git_default_config(k, v);
 }
+
+void wt_status_use_color(int please)
+{
+	use_color = please;
+}
+
diff --git a/wt-status.h b/wt-status.h
index cfea4ae..dd4421a 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -24,5 +24,6 @@ struct wt_status {
 int git_status_config(const char *var, const char *value);
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
+void wt_status_use_color(int please);
 
 #endif /* STATUS_H */
-- 
1.5.2
