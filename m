From: Alex Riesen <raa.lkml@gmail.com>
Subject: make update-index --chmod work with multiple files and --stdin
Date: Sat, 22 Apr 2006 22:46:42 +0200
Message-ID: <20060422204642.GA7676@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 22 22:46:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXP0C-0004w1-IO
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWDVUqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWDVUqq
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 16:46:46 -0400
Received: from devrace.com ([198.63.210.113]:19717 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751166AbWDVUqp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Apr 2006 16:46:45 -0400
Received: from tigra.home (p54A06533.dip.t-dialin.net [84.160.101.51])
	by devrace.com (Postfix) with ESMTP id 0E368357;
	Sat, 22 Apr 2006 15:46:45 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FXP06-0002rg-00; Sat, 22 Apr 2006 22:46:42 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FXP06-0000Zz-Gd; Sat, 22 Apr 2006 22:46:42 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19058>

I had a project where lots of files were "accidentally" marked +x, and
doing plain "git-update-index --chmod=-x" for each file was too slow.
Besides, it's somewhat inconsistent, that --chmod does work only for
one subsequent file.

---

Yes, windows again.

 update-index.c |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

5c7b9c2d187f36ba8b5632d2125f2bd19abb3564
diff --git a/update-index.c b/update-index.c
index 1efac27..c3c2000 100644
--- a/update-index.c
+++ b/update-index.c
@@ -350,6 +350,7 @@ static int chmod_path(int flip, const ch
 		return -1;
 	}
 	active_cache_changed = 1;
+	report("chmod %cx '%s'", flip, path);
 	return 0;
 }
 
@@ -478,6 +479,7 @@ int main(int argc, const char **argv)
 	int read_from_stdin = 0;
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
+	char chmod_mode = 0;
 
 	git_config(git_default_config);
 
@@ -544,8 +546,7 @@ int main(int argc, const char **argv)
 			    !strcmp(path, "--chmod=+x")) {
 				if (argc <= i+1)
 					die("git-update-index: %s <path>", path);
-				if (chmod_path(path[8], argv[++i]))
-					die("git-update-index: %s cannot chmod %s", path, argv[i]);
+				chmod_mode = path[8];
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
@@ -594,6 +595,11 @@ int main(int argc, const char **argv)
 			die("unknown option %s", path);
 		}
 		update_one(path, prefix, prefix_length);
+		if ( chmod_mode ) {
+			if (chmod_path(chmod_mode, path))
+				die("git-update-index: cannot chmod %cx %s",
+				    chmod_mode, path);
+		}
 	}
 	if (read_from_stdin) {
 		struct strbuf buf;
@@ -608,6 +614,12 @@ int main(int argc, const char **argv)
 			else
 				path_name = buf.buf;
 			update_one(path_name, prefix, prefix_length);
+			if ( chmod_mode ) {
+				const char *p = prefix_path(prefix, prefix_length, path_name);
+				if (chmod_path(chmod_mode, p))
+					die("git-update-index: cannot chmod %cx %s",
+					    chmod_mode, p);
+			}
 			if (path_name != buf.buf)
 				free(path_name);
 		}
-- 
1.3.0.gc2941
