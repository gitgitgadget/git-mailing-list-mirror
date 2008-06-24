From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/2] Introduce leaky().
Date: Tue, 24 Jun 2008 22:14:33 +0200
Message-ID: <1214338474-16822-2-git-send-email-madcoder@debian.org>
References: <1214338474-16822-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 22:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEvP-0001UV-Bx
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461AbYFXUOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbYFXUOl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:14:41 -0400
Received: from pan.madism.org ([88.191.52.104]:55491 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752893AbYFXUOh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:14:37 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 302153830E;
	Tue, 24 Jun 2008 22:14:36 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4799F3574FF; Tue, 24 Jun 2008 22:14:34 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.119.gbb8cf
In-Reply-To: <1214338474-16822-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86137>

This can be used to mark allocated memory as a "leak". This can be used to
collect memory at the exit of the command, so that tools like valgrind can
be used to check for actual memory leak without noise.

COLLECT_LEAKS_AT_EXIT must be set to that purpose, else 'leaky' is the
transparent macro.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 Makefile |    5 +++++
 alloc.c  |   20 ++++++++++++++++++++
 cache.h  |    5 +++++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 9c16482..6be15c8 100644
--- a/Makefile
+++ b/Makefile
@@ -151,6 +151,8 @@ all::
 # Define NO_EXTERNAL_GREP if you don't want "git grep" to ever call
 # your external grep (e.g., if your system lacks grep, if its grep is
 # broken, or spawning external process is slower than built-in grep git has).
+#
+# Define COLLECT_LEAKS_AT_EXIT if you want memory marked as leaky() at exit.
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -947,6 +949,9 @@ endif
 ifdef NO_EXTERNAL_GREP
 	BASIC_CFLAGS += -DNO_EXTERNAL_GREP
 endif
+ifdef COLLECT_LEAKS_AT_EXIT
+	BASIC_CFLAGS += -DCOLLECT_LEAKS_AT_EXIT
+endif
 
 ifeq ($(TCLTK_PATH),)
 NO_TCLTK=NoThanks
diff --git a/alloc.c b/alloc.c
index 216c23a..1afe810 100644
--- a/alloc.c
+++ b/alloc.c
@@ -74,3 +74,23 @@ void alloc_report(void)
 	REPORT(commit);
 	REPORT(tag);
 }
+
+#ifdef COLLECT_LEAKS_AT_EXIT
+static void **leaks;
+int leaknb, leaksz;
+
+static void release_leaks(void)
+{
+	while (leaknb-- > 0)
+		free(*leaks++);
+	free(leaks);
+}
+
+void *leaky(void *ptr)
+{
+	if (leaksz == 0)
+		atexit(&release_leaks);
+	ALLOC_GROW(leaks, leaknb + 1, leaksz);
+	return leaks[leaknb++] = ptr;
+}
+#endif
diff --git a/cache.h b/cache.h
index 101ead5..33603bb 100644
--- a/cache.h
+++ b/cache.h
@@ -777,6 +777,11 @@ int decode_85(char *dst, const char *line, int linelen);
 void encode_85(char *buf, const unsigned char *data, int bytes);
 
 /* alloc.c */
+#ifdef COLLECT_LEAKS_AT_EXIT
+extern void *leaky(void *);
+#else
+# define leaky(x) x
+#endif
 extern void *alloc_blob_node(void);
 extern void *alloc_tree_node(void);
 extern void *alloc_commit_node(void);
-- 
1.5.6.120.g3adb8.dirty
