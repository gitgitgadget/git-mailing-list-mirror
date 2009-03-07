From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] cleanup: add isascii()
Date: Sat, 07 Mar 2009 14:06:49 +0100
Message-ID: <1236431209.20373.9.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 14:08:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfwGW-00023H-M2
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 14:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZCGNG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 08:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbZCGNG5
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 08:06:57 -0500
Received: from india601.server4you.de ([85.25.151.105]:55747 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbZCGNG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 08:06:56 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id DB0E72F8057;
	Sat,  7 Mar 2009 14:06:53 +0100 (CET)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112538>

Add a standard definition of isascii() and use it to replace an open
coded high-bit test in pretty.c.  While we're there, write the ESC
char as the more commonly used '\033' instead of as 0x1b to enhance
its grepability.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 git-compat-util.h |    2 ++
 pretty.c          |    3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index dcf4127..878d83d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -319,6 +319,7 @@ static inline int has_extension(const char *filename, const char *ext)
 }
 
 /* Sane ctype - no locale, and works with signed chars */
+#undef isascii
 #undef isspace
 #undef isdigit
 #undef isalpha
@@ -332,6 +333,7 @@ extern unsigned char sane_ctype[256];
 #define GIT_GLOB_SPECIAL 0x08
 #define GIT_REGEX_SPECIAL 0x10
 #define sane_istest(x,mask) ((sane_ctype[(unsigned char)(x)] & (mask)) != 0)
+#define isascii(x) (((x) & ~0x7f) == 0)
 #define isspace(x) sane_istest(x,GIT_SPACE)
 #define isdigit(x) sane_istest(x,GIT_DIGIT)
 #define isalpha(x) sane_istest(x,GIT_ALPHA)
diff --git a/pretty.c b/pretty.c
index f499294..c018408 100644
--- a/pretty.c
+++ b/pretty.c
@@ -83,8 +83,7 @@ static int get_one_line(const char *msg)
 /* High bit set, or ISO-2022-INT */
 int non_ascii(int ch)
 {
-	ch = (ch & 0xff);
-	return ((ch & 0x80) || (ch == 0x1b));
+	return !isascii(ch) || ch == '\033';
 }
 
 static int is_rfc2047_special(char ch)
-- 
1.6.2
