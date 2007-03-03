From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 6/6] Fix a "pointer type missmatch" warning.
Date: Sat, 03 Mar 2007 18:29:03 +0000
Message-ID: <45E9BE6F.9090400@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 03 19:29:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNYzK-0007UJ-Go
	for gcvg-git@gmane.org; Sat, 03 Mar 2007 19:29:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbXCCS3e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Mar 2007 13:29:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbXCCS3e
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Mar 2007 13:29:34 -0500
Received: from anchor-post-31.mail.demon.net ([194.217.242.89]:2836 "EHLO
	anchor-post-31.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030363AbXCCS30 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Mar 2007 13:29:26 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-31.mail.demon.net with esmtp (Exim 4.42)
	id 1HNYyt-000C2X-5Y; Sat, 03 Mar 2007 18:29:20 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41311>


In particular, the second parameter in the call to iconv() will
cause this warning if your library declares iconv() with the
second (input buffer pointer) parameter of type const char **.
This is the old prototype, which is none-the-less used by the
current version of newlib on Cygwin. (It appears in old versions
of glibc too).

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Note: set OLD_ICONV in your config.mak file on Cygwin.

  Makefile |    7 +++++++
  utf8.c   |   10 ++++++++--
  2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 8390a94..d447c43 100644
--- a/Makefile
+++ b/Makefile
@@ -85,6 +85,9 @@ all::
  #
  # Define NO_ICONV if your libc does not properly support iconv.
  #
+# Define OLD_ICONV if your library has an old iconv(), where the second
+# (input buffer pointer) parameter is declared with type (const char **).
+#
  # Define NO_R_TO_GCC if your gcc does not like "-R/path/lib" that
  # tells runtime paths to dynamic libraries; "-Wl,-rpath=/path/lib"
  # is used instead.
@@ -560,6 +563,10 @@ ifdef NO_ICONV
  	BASIC_CFLAGS += -DNO_ICONV
  endif

+ifdef OLD_ICONV
+	BASIC_CFLAGS += -DOLD_ICONV
+endif
+
  ifdef PPC_SHA1
  	SHA1_HEADER = "ppc/sha1.h"
  	LIB_OBJS += ppc/sha1.o ppc/sha1ppc.o
diff --git a/utf8.c b/utf8.c
index 211e100..f381a7f 100644
--- a/utf8.c
+++ b/utf8.c
@@ -293,11 +293,17 @@ int is_encoding_utf8(const char *name)
   * with iconv.  If the conversion fails, returns NULL.
   */
  #ifndef NO_ICONV
+#ifdef OLD_ICONV
+	typedef const char * iconv_ibp;
+#else
+	typedef char * iconv_ibp;
+#endif
  char *reencode_string(const char *in, const char *out_encoding, const char *in_encoding)
  {
  	iconv_t conv;
  	size_t insz, outsz, outalloc;
-	char *out, *outpos, *cp;
+	char *out, *outpos;
+	iconv_ibp cp;

  	if (!in_encoding)
  		return NULL;
@@ -309,7 +315,7 @@ char *reencode_string(const char *in, const char *out_encoding, const char *in_e
  	outalloc = outsz + 1; /* for terminating NUL */
  	out = xmalloc(outalloc);
  	outpos = out;
-	cp = (char *)in;
+	cp = (iconv_ibp)in;

  	while (1) {
  		size_t cnt = iconv(conv, &cp, &insz, &outpos, &outsz);
-- 
1.5.0
