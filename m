From: =?ISO-8859-1?Q?Andreas_F=E4rber?= <andreas.faerber@web.de>
Subject: [PATCH 4/6] Don't use struct stat's st_blocks member on Haiku
Date: Sun, 17 Aug 2008 10:59:35 +0200
Message-ID: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 17 11:01:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUe8Q-00063t-Ts
	for gcvg-git-2@gmane.org; Sun, 17 Aug 2008 11:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbYHQJAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2008 05:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752276AbYHQJAA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Aug 2008 05:00:00 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:59925 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbYHQI77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2008 04:59:59 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id C01FAE8FCFDC;
	Sun, 17 Aug 2008 10:59:57 +0200 (CEST)
Received: from [91.18.70.145] (helo=[10.0.1.1])
	by smtp06.web.de with asmtp (TLSv1:AES128-SHA:128)
	(WEB.DE 4.109 #226)
	id 1KUe7B-0001NS-00; Sun, 17 Aug 2008 10:59:57 +0200
X-Mailer: Apple Mail (2.926)
X-Sender: Andreas.Faerber@web.de
X-Provags-ID: V01U2FsdGVkX1/Izjr9dBffysg0kvtxEQDCdvVi3bBW7gYyb7g0
	x8qBPXoWQAgroBtF5l9ScNaJtVYkO8sB1NhEjDpb5O73nOyHZJ
	x6edCATczAV3kFqPU6zA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92588>

Signed-off-by: Andreas Faerber <andreas.faerber@web.de>
Signed-off-by: Ingo Weinhold <ingo_weinhold@gmx.de>
---
BeOS didn't have that field, so neither has Haiku currently.
It is part of the optional XSI POSIX feature.

  Makefile                |    4 ++++
  builtin-count-objects.c |    4 ++++
  configure.ac            |    8 ++++++++
  3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 5dba2c7..a4d73fc 100644
--- a/Makefile
+++ b/Makefile
@@ -730,6 +730,7 @@ ifeq ($(uname_S),HP-UX)
  endif
  ifeq ($(uname_S),Haiku)
  	NO_IPV6 = YesPlease
+	NO_ST_BLOCKS_IN_STAT = YesPlease
  	EXTLIBS += -lnetwork
  endif
  ifneq (,$(findstring MINGW,$(uname_S)))
@@ -867,6 +868,9 @@ endif
  ifdef NO_D_INO_IN_DIRENT
  	BASIC_CFLAGS += -DNO_D_INO_IN_DIRENT
  endif
+ifdef NO_ST_BLOCKS_IN_STAT
+	BASIC_CFLAGS += -DNO_ST_BLOCKS_IN_STAT
+endif
  ifdef NO_C99_FORMAT
  	BASIC_CFLAGS += -DNO_C99_FORMAT
  endif
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index 91b5487..609c687 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -43,7 +43,11 @@ static void count_objects(DIR *d, char *path, int  
len, int verbose,
  			if (lstat(path, &st) || !S_ISREG(st.st_mode))
  				bad = 1;
  			else
+#ifdef NO_ST_BLOCKS_IN_STAT
+				(*loose_size) += (st.st_size + 511) / 512;
+#else
  				(*loose_size) += xsize_t(st.st_blocks);
+#endif
  		}
  		if (bad) {
  			if (verbose) {
diff --git a/configure.ac b/configure.ac
index 75ec83a..09d18ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -281,6 +281,14 @@ AC_CHECK_MEMBER(struct dirent.d_type,
  [#include <dirent.h>])
  AC_SUBST(NO_D_TYPE_IN_DIRENT)
  #
+# Define NO_ST_BLOCKS_IN_STAT if your platform does not have  
st_blocks in
+# struct stat (BeOS, Haiku).
+AC_CHECK_MEMBER(struct stat.st_blocks,
+[NO_ST_BLOCKS_IN_STAT=],
+[NO_ST_BLOCKS_IN_STAT=YesPlease],
+[#include <sys/stat.h>])
+AC_SUBST(NO_ST_BLOCKS_IN_STAT)
+#
  # Define NO_SOCKADDR_STORAGE if your platform does not have struct
  # sockaddr_storage.
  AC_CHECK_TYPE(struct sockaddr_storage,
-- 
1.6.0.rc3.32.g8aaa
