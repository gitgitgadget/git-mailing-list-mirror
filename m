From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 1/2] Introduce the function strip_path_suffix()
Date: Wed, 18 Feb 2009 16:11:04 +0100 (CET)
Message-ID: <7b5ee74d497bbb7144b8683725cd83c8bbd33f9a.1234969572u.git.johannes.schindelin@gmx.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>, Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Feb 18 16:13:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZo7B-0005Kd-33
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbZBRPLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbZBRPLJ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:11:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:38615 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754187AbZBRPLG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:11:06 -0500
Received: (qmail invoked by alias); 18 Feb 2009 15:11:05 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp059) with SMTP; 18 Feb 2009 16:11:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Bg6MLPPMB8/TQFPGIOS8Ufp3sU+1NH8MH00YrX8
	KO2F26YY34Cz8H
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <cover.1234969572u.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110551>

The function strip_path_suffix() will try to split the given path into
prefix/suffix.  The suffix has to be passed to the function, and if the
path matches, the prefix is set.

Arbitrary runs of directory separators ("slashes") are assumed identical.

Example:

	strip_path_suffix("C:\\msysgit/\\libexec\\git-core",
		"libexec///git-core", &prefix)

will set prefix to "C:\\msysgit" and return 0.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 cache.h |    2 ++
 path.c  |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/cache.h b/cache.h
index 4e28c24..2186143 100644
--- a/cache.h
+++ b/cache.h
@@ -629,6 +629,8 @@ const char *make_nonrelative_path(const char *path);
 const char *make_relative_path(const char *abs, const char *base);
 int normalize_path_copy(char *dst, const char *src);
 int longest_ancestor_length(const char *path, const char *prefix_list);
+int strip_path_suffix(const char *path, const char *suffix,
+		const char **prefix);
 
 /* Read and unpack a sha1 file into memory, write memory to a sha1 file */
 extern int sha1_object_info(const unsigned char *, unsigned long *);
diff --git a/path.c b/path.c
index 4b9107f..947e5b7 100644
--- a/path.c
+++ b/path.c
@@ -499,3 +499,36 @@ int longest_ancestor_length(const char *path, const char *prefix_list)
 
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
+int strip_path_suffix(const char *path, const char *suffix, const char **prefix)
+{
+	int path_len = strlen(path), suffix_len = strlen(suffix);
+
+	while (suffix_len) {
+		if (!path_len)
+			return 1;
+
+		if (is_dir_sep(path[path_len - 1])) {
+			if (!is_dir_sep(suffix[suffix_len - 1]))
+				return 1;
+			path_len = chomp_trailing_dir_sep(path, path_len);
+			suffix_len = chomp_trailing_dir_sep(suffix, suffix_len);
+		}
+		else if (path[--path_len] != suffix[--suffix_len])
+			return 1;
+	}
+
+	if (path_len && !is_dir_sep(path[path_len - 1]))
+		return 1;
+	*prefix = xstrndup(path, chomp_trailing_dir_sep(path, path_len));
+	return 0;
+}
-- 
1.6.1.1.825.g72a9f
