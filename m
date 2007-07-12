From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH 3/6] Add functions for parsing integers with size suffixes
Date: Thu, 12 Jul 2007 07:55:49 -0500
Message-ID: <1184244952173-git-send-email-bdowning@lavos.net>
References: <1184244952554-git-send-email-bdowning@lavos.net>
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brian Downing <bdowning@lavos.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 14:56:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8yDX-0005TH-Un
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 14:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763504AbXGLM4B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 08:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763394AbXGLM4A
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 08:56:00 -0400
Received: from 74-134-246-243.dhcp.insightbb.com ([74.134.246.243]:54735 "EHLO
	silvara" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1763151AbXGLMzu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 08:55:50 -0400
Received: by silvara (Postfix, from userid 1000)
	id 924DB52137; Thu, 12 Jul 2007 07:55:52 -0500 (CDT)
X-Mailer: git-send-email 1.5.2.GIT
In-Reply-To: <1184244952554-git-send-email-bdowning@lavos.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52279>

Split out the nnn{k,m,g} parsing code from git_config_int into
git_parse_long, so command-line parameters can enjoy the same
functionality.  Also add get_parse_ulong for unsigned values.

Make git_config_int use git_parse_long, and add get_config_ulong
as well.

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 cache.h  |    3 +++
 config.c |   61 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 53 insertions(+), 11 deletions(-)

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
index 561ee3b..ee338d1 100644
--- a/config.c
+++ b/config.c
@@ -233,21 +233,60 @@ static int git_parse_file(config_fn_t fn)
 	die("bad config file line %d in %s", config_linenr, config_file_name);
 }
 
-int git_config_int(const char *name, const char *value)
+int git_parse_long(const char *value, long *ret)
+{
+	if (value && *value) {
+		char *end;
+		long val = strtol(value, &end, 0);
+		if (!*end)
+			*ret = val;
+		else if (!strcasecmp(end, "k"))
+			*ret = val * 1024;
+		else if (!strcasecmp(end, "m"))
+			*ret = val * 1024 * 1024;
+		else if (!strcasecmp(end, "g"))
+			*ret = val * 1024 * 1024 * 1024;
+		else
+			return 0;
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
+		unsigned long val = strtoul(value, &end, 0);
 		if (!*end)
-			return val;
-		if (!strcasecmp(end, "k"))
-			return val * 1024;
-		if (!strcasecmp(end, "m"))
-			return val * 1024 * 1024;
-		if (!strcasecmp(end, "g"))
-			return val * 1024 * 1024 * 1024;
-	}
-	die("bad config value for '%s' in %s", name, config_file_name);
+			*ret = val;
+		else if (!strcasecmp(end, "k"))
+			*ret = val * 1024;
+		else if (!strcasecmp(end, "m"))
+			*ret = val * 1024 * 1024;
+		else if (!strcasecmp(end, "g"))
+			*ret = val * 1024 * 1024 * 1024;
+		else
+			return 0;
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
