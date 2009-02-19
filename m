From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 1/2] Introduce the function strip_path_suffix()
Date: Thu, 19 Feb 2009 20:10:49 +0100 (CET)
Message-ID: <f6344cbba22e049806796f4920e229fb2e539d5c.1235070304u.git.johannes.schindelin@gmx.de>
References: <499C63E7.5040306@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 19 20:11:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaEIm-0000pR-29
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 20:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbZBSTJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 14:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752134AbZBSTJt
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 14:09:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:47722 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752062AbZBSTJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 14:09:49 -0500
Received: (qmail invoked by alias); 19 Feb 2009 19:09:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp065) with SMTP; 19 Feb 2009 20:09:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180yYZ6IRw0sV02tN1gUPNXO10f2PIwZ0BbDMNQBv
	2e3AoO1L5BmspK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C63E7.5040306@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110731>

The function strip_path_suffix() will try to strip a given suffix from 
a given path.  The suffix must start at a directory boundary (i.e. "core" 
is not a path suffix of "libexec/git-core", but "git-core" is).

Arbitrary runs of directory separators ("slashes") are assumed identical.

Example:

	strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
		"libexec///git-core", &prefix)

will set prefix to "C:\\msysgit" and return 0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h               |    1 +
 path.c                |   32 ++++++++++++++++++++++++++++++++
 t/t0060-path-utils.sh |    4 ++++
 test-path-utils.c     |    6 ++++++
 4 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index c926bc7..1fa184d 100644
--- a/cache.h
+++ b/cache.h
@@ -630,6 +630,7 @@ const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
+char *strip_path_suffix(const char *path, const char *suffix);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 4b9107f..2030bf1 100644
--- a/path.c
+++ b/path.c
@@ -499,3 +499,35 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 
 	return max_len;
 }
+
+/* strip arbitrary amount of directory separators at end of path */
+static inline int chomp_trailing_dir_sep(const char *path, int len)
+{
+	while (len && is_dir_sep(path[len - 1]))
+		len--;
+	return len;
+}
+
+/* sets prefix if the suffix matches */
+char *strip_path_suffix(const char *path, const char *suffix)
+{
+	int path_len = strlen(path), suffix_len = strlen(suffix);
+
+	while (suffix_len) {
+		if (!path_len)
+			return NULL;
+
+		if (is_dir_sep(path[path_len - 1])) {
+			if (!is_dir_sep(suffix[suffix_len - 1]))
+				return NULL;
+			path_len = chomp_trailing_dir_sep(path, path_len);
+			suffix_len = chomp_trailing_dir_sep(suffix, suffix_len);
+		}
+		else if (path[--path_len] != suffix[--suffix_len])
+			return NULL;
+	}
+
+	if (path_len && !is_dir_sep(path[path_len - 1]))
+		return NULL;
+	return xstrndup(path, chomp_trailing_dir_sep(path, path_len));
+}
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 4ed1f0b..8336114 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -85,4 +85,8 @@ ancestor /foo/bar :://foo/.:: 4
 ancestor /foo/bar //foo/./::/bar 4
 ancestor /foo/bar ::/bar -1
 
+test_expect_success 'strip_path_suffix' '
+	test c:/msysgit = $(test-path-utils strip_path_suffix \
+		c:/msysgit/libexec//git-core libexec/git-core)
+'
 test_done
diff --git a/test-path-utils.c b/test-path-utils.c
index 5168a8e..d261398 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -26,6 +26,12 @@ int main(int argc, char **argv)
 		return 0;
 	}
 
+	if (argc == 4 && !strcmp(argv[1], "strip_path_suffix")) {
+		char *prefix = strip_path_suffix(argv[2], argv[3]);
+		printf("%s\n", prefix ? prefix : "(null)");
+		return 0;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
1.6.2.rc1.380.g0299c
