From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH 2/2] Windows: Skip fstat/lstat optimization in write_entry()
Date: Mon, 20 Apr 2009 10:17:00 +0200
Message-ID: <49EC2F7C.8070209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 10:18:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvoiC-0001PE-JN
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 10:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbZDTIRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 04:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbZDTIRK
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 04:17:10 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29022 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbZDTIRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 04:17:09 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LvogT-00024B-2a; Mon, 20 Apr 2009 10:17:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0F1084E4; Mon, 20 Apr 2009 10:16:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116946>

From: Johannes Sixt <j6t@kdbg.org>

Commit e4c72923 (write_entry(): use fstat() instead of lstat() when file
is open, 2009-02-09) introduced an optimization of write_entry().
Unfortunately, we cannot take advantage of this optimization on Windows
because there is no guarantee that the time stamps are updated before the
file is closed:

  "The only guarantee about a file timestamp is that the file time is
   correctly reflected when the handle that makes the change is closed."

(http://msdn.microsoft.com/en-us/library/ms724290(VS.85).aspx)

The failure of this optimization on Windows can be observed most easily by
running a 'git checkout' that has to update several large files. In this
case, 'git checkout' will report modified files, but infact only the
timestamps were incorrectly recorded in the index, as can be verified by a
subsequent 'git diff', which shows no change.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 My gut feeling was right: We cannot have this optimization on Windows.

 http://thread.gmane.org/gmane.comp.version-control.git/108351/focus=108357

 I've a repository where I can reproduce the error quite easily and this
 fixes it.

 -- Hannes (who forgot to add Dscho and git@vger on the first send attempt)

 Makefile          |    8 ++++++++
 entry.c           |    3 ++-
 git-compat-util.h |    6 ++++++
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 076a732..a01d603 100644
--- a/Makefile
+++ b/Makefile
@@ -167,6 +167,10 @@ all::
 # Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
 # your external grep (e.g., if your system lacks grep, if its grep is
 # broken, or spawning external process is slower than built-in grep git has).
+#
+# Define UNRELIABLE_FSTAT if your system's fstat does not return the same
+# information on a not yet closed file that lstat would return for the same
+# file after it was closed.

 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -833,6 +837,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
+	UNRELIABLE_FSTAT = UnfortunatelyYes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -1111,6 +1116,9 @@ endif
 ifdef NO_EXTERNAL_GREP
 	BASIC_CFLAGS += -DNO_EXTERNAL_GREP
 endif
+ifdef UNRELIABLE_FSTAT
+	BASIC_CFLAGS += -DUNRELIABLE_FSTAT
+endif

 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/entry.c b/entry.c
index 5daacc2..915514a 100644
--- a/entry.c
+++ b/entry.c
@@ -147,7 +147,8 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout

 		wrote = write_in_full(fd, new, size);
 		/* use fstat() only when path == ce->name */
-		if (state->refresh_cache && !to_tempfile && !state->base_dir_len) {
+		if (fstat_is_reliable() &&
+		    state->refresh_cache && !to_tempfile && !state->base_dir_len) {
 			fstat(fd, &st);
 			fstat_done = 1;
 		}
diff --git a/git-compat-util.h b/git-compat-util.h
index d94c683..bf00f35 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -409,4 +409,10 @@ void git_qsort(void *base, size_t nmemb, size_t size,
 #endif
 #endif

+#ifdef UNRELIABLE_FSTAT
+#define fstat_is_reliable() 0
+#else
+#define fstat_is_reliable() 1
+#endif
+
 #endif

-- 
1.6.3.rc1.989.ga175e.dirty
