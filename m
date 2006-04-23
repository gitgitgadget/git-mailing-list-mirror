From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: make update-index --chmod work with multiple files and --stdin
Date: Sun, 23 Apr 2006 09:01:29 +0200
Message-ID: <20060423070129.GA5802@steel.home>
References: <20060422204642.GA7676@steel.home> <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 09:01:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXYbC-0005Ks-Ag
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 09:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbWDWHBe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 03:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWDWHBe
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 03:01:34 -0400
Received: from devrace.com ([198.63.210.113]:11533 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1751353AbWDWHBd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Apr 2006 03:01:33 -0400
Received: from tigra.home (p54A074BC.dip.t-dialin.net [84.160.116.188])
	by devrace.com (Postfix) with ESMTP id C1302357;
	Sun, 23 Apr 2006 02:01:34 -0500 (CDT)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1FXYb4-0006tP-00; Sun, 23 Apr 2006 09:01:30 +0200
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1FXYb4-0003R5-1R; Sun, 23 Apr 2006 09:01:30 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19066>

Junio C Hamano, Sun, Apr 23, 2006 02:54:51 +0200:
> > I had a project where lots of files were "accidentally" marked +x, and
> > doing plain "git-update-index --chmod=-x" for each file was too slow.
> > Besides, it's somewhat inconsistent, that --chmod does work only for
> > one subsequent file.
> 
> If you are doing that on the command line, people may want to
> have a way to mean "from here on do not do chmod, just do normal
> update-index and nothing else" by resetting the chmod_mode thing
> back to zero.  Nothing major, and we do not do that to allow_add
> and allow_remove either, but just a thought.

Not sure about that, but did it anyway (as separate patches).

I updated the patch with the other remarks regarding
set_executable_bit, whitespaces and die in chmod_path (thought about
this one myself, but was lazy).

---

 update-index.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

92d1372fd0358811a5f2670b99a6a304dadb7864
diff --git a/update-index.c b/update-index.c
index 1efac27..a8582ea 100644
--- a/update-index.c
+++ b/update-index.c
@@ -328,7 +328,7 @@ static int add_cacheinfo(unsigned int mo
 	return 0;
 }
 
-static int chmod_path(int flip, const char *path)
+static void chmod_path(int flip, const char *path)
 {
 	int pos;
 	struct cache_entry *ce;
@@ -336,21 +336,24 @@ static int chmod_path(int flip, const ch
 
 	pos = cache_name_pos(path, strlen(path));
 	if (pos < 0)
-		return -1;
+		goto _fail;
 	ce = active_cache[pos];
 	mode = ntohl(ce->ce_mode);
 	if (!S_ISREG(mode))
-		return -1;
+		goto _fail;
 	switch (flip) {
 	case '+':
 		ce->ce_mode |= htonl(0111); break;
 	case '-':
 		ce->ce_mode &= htonl(~0111); break;
 	default:
-		return -1;
+		goto _fail;
 	}
 	active_cache_changed = 1;
-	return 0;
+	report("chmod %cx '%s'", flip, path);
+	return;
+_fail:
+	die("git-update-index: cannot chmod %cx '%s'", flip, path);
 }
 
 static struct cache_file cache_file;
@@ -478,6 +481,7 @@ int main(int argc, const char **argv)
 	int read_from_stdin = 0;
 	const char *prefix = setup_git_directory();
 	int prefix_length = prefix ? strlen(prefix) : 0;
+	char set_executable_bit = 0;
 
 	git_config(git_default_config);
 
@@ -544,8 +548,7 @@ int main(int argc, const char **argv)
 			    !strcmp(path, "--chmod=+x")) {
 				if (argc <= i+1)
 					die("git-update-index: %s <path>", path);
-				if (chmod_path(path[8], argv[++i]))
-					die("git-update-index: %s cannot chmod %s", path, argv[i]);
+				set_executable_bit = path[8];
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
@@ -594,6 +597,8 @@ int main(int argc, const char **argv)
 			die("unknown option %s", path);
 		}
 		update_one(path, prefix, prefix_length);
+		if (set_executable_bit)
+			chmod_path(set_executable_bit, path);
 	}
 	if (read_from_stdin) {
 		struct strbuf buf;
@@ -608,6 +613,10 @@ int main(int argc, const char **argv)
 			else
 				path_name = buf.buf;
 			update_one(path_name, prefix, prefix_length);
+			if (set_executable_bit) {
+				const char *p = prefix_path(prefix, prefix_length, path_name);
+				chmod_path(set_executable_bit, p);
+			}
 			if (path_name != buf.buf)
 				free(path_name);
 		}
-- 
1.3.0.gc2941
