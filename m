From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] Make git-update-cache --force-remove regular
Date: Tue, 31 May 2005 18:52:43 +0200
Message-ID: <20050531165243.GD7013@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 18:59:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdA3u-000166-OY
	for gcvg-git@gmane.org; Tue, 31 May 2005 18:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVEaQ7A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 12:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261531AbVEaQ4X
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 12:56:23 -0400
Received: from w241.dkm.cz ([62.24.88.241]:16808 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261968AbVEaQwt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 12:52:49 -0400
Received: (qmail 5457 invoked by uid 2001); 31 May 2005 16:52:43 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make the --force-remove flag behave same as --add, --remove and
--replace. This means I can do

	git-update-cache --force-remove -- file1.c file2.c

which is probably saner and also makes it easier to use in cg-rm.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 2cd99acef0c74c6218b51e058a3e045e1a8b7b66
tree 4e25708b4fd3ca1589833245a8e48bf87cb7fbde
parent 3e26fef188baa4626457fae25b0b63e1c788efcd
author Petr Baudis <pasky@ucw.cz> Tue, 31 May 2005 18:51:56 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Tue, 31 May 2005 18:51:56 +0200

 Documentation/git-update-cache.txt |    4 ++--
 update-cache.c                     |   12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-update-cache.txt b/Documentation/git-update-cache.txt
--- a/Documentation/git-update-cache.txt
+++ b/Documentation/git-update-cache.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-update-cache'
 	     [--add] [--remove] [--refresh] [--replace]
 	     [--ignore-missing]
-	     [--force-remove <file>]
+	     [--force-remove]
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--] [<file>]\*
 
@@ -49,7 +49,7 @@ OPTIONS
 	
 --force-remove::
 	Remove the file from the index even when the working directory
-	still has such a file.
+	still has such a file. (Implies --remove.)
 
 --replace::
 	By default, when a file `path` exists in the index,
diff --git a/update-cache.c b/update-cache.c
--- a/update-cache.c
+++ b/update-cache.c
@@ -13,6 +13,7 @@
  * files be revision controlled.
  */
 static int allow_add = 0, allow_remove = 0, allow_replace = 0, not_new = 0;
+static int force_remove;
 
 /* Three functions to allow overloaded pointer return; see linux/err.h */
 static inline void *ERR_PTR(long error)
@@ -376,11 +377,7 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(path, "--force-remove")) {
-				if (argc <= i + 1)
-					die("git-update-cache: --force-remove <path>");
-				if (remove_file_from_cache(argv[i+1]))
-					die("git-update-cache: --force-remove cannot remove %s", argv[i+1]);
-				i++;
+				force_remove = 1;
 				continue;
 			}
 
@@ -394,6 +391,11 @@ int main(int argc, char **argv)
 			fprintf(stderr, "Ignoring path %s\n", argv[i]);
 			continue;
 		}
+		if (force_remove) {
+			if (remove_file_from_cache(path))
+				die("git-update-cache: --force-remove cannot remove %s", path);
+			continue;
+		}
 		if (add_file_to_cache(path))
 			die("Unable to add %s to database", path);
 	}

|
-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
