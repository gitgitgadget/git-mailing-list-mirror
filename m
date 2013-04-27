From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 5/6] compat/mingw.c: Fix some sparse warnings
Date: Sat, 27 Apr 2013 20:18:55 +0100
Message-ID: <517C249F.6020909@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 21:47:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWB5h-0000k4-Fi
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 21:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481Ab3D0TrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 15:47:19 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:33149 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756460Ab3D0TrR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 15:47:17 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id A6A64384081;
	Sat, 27 Apr 2013 20:47:16 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id DE68038407C;
	Sat, 27 Apr 2013 20:47:15 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Sat, 27 Apr 2013 20:47:15 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222676>


Sparse issues the following warnings:

        SP compat/mingw.c
    compat/mingw.c:795:3: warning: symbol 'pinfo_t' was not declared. \
        Should it be static?
    compat/mingw.c:796:16: warning: symbol 'pinfo' was not declared. \
        Should it be static?
    compat/mingw.c:797:18: warning: symbol 'pinfo_cs' was not declared. \
        Should it be static?
    compat/mingw.c:1207:23: warning: Using plain integer as NULL pointer

In 'pinfo_t' variable, defined on line 795, seems to have been a
mistake (a missing typedef keyword?), so we simply remove it.

The 'pinfo' variable does not require more than file scope, so we
simply add the static modifier to the declaration.

The 'pinfo_cs' variable, in contrast, requires initialisation in the
mingw replacement main() function, so we add an extern declaration to
the compat/mingw.h header file.

The remaining warning is suppressed by replacing the rhs of the
pointer assignment with the NULL pointer literal.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 compat/mingw.c | 6 +++---
 compat/mingw.h | 7 +++++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index b673625..b295e2f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -841,8 +841,8 @@ struct pinfo_t {
 	struct pinfo_t *next;
 	pid_t pid;
 	HANDLE proc;
-} pinfo_t;
-struct pinfo_t *pinfo = NULL;
+};
+static struct pinfo_t *pinfo = NULL;
 CRITICAL_SECTION pinfo_cs;
 
 static pid_t mingw_spawnve_fd(const char *cmd, const char **argv, char **env,
@@ -1253,7 +1253,7 @@ static int WSAAPI getaddrinfo_stub(const char *node, const char *service,
 	else
 		sin->sin_addr.s_addr = INADDR_LOOPBACK;
 	ai->ai_addr = (struct sockaddr *)sin;
-	ai->ai_next = 0;
+	ai->ai_next = NULL;
 	return 0;
 }
 
diff --git a/compat/mingw.h b/compat/mingw.h
index 685cd2c..3036980 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -334,6 +334,13 @@ char **make_augmented_environ(const char *const *vars);
 void free_environ(char **env);
 
 /*
+ * A critical section used in the implementation of the spawn
+ * functions (mingw_spawnv[p]e()) and waitpid(). Intialised in
+ * the replacement main() macro below.
+ */
+extern CRITICAL_SECTION pinfo_cs;
+
+/*
  * A replacement of main() that ensures that argv[0] has a path
  * and that default fmode and std(in|out|err) are in binary mode
  */
-- 
1.8.2
