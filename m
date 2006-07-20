From: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Thu, 20 Jul 2006 11:30:44 +0200
Message-ID: <20060720093044.GA10824@1wt.eu>
References: <20060719214025.GA10997@1wt.eu> <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 11:31:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3Urz-0006Ur-Ef
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 11:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbWGTJay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Jul 2006 05:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWGTJay
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Jul 2006 05:30:54 -0400
Received: from 1wt.eu ([62.212.114.60]:56588 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932578AbWGTJay (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Jul 2006 05:30:54 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24024>

Hi Junio,

On Wed, Jul 19, 2006 at 03:33:48PM -0700, Junio C Hamano wrote:
> Willy Tarreau <w@1wt.eu> writes:
> 
> > While I agreed with Linus that the very permissive file modes set in tar
> > archives were not particularly a problem for kernel users, I'm finding
> > that for some other projects it sometimes becomes really annoying, to
> > the point that I finally considered using a plain tar instead. This is a
> > shame because tar-tree is really fast an powerful, and I like its ability
> > to enforce permissions when those of the local dir might be wrong for
> > various reasons.
> 
> I do not have problem with an option to allow a non-default
> behaviour in this area.  Maybe we might want to be able to set
> the mask in the configuration file as well, perhaps like...
> 
> 	tar.umask = user ;# use from the current process'
>         tar.umask = 0    ;# same as default
>         tar.umask = 002  ;# group friendly

Here's the new version following your suggestion above. I really liked it.
I've also added a configuration example in the doc. Once again, please
ensure that the doc generates correctly.

Thanks,
Willy


>From d8a0d2bbd2365b719a7f68edd78c77a0fd903cab Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Thu, 20 Jul 2006 11:23:40 +0200
Subject: tar-tree: add the "tar.umask" config option

By default, git-tar-tree(1) sets file and directories modes to 0666
or 0777. While this is both useful and acceptable for projects such
as the Linux Kernel, it might be excessive for other projects. With
this variable, it becomes possible to tell git-tar-tree(1) to apply
a specific umask to the modes above. The special value "user"
indicates that the user's current umask will be used. This should be
enough for most projects, as it will lead to the same permissions as
git-checkout(1) would use. The default value remains 0, which means
world read-write.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/config.txt       |   11 +++++++++++
 Documentation/git-tar-tree.txt |   15 ++++++++++++++-
 builtin-tar-tree.c             |   21 ++++++++++++++++++---
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b434c1..f4985d4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -208,6 +208,17 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+tar.umask::
+	By default, git-link:git-tar-tree[1] sets file and directories modes
+	to 0666 or 0777. While this is both useful and acceptable for projects
+	such as the Linux Kernel, it might be excessive for other projects.
+	With this variable, it becomes possible to tell
+	git-link:git-tar-tree[1] to apply a specific umask to the modes above.
+	The special value "user" indicates that the user's current umask will
+	be used. This should be enough for most projects, as it will lead to
+	the same permissions as git-link:git-checkout[1] would use. The default
+	value remains 0, which means world read-write.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL' and 'GIT_COMMITTER_EMAIL'
diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index f2675c4..7a99acf 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -37,7 +37,20 @@ OPTIONS
 	Instead of making a tar archive from local repository,
 	retrieve a tar archive from a remote repository.
 
-Examples
+CONFIGURATION
+-------------
+By default, file and directories modes are set to 0666 or 0777. It is
+possible to change this by setting the "umask" variable in the
+repository configuration as follows :
+
+[tar]
+        umask = 002	;# group friendly
+
+The special umask value "user" indicates that the user's current umask
+will be used instead. The default value remains 0, which means world
+readable/writable files and directories.
+
+EXAMPLES
 --------
 git tar-tree HEAD junk | (cd /var/tmp/ && tar xf -)::
 
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f2e48aa..e5aaded 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -20,6 +20,7 @@ static char block[BLOCKSIZE];
 static unsigned long offset;
 
 static time_t archive_time;
+static int tar_umask;
 
 /* tries hard to write, either succeeds or dies in the attempt */
 static void reliable_write(const void *data, unsigned long size)
@@ -188,13 +189,13 @@ static void write_entry(const unsigned c
 	} else {
 		if (S_ISDIR(mode)) {
 			*header.typeflag = TYPEFLAG_DIR;
-			mode |= 0777;
+			mode = (mode | 0777) & ~tar_umask;
 		} else if (S_ISLNK(mode)) {
 			*header.typeflag = TYPEFLAG_LNK;
 			mode |= 0777;
 		} else if (S_ISREG(mode)) {
 			*header.typeflag = TYPEFLAG_REG;
-			mode |= (mode & 0100) ? 0777 : 0666;
+			mode = (mode | ((mode & 0100) ? 0777 : 0666)) & ~tar_umask;
 		} else {
 			error("unsupported file mode: 0%o (SHA1: %s)",
 			      mode, sha1_to_hex(sha1));
@@ -293,6 +294,20 @@ static void traverse_tree(struct tree_de
 	}
 }
 
+int git_tar_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "tar.umask")) {
+		if (!strcmp(value, "user")) {
+			tar_umask = umask(0);
+			umask(tar_umask);
+		} else {
+			tar_umask = git_config_int(var, value);
+		}
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 static int generate_tar(int argc, const char **argv, char** envp)
 {
 	unsigned char sha1[20], tree_sha1[20];
@@ -305,7 +320,7 @@ static int generate_tar(int argc, const 
 	current_path.len = current_path.eof = 0;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_tar_config);
 
 	switch (argc) {
 	case 3:
-- 
1.4.1
