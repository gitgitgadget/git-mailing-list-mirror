From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH ld/maint-diff-quiet-w] Windows: redirect fopen("/dev/null")
 to fopen("nul")
Date: Thu, 25 Feb 2010 09:49:34 +0100
Message-ID: <4B86399E.3090508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Larry D'Anna <larry@elder-gods.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 09:49:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkZPn-0004LQ-B2
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 09:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353Ab0BYItl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 03:49:41 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53058 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab0BYItj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 03:49:39 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkZPb-0003A9-02; Thu, 25 Feb 2010 09:49:35 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B3E621660F;
	Thu, 25 Feb 2010 09:49:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141034>

From: Johannes Sixt <j6t@kdbg.org>

An instance of fopen("/dev/null",...) was added to the code base. On
Windows, we have to use "nul" instead. This implements a compatibility
wrapper of fopen() that checks for this particular condition.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 compat/mingw.c |    8 ++++++++
 compat/mingw.h |    3 +++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5edf152..57aec93 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,6 +140,14 @@ int mingw_open (const char *filename, int oflags, ...)
 	return fd;
 }

+#undef fopen
+FILE *mingw_fopen (const char *filename, const char *otype)
+{
+	if (!strcmp(filename, "/dev/null"))
+		filename = "nul";
+	return fopen(filename, otype);
+}
+
 /*
  * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
  * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
diff --git a/compat/mingw.h b/compat/mingw.h
index f53bcca..e187b04 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -170,6 +170,9 @@ int link(const char *oldpath, const char *newpath);
 int mingw_open (const char *filename, int oflags, ...);
 #define open mingw_open

+FILE *mingw_fopen (const char *filename, const char *otype);
+#define fopen mingw_fopen
+
 char *mingw_getcwd(char *pointer, int len);
 #define getcwd mingw_getcwd

-- 
1.7.0.1285.g1a907.dirty
