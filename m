From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] strbuf: use strbuf_addstr() for adding C strings
Date: Thu, 17 Jul 2014 01:38:18 +0200
Message-ID: <53C70CEA.8000000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:38:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7YmM-0006Th-Pc
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 01:38:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009AbaGPXi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2014 19:38:27 -0400
Received: from mout.web.de ([212.227.15.14]:57111 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818AbaGPXi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 19:38:26 -0400
Received: from [192.168.178.27] ([79.250.168.234]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LrbHJ-1WQcEH0Uxh-013Qdt; Thu, 17 Jul 2014 01:38:24
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:PBk8mytq4TKvkG9n3JiXBR4HB7qwGL3yW1aiNn9bXd8NHQkX1f5
 4W/VaQLZN5kjwSGJ1Q/d9bjFSHRrzqyHWjQTa2aHZTP1fGi21FMPPMg5xLQ+31fw5l4bl5I
 JrHWmdWGyzMZp6bnZ8rDaJ+iYWIY7RXCo0M65th4DsyGW/ZvfKJNBtwEZI/zTWqbZueDIEj
 MbpW6poQ8/NPYYtYd1inQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253716>

Avoid code duplication and let strbuf_addstr() call strlen() for us.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/commit.c |  2 +-
 diff.c           | 12 ++++++------
 path.c           |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 72eb3be..f2d7979 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -702,7 +702,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		char *buffer;
 		buffer = strstr(use_message_buffer, "\n\n");
 		if (buffer)
-			strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
+			strbuf_addstr(&sb, buffer + 2);
 		hook_arg1 = "commit";
 		hook_arg2 = use_message;
 	} else if (fixup_message) {
diff --git a/diff.c b/diff.c
index 06bdfb8..867f034 100644
--- a/diff.c
+++ b/diff.c
@@ -525,9 +525,9 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	ep += 2; /* skip over @@ */
 
 	/* The hunk header in fraginfo color */
-	strbuf_add(&msgbuf, frag, strlen(frag));
+	strbuf_addstr(&msgbuf, frag);
 	strbuf_add(&msgbuf, line, ep - line);
-	strbuf_add(&msgbuf, reset, strlen(reset));
+	strbuf_addstr(&msgbuf, reset);
 
 	/*
 	 * trailing "\r\n"
@@ -541,15 +541,15 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 		if (*ep != ' ' && *ep != '\t')
 			break;
 	if (ep != cp) {
-		strbuf_add(&msgbuf, plain, strlen(plain));
+		strbuf_addstr(&msgbuf, plain);
 		strbuf_add(&msgbuf, cp, ep - cp);
-		strbuf_add(&msgbuf, reset, strlen(reset));
+		strbuf_addstr(&msgbuf, reset);
 	}
 
 	if (ep < line + len) {
-		strbuf_add(&msgbuf, func, strlen(func));
+		strbuf_addstr(&msgbuf, func);
 		strbuf_add(&msgbuf, ep, line + len - ep);
-		strbuf_add(&msgbuf, reset, strlen(reset));
+		strbuf_addstr(&msgbuf, reset);
 	}
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
diff --git a/path.c b/path.c
index bc804a3..c3883d4 100644
--- a/path.c
+++ b/path.c
@@ -277,16 +277,16 @@ char *expand_user_path(const char *path)
 			const char *home = getenv("HOME");
 			if (!home)
 				goto return_null;
-			strbuf_add(&user_path, home, strlen(home));
+			strbuf_addstr(&user_path, home);
 		} else {
 			struct passwd *pw = getpw_str(username, username_len);
 			if (!pw)
 				goto return_null;
-			strbuf_add(&user_path, pw->pw_dir, strlen(pw->pw_dir));
+			strbuf_addstr(&user_path, pw->pw_dir);
 		}
 		to_copy = first_slash;
 	}
-	strbuf_add(&user_path, to_copy, strlen(to_copy));
+	strbuf_addstr(&user_path, to_copy);
 	return strbuf_detach(&user_path, NULL);
 return_null:
 	strbuf_release(&user_path);
-- 
2.0.2
