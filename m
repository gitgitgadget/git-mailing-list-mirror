From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect broken in 1.2.4
Date: Tue, 02 May 2006 00:25:52 -0700
Message-ID: <7vpsiwopkv.fsf@assigned-by-dhcp.cox.net>
References: <20060501181020.GA21263@suse.de>
	<20060502070155.GA861@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue May 02 09:26:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FapGm-0007Fj-CK
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWEBHZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbWEBHZ4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:25:56 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:54704 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932473AbWEBHZz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 May 2006 03:25:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060502072554.WNYM27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 2 May 2006 03:25:54 -0400
To: Olaf Hering <olh@suse.de>
In-Reply-To: <20060502070155.GA861@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Tue, 2 May 2006 09:01:55 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19402>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> Olaf Hering wrote:
>> Did SuSE just pick up a bad version of git, 1.2.4?
>> git-bisect doesnt work correctly in the kernel sources, .git/HEAD doesnt
>> contain the commit id anymore, but 'ref: refs/heads/bisect'
>> 
>> CONFIG_LOCALVERSION_AUTO depends on the id.
> Probably you should update to at least linux-v2.6.15-g117a93d.  The
> script to determine the localversion[1] depends on .git/HEAD being a
> symlink.
>
> Since 
>
> 	git-1.1.4-g2fabd21
>
> .git/HEAD isn't a symlink any more (per default at least).

Ouch.  Although what Uwe says is all correct, we should not say
"don't try kernel older than 2615-117a".  That makes bisect
rather useless.

> You can rebuild git with USE_SYMLINK_HEAD if you really want the old
> behaviour.

That probably is a sane thing to do.

We should introduce prefer_symlink_refs configuration to work
with projects whose older version of build infrastructure
depends on symlink refs.

The patch is on top of post 1.3.1 git, but .c and .h part should
apply more-or-less cleanly to older code base.  You should 
be able to say:

	[core]
        prefersymlinkrefs = true

in .git/config file, maybe do "git checkout -f master" to switch
branch and make .git/HEAD into symlink, and do the bisect again.

Sorry for the screwup.

-- >8 --

diff --git a/Documentation/config.txt b/Documentation/config.txt
index b27b0d5..d1a4bec 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -64,9 +64,11 @@ core.ignoreStat::
 	slow, such as Microsoft Windows.  See gitlink:git-update-index[1].
 	False by default.
 
-core.onlyUseSymrefs::
-	Always use the "symref" format instead of symbolic links for HEAD
-	and other symbolic reference files. True by default.
+core.preferSymlinkRefs::
+	Instead of the default "symref" format for HEAD
+	and other symbolic reference files, use symbolic links.
+	This is sometimes needed to work with old scripts that
+	expect HEAD to be a symbolic link.
 
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
diff --git a/Makefile b/Makefile
index 2374335..ecbdde6 100644
--- a/Makefile
+++ b/Makefile
@@ -28,8 +28,8 @@ # Define NO_STRCASESTR if you don't have
 #
 # Define NO_SETENV if you don't have setenv in the C library.
 #
-# Define USE_SYMLINK_HEAD if you want .git/HEAD to be a symbolic link.
-# Don't enable it on Windows.
+# Define NO_SYMLINK_HEAD if you never want .git/HEAD to be a symbolic link.
+# Enable it on Windows.  By default, symrefs are still used.
 #
 # Define PPC_SHA1 environment variable when running make to make use of
 # a bundled SHA1 routine optimized for PowerPC.
@@ -265,6 +265,7 @@ ifeq ($(uname_O),Cygwin)
 	NO_D_TYPE_IN_DIRENT = YesPlease
 	NO_D_INO_IN_DIRENT = YesPlease
 	NO_STRCASESTR = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	# There are conflicting reports about this.
 	# On some boxes NO_MMAP is needed, and not so elsewhere.
@@ -388,6 +389,9 @@ endif
 ifdef NO_D_INO_IN_DIRENT
 	ALL_CFLAGS += -DNO_D_INO_IN_DIRENT
 endif
+ifdef NO_SYMLINK_HEAD
+	ALL_CFLAGS += -DNO_SYMLINK_HEAD
+endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
 	COMPAT_OBJS += compat/strcasestr.o
diff --git a/cache.h b/cache.h
index a0cf8ca..d186b44 100644
--- a/cache.h
+++ b/cache.h
@@ -170,7 +170,7 @@ extern void rollback_index_file(struct c
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
 extern int assume_unchanged;
-extern int only_use_symrefs;
+extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int diff_rename_limit_default;
 extern int shared_repository;
diff --git a/config.c b/config.c
index 4e1f0c2..6cd31a3 100644
--- a/config.c
+++ b/config.c
@@ -227,8 +227,8 @@ int git_default_config(const char *var, 
 		return 0;
 	}
 
-	if (!strcmp(var, "core.symrefsonly")) {
-		only_use_symrefs = git_config_bool(var, value);
+	if (!strcmp(var, "core.prefersymlinkrefs")) {
+		prefer_symlink_refs = git_config_bool(var, value);
 		return 0;
 	}
 
diff --git a/environment.c b/environment.c
index 6df6478..444c99e 100644
--- a/environment.c
+++ b/environment.c
@@ -13,7 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
 int assume_unchanged = 0;
-int only_use_symrefs = 0;
+int prefer_symlink_refs = 0;
 int warn_ambiguous_refs = 1;
 int repository_format_version = 0;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
diff --git a/refs.c b/refs.c
index 03398cc..275b914 100644
--- a/refs.c
+++ b/refs.c
@@ -76,8 +76,8 @@ int create_symref(const char *git_HEAD, 
 	char ref[1000];
 	int fd, len, written;
 
-#ifdef USE_SYMLINK_HEAD
-	if (!only_use_symrefs) {
+#ifndef NO_SYMLINK_HEAD
+	if (prefer_symlink_refs) {
 		unlink(git_HEAD);
 		if (!symlink(refs_heads_master, git_HEAD))
 			return 0;
