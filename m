From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Tue, 28 Apr 2009 00:32:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 28 00:32:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZN7-0000QF-Gu
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:32:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757542AbZD0WcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757494AbZD0WcN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:32:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:33216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757354AbZD0WcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:32:12 -0400
Received: (qmail invoked by alias); 27 Apr 2009 22:32:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 28 Apr 2009 00:32:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19bhScvhmFb3QJZHem/wghD1z6NJ0wDTiCXMn6TKK
	e6liMPsY72rZDh
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.42
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117723>


"Unreliable hardlinks" is a misleading description for what is happening.
So rename it to something less misleading.

Suggested by Linus Torvalds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 27 Apr 2009, Linus Torvalds wrote:

	> Maybe the config option shouldn't be a boolean, but a "how to 
	> instantiate objects". IOW, we could do
	> 
	> 	[core]
	> 		createobject = {link|rename}
	> 
	> instead. Maybe we some day could allow "inplace", for some 
	> totally broken system that supports neither renames nor links, and
	> just wants the object to be created with the final name to start
	> with.

	Here you go.  Only compile-tested.

 Documentation/config.txt |   12 ++++++++----
 Makefile                 |   10 +++++-----
 cache.h                  |    7 ++++++-
 config.c                 |    9 +++++++--
 environment.c            |    6 +++---
 sha1_file.c              |    2 +-
 6 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 83454c5..2c03162 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -429,10 +429,14 @@ relatively high IO latencies.  With this set to 'true', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
 
-core.unreliableHardlinks::
-	Some filesystem drivers cannot properly handle hardlinking a file
-	and deleting the source right away.  In such a case, you need to
-	set this config variable to 'true'.
+core.createObject::
+	You can set this to 'link', in which case a hardlink followed by
+	a delete of the source are used to make sure that object creation
+	will not overwrite existing objects.
++
+On some file system/operating system combinations, this is unreliable.
+Set this config setting to 'rename' there; However, This will remove the
+check that makes sure that existing object files will not get overwritten.
 
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
diff --git a/Makefile b/Makefile
index 5c8e83a..9ca1826 100644
--- a/Makefile
+++ b/Makefile
@@ -172,8 +172,8 @@ all::
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
 #
-# Define UNRELIABLE_HARDLINKS if your operating systems has problems when
-# hardlinking a file to another name and unlinking the original file right
+# Define OBJECT_CREATION_USES_RENAMES if your operating systems has problems
+# when hardlinking a file to another name and unlinking the original file right
 # away (some NTFS drivers seem to zero the contents in that scenario).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
@@ -839,7 +839,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
-	UNRELIABLE_HARDLINKS = UnfortunatelySometimes
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -1023,8 +1023,8 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
-ifdef UNRELIABLE_HARDLINKS
-	COMPAT_CFLAGS += -DUNRELIABLE_HARDLINKS=1
+ifdef OBJECT_CREATION_USES_RENAMES
+	COMPAT_CFLAGS += -DOBJECT_CREATION_MODE=1
 endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
diff --git a/cache.h b/cache.h
index ff9e145..d0d48b4 100644
--- a/cache.h
+++ b/cache.h
@@ -554,7 +554,12 @@ extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
 
-extern int unreliable_hardlinks;
+enum object_creation_mode {
+	OBJECT_CREATION_USES_HARDLINKS = 0,
+	OBJECT_CREATION_USES_RENAMES = 1,
+};
+
+extern enum object_creation_mode object_creation_mode;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index 1750cfb..876f0ed 100644
--- a/config.c
+++ b/config.c
@@ -495,8 +495,13 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
-	if (!strcmp(var, "core.unreliablehardlinks")) {
-		unreliable_hardlinks = git_config_bool(var, value);
+	if (!strcmp(var, "core.createobject")) {
+		if (!strcmp(value, "rename"))
+			object_creation_mode = OBJECT_CREATION_USES_RENAMES;
+		else if (!strcmp(value, "link"))
+			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
+		else
+			die ("Invalid mode for object creation: %s", value);
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 10578d2..801a005 100644
--- a/environment.c
+++ b/environment.c
@@ -43,10 +43,10 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
-#ifndef UNRELIABLE_HARDLINKS
-#define UNRELIABLE_HARDLINKS 0
+#ifndef OBJECT_CREATION_MODE
+#define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
-int unreliable_hardlinks = UNRELIABLE_HARDLINKS;
+enum object_creation_mode object_creation_mode = OBJECT_CREATION_MODE;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 11969fc..f708cf4 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2225,7 +2225,7 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
 
-	if (unreliable_hardlinks)
+	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
 		goto try_rename;
 	else if (link(tmpfile, filename))
 		ret = errno;
-- 
1.6.3.rc3.326.g039c1
