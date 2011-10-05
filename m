From: Phil Hord <hordp@cisco.com>
Subject: [PATCHv3 3/5] Add a common is_gitfile function
Date: Wed, 05 Oct 2011 09:33:54 -0400
Message-ID: <4E8C5CC2.4030505@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>,
	Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:36:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBReW-0000rp-6s
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934759Ab1JENgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 09:36:47 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:37279 "EHLO
	rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934700Ab1JENgp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=2815; q=dns/txt;
  s=iport; t=1317821805; x=1319031405;
  h=message-id:date:from:mime-version:to:cc:subject:
   content-transfer-encoding;
  bh=7uvlTOJw/IBVOhz4tvCjinEO8EnniXzRY5TwHkUJC+E=;
  b=S12bE/crvBzFOd9CGmSg79lIT8HcH6rO1Bdqg1LhIETaoDaXX2c7n8g6
   GNHX8zWF8r053/FHR9QZmuKIEGvEf3YRMnWVVpFFkcu0ic7m6nPQULro5
   2TKy8CVcLS4wqJsUEhpLIgHN4vAKJltomseZz2j1wyYl9Y9FZDtH/2tLU
   o=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAIVcjE6tJV2c/2dsb2JhbABCqBGBBYFsAWUBPBYYAwIBAgFLAQwBBQIBAR6gOgGeDIcpBJNthSeDNokD
X-IronPort-AV: E=Sophos;i="4.68,491,1312156800"; 
   d="scan'208";a="26189170"
Received: from rcdn-core-5.cisco.com ([173.37.93.156])
  by rcdn-iport-2.cisco.com with ESMTP; 05 Oct 2011 13:36:45 +0000
Received: from [64.100.104.107] (dhcp-64-100-104-107.cisco.com [64.100.104.107])
	by rcdn-core-5.cisco.com (8.14.3/8.14.3) with ESMTP id p95DaihB002502;
	Wed, 5 Oct 2011 13:36:44 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110812 Thunderbird/6.0
X-Enigmail-Version: 1.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182843>

There are at least two locations in the code that check for
gitfiles.  Each one is slightly different for pretty good
reasons.  Work towards a common API by abstracting the
"is this a gitfile" question into a single function.

Signed-off-by: Phil Hord <hordp@cisco.com>

diff --git a/builtin/clone.c b/builtin/clone.c
index 488f48e..5110399 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -120,13 +120,7 @@ static char *get_repo_path(const char *repo, int *is_bundle)
 			return xstrdup(absolute_path(path));
 		} else if (S_ISREG(st.st_mode) && st.st_size > 8) {
 			/* Is it a "gitfile"? */
-			char signature[8];
-			int len, fd = open(path, O_RDONLY);
-			if (fd < 0)
-				continue;
-			len = read_in_full(fd, signature, 8);
-			close(fd);
-			if (len != 8 || strncmp(signature, "gitdir: ", 8))
+			if (!is_gitfile(path))
 				continue;
 			path = read_gitfile(path);
 			if (path) {
diff --git a/cache.h b/cache.h
index 7eeb8cf..61e1b0f 100644
--- a/cache.h
+++ b/cache.h
@@ -441,6 +441,7 @@ extern const char *get_git_work_tree(void);
 extern const char *read_gitfile(const char *path);
 extern const char *resolve_gitdir(const char *suspect);
 extern void set_git_work_tree(const char *tree);
+extern int is_gitfile(const char *path);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
diff --git a/setup.c b/setup.c
index 61c22e6..a3d5a41 100644
--- a/setup.c
+++ b/setup.c
@@ -358,7 +358,7 @@ const char *read_gitfile(const char *path)
 
 	if (stat(path, &st))
 		return NULL;
-	if (!S_ISREG(st.st_mode))
+	if (!is_gitfile(path))
 		return NULL;
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
@@ -368,9 +368,6 @@ const char *read_gitfile(const char *path)
 	close(fd);
 	if (len != st.st_size)
 		die("Error reading %s", path);
-	buf[len] = '\0';
-	if (prefixcmp(buf, "gitdir: "))
-		die("Invalid gitfile format: %s", path);
 	while (buf[len - 1] == '\n' || buf[len - 1] == '\r')
 		len--;
 	if (len < 9)
@@ -397,6 +394,32 @@ const char *read_gitfile(const char *path)
 	return path;
 }
 
+/*
+ * See if the referenced file looks like a 'gitfile'.
+ * Does not try to determine if the referenced gitdir is actually valid.
+ */
+int is_gitfile(const char *path)
+{
+	struct stat st;
+	char buf[9];
+	int fd, len;
+	if (stat(path, &st))
+		return 0;
+	if (!S_ISREG(st.st_mode))
+		return 0;
+	if (st.st_size < 10 || st.st_size > PATH_MAX)
+		return 0;
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0)
+		return 0;
+	len = read_in_full(fd, buf, sizeof(buf));
+	close(fd);
+	if (len != sizeof(buf))
+		return 0;
+	return !prefixcmp(buf, "gitdir: ");
+}
+
 static const char *setup_explicit_git_dir(const char *gitdirenv,
 					  char *cwd, int len,
 					  int *nongit_ok)
-- 
1.7.7.505.ga09f6
