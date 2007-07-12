From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Add functions for parsing integers with size suffixes
Date: Thu, 12 Jul 2007 08:32:26 -0500
Message-ID: <11842471462637-git-send-email-bdowning@lavos.net>
References: <Pine.LNX.4.64.0707121404450.4516@racer.site>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 15:32:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ymS-0005Ex-1m
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 15:32:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763938AbXGLNcZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 09:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762292AbXGLNcY
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 09:32:24 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:54595 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1762098AbXGLNcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 09:32:24 -0400
Received: by silvara (Postfix, from userid 1000)
	id D342A52133; Thu, 12 Jul 2007 08:32:26 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <Pine.LNX.4.64.0707121404450.4516@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52288>

Split out the nnn{k,m,g} parsing code from git_config_int into
git_parse_long, so command-line parameters can enjoy the same
functionality.  Also add get_parse_ulong for unsigned values.

Make git_config_int use git_parse_long, and add get_config_ulong
as well.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
    Good idea!

 cache.h  |    3 +++
 config.c |   58 ++++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/cache.h b/cache.h
index e64071e..917a7e3 100644
--- a/cache.h
+++ b/cache.h
@@ -521,7 +521,10 @@ typedef int (*config_fn_t)(const char *, const char *);
 extern int git_default_config(const char *, const char *);
 extern int git_config_from_file(config_fn_t fn, const char *);
 extern int git_config(config_fn_t fn);
+extern int git_parse_long(const char *, long *);
+extern int git_parse_ulong(const char *, unsigned long *);
 extern int git_config_int(const char *, const char *);
+extern unsigned long git_config_ulong(const char *, const char *);
 extern int git_config_bool(const char *, const char *);
 extern int git_config_set(const char *, const char *);
 extern int git_config_set_multivar(const char *, const char *, const char *, int);
diff --git a/config.c b/config.c
index 561ee3b..f89a611 100644
--- a/config.c
+++ b/config.c
@@ -233,21 +233,55 @@ static int git_parse_file(config_fn_t fn)
 	die("bad config file line %d in %s", config_linenr, config_file_name);
 }
 
-int git_config_int(const char *name, const char *value)
+static unsigned long get_unit_factor(const char *end)
+{
+	if (!*end)
+		return 1;
+	else if (!strcasecmp(end, "k"))
+		return 1024;
+	else if (!strcasecmp(end, "m"))
+		return 1024 * 1024;
+	else if (!strcasecmp(end, "g"))
+		return 1024 * 1024 * 1024;
+	die("unknown unit: '%s'", end);
+}
+
+int git_parse_long(const char *value, long *ret)
+{
+	if (value && *value) {
+		char *end;
+		long val = strtol(value, &end, 0);
+		*ret = val * get_unit_factor(end);
+		return 1;
+	}
+	return 0;
+}
+
+int git_parse_ulong(const char *value, unsigned long *ret)
 {
 	if (value && *value) {
 		char *end;
-		int val = strtol(value, &end, 0);
-		if (!*end)
-			return val;
-		if (!strcasecmp(end, "k"))
-			return val * 1024;
-		if (!strcasecmp(end, "m"))
-			return val * 1024 * 1024;
-		if (!strcasecmp(end, "g"))
-			return val * 1024 * 1024 * 1024;
-	}
-	die("bad config value for '%s' in %s", name, config_file_name);
+		unsigned long val = strtoul(value, &end, 0);
+		*ret = val * get_unit_factor(end);
+		return 1;
+	}
+	return 0;
+}
+
+int git_config_int(const char *name, const char *value)
+{
+	long ret;
+	if (!git_parse_long(value, &ret))
+		die("bad config value for '%s' in %s", name, config_file_name);
+	return ret;
+}
+
+unsigned long git_config_ulong(const char *name, const char *value)
+{
+	unsigned long ret;
+	if (!git_parse_ulong(value, &ret))
+		die("bad config value for '%s' in %s", name, config_file_name);
+	return ret;
 }
 
 int git_config_bool(const char *name, const char *value)
-- 
1.5.2.GIT
