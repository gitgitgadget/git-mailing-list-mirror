From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sat, 25 Apr 2009 11:57:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904251155130.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <200904232116.10769.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Apr 25 12:03:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lxeiq-0005GG-FP
	for gcvg-git-2@gmane.org; Sat, 25 Apr 2009 12:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbZDYJ5J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Apr 2009 05:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbZDYJ5I
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Apr 2009 05:57:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:48203 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752186AbZDYJ5G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Apr 2009 05:57:06 -0400
Received: (qmail invoked by alias); 25 Apr 2009 09:57:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 25 Apr 2009 11:57:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Fo/RsD63F50CJJObJ08eOH+/MLYZVzfPrWow1mg
	u/EK6F8/gQqfKD
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200904232116.10769.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117542>


It seems that accessing NTFS partitions with ufsd (at least on my EeePC)
has an unnerving bug: if you link() a file and unlink() it right away,
the target of the link() will have the correct size, but consist of NULs.

It seems as if the calls are simply not serialized correctly, as single-stepping
through the function move_temp_to_file() works flawlessly.

As ufsd is "Commertial software" (sic!), I cannot fix it, and have to work
around it in Git.

At the same time, it seems that this fixes msysGit issues 222 and 229 to
assume that Windows cannot handle link() && unlink().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Acked-by: Johannes Sixt <j6t@kdbg.org>
---

	On Thu, 23 Apr 2009, Johannes Sixt wrote:

	> +		ret = ~EEXIST;	/* anything but EEXIST */

	In addition to this, I also added the "(sic!)" for the "Commertial 
	software" tyop.  So I still dared to add your

	> Acked-by: Johannes Sixt <j6t@kdbg.org>

 Documentation/config.txt |    5 +++++
 Makefile                 |    8 ++++++++
 cache.h                  |    2 ++
 config.c                 |    5 +++++
 environment.c            |    4 ++++
 sha1_file.c              |    4 +++-
 6 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3188569..d31adb6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -429,6 +429,11 @@ relatively high IO latencies.  With this set to 'true', git will do the
 index comparison to the filesystem data in parallel, allowing
 overlapping IO's.
 
+core.unreliableHardlinks::
+	Some filesystem drivers cannot properly handle hardlinking a file
+	and deleting the source right away.  In such a case, you need to
+	set this config variable to 'true'.
+
 alias.*::
 	Command aliases for the linkgit:git[1] command wrapper - e.g.
 	after defining "alias.last = cat-file commit HEAD", the invocation
diff --git a/Makefile b/Makefile
index 6f602c7..5c8e83a 100644
--- a/Makefile
+++ b/Makefile
@@ -171,6 +171,10 @@ all::
 # Define UNRELIABLE_FSTAT if your system's fstat does not return the same
 # information on a not yet closed file that lstat would return for the same
 # file after it was closed.
+#
+# Define UNRELIABLE_HARDLINKS if your operating systems has problems when
+# hardlinking a file to another name and unlinking the original file right
+# away (some NTFS drivers seem to zero the contents in that scenario).
 
 GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -835,6 +839,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_NSEC = YesPlease
 	USE_WIN32_MMAP = YesPlease
 	UNRELIABLE_FSTAT = UnfortunatelyYes
+	UNRELIABLE_HARDLINKS = UnfortunatelySometimes
 	COMPAT_CFLAGS += -D__USE_MINGW_ACCESS -DNOGDI -Icompat -Icompat/regex -Icompat/fnmatch
 	COMPAT_CFLAGS += -DSNPRINTF_SIZE_CORR=1
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
@@ -1018,6 +1023,9 @@ else
 		COMPAT_OBJS += compat/win32mmap.o
 	endif
 endif
+ifdef UNRELIABLE_HARDLINKS
+	COMPAT_CFLAGS += -DUNRELIABLE_HARDLINKS=1
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
diff --git a/cache.h b/cache.h
index ab1294d..ff9e145 100644
--- a/cache.h
+++ b/cache.h
@@ -554,6 +554,8 @@ extern enum branch_track git_branch_track;
 extern enum rebase_setup_type autorebase;
 extern enum push_default_type push_default;
 
+extern int unreliable_hardlinks;
+
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
 extern int check_repository_format(void);
diff --git a/config.c b/config.c
index 8c1ae59..1750cfb 100644
--- a/config.c
+++ b/config.c
@@ -495,6 +495,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.unreliablehardlinks")) {
+		unreliable_hardlinks = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/environment.c b/environment.c
index 4696885..10578d2 100644
--- a/environment.c
+++ b/environment.c
@@ -43,6 +43,10 @@ unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
 enum push_default_type push_default = PUSH_DEFAULT_UNSPECIFIED;
+#ifndef UNRELIABLE_HARDLINKS
+#define UNRELIABLE_HARDLINKS 0
+#endif
+int unreliable_hardlinks = UNRELIABLE_HARDLINKS;
 
 /* Parallel index stat data preload? */
 int core_preload_index = 0;
diff --git a/sha1_file.c b/sha1_file.c
index 8fe135d..bb6eecf 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2225,7 +2225,9 @@ int move_temp_to_file(const char *tmpfile, const char *filename)
 {
 	int ret = 0;
 
-	if (link(tmpfile, filename))
+	if (unreliable_hardlinks)
+		ret = ~EEXIST; /* anything but EEXIST */
+	else if (link(tmpfile, filename))
 		ret = errno;
 
 	/*
-- 
1.6.2.1.613.g25746
