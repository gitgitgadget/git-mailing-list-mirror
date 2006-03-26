From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Optionally do not list empty directories in git-ls-files --others
Date: Sun, 26 Mar 2006 16:59:52 +0200
Message-ID: <20060326145952.GM18185@pasky.or.cz>
References: <3afbacad0602270643k9fdd255w8f3769ad77c54e65@mail.gmail.com> <20060326142505.GL18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 16:59:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNWif-0003Mi-Ox
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 16:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWCZO7l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 09:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWCZO7l
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 09:59:41 -0500
Received: from w241.dkm.cz ([62.24.88.241]:45973 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750785AbWCZO7k (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Mar 2006 09:59:40 -0500
Received: (qmail 9702 invoked by uid 2001); 26 Mar 2006 16:59:52 +0200
To: junkio@cox.net, Jim MacBaine <jmacbaine@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060326142505.GL18185@pasky.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18041>

 Hi,

Dear diary, on Sun, Mar 26, 2006 at 04:25:05PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> Dear diary, on Mon, Feb 27, 2006 at 03:43:32PM CET, I got a letter
> where Jim MacBaine <jmacbaine@gmail.com> said that...
> > Many packages put empty directories under /etc, and although only a
> > few of those directories are actually needed, the automatic removal of
> > those packages will fail if I remove the empty directories manually.  
> > Equally, the removal will fail, if I put a .placeholder file into
> > those direrectories and cg-add it.  Is there a simple way out?
> 
>   this is caused by git-ls-files behaviour - we now call it with
> the --directory argument which is nice since it will show a non-empty
> unknown directory as a single entry and won't list all its contents.
> What is not so nice is the side-effect you are describing, and I tend
> to agree that if the directory is empty, it should not be listed.

  it turned out that cg-clean depends on the original behaviour (and it
makes sense there, we want to purge even empty directories). Therefore
this patch will preserve the old behaviour but add an option
--no-empty-directory. When that gets propagated to Git releases, I will
use it in cg-status.

---

Without the --directory flag, git-ls-files wouldn't ever list directories,
producing no output for empty directories, which is good since they cannot
be added and they bear no content, even untracked one (if Git ever starts
tracking directories on their own, this should obviously change since the
content notion will change).

With the --directory flag however, git-ls-files would list even empty
directories. This may be good in some situations but sometimes you want to
prevent that. This patch adds a --no-empty-directory option which makes
git-ls-files omit empty directories.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/git-ls-files.txt |    3 +++
 ls-files.c                     |   33 +++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index e813f84..980c5c9 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -52,6 +52,9 @@ OPTIONS
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
 
+--no-empty-directory::
+	Do not list empty directories. Has no effect without --directory.
+
 -u|--unmerged::
 	Show unmerged files in the output (forces --stage)
 
diff --git a/ls-files.c b/ls-files.c
index e42119c..83b0a3b 100644
--- a/ls-files.c
+++ b/ls-files.c
@@ -20,6 +20,7 @@ static int show_unmerged = 0;
 static int show_modified = 0;
 static int show_killed = 0;
 static int show_other_directories = 0;
+static int hide_empty_directories = 0;
 static int show_valid_bit = 0;
 static int line_terminator = '\n';
 
@@ -258,11 +259,12 @@ static int dir_exists(const char *dirnam
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
@@ -270,7 +272,7 @@ static void read_directory(const char *p
 
 		exclude_stk = push_exclude_per_directory(base, baselen);
 
-		while ((de = readdir(dir)) != NULL) {
+		while ((de = readdir(fdir)) != NULL) {
 			int len;
 
 			if ((de->d_name[0] == '.') &&
@@ -288,6 +290,7 @@ static void read_directory(const char *p
 
 			switch (DTYPE(de)) {
 			struct stat st;
+			int subdir, rewind_base;
 			default:
 				continue;
 			case DT_UNKNOWN:
@@ -301,22 +304,32 @@ static void read_directory(const char *p
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
+				rewind_base = nr_dir;
+				subdir = read_directory(fullname, fullname,
+				                        baselen + len);
 				if (show_other_directories &&
-				    !dir_exists(fullname, baselen + len))
+				    (subdir || !hide_empty_directories) &&
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
@@ -696,6 +709,10 @@ int main(int argc, const char **argv)
 			show_other_directories = 1;
 			continue;
 		}
+		if (!strcmp(arg, "--no-empty-directory")) {
+			hide_empty_directories = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-u") || !strcmp(arg, "--unmerged")) {
 			/* There's no point in showing unmerged unless
 			 * you also show the stage information.



-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
