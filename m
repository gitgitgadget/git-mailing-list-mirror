From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: [PATCH/RFC] Fix for default pager
Date: Mon,  7 Jun 2010 20:58:08 -0300
Message-ID: <1275955088-32750-1-git-send-email-soft.d4rio@gmail.com>
References: <Installing on AIX fails>
Cc: Dario Rodriguez <soft.d4rio@gmail.com>, git@vger.kernel.org
To: peff@peff.net, jrnieder@uchicago.edu
X-From: git-owner@vger.kernel.org Tue Jun 08 01:58:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLmDD-0001EO-WD
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 01:58:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227Ab0FGX6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 19:58:31 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52032 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834Ab0FGX6a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 19:58:30 -0400
Received: by gye5 with SMTP id 5so2687223gye.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 16:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:to;
        bh=G2/pELLm7gC7P7ib6KfL9rll7ZlYUOzG6hlFrnh99Xs=;
        b=ow+RyYvqsOprLDikug4MTxYWGZknvHjmAfer66KNxylrZQiwMXvbevfbVmPUzNMemm
         P776H6sh4F83GC5YFQ3yP6NL0cD/6UeQKw2BYj+WV7R9bKnhliOQ+q7hzkokKUjyeVdR
         piqbnCODC4nbLYJnZ8Pc/7sswc0rgljggt2Qo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=omHrMsTX1oQJhqAqt9Uppeiv9yZPtDREvYrfI2za48Z73f5767agHM9YVBmEwaQY3A
         VLjVk0wor4zAGejmNPPiIFe31Zl37NVpNyNrHj2l2szJTKrar17Q1NgSo019bmwtE2OR
         WNvVGq0Z8hChJevmFXC8V+s+8zNpa7bumGWME=
Received: by 10.150.244.10 with SMTP id r10mr4066593ybh.414.1275955109239;
        Mon, 07 Jun 2010 16:58:29 -0700 (PDT)
Received: from localhost.localdomain ([190.50.19.248])
        by mx.google.com with ESMTPS id u8sm2981495ybe.6.2010.06.07.16.58.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 16:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.245.g7c42e.dirty
In-Reply-To: <Installing on AIX fails>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148634>

All commands using pager:

Default pager was 'less' even when some systems such AIX and other basic
or old systems do NOT have 'less' installed. In such case, git just
does not display anything in pager-enabled functionalities such as 'git log'
or 'git show', exiting with status 0.

With this patch, git will not use DEFAULT_PAGER macro anymore, instead,
git will look for 'less' and 'more' in the most common paths.
If there is no pager, returns NULL as if it's 'cat'.

Obviously, the commit message needs to be rewritten :p

Signed-off-by: Dario Rodriguez <soft.d4rio@gmail.com>
---
 pager.c |   80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/pager.c b/pager.c
index dac358f..3cfbd73 100644
--- a/pager.c
+++ b/pager.c
@@ -2,10 +2,19 @@
 #include "run-command.h"
 #include "sigchain.h"
 
-#ifndef DEFAULT_PAGER
-#define DEFAULT_PAGER "less"
+#ifndef GIT_PAGER_ENVIRONMENT
+#define GIT_PAGER_ENVIRONMENT "GIT_PAGER"
 #endif
 
+#ifndef GIT_PGR_LOOKUP_DBG_ENVIRONMENT
+#define GIT_PGR_LOOKUP_DBG_ENVIRONMENT "GIT_PAGER_LOOKUP_DEBUG"
+#endif
+
+#ifndef PAGER_ENVIRONMENT
+#define PAGER_ENVIRONMENT "PAGER"
+#endif
+
+
 /*
  * This is split up from the rest of git so that we can do
  * something different on Windows.
@@ -48,23 +57,80 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
 
-const char *git_pager(int stdout_is_tty)
+static int is_executable(const char *name)
+{
+	struct stat st;
+
+	if (stat(name, &st) ||
+	    !S_ISREG(st.st_mode))
+		return 0;
+
+#ifdef WIN32
+{	/* cannot trust the executable bit, peek into the file instead */
+	char buf[3] = { 0 };
+	int n;
+	int fd = open(name, O_RDONLY);
+	st.st_mode &= ~S_IXUSR;
+	if (fd >= 0) {
+		n = read(fd, buf, 2);
+		if (n == 2)
+			/* DOS executables start with "MZ" */
+			if (!strcmp(buf, "#!") || !strcmp(buf, "MZ"))
+				st.st_mode |= S_IXUSR;
+		close(fd);
+	}
+}
+#endif
+	return st.st_mode & S_IXUSR;
+}
+
+const char *git_pager(int stdout_is_tty) 
 {
+	static const char *pager_bins[] =
+		{ "less", "more", NULL };
+	static const char *common_binary_paths[] =
+		{ "/bin/","/usr/bin/","/usr/local/bin/",NULL };
+
 	const char *pager;
+	char **p1,**p2,*pager_heap;
+	char exe_name[255];
+	int pager_lkp_dbg=0;
 
 	if (!stdout_is_tty)
 		return NULL;
 
-	pager = getenv("GIT_PAGER");
+	if(getenv(GIT_PGR_LOOKUP_DBG_ENVIRONMENT))
+		pager_lkp_dbg=1;
+
+	memset( exe_name,0,255 );
+	pager = getenv(GIT_PAGER_ENVIRONMENT);
 	if (!pager) {
 		if (!pager_program)
 			git_config(git_default_config, NULL);
 		pager = pager_program;
 	}
 	if (!pager)
-		pager = getenv("PAGER");
-	if (!pager)
-		pager = DEFAULT_PAGER;
+		pager = getenv(PAGER_ENVIRONMENT);
+	if (!pager) {
+
+		for (p1=(char**)pager_bins; (*p1)&&(!pager)
+			;p1++)
+			for (p2=(char**)common_binary_paths; (*p2)&&(!pager)
+				;p2++) {
+				sprintf( exe_name,"%s%s",
+					 *p2,*p1 );
+				if (is_executable(exe_name)) {
+					pager_heap = (char*) malloc(sizeof(exe_name));
+					strcpy(pager_heap,exe_name);
+					pager = pager_heap;
+				}
+			}
+
+		if (pager_lkp_dbg)
+			fprintf(stderr, "Debug: Lookup for existent pagers, got [%s]\n",
+				(pager==NULL)?"(null)":pager);
+
+	}
 	else if (!*pager || !strcmp(pager, "cat"))
 		pager = NULL;
 
-- 
1.7.1.245.g7c42e.dirty
