From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Wed, 19 Jul 2006 23:40:25 +0200
Message-ID: <20060719214025.GA10997@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, torvalds@osdl.org
X-From: git-owner@vger.kernel.org Wed Jul 19 23:40:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3Jmb-000222-Q9
	for gcvg-git@gmane.org; Wed, 19 Jul 2006 23:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWGSVki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 17:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932549AbWGSVki
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 17:40:38 -0400
Received: from 1wt.eu ([62.212.114.60]:54540 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S932548AbWGSVki (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jul 2006 17:40:38 -0400
Received: (from willy@localhost)
	by pcw.home.local (8.10.2/8.10.2) id k6JLeP911057;
	Wed, 19 Jul 2006 23:40:25 +0200
To: Junio C Hamano <junkio@cox.net>,
	Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24008>

Hi Junio, Hi Rene,

While I agreed with Linus that the very permissive file modes set in tar
archives were not particularly a problem for kernel users, I'm finding
that for some other projects it sometimes becomes really annoying, to
the point that I finally considered using a plain tar instead. This is a
shame because tar-tree is really fast an powerful, and I like its ability
to enforce permissions when those of the local dir might be wrong for
various reasons.

So I added a config option to tell tar-tree to respect the user's umask
to the files and dirs listed in the output tar file. By default, this
option is not set, of course, but once set to true, the files look somewhat
better :

$ cat .git/config
[core]
        repositoryformatversion = 0
        filemode = true

[tar]
        applyUmask = true

$ ./git-tar-tree HEAD | tar tvf -|head
-rw-r--r-- git/git        1887 2006-07-19 23:23:00 .gitignore
-rw-r--r-- git/git       18787 2006-07-19 23:23:00 COPYING
drwxr-xr-x git/git           0 2006-07-19 23:23:00 Documentation/
-rw-r--r-- git/git          52 2006-07-19 23:23:00 Documentation/.gitignore
-rw-r--r-- git/git        2463 2006-07-19 23:23:00 Documentation/Makefile
-rw-r--r-- git/git       11550 2006-07-19 23:23:00 Documentation/SubmittingPatches
-rw-r--r-- git/git         822 2006-07-19 23:23:00 Documentation/asciidoc.conf
-rwxr-xr-x git/git        1049 2006-07-19 23:23:00 Documentation/build-docdep.perl
-rw-r--r-- git/git         596 2006-07-19 23:23:00 Documentation/callouts.xsl


Let me insist on the fact that the default behaviour is unchanged.
Would you consider this for inclusion ? I've made the patch below
against <master>. Please check on your side that the doc generates
valid output, as I've never managed to install the asciidoc/xmlto
toolchain.

Please keep me CCed in replies as I'm not subscribed to the git list.

Regards,
Willy

--

>From dcc976d83c3b9c85460329932ce22547b7f5f3f9 Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Wed, 19 Jul 2006 23:23:00 +0200
Subject: tar-tree: add the "tar.applyUmask" config option

For some projects, producing tar files with world-writable files
can be problematic. This change introduces a the "tar.applyUmask"
config option to make tar-tree apply the umask to the permissions
set in the tar file.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/config.txt |    9 +++++++++
 builtin-tar-tree.c       |   19 ++++++++++++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 0b434c1..32519a9 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -208,6 +208,15 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+tar.applyUmask::
+	By default, git-link:git-tar-tree[1] sets file and directories modes
+	to 0666 or 0777. While this is both useful and acceptable for projects
+	such as the Linux Kernel, it might be excessive for other projects.
+	Setting this variable to true makes git-link:git-tar-tree[1] apply the
+	umask to the modes above. This should be enough for most projects, as
+	it will lead to the same permissions as git-link:git-checkout[1] would
+	use. The default is false.
+
 user.email::
 	Your email address to be recorded in any newly created commits.
 	Can be overridden by the 'GIT_AUTHOR_EMAIL' and 'GIT_COMMITTER_EMAIL'
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index f2e48aa..f66f6ad 100644
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
+			mode |= 0777 & ~tar_umask;
 		} else if (S_ISLNK(mode)) {
 			*header.typeflag = TYPEFLAG_LNK;
 			mode |= 0777;
 		} else if (S_ISREG(mode)) {
 			*header.typeflag = TYPEFLAG_REG;
-			mode |= (mode & 0100) ? 0777 : 0666;
+			mode |= ((mode & 0100) ? 0777 : 0666) &	~tar_umask;
 		} else {
 			error("unsupported file mode: 0%o (SHA1: %s)",
 			      mode, sha1_to_hex(sha1));
@@ -293,6 +294,18 @@ static void traverse_tree(struct tree_de
 	}
 }
 
+int git_tar_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "tar.applyumask")) {
+		if (git_config_bool(var, value)) {
+			tar_umask = umask(0);
+			umask(tar_umask);
+		}
+		return 0;
+	}
+	return git_default_config(var, value);
+}
+
 static int generate_tar(int argc, const char **argv, char** envp)
 {
 	unsigned char sha1[20], tree_sha1[20];
@@ -305,7 +318,7 @@ static int generate_tar(int argc, const 
 	current_path.len = current_path.eof = 0;
 
 	setup_git_directory();
-	git_config(git_default_config);
+	git_config(git_tar_config);
 
 	switch (argc) {
 	case 3:
-- 
1.4.1
