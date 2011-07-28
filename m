From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 28 Jul 2011 10:57:45 +0200
Message-ID: <1311843465.3734.40.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org>	<4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <BANLkTimsfR4LqDAci0Vr+m9uUE_W-7OSAw@mail.gmail.com>
	 <4E0A08AE.8090407@web.de>  <1311792580.2413.82.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 28 10:54:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmMMi-0007iU-Vf
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 10:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1G1Iym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 04:54:42 -0400
Received: from mail6.surf-town.net ([212.97.132.46]:51315 "EHLO
	mailgw12.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755263Ab1G1Iyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 04:54:40 -0400
Received: by mailgw12.surf-town.net (Postfix, from userid 65534)
	id 188A2138C3D; Thu, 28 Jul 2011 10:54:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw12.surf-town.net (Postfix) with ESMTP id DD4FA138BDC;
	Thu, 28 Jul 2011 10:54:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw12.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw12.surf-town.net ([127.0.0.1])
	by localhost (mailgw12.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id MID+P5NBEctn; Thu, 28 Jul 2011 10:54:32 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-48-110.w92-141.abo.wanadoo.fr [92.141.183.110])
	by mailgw12.surf-town.net (Postfix) with ESMTPSA id 5DE80138B90;
	Thu, 28 Jul 2011 10:54:27 +0200 (CEST)
In-Reply-To: <1311792580.2413.82.camel@Naugrim.eriador.com>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178050>

	Hello,

The same with some orthographique corrections by
Sverre Rabbelier <srabbelier@gmail.com> (unofficial)


>From 9a4e10fbb884583638c1651cc6cb98e0ce59cb9b Mon Sep 17 00:00:00 2001
From: Henri GEIST <henri@flying-robots.com>
Date: Thu, 28 Jul 2011 10:15:55 +0200
Subject: [PATCH] Enabeling (sub)modules linking out of repository.

Depending on there workflow some people needs to link there repository
to depend on external modules.
Just like library could be shared by different program and other libraries.
It's a means to track dependency between source code projects.

In the current code it was not possible to add a gitlink to a repository
outside of the main repository.

This pach :
  - Enables adding an external git directory.
  - Still forbids to add anything else.
  - Takes care of prohibitting git to overwrite any data outside of the
    current directory.
  - Increase some tests to validate the new feature.

This way you can have :
  - Project depending of multiple subprojects themselves depending on
    one third rank common suproject without clashing at compilation
    linking.
  - Confidence that all suproject use the same version of the third rank
    subproject (git status will tell you.)
  - All subproject and subsubproject could be easily worked on there one
    and synchronized after in the big project.

Signed-off-by: Henri GEIST <henri@flying-robots.com>
---
 builtin/clean.c       |    6 ++++--
 path.c                |   20 +++++++++++++++++---
 read-cache.c          |   14 ++++++++++++++
 setup.c               |   10 ++++++++--
 t/t0060-path-utils.sh |   16 ++++++++--------
 test-path-utils.c     |    6 ++++--
 6 files changed, 55 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 75697f7..e234e5d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -149,8 +149,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		if (S_ISDIR(st.st_mode)) {
 			strbuf_addstr(&directory, ent->name);
 			qname = quote_path_relative(directory.buf, directory.len, &buf, prefix);
-			if (show_only && (remove_directories ||
-			    (matches == MATCHED_EXACTLY))) {
+			if (!strncmp ("../", qname, 3)) {
+				die("'%s' is outside repository", qname);
+			} else if (show_only && (remove_directories ||
+				   (matches == MATCHED_EXACTLY))) {
 				printf(_("Would remove %s\n"), qname);
 			} else if (remove_directories ||
 				   (matches == MATCHED_EXACTLY)) {
diff --git a/path.c b/path.c
index 4d73cc9..daf1573 100644
--- a/path.c
+++ b/path.c
@@ -444,7 +444,8 @@ const char *relative_path(const char *abs, const char *base)
  * - Removes "." components.
  * - Removes ".." components, and the components the precede them.
  * Returns failure (non-zero) if a ".." component appears as first path
- * component anytime during the normalization. Otherwise, returns success (0).
+ * component but finish the normalization before.
+ * Otherwise, returns success (0).
  *
  * Note that this function is purely textual.  It does not follow symlinks,
  * verify the existence of the path, or make any system calls.
@@ -519,13 +520,26 @@ int normalize_path_copy(char *dst, const char *src)
 		 * go up one level.
 		 */
 		dst--;	/* go to trailing '/' */
-		if (dst <= dst0)
-			return -1;
+		if (dst <= dst0
+		    || (dst0 + 2 <= dst
+			&& dst[-1] == '.' && dst[-2] == '.'
+			&& (dst0 + 2 == dst || dst[-3] == '/'))) {
+			dst++;
+			*dst++ = '.';
+			*dst++ = '.';
+			*dst++ = '/';
+			continue;
+		}
 		/* Windows: dst[-1] cannot be backslash anymore */
 		while (dst0 < dst && dst[-1] != '/')
 			dst--;
 	}
 	*dst = '\0';
+	if (*dst0 == '/')
+		dst0++;
+	if (2 <= strlen (dst0)
+	    && dst0[0] == '.' && dst0[1] == '.' && dst0[2] == '/')
+		return -1;
 	return 0;
 }
 
diff --git a/read-cache.c b/read-cache.c
index 46a9e60..7fb695a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -753,6 +753,20 @@ static int verify_dotfile(const char *rest)
 int verify_path(const char *path)
 {
 	char c;
+	struct stat buf;
+
+	lstat (path, &buf);
+	if (buf.st_mode & S_IFDIR) {
+		for (;;) {
+			if (path[0] != '.')
+				break;
+			if (path[1] != '.')
+				break;
+			if (path[2] != '/')
+				break;
+			path += 3;
+		}
+	}
 
 	if (has_dos_drive_prefix(path))
 		return 0;
diff --git a/setup.c b/setup.c
index 5ea5502..ce7993e 100644
--- a/setup.c
+++ b/setup.c
@@ -8,6 +8,8 @@ char *prefix_path(const char *prefix, int len, const char *path)
 {
 	const char *orig = path;
 	char *sanitized;
+	struct stat buf;
+
 	if (is_absolute_path(orig)) {
 		const char *temp = real_path(path);
 		sanitized = xmalloc(len + strlen(temp) + 1);
@@ -18,8 +20,12 @@ char *prefix_path(const char *prefix, int len, const char *path)
 			memcpy(sanitized, prefix, len);
 		strcpy(sanitized + len, path);
 	}
-	if (normalize_path_copy(sanitized, sanitized))
-		goto error_out;
+	if (normalize_path_copy(sanitized, sanitized)) {
+		if (0 != lstat(sanitized, &buf))
+			goto error_out;
+		if (!(buf.st_mode & S_IFDIR))
+			goto error_out;
+	}
 	if (is_absolute_path(orig)) {
 		size_t root_len, len, total;
 		const char *work_tree = get_git_work_tree();
diff --git a/t/t0060-path-utils.sh b/t/t0060-path-utils.sh
index 53cf1f8..b4b9b1f 100755
--- a/t/t0060-path-utils.sh
+++ b/t/t0060-path-utils.sh
@@ -48,12 +48,12 @@ norm_path "" ""
 norm_path . ""
 norm_path ./ ""
 norm_path ./. ""
-norm_path ./.. ++failed++
-norm_path ../. ++failed++
-norm_path ./../.// ++failed++
+norm_path ./.. "../ ++failed++"
+norm_path ../. "../ ++failed++"
+norm_path ./../.// "../ ++failed++"
 norm_path dir/.. ""
 norm_path dir/sub/../.. ""
-norm_path dir/sub/../../.. ++failed++
+norm_path dir/sub/../../.. "../ ++failed++"
 norm_path dir dir
 norm_path dir// dir/
 norm_path ./dir dir
@@ -73,12 +73,12 @@ norm_path // / POSIX
 norm_path /// / POSIX
 norm_path /. / POSIX
 norm_path /./ / POSIX
-norm_path /./.. ++failed++ POSIX
-norm_path /../. ++failed++ POSIX
-norm_path /./../.// ++failed++ POSIX
+norm_path /./.. "/../ ++failed++" POSIX
+norm_path /../. "/../ ++failed++" POSIX
+norm_path /./../.// "/../ ++failed++" POSIX
 norm_path /dir/.. / POSIX
 norm_path /dir/sub/../.. / POSIX
-norm_path /dir/sub/../../.. ++failed++ POSIX
+norm_path /dir/sub/../../.. "/../ ++failed++" POSIX
 norm_path /dir /dir POSIX
 norm_path /dir// /dir/ POSIX
 norm_path /./dir /dir POSIX
diff --git a/test-path-utils.c b/test-path-utils.c
index e767159..ba6c8ac 100644
--- a/test-path-utils.c
+++ b/test-path-utils.c
@@ -5,8 +5,10 @@ int main(int argc, char **argv)
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
 		char *buf = xmalloc(PATH_MAX + 1);
 		int rv = normalize_path_copy(buf, argv[2]);
-		if (rv)
-			buf = "++failed++";
+		if (rv) {
+			fputs(buf, stdout);
+			buf = " ++failed++";
+		}
 		puts(buf);
 		return 0;
 	}
-- 
1.7.2.5
