From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 03/10] Tighten rules for matching server capabilities in
 server_supports()
Date: Mon, 23 May 2011 02:51:56 +0200
Message-ID: <1306111923-16859-4-git-send-email-johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 23 02:52:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOJNt-0000SO-CP
	for gcvg-git-2@lo.gmane.org; Mon, 23 May 2011 02:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752468Ab1EWAw2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 20:52:28 -0400
Received: from smtp.getmail.no ([84.208.15.66]:53497 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509Ab1EWAw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 20:52:26 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM001QLIFB4YA0@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:23 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 029921EA5745_DD9AFC7B	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:23 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 427361EA3369_DD9AFC6F	for <git@vger.kernel.org>; Mon,
 23 May 2011 00:52:22 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLM005PMIF9TE20@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 May 2011 02:52:22 +0200 (MEST)
X-Mailer: git-send-email 1.7.5.rc1.3.g4d7b
In-reply-to: <1306111923-16859-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174209>

When using server_supports() to match a given "feature" against the server
capabilities, follow these rules:

 - "feature" must appear at the beginning of server_capabilities, or the
   byte immediately before the matched location in server_capabilities
   must be a SP; and

 - if "feature" does not end with an equal sign, it does not expect a
   value. The byte after the matched location in server_capabilities must
   be either the end of string or a SP. A feature that expects a value is
   checked with 'server_supports("feature=")' and the matched location in
   server_capabilities can be followed by anything (i.e. if at the end of
   string or a SP, it gets an empty string as the value, and otherwise it
   will get the stretch of bytes after the '=' up to the next SP).

Given the server_capabilities string "foo=ab bar=froboz boz",
this patch should make it behave as follows:

  server_supports("foo=") matches "foo=ab", returns "ab";

  server_supports("ab") does not match anything;

  server_supports("bar") does not match anything;

  server_supports("boz") matches (and returns "boz"), without failing
                         at the end of bar=froboz that comes earlier.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 cache.h   |    2 +-
 connect.c |   30 +++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 009b365..1a9338f 100644
--- a/cache.h
+++ b/cache.h
@@ -995,7 +995,7 @@ struct extra_have_objects {
 	unsigned char (*array)[20];
 };
 extern struct ref **get_remote_heads(int in, struct ref **list, int nr_match, char **match, unsigned int flags, struct extra_have_objects *);
-extern int server_supports(const char *feature);
+extern const char *server_supports(const char *feature);
 
 extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
diff --git a/connect.c b/connect.c
index 2119c3f..3c0a706 100644
--- a/connect.c
+++ b/connect.c
@@ -8,6 +8,7 @@
 #include "url.h"
 
 static char *server_capabilities;
+static size_t server_capabilities_len;
 
 static int check_ref(const char *name, int len, unsigned int flags)
 {
@@ -80,8 +81,16 @@ struct ref **get_remote_heads(int in, struct ref **list,
 
 		name_len = strlen(name);
 		if (len != name_len + 41) {
+			char *p;
 			free(server_capabilities);
 			server_capabilities = xstrdup(name + name_len + 1);
+			server_capabilities_len = strlen(server_capabilities);
+			/* split capabilities on SP */
+			for (p = server_capabilities;
+			     p < server_capabilities + server_capabilities_len;
+			     p++)
+				if (*p == ' ')
+					*p = '\0';
 		}
 
 		if (extra_have &&
@@ -102,10 +111,25 @@ struct ref **get_remote_heads(int in, struct ref **list,
 	return list;
 }
 
-int server_supports(const char *feature)
+const char *server_supports(const char *feature)
 {
-	return server_capabilities &&
-		strstr(server_capabilities, feature) != NULL;
+	const char *p = server_capabilities;
+	size_t feature_len = strlen(feature);
+	int need_value = feature[feature_len - 1] == '=';
+
+	if (!server_capabilities)
+		return NULL;
+
+	for (p = server_capabilities;
+	     p < server_capabilities + server_capabilities_len;
+	     p += strlen(p) + 1) {
+		if (need_value) {
+			if (!strncmp(p, feature, feature_len))
+				return p + feature_len;
+		} else if (!strcmp(p, feature))
+			return p;
+	}
+	return NULL;
 }
 
 int path_match(const char *path, int nr, char **match)
-- 
1.7.5.rc1.3.g4d7b
