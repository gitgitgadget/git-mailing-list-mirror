From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/8] git-apply: work from subdirectory.
Date: Sat, 26 Nov 2005 01:56:32 -0800
Message-ID: <7viruf68bz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0511200935081.13959@g5.osdl.org>
	<200511210026.30280.Josef.Weidendorfer@gmx.de>
	<200511221831.03954.Josef.Weidendorfer@gmx.de>
	<Pine.LNX.4.63.0511221854120.27872@wbgn013.biozentrum.uni-wuerzburg.de>
	<438371E8.2030701@op5.se>
	<Pine.LNX.4.63.0511231553390.8191@wbgn013.biozentrum.uni-wuerzburg.de>
	<7viruj3q7z.fsf@assigned-by-dhcp.cox.net> <4384FB61.40506@op5.se>
	<Pine.LNX.4.63.0511240042350.11106@wbgn013.biozentrum.uni-wuerzburg.de>
	<43857430.7060103@op5.se> <7vsltmwiky.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241127020.12985@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xveth4l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511241419390.14297@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmzjtn3h1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0511242252080.26485@wbgn013.biozentrum.uni
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 10:57:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfwnP-0002JZ-6a
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 10:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKZJ4f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 04:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKZJ4e
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 04:56:34 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:35474 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbVKZJ4e (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 04:56:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051126095517.FABP17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 26 Nov 2005 04:55:17 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12772>

This adds three things:

 - prefix_filename() is like prefix_path() but can be used to
   name any file on the filesystem, not the files that might go
   into the index file.

 - git-apply uses setup_git_directory() to find out the GIT_DIR
   and reads configuration file.  Later this would allow us to
   affect the behaviour of the command from the configuration.

 - When git-apply is run from a subdirectory, it applies the
   given patch only to the files under the current directory and
   below.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 apply.c |   15 +++++++++++++++
 cache.h |    1 +
 setup.c |   15 +++++++++++++++
 3 files changed, 31 insertions(+), 0 deletions(-)

applies-to: 9ccf8849fa9b522a344645c2f28f12ab036e30d5
c20b8d006edfa964b3df5e4c5cc28cb93edcb240
diff --git a/apply.c b/apply.c
index 50be8f3..ae06d41 100644
--- a/apply.c
+++ b/apply.c
@@ -16,6 +16,9 @@
 //  --numstat does numeric diffstat, and doesn't actually apply
 //  --index-info shows the old and new index info for paths if available.
 //
+static const char *prefix;
+static int prefix_length;
+
 static int allow_binary_replacement = 0;
 static int check_index = 0;
 static int write_index = 0;
@@ -1706,6 +1709,12 @@ static int use_patch(struct patch *p)
 			return 0;
 		x = x->next;
 	}
+	if (prefix && *prefix) {
+		int pathlen = strlen(pathname);
+		if (pathlen <= prefix_length ||
+		    memcmp(prefix, pathname, prefix_length))
+			return 0;
+	}
 	return 1;
 }
 
@@ -1784,6 +1793,10 @@ int main(int argc, char **argv)
 	int i;
 	int read_stdin = 1;
 
+	prefix = setup_git_directory();
+	prefix_length = prefix ? strlen(prefix) : 0;
+	git_config(git_default_config);
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		int fd;
@@ -1845,6 +1858,8 @@ int main(int argc, char **argv)
 			line_termination = 0;
 			continue;
 		}
+		arg = prefix_filename(prefix, prefix_length, arg);
+
 		fd = open(arg, O_RDONLY);
 		if (fd < 0)
 			usage(apply_usage);
diff --git a/cache.h b/cache.h
index 6ac94c5..62920ce 100644
--- a/cache.h
+++ b/cache.h
@@ -149,6 +149,7 @@ extern char *get_graft_file(void);
 extern const char **get_pathspec(const char *prefix, const char **pathspec);
 extern const char *setup_git_directory(void);
 extern const char *prefix_path(const char *prefix, int len, const char *path);
+extern const char *prefix_filename(const char *prefix, int len, const char *path);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
diff --git a/setup.c b/setup.c
index ab3c778..54f6a34 100644
--- a/setup.c
+++ b/setup.c
@@ -47,6 +47,21 @@ const char *prefix_path(const char *pref
 	return path;
 }
 
+/* 
+ * Unlike prefix_path, this should be used if the named file does
+ * not have to interact with index entry; i.e. name of a random file
+ * on the filesystem.
+ */
+const char *prefix_filename(const char *pfx, int pfx_len, const char *arg)
+{
+	static char path[PATH_MAX];
+	if (!pfx || !*pfx || arg[0] == '/')
+		return arg;
+	memcpy(path, pfx, pfx_len);
+	strcpy(path + pfx_len, arg);
+	return path;
+}
+
 const char **get_pathspec(const char *prefix, const char **pathspec)
 {
 	const char *entry = *pathspec;
---
0.99.9.GIT
