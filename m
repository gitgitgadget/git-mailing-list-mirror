From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 8/9] mailmap: debug: avoid passing NULL to fprintf() '%s' directive
Date: Mon, 15 Jul 2013 02:54:12 -0400
Message-ID: <1373871253-96480-9-git-send-email-sunshine@sunshineco.com>
References: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 15 08:55:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycgd-00048q-TR
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 08:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab3GOGzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 02:55:01 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:62407 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOGyx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 02:54:53 -0400
Received: by mail-ie0-f177.google.com with SMTP id aq17so25008625iec.36
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 23:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6jLS5tXsxDg4tXxgx4EnBGouHI1NTCykzTb0jqGJohU=;
        b=vDY7zmO8oJr4CKck0Xc5kAisSOKxkMqXccwA04xzvGmaBRTq9eXMN4D+qAZ0wyS2LI
         qJ3xqXS/5Hoq5b1cKiq3Go8qy2l73TEKEwzDA4tv4f2GCjh7fcCKB4DobHxTpnnOjLep
         Y4Snyje0vHWNbEjgQ4QD7Cnl5F2BdGvYDdftg4/G/5w5Q3Tjl2wfwNk9s0fBO90DbgOI
         ews0ZxE2VcqO/gIJkMfgNpmoyPq8rIjkXyC+usTUmT8JkorcfxwmeWL8JTQHVdlWj3ZW
         hW0frecBYz+Is74xwrMtD/pmSfxj14Qa4TTAyc0S82+dgolZlAF3uJU3guldqnKRIfAo
         9gtw==
X-Received: by 10.50.111.170 with SMTP id ij10mr6258489igb.9.1373871293224;
        Sun, 14 Jul 2013 23:54:53 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id y9sm16781487iga.9.2013.07.14.23.54.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 14 Jul 2013 23:54:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2.804.g0da7a53
In-Reply-To: <1373871253-96480-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230434>

POSIX does not state the behavior of format directive '%s' when passed a
NULL pointer. Some implementations interpolate literal "(null)"; others
may crash. Callers of debug_mm() often pass NULL as indication of either
a missing name or email address.  Instead, let's always supply a proper
string pointer, and make it a bit more descriptive: "(none)"

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 mailmap.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 4cc6e81..928e6e5 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -5,8 +5,10 @@
 #define DEBUG_MAILMAP 0
 #if DEBUG_MAILMAP
 #define debug_mm(...) fprintf(stderr, __VA_ARGS__)
+#define debug_str(X) ((X) ? (X) : "(none)")
 #else
 static inline void debug_mm(const char *format, ...) {}
+static inline const char *debug_str(const char *s) { return s; }
 #endif
 
 const char *git_mailmap_file;
@@ -29,7 +31,7 @@ struct mailmap_entry {
 static void free_mailmap_info(void *p, const char *s)
 {
 	struct mailmap_info *mi = (struct mailmap_info *)p;
-	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n", s, mi->name, mi->email);
+	debug_mm("mailmap: -- complex: '%s' -> '%s' <%s>\n", s, debug_str(mi->name), debug_str(mi->email));
 	free(mi->name);
 	free(mi->email);
 }
@@ -38,7 +40,8 @@ static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
 	debug_mm("mailmap: removing entries for <%s>, with %d sub-entries\n", s, me->namemap.nr);
-	debug_mm("mailmap: - simple: '%s' <%s>\n", me->name, me->email);
+	debug_mm("mailmap: - simple: '%s' <%s>\n", debug_str(me->name), debug_str(me->email));
+
 	free(me->name);
 	free(me->email);
 
@@ -94,7 +97,7 @@ static void add_mapping(struct string_list *map,
 	}
 
 	debug_mm("mailmap:  '%s' <%s> -> '%s' <%s>\n",
-		 old_name, old_email, new_name, new_email);
+		 debug_str(old_name), old_email, debug_str(new_name), debug_str(new_email));
 }
 
 static char *parse_name_and_email(char *buffer, char **name,
@@ -309,7 +312,7 @@ int map_user(struct string_list *map,
 	struct mailmap_entry *me;
 
 	debug_mm("map_user: map '%.*s' <%.*s>\n",
-		 (int)*namelen, *name, (int)*emaillen, *email);
+		 (int)*namelen, debug_str(*name), (int)*emaillen, debug_str(*email));
 
 	item = lookup_prefix(map, *email, *emaillen);
 	if (item != NULL) {
@@ -337,8 +340,8 @@ int map_user(struct string_list *map,
 				*name = mi->name;
 				*namelen = strlen(*name);
 		}
-		debug_mm("map_user:  to '%.*s' <%.*s>\n", (int)*namelen, *name,
-				 (int)*emaillen, *email);
+		debug_mm("map_user:  to '%.*s' <%.*s>\n", (int)*namelen, debug_str(*name),
+				 (int)*emaillen, debug_str(*email));
 		return 1;
 	}
 	debug_mm("map_user:  --\n");
-- 
1.8.3.2.804.g0da7a53
