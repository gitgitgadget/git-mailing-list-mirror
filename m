From: Drew Northup <n1xim.email@gmail.com>
Subject: [PATCH] TIG: Implement mkstemps() work-around for platforms lacking it
Date: Tue,  9 Jul 2013 11:33:12 -0400
Message-ID: <1373383992-4298-1-git-send-email-n1xim.email@gmail.com>
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Jonas Fonseca <fonseca@diku.dk>,
	Drew Northup <n1xim.email@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 17:34:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwZvT-0001U7-64
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 17:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab3GIPdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 11:33:55 -0400
Received: from mail-vc0-f181.google.com ([209.85.220.181]:39372 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab3GIPdy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 11:33:54 -0400
Received: by mail-vc0-f181.google.com with SMTP id lf11so4461550vcb.12
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=yK32RJ7AqPTEJa+F6xNz8jo3rHWnQc8s6sPUI6/vi7M=;
        b=vrrlIyNJsA4bKIfB+P2JnDMsYHolpFqeHssrP5dMRFtnVoifV0Xt78PouQ4M6e1JGv
         pKPz5KAfz/jZf9w3DUEItTNKiJv2YVnCAkBl1ppFDewKcBMXreCj2EQFU1X3bXLl0PR9
         8CSMtC4IAcDIu5aNrEyPmyV+uzU69zhetLtryymemUh3jWmqTIk9d/PzuKERfmI7mu6X
         vaSBkucA8u+R/T/uC1xDBxTGlvoMu7kEwzMqCnmFmU6RKLW+HmdEWU9N4++my3gaCGBv
         ve6oR3aVPOuaNtwDVlLebIqHjlLiERsxvUukujT7+3fbBn0GwE6kyqWASYMUuYaLkC+s
         J9Zg==
X-Received: by 10.52.91.202 with SMTP id cg10mr14072568vdb.85.1373384033625;
        Tue, 09 Jul 2013 08:33:53 -0700 (PDT)
Received: from atom.sys-os.org (pool-70-16-208-44.man.east.myfairpoint.net. [70.16.208.44])
        by mx.google.com with ESMTPSA id t5sm20794999vde.8.2013.07.09.08.33.52
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jul 2013 08:33:52 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229961>

The function mkstemps() isn't available in all libc implementations. In
glibc it first became available in 2.11, so platforms such as RHEL 5 &
Slackware 13 lack it. This is likely true of many non-LINUX platforms
as well.

This fixes breakage that was introduced with a0fdac29 "Create temporary
file with name as suffix."

Signed-off-by: Drew Northup <n1xim.email@gmail.com>
---

This work-around is taken from Git and was inspired by code in libiberty.
It is presumed that this isn't a problem due to compatible license terms.

A (virtually identical) version of this available in
https://github.com/n1xim/tig/tree/mkstemps_wkarnd (differences only in
the commit message).

 configure.ac |  4 ++++
 io.c         | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 io.h         | 14 +++++++++++
 3 files changed, 95 insertions(+)

diff --git a/configure.ac b/configure.ac
index 8dd2508..40e1f85 100644
--- a/configure.ac
+++ b/configure.ac
@@ -21,6 +21,10 @@ AC_SUBST(CURSES_LIB)
 
 AM_ICONV
 
+dnl  Not all platforms have mkstemps
+AC_CHECK_FUNC([mkstemps], [AC_DEFINE([HAVE_MKSTEMPS], [1],
+	      [Define if mkstemps is available.])])
+
 AC_PROG_CC
 
 AC_CHECK_PROGS(ASCIIDOC, [asciidoc], [false])
diff --git a/io.c b/io.c
index 3ff1d1c..f1b6fbc 100644
--- a/io.c
+++ b/io.c
@@ -237,6 +237,83 @@ encoding_convert(struct encoding *encoding, char *line)
 }
 
 /*
+ * Compatibility: no mkstemps()
+ */
+
+/* Adapted from libiberty's mkstemp.c via Git's wrapper.c. */
+
+#undef TMP_MAX
+#define TMP_MAX 16384
+
+int tig_mkstemps_mode(char *pattern, int suffix_len, int mode)
+{
+	static const char letters[] =
+		"abcdefghijklmnopqrstuvwxyz"
+		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
+		"0123456789";
+	static const int num_letters = 62;
+	uint64_t value;
+	struct timeval tv;
+	char *template;
+	size_t len;
+	int fd, count;
+
+	len = strlen(pattern);
+
+	if (len < 6 + suffix_len) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	if (strncmp(&pattern[len - 6 - suffix_len], "XXXXXX", 6)) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/*
+	 * Replace pattern's XXXXXX characters with randomness.
+	 * Try TMP_MAX different filenames.
+	 */
+	gettimeofday(&tv, NULL);
+	value = ((size_t)(tv.tv_usec << 16)) ^ tv.tv_sec ^ getpid();
+	template = &pattern[len - 6 - suffix_len];
+	for (count = 0; count < TMP_MAX; ++count) {
+		uint64_t v = value;
+		/* Fill in the random bits. */
+		template[0] = letters[v % num_letters]; v /= num_letters;
+		template[1] = letters[v % num_letters]; v /= num_letters;
+		template[2] = letters[v % num_letters]; v /= num_letters;
+		template[3] = letters[v % num_letters]; v /= num_letters;
+		template[4] = letters[v % num_letters]; v /= num_letters;
+		template[5] = letters[v % num_letters]; v /= num_letters;
+
+		fd = open(pattern, O_CREAT | O_EXCL | O_RDWR, mode);
+		if (fd > 0)
+			return fd;
+		/*
+		 * Fatal error (EPERM, ENOSPC etc).
+		 * It doesn't make sense to loop.
+		 */
+		if (errno != EEXIST)
+			break;
+		/*
+		 * This is a random value.  It is only necessary that
+		 * the next TMP_MAX values generated by adding 7777 to
+		 * VALUE are different with (module 2^32).
+		 */
+		value += 7777;
+	}
+	/* We return the null string if we can't find a unique file name.  */
+	pattern[0] = '\0';
+	return -1;
+}
+
+int tigmkstemps(char *pattern, int suffix_len)
+{
+	return tig_mkstemps_mode(pattern, suffix_len, 0600);
+}
+
+/*
  * Executing external commands.
  */
 
diff --git a/io.h b/io.h
index 646989d..8f43216 100644
--- a/io.h
+++ b/io.h
@@ -16,6 +16,9 @@
 
 #include "tig.h"
 
+/* Needed for mkstemps workaround */
+#include <stdint.h>
+
 /*
  * Argument array helpers.
  */
@@ -41,6 +44,17 @@ struct encoding *encoding_open(const char *fromcode);
 char *encoding_convert(struct encoding *encoding, char *line);
 
 /*
+ * Compatibility: no mkstemps()
+ */
+
+#ifndef HAVE_MKSTEMPS
+#define mkstemps tigmkstemps
+#endif
+
+int tigmkstemps(char *, int);
+int tig_mkstemps_mode(char *pattern, int suffix_len, int mode);
+
+/*
  * Executing external commands.
  */
 
-- 
1.8.0
