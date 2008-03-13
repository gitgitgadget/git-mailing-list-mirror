From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 00:56:30 -0700
Message-ID: <7vy78nxdjl.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213916.GK26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:57:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZiJa-0004bs-7O
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbYCMH4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbYCMH4j
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:56:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32882 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbYCMH4i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:56:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 372982FD3;
	Thu, 13 Mar 2008 03:56:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 4D5672FD2; Thu, 13 Mar 2008 03:56:32 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77052>

There is one more reason other than you said in the Makefile patch one
might want to avoid external grep.  Cygwin may have perfectly well working
grep, but the reason they avoid external grep is because forking is too
slow there.

---

 Makefile       |    5 ++---
 builtin-grep.c |   12 ++++++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 8e80225..bc46fd4 100644
--- a/Makefile
+++ b/Makefile
@@ -149,8 +149,8 @@ all::
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
 # Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
-# your external grep (e.g., if your system lacks grep, or if its grep is
-# not very featureful).
+# your external grep (e.g., if your system lacks grep, if its grep is
+# broken, or spawning external process is slower than built-in grep git has).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -470,7 +470,6 @@ ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
-	NO_EXTERNAL_GREP = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
diff --git a/builtin-grep.c b/builtin-grep.c
index f215b28..ef29910 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -12,6 +12,14 @@
 #include "builtin.h"
 #include "grep.h"
 
+#ifndef NO_EXTERNAL_GREP
+#ifdef __unix__
+#define NO_EXTERNAL_GREP 0
+#else
+#define NO_EXTERNAL_GREP 1
+#endif
+#endif
+
 /*
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
@@ -153,7 +161,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	return i;
 }
 
-#ifndef NO_EXTERNAL_GREP
+#if !NO_EXTERNAL_GREP
 static int exec_grep(int argc, const char **argv)
 {
 	pid_t pid;
@@ -372,7 +380,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 	int nr;
 	read_cache();
 
-#ifndef NO_EXTERNAL_GREP
+#if !NO_EXTERNAL_GREP
 	/*
 	 * Use the external "grep" command for the case where
 	 * we grep through the checked-out files. It tends to
