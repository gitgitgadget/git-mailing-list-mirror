From: Mark Junker <mjscod@web.de>
Subject: [PATCH] Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8
Date: Mon, 21 Jan 2008 10:12:09 +0100
Message-ID: <fn1nl6$ek5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 10:30:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGsza-0006Cb-1I
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 10:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270AbYAUJaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 04:30:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbYAUJaI
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 04:30:08 -0500
Received: from main.gmane.org ([80.91.229.2]:40551 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757443AbYAUJaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 04:30:06 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1JGsyg-0001n4-QQ
	for git@vger.kernel.org; Mon, 21 Jan 2008 09:30:02 +0000
Received: from 80.146.179.234 ([80.146.179.234])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 09:30:02 +0000
Received: from mjscod by 80.146.179.234 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 09:30:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 80.146.179.234
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X; de; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71244>

Use FIX_UTF8_MAC to enable conversion from UTF8-MAC to UTF8 for readdir 
and get_pathspec.

I had to change get_pathspec too because otherwise git-add wouldn't work 
anymore because it uses the output of get_pathspec as strings to compare 
with the output of readdir.

I'm quite unsure because this is my first patch for the git project and 
I have several questions:

1. Is FIX_UTF8_MAC the right name for this "feature"?
2. Do I have to introduce a configuration option for this "feature"?

Signed-off-by: Mark Junker <mjscod@web.de>
---
  Makefile          |    5 +++++
  compat/readdir.c  |   26 ++++++++++++++++++++++++++
  git-compat-util.h |    5 +++++
  setup.c           |   12 ++++++++++++
  4 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5aac0c0..e55914e 100644
--- a/Makefile
+++ b/Makefile
@@ -417,6 +417,7 @@ ifeq ($(uname_S),Darwin)
  	endif
  	NO_STRLCPY = YesPlease
  	NO_MEMMEM = YesPlease
+	FIX_UTF8_MAC = YesPlease
  endif
  ifeq ($(uname_S),SunOS)
  	NEEDS_SOCKET = YesPlease
@@ -616,6 +617,10 @@ ifdef NO_STRLCPY
  	COMPAT_CFLAGS += -DNO_STRLCPY
  	COMPAT_OBJS += compat/strlcpy.o
  endif
+ifdef FIX_UTF8_MAC
+	COMPAT_CFLAGS += -DFIX_UTF8_MAC
+	COMPAT_OBJS += compat/readdir.o
+endif
  ifdef NO_STRTOUMAX
  	COMPAT_CFLAGS += -DNO_STRTOUMAX
  	COMPAT_OBJS += compat/strtoumax.o
diff --git a/compat/readdir.c b/compat/readdir.c
new file mode 100644
index 0000000..045cfef
--- /dev/null
+++ b/compat/readdir.c
@@ -0,0 +1,26 @@
+#include "../git-compat-util.h"
+#include "../utf8.h"
+
+#undef readdir
+
+static struct dirent temp;
+
+struct dirent *gitreaddir(DIR *dirp)
+{
+	size_t utf8_len;
+	char *utf8;
+	struct dirent *result;
+	result = readdir(dirp);
+	if (result != NULL) {
+		memcpy(&temp, result, sizeof(struct dirent));
+		utf8 = reencode_string(temp.d_name, "UTF8", "UTF8-MAC");
+		if (utf8 != NULL) {
+			utf8_len = strlen(utf8);
+			temp.d_namlen = (u_int8_t) utf8_len;
+			memcpy(temp.d_name, utf8, utf8_len + 1);
+			free(utf8);
+			result = &temp;
+		}
+	}
+	return result;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index b6ef544..cd0233d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -202,6 +202,11 @@ void *gitmemmem(const void *haystack, size_t 
haystacklen,
                  const void *needle, size_t needlelen);
  #endif

+#ifdef FIX_UTF8_MAC
+#define readdir gitreaddir
+struct dirent *gitreaddir(DIR *dirp);
+#endif
+
  #ifdef __GLIBC_PREREQ
  #if __GLIBC_PREREQ(2, 1)
  #define HAVE_STRCHRNUL
diff --git a/setup.c b/setup.c
index adede16..4cec28b 100644
--- a/setup.c
+++ b/setup.c
@@ -1,5 +1,8 @@
  #include "cache.h"
  #include "dir.h"
+#ifdef FIX_UTF8_MAC
+#include "utf8.h"
+#endif

  static int inside_git_dir = -1;
  static int inside_work_tree = -1;
@@ -131,6 +134,15 @@ const char **get_pathspec(const char *prefix, const 
char **pathspec)
  	p = pathspec;
  	prefixlen = prefix ? strlen(prefix) : 0;
  	do {
+#ifdef FIX_UTF8_MAC
+		/* Reencode as UTF8 (composed) to have a counterpart for the
+		 * readdir-replacement on MacOS X.
+		 */
+		char *utf8 = reencode_string(entry, "UTF8", "UTF8-MAC");
+		if (utf8 != NULL) {
+			entry = utf8;
+		}
+#endif
  		*p = prefix_path(prefix, prefixlen, entry);
  	} while ((entry = *++p) != NULL);
  	return (const char **) pathspec;
-- 
1.5.4.rc3.40.gebe4
