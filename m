From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] introduce config core.binaryCheckFirstBytes for xdiff-interface
Date: Fri, 7 Sep 2007 19:14:21 +0000
Message-ID: <20070907191421.5526.qmail@f74fa18bc10c8f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjHQ-00067R-19
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:14:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758154AbXIGTOG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757509AbXIGTOF
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:14:05 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:38981 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752110AbXIGTOE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 15:14:04 -0400
Received: (qmail 5527 invoked by uid 1000); 7 Sep 2007 19:14:21 -0000
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58057>

xdiff-interface uses a hardcoded value of 8000 bytes to check from
the top of data whether to handle it as binary content.  If a NULL
character appears after the first 8000 bytes, git won't notice,
which for example breaks the git format-patch | git am pipeline in
git rebase, as reported by Jamey Sharp through
 http://bugs.debian.org/436182

This patch makes the hardcoded value configurable, so that users can
adjust the behavior when tracking binary files of huge sizes, e.g.
pdf's, in a repository.

Signed-off-by: Gerrit Pape <pape@smarden.org>
---
 Documentation/config.txt |    6 ++++++
 cache.h                  |    1 +
 config.c                 |    8 ++++++++
 environment.c            |    1 +
 xdiff-interface.c        |    5 ++---
 5 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 866e053..6c450ee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -275,6 +275,12 @@ You probably do not need to adjust this value.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
+core.binaryCheckFirstBytes::
+	Number of bytes of the top of data that should be checked to
+	decide whether the data must be handled as binary content, or
+	can be interpreted as text.  The default is 8000, when set to
+	zero, all available data is checked.
+
 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and
 	'.git/info/exclude', git looks into this file for patterns
diff --git a/cache.h b/cache.h
index 70abbd5..a9ca846 100644
--- a/cache.h
+++ b/cache.h
@@ -313,6 +313,7 @@ extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
+extern int binary_first_bytes;
 
 #define GIT_REPO_VERSION 0
 extern int repository_format_version;
diff --git a/config.c b/config.c
index dc3148d..892b2ff 100644
--- a/config.c
+++ b/config.c
@@ -395,6 +395,14 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.binarycheckfirstbytes")) {
+		int bytes = git_config_int(var, value);
+		if (bytes < 0)
+			die("bad value for core.binaryCheckFirstBytes %d", bytes);
+		binary_first_bytes = bytes;
+		return 0;
+	}
+
 	if (!strcmp(var, "user.name")) {
 		strlcpy(git_default_name, value, sizeof(git_default_name));
 		return 0;
diff --git a/environment.c b/environment.c
index b5a6c69..dd072b9 100644
--- a/environment.c
+++ b/environment.c
@@ -35,6 +35,7 @@ int pager_in_use;
 int pager_use_color = 1;
 char *editor_program;
 int auto_crlf = 0;	/* 1: both ways, -1: only when adding git objects */
+int binary_first_bytes = 8000;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/xdiff-interface.c b/xdiff-interface.c
index be866d1..dba0232 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -122,11 +122,10 @@ int read_mmfile(mmfile_t *ptr, const char *filename)
 	return 0;
 }
 
-#define FIRST_FEW_BYTES 8000
 int buffer_is_binary(const char *ptr, unsigned long size)
 {
-	if (FIRST_FEW_BYTES < size)
-		size = FIRST_FEW_BYTES;
+	if (binary_first_bytes && (binary_first_bytes < size))
+		size = binary_first_bytes;
 	return !!memchr(ptr, 0, size);
 }
 
-- 
1.5.3.1
