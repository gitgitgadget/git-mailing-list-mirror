From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2nd try] runstatus: do not recurse into subdirectories if
 not needed
Date: Thu, 28 Sep 2006 02:44:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609280240060.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609271315470.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac4k97if.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0609280216350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 02:45:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSk17-0008N4-7M
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 02:44:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031304AbWI1Aoe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 20:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031305AbWI1Aoe
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 20:44:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:49303 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031304AbWI1Aoc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 20:44:32 -0400
Received: (qmail invoked by alias); 28 Sep 2006 00:44:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 28 Sep 2006 02:44:31 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0609280216350.14200@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27959>


This speeds up the case when you run git-status, having an untracked
subdirectory containing huge amounts of files.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	On Thu, 28 Sep 2006, Johannes Schindelin wrote:

	> On Wed, 27 Sep 2006, Junio C Hamano wrote:
	> 
	> > Does this really check if the directory is empty (I think you
	> > would read "." and ".." out of it at least)?
	> >
	> > When the original code recurses into subdirectory, it seems to
	> > behave identically for a truly empty directory and a directory
	> > that has only ".git" (or excluded files in it under 
	> > !show_ignored).
	> 
	> Of course I missed that. Probably, because there is no test for 
	> that.
	>
	> [...] 
	> 
	> Now, I could enhance dir_is_empty() to recursively test if the 
	> dir is empty, and return 0 on first sight of a not-excluded dir 
	> entry, but is it really worth the hassle?

	Okay, so no more dir_is_empty(). Instead, read_directory_recursive()
	gets a flag. With this flag, "check_only", it exits as soon as it
	found valid entries, but does not add any. Way easier.

 dir.c |   27 +++++++++++++++------------
 1 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/dir.c b/dir.c
index e2f472b..96389b3 100644
--- a/dir.c
+++ b/dir.c
@@ -283,7 +283,7 @@ static int dir_exists(const char *dirnam
  * Also, we ignore the name ".git" (even if it is not a directory).
  * That likely will not change.
  */
-static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen)
+static int read_directory_recursive(struct dir_struct *dir, const char *path, const char *base, int baselen, int check_only)
 {
 	DIR *fdir = opendir(path);
 	int contents = 0;
@@ -314,7 +314,6 @@ static int read_directory_recursive(stru
 
 			switch (DTYPE(de)) {
 			struct stat st;
-			int subdir, rewind_base;
 			default:
 				continue;
 			case DT_UNKNOWN:
@@ -328,26 +327,30 @@ static int read_directory_recursive(stru
 			case DT_DIR:
 				memcpy(fullname + baselen + len, "/", 2);
 				len++;
-				rewind_base = dir->nr;
-				subdir = read_directory_recursive(dir, fullname, fullname,
-				                        baselen + len);
 				if (dir->show_other_directories &&
-				    (subdir || !dir->hide_empty_directories) &&
 				    !dir_exists(fullname, baselen + len)) {
-					/* Rewind the read subdirectory */
-					while (dir->nr > rewind_base)
-						free(dir->entries[--dir->nr]);
+					if (dir->hide_empty_directories &&
+					    !read_directory_recursive(dir,
+						    fullname, fullname,
+						    baselen + len, 1))
+						continue;
 					break;
 				}
-				contents += subdir;
+
+				contents += read_directory_recursive(dir,
+					fullname, fullname, baselen + len, 0);
 				continue;
 			case DT_REG:
 			case DT_LNK:
 				break;
 			}
-			add_name(dir, fullname, baselen + len);
 			contents++;
+			if (check_only)
+				goto exit_early;
+			else
+				add_name(dir, fullname, baselen + len);
 		}
+exit_early:
 		closedir(fdir);
 
 		pop_exclude_per_directory(dir, exclude_stk);
@@ -393,7 +396,7 @@ int read_directory(struct dir_struct *di
 		}
 	}
 
-	read_directory_recursive(dir, path, base, baselen);
+	read_directory_recursive(dir, path, base, baselen, 0);
 	qsort(dir->entries, dir->nr, sizeof(struct dir_entry *), cmp_name);
 	return dir->nr;
 }
