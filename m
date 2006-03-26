From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Do not ever list empty directories in git-ls-files --others
Date: Sun, 26 Mar 2006 16:25:05 +0200
Message-ID: <20060326142505.GL18185@pasky.or.cz>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 16:25:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNWB1-0006FX-PA
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 16:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWCZOYz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 09:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWCZOYz
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 09:24:55 -0500
Received: from w241.dkm.cz ([62.24.88.241]:3483 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751251AbWCZOYy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 09:24:54 -0500
Received: (qmail 18984 invoked by uid 2001); 26 Mar 2006 16:25:05 +0200
To: junkio@cox.net, Jim MacBaine <jmacbaine@gmail.com>
Content-Disposition: inline
In-Reply-To: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18040>

  Hi,

Dear diary, on Mon, Feb 27, 2006 at 03:43:32PM CET, I got a letter
where Jim MacBaine <jmacbaine@gmail.com> said that...
> Many packages put empty directories under /etc, and although only a
> few of those directories are actually needed, the automatic removal of
> those packages will fail if I remove the empty directories manually.  
> Equally, the removal will fail, if I put a .placeholder file into
> those direrectories and cg-add it.  Is there a simple way out?

  this is caused by git-ls-files behaviour - we now call it with
the --directory argument which is nice since it will show a non-empty
unknown directory as a single entry and won't list all its contents.
What is not so nice is the side-effect you are describing, and I tend
to agree that if the directory is empty, it should not be listed.

---

Without the --directory flag, git-ls-files wouldn't ever list directories,
producing no output for empty directories, which is good since they cannot
be added and they bear no content, even untracked one (if Git ever starts
tracking directories on their own, this should obviously change since the
content notion will change).

With the --directory flag however, git-ls-files would list even empty
directories. This patch fixes this.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 ls-files.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/ls-files.c b/ls-files.c
index e42119c..4502b51 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -258,11 +258,12 @@ static int dir_exists(const char *dirnam
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static void read_directory(const char *path, const char *base, int baselen)
+static int read_directory(const char *path, const char *base, int baselen)
 {
-	DIR *dir = opendir(path);
+	DIR *fdir = opendir(path);
+	int contents = 0;
 
-	if (dir) {
+	if (fdir) {
 		int exclude_stk;
 		struct dirent *de;
 		char fullname[MAXPATHLEN + 1];
@@ -270,7 +271,7 @@ static void read_directory(const char *p
 
 		exclude_stk = push_exclude_per_directory(base, baselen);
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(fdir)) != NULL) {
 			int len;
 
 			if ((de->d_name[0] == '.') &&
@@ -288,6 +289,7 @@ static void read_directory(const char *p
 
 			switch (DTYPE(de)) {
 			struct stat st;
+			int subdir, rewind_base;
 			default:
 				continue;
 			case DT_UNKNOWN:
@@ -301,22 +303,31 @@ static void read_directory(const char *p
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
-				if (show_other_directories &&
-				    !dir_exists(fullname, baselen + len))
+				rewind_base = nr_dir;
+				subdir = read_directory(fullname, fullname,
+				                        baselen + len);
+				if (show_other_directories && subdir &&
+				    !dir_exists(fullname, baselen + len)) {
+					// Rewind the read subdirectory
+					while (nr_dir > rewind_base)
+						free(dir[--nr_dir]);
 					break;
-				read_directory(fullname, fullname,
-					       baselen + len);
+				}
+				contents += subdir;
 				continue;
 			case DT_REG:
 			case DT_LNK:
 				break;
 			}
 			add_name(fullname, baselen + len);
+			contents++;
 		}
-		closedir(dir);
+		closedir(fdir);
 
 		pop_exclude_per_directory(exclude_stk);
 	}
+
+	return contents;
 }
 
 static int cmp_name(const void *p1, const void *p2)


-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
