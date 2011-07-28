From: "Theo Niessink" <theo@taletn.com>
Subject: RE: [PATCH] On Cygwin support both UNIX and DOS style path-names
Date: Thu, 28 Jul 2011 12:44:45 +0200
Message-ID: <214795D425BD400EB32D9D140BB8C1F6@martinic.local>
References: <FD5C22CB4AC2439D8151F6B7CD4B7CC9@martinic.local> <4E312BD6.6020901@obry.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <git@vger.kernel.org>
To: <pascal@obry.net>
X-From: git-owner@vger.kernel.org Thu Jul 28 12:44:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmO5E-0001pD-3x
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 12:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755452Ab1G1Kot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 06:44:49 -0400
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:2836 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753248Ab1G1Kor convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 06:44:47 -0400
Received: from cpsps-ews21.kpnxchange.com ([10.94.84.187]) by cpsmtpb-ews07.kpnxchange.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Thu, 28 Jul 2011 12:44:17 +0200
Received: from CPSMTPM-CMT103.kpnxchange.com ([195.121.3.19]) by cpsps-ews21.kpnxchange.com with Microsoft SMTPSVC(7.5.7601.17514);
	 Thu, 28 Jul 2011 12:44:16 +0200
Received: from pc0003 ([77.168.115.212]) by CPSMTPM-CMT103.kpnxchange.com with Microsoft SMTPSVC(7.0.6002.18264);
	 Thu, 28 Jul 2011 12:44:45 +0200
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
In-Reply-To: <4E312BD6.6020901@obry.net>
Thread-Index: AcxNCMgnpIiScGCTToywjkY4OYx4jAACjeUA
X-OriginalArrivalTime: 28 Jul 2011 10:44:45.0961 (UTC) FILETIME=[5DC1EF90:01CC4D13]
X-RcptDomain: vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178062>

Pascal Obry wrote:
> Thanks for the review/feedback. Will work on that and propose another
> patch.

Perhaps something like this on top of (or before) your patch?

-- >8 --
Subject: [PATCH] git-compat-util: add generic find_last_dir_sep that respects
 is_dir_sep

Move MinGW's find_last_dir_sep to git-compat-util.h, so it can also be used
on other platforms that define is_dir_sep, e.g. Cygwin.

Signed-off-by: Theo Niessink <theo@taletn.com>
---
 compat/mingw.h    |    9 ---------
 git-compat-util.h |   12 ++++++++++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/compat/mingw.h b/compat/mingw.h
index ce9dd98..547568b 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -300,15 +300,6 @@ int winansi_fprintf(FILE *stream, const char *format, ...) __attribute__((format
 
 #define has_dos_drive_prefix(path) (isalpha(*(path)) && (path)[1] == ':')
 #define is_dir_sep(c) ((c) == '/' || (c) == '\\')
-static inline char *mingw_find_last_dir_sep(const char *path)
-{
-	char *ret = NULL;
-	for (; *path; ++path)
-		if (is_dir_sep(*path))
-			ret = (char *)path;
-	return ret;
-}
-#define find_last_dir_sep mingw_find_last_dir_sep
 #define PATH_SEP ';'
 #define PRIuMAX "I64u"
 
diff --git a/git-compat-util.h b/git-compat-util.h
index ddfbf77..c2c94cd 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -211,6 +211,18 @@ extern char *gitbasename(char *);
 #define has_dos_drive_prefix(path) 0
 #endif
 
+#if !defined(find_last_dir_sep) && defined(is_dir_sep)
+static inline char *compat_find_last_dir_sep(const char *path)
+{
+	char *ret = NULL;
+	for (; *path; ++path)
+		if (is_dir_sep(*path))
+			ret = (char *)path;
+	return ret;
+}
+#define find_last_dir_sep compat_find_last_dir_sep
+#endif
+
 #ifndef is_dir_sep
 #define is_dir_sep(c) ((c) == '/')
 #endif
-- 
1.7.6.msysgit.0
