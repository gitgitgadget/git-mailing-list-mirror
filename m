From: Jeff King <peff@peff.net>
Subject: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Wed, 12 Mar 2008 17:39:16 -0400
Message-ID: <20080312213916.GK26286@coredump.intra.peff.net>
References: <cover.1205356737.git.peff@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 22:40:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZYgc-0001xY-C4
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 22:40:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755411AbYCLVjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 17:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755395AbYCLVjT
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 17:39:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3445 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755314AbYCLVjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 17:39:18 -0400
Received: (qmail 3429 invoked by uid 111); 12 Mar 2008 21:39:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 17:39:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 17:39:16 -0400
Content-Disposition: inline
In-Reply-To: <cover.1205356737.git.peff@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77001>

Previously, we just chose whether to allow external grep
based on the __unix__ define. However, there are systems
which define this macro but which have an inferior group
(e.g., one that does not support all options used by t7002).
This allows users to accept the potential speed penalty to
get a more consistent grep experience (and to pass the
testsuite).

Signed-off-by: Jeff King <peff@peff.net>
---
This might have fallouts for msysgit (i.e., they need to define
NO_EXTERNAL_GREP instead of relying on __unix__ not being defined).

 Makefile       |    7 +++++++
 builtin-grep.c |    4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index e3eaa6a..8e80225 100644
--- a/Makefile
+++ b/Makefile
@@ -148,6 +148,9 @@ all::
 # is a simplified version of the merge sort used in glibc. This is
 # recommended if Git triggers O(n^2) behavior in your platform's qsort().
 #
+# Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
+# your external grep (e.g., if your system lacks grep, or if its grep is
+# not very featureful).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -467,6 +470,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
+	NO_EXTERNAL_GREP = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
 	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
@@ -760,6 +764,9 @@ endif
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
+ifdef NO_EXTERNAL_GREP
+	BASIC_CFLAGS += -DNO_EXTERNAL_GREP
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/builtin-grep.c b/builtin-grep.c
index f4f4ecb..f215b28 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -153,7 +153,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	return i;
 }
 
-#ifdef __unix__
+#ifndef NO_EXTERNAL_GREP
 static int exec_grep(int argc, const char **argv)
 {
 	pid_t pid;
@@ -372,7 +372,7 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 	int nr;
 	read_cache();
 
-#ifdef __unix__
+#ifndef NO_EXTERNAL_GREP
 	/*
 	 * Use the external "grep" command for the case where
 	 * we grep through the checked-out files. It tends to
-- 
1.5.4.4.543.g30fdd.dirty
